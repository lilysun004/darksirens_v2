#%%
import os
import subprocess
import pandas as pd
import numpy as np
from scipy.integrate import quad
from astropy.table import QTable
import astropy_healpix as ah
from astropy import units as u
from astropy.io import fits
import matplotlib.pyplot as plt
from scipy.optimize import brentq
import shutil

true_H0 = 67
Omega_m = 0.319
Omega_lamb = 1- Omega_m
c = 299792.458

H0_prior_min, H0_prior_max = 20, 140
H0_values = np.linspace(H0_prior_min,H0_prior_max,25)

# Define the template for the .sh file
sh_template = """lalapps_inspinj \\
-o inj.xml \\
--m-distr fixMasses --fixed-mass1 {m1} --fixed-mass2 {m2} \\
--t-distr uniform --time-step 7200 \\
--gps-start-time {t_start} \\
--gps-end-time {t_end} \\
--d-distr volume \\
--min-distance {min_dL}e3 --max-distance {max_dL}e3 \\
--l-distr fixed --longitude {RA} --latitude {Dec} --i-distr uniform \\
--f-lower 20 --disable-spin \\
--waveform SEOBNRv4_ROM

bayestar-sample-model-psd \\
-o psd.xml \\
--H1=aLIGOZeroDetHighPower \\
--L1=aLIGOZeroDetHighPower \\
--V1=AdvVirgo

bayestar-realize-coincs \\
-o coinc.xml \\
inj.xml --reference-psd psd.xml \\
--detector H1 L1 V1 \\
--measurement-error gaussian-noise \\
--snr-threshold 4.0 \\
--net-snr-threshold 12.0 \\
--min-triggers 2 \\
--keep-subthreshold

bayestar-localize-coincs coinc.xml
"""

# --E1=EinsteinTelescopeP1600143 \\
# --E2=EinsteinTelescopeP1600143 \\
# --E3=EinsteinTelescopeP1600143 \\
# --X1=CosmicExplorerP1600143

# --detector E1 E2 E3 X1 \\

#%% Functions
mmin, mmax = 2.2, 86.16
y1, y2 = 1.05, 5.17
bq, bbreak = 0.28, 0.41
mbreak = mmin + bbreak*(mmax - mmin)
a2 = mbreak ** (y2-y1)
m_values = np.linspace(mmin,mmax,1000)

def p1(m1):
    if m1 > mmin and m1 < mbreak:
        return m1**(-y1)
    if m1 >= mbreak and m1 < mmax:
        return a2*m1**(-y2)
    else:
        return 0

p_m1_values = np.array([p1(m1) for m1 in m_values])
p_m1_values = p_m1_values / np.sum(p_m1_values)

def draw_from_mass_distr_m1():
    return np.random.choice(m_values,p=p_m1_values)

def p2(m1, m2):
    return (1+bq)/m1 * (m2/m1)**bq / (1 - (mmin/m1) ** (1+bq))

def draw_from_mass_distr_m2(m1):
    p_m2_values = np.array([p2(m1,m2) for m2 in m_values])
    p_m2_values = p_m2_values/np.sum(p_m2_values)
    return np.random.choice(m_values,p=p_m2_values)

def draw_from_time(start=1000000000,period=3.156e7):
    return np.random.uniform(start, start+period)

def E(z):
    return np.sqrt(Omega_m*(1+z)**3 + Omega_lamb)

def dL_integrand(dummy):
    return 1/E(dummy)

def dL(z,H0):
    integral = quad(dL_integrand,0,z)[0]
    return c*(1+z)/H0 * integral

def dL_rootfinder(z,H0,target_dL):
    return dL(z,H0) - target_dL 

def z_finder(target_dL,H0):
    return brentq(dL_rootfinder,0,10,args=(H0,target_dL))

def p_bg_integrand(z):
    return r_c(z)**2/E(z)

def p_bg_func(z):
    numerator = p_bg_integrand(z)
    denominator = quad(p_bg_integrand,0,np.inf)[0]
    return numerator/denominator

def r_c(z):
    return quad(dL_integrand,0,z)[0]

def normalize(x,y):
    C = np.trapz(y,x)
    if C <= 10e-100:
        return np.zeros(len(y)) 
    return 1/C*y

def gaussian_likelihood(x_values, x_mean, x_sigma):
    return (1.0 / (x_sigma * np.sqrt(2 * np.pi))) * np.exp(-0.5 * ((x_values - x_mean) / x_sigma) ** 2)

def confidence_interval(x,y,ci): # assumes x is equally spaced array!
    total_area = np.sum(y)
    sorted_indices = np.argsort(-y)
    cumulative_prob = np.cumsum(y[sorted_indices])
    threshold_index = np.argmax(cumulative_prob >= ci*total_area)
    mostprob_indices = sorted_indices[:threshold_index+1]
    interval_x = x[mostprob_indices]
    return min(interval_x), max(interval_x)

#%% Load Euclid
euclid = pd.read_parquet('../subeuclid_fullsky_sub.parquet')
possible_host_indexs = euclid.index.to_numpy()
original_directory = os.getcwd()

#%% GENERATE EVENTS AND SKYMAPS
os.chdir(original_directory)

params_all = {}
n_events_sofar = 50
n_events_target = 500
while n_events_sofar < n_events_target:
    #Draw parameters
    params_n = {}
    host_index = np.random.choice(possible_host_indexs)
    host_truez = euclid['ztrue'][host_index]
    if host_truez > 1.5:
        print('>1.5')
        continue
    host_dL = dL(host_truez,true_H0)
    host_ra = euclid['RA'][host_index]
    host_dec = euclid['Dec'][host_index]
    m1 = draw_from_mass_distr_m1()
    m2 = draw_from_mass_distr_m2(m1)
    t_start = draw_from_time()
    t_end = t_start + 7200
    # print(n_events_sofar, 'params drawn')

    # Create temporary folder and file
    folder_name = 'event'+'{:03}'.format(n_events_sofar)
    os.makedirs(folder_name, exist_ok=True)
    script_content = sh_template.format(
        RA=host_ra,
        Dec=host_dec,
        min_dL=host_dL-0.01,
        max_dL=host_dL+0.01,
        m1=m1,
        m2=m2,
        t_start=t_start,
        t_end=t_end
    )
    print(n_events_sofar, 'truez', host_truez)
    file_path = os.path.join(folder_name, "gen.sh")
    with open(file_path, "w") as file:
        file.write(script_content)
    os.chmod(file_path, 0o755)
    # print(n_events_sofar, '.sh created')

    #Execute Bayestar
    os.chdir(folder_name)
    sh_files = [f for f in os.listdir() if f.endswith('.sh')]
    with subprocess.Popen(['bash', sh_files[0]], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL) as process:
            process.communicate()  # Ensure the process completes

    # print(os.getcwd())
    #Check if fits exists
    fits_files = [f for f in os.listdir() if f.endswith('.fits')]
    if not fits_files:
        os.chdir(original_directory)
        shutil.rmtree(folder_name)
        print(n_events_sofar, 'no .fits, try again')
        continue
    print('.fits file created', n_events_sofar)
    params_n = {'RA':host_ra,
                'Dec':host_dec,
                'min_dL':host_dL-0.01,
                'max_dL':host_dL+0.01,
                'm1':m1,
                'm2':m2,
                'truez':host_truez,
                'truedL':host_dL,
                't_start':t_start,
                't_end':t_end}
    params_all[n_events_sofar] = params_n
    n_events_sofar +=1
    os.chdir(original_directory)

print('DONE!!!')

#%%
all_posteriors_nobeta = {}
os.chdir(original_directory)

def find_index_from_coords(coords, big_indexs, sorter, max_nside):
    ra, dec = coords
    match_ipix = ah.lonlat_to_healpix(ra, dec, max_nside, order='nested')
    i = sorter[np.searchsorted(big_indexs, match_ipix, side='right', sorter=sorter)-1]
    return i

def find_indexs_in_region(probdensity, pixel_areas, total_prob=0.9):
    '''
    Given an array of probability density and corresponding pixel areas
    Finds the healpix index of the 90% region.
    '''
    sorted_indexs = np.argsort(-probdensity)
    sorted_probdensity = probdensity[sorted_indexs]
    sorted_pixel_areas = pixel_areas[sorted_indexs]
    sorted_prob = sorted_probdensity * sorted_pixel_areas
    cumprob = np.cumsum(sorted_prob)
    threshold_index = cumprob.searchsorted(0.9)
    mostprob_nuniq_indexs = sorted_indexs[:threshold_index+1]
    return mostprob_nuniq_indexs

def get_galaxy_catalog(euclid, filename):
    '''
    Takes in the euclid df with RA, Dec, ztrue, zmean, 
    zsigma, and the sky localistion.

    Returns the galaxy catalog keeping only galaxies 
    within 90% localisation area.

    For each galaxy, find the skymap information 
    (prob density, dL mean and error, dLnorm) at that pixel.

    Returns a new df with new columns.
    '''
    skymap = QTable.read(filename)
    max_level = 29
    max_nside = ah.level_to_nside(max_level)
    level, ipix = ah.uniq_to_level_ipix(skymap['UNIQ'])
    big_indexs = ipix * (2**(max_level - level))**2
    sorter = np.argsort(big_indexs)

    probdensity = skymap['PROBDENSITY']
    pixel_areas = ah.nside_to_pixel_area(ah.level_to_nside(level))

    # healpix indexes of 90% region
    mostprob_nuniq_indexs = find_indexs_in_region(probdensity, pixel_areas) 

    galaxy_catalog_list = []
    galaxy_nuniq_indexs = []
    mostprob_probdensities = []
    mostprob_distmus = []
    mostprob_distsigmas = []
    mostprob_distnorms = []

    for row in euclid.itertuples(index=False): # for each galaxy
        coords = row.RA * u.deg, row.Dec * u.deg
        index = find_index_from_coords(coords, big_indexs, sorter, max_nside) #healpix index of galaxy
        galaxy_nuniq_indexs.append(index)
        if index in mostprob_nuniq_indexs: #if galaxy is in 90% region
            galaxy_catalog_list.append(row._asdict()) #add the galaxy information to result

            # new columns added to result, representing values at that galaxy's position
            mostprob_probdensities.append(skymap[index]['PROBDENSITY'].value)
            mostprob_distmus.append(skymap[index]['DISTMU'].value)
            mostprob_distsigmas.append(skymap[index]['DISTSIGMA'].value)
            mostprob_distnorms.append(skymap[index]['DISTNORM'].value)
    
    galaxy_catalog = pd.DataFrame(galaxy_catalog_list)
    galaxy_catalog['ProbDensity'] = np.array(mostprob_probdensities)
    galaxy_catalog['DistMu'] = np.array(mostprob_distmus)
    galaxy_catalog['DistSigma'] = np.array(mostprob_distsigmas)
    galaxy_catalog['DistNorm'] = np.array(mostprob_distnorms)

    return galaxy_catalog

def find_catalog_zlimits(galaxy_catalog):
    '''
    ## SHOULD THIS BE INCLUDED??? SOME PAPERS DON'T HAVE THIS CUT
    Given a localisation region, finds the z_min and z_max to cut catalog,
    based on dL_min and dL_max.
    '''
    max_dL = max(galaxy_catalog['DistMu'])*2
    if max_dL == np.inf:
        max_dL = 10000
    dL_values = np.linspace(0,max_dL,1000)
    p_dL = np.zeros(len(dL_values))
    probdensity = np.array(galaxy_catalog['ProbDensity'])
    distmu = np.array(galaxy_catalog['DistMu'])
    distsigma = np.array(galaxy_catalog['DistSigma'])
    for i in range(len(probdensity)):
        p_dL += probdensity[i] * gaussian_likelihood(dL_values,distmu[i],distsigma[i])
    dL_lower_bound, dL_upper_bound = confidence_interval(dL_values,p_dL,0.9)
    z_lower_bound = z_finder(dL_lower_bound,H0_prior_min)
    z_upper_bound = z_finder(dL_upper_bound,H0_prior_max)
    return z_lower_bound, z_upper_bound

def cut_catalog_z(galaxy_catalog,z_lower_bound,z_upper_bound):
    '''
    Performs a cut on galaxy catalog df
    Keeps galaxies within (z_lower_bound, z_upper_bound)
    '''
    galaxy_catalog = galaxy_catalog[(galaxy_catalog['zmean']>z_lower_bound)
                                            &(galaxy_catalog['zmean']<z_upper_bound)]
    result = galaxy_catalog.reset_index(drop=True)
    return result

def calculate_preds(zmeans, zsigmas, p_bg):
    '''
    Returns an array of subarrays.
    Each subarray represents probability of observing a galaxy at that redshift.
    '''
    p_reds = []
    for j in range(len(zmeans)):
        zmean = zmeans[j]
        zsigma = zsigmas[j]
        L_red = gaussian_likelihood(z_values,zmean,zsigma)
        p_red = normalize(z_values,L_red*p_bg)
        p_reds.append(p_red)
    p_reds = np.array(p_reds)
    return p_reds

def calculate_posterior_nobeta(H0_values, p_reds, galaxy_catalog):
    posterior = []
    for Hi, H0 in enumerate(H0_values):
        sum_over_gals = 0
        dL_values = np.array([dL(z,H0) for z in z_values])
        for j in range(len(zmeans)):
            prob_j = galaxy_catalog.loc[j,'ProbDensity']
            dLmean = galaxy_catalog.loc[j,'DistMu']
            dLsigma = galaxy_catalog.loc[j,'DistSigma']
            dLnorm = galaxy_catalog.loc[j,'DistNorm']
            L_GW = prob_j * gaussian_likelihood(dL_values,dLmean,dLsigma)#* dLnorm
            p_red = p_reds[j]
            to_integrate = L_GW*p_red
            integral = np.trapz(to_integrate,z_values)
            sum_over_gals += integral
        each_posterior_nobeta = sum_over_gals
        posterior.append(each_posterior_nobeta)
        print(f'H0 = {H0} done',end='\r')
    return np.array(posterior)
    
# %%
z_values = np.linspace(0, 5, 1000)
p_bg = np.array([p_bg_func(z) for z in z_values])

#%% READING PARAMETERS AGAIN
os.chdir(original_directory)
import re
params_all = {}

patterns = {
    'm1': r'--fixed-mass1 (\d+\.?\d*)',
    'm2': r'--fixed-mass2 (\d+\.?\d*)',
    't_start': r'--gps-start-time (\d+\.\d+)',
    't_end': r'--gps-end-time (\d+\.\d+)',
    'min_dL': r'--min-distance (\d+\.\d+)e3',
    'max_dL': r'--max-distance (\d+\.\d+)e3',
    'RA': r'--longitude (-?\d+\.\d+)',
    'Dec': r'--latitude (-?\d+\.\d+)'
}

subfolders = [f.path for f in os.scandir() if f.is_dir()]
subfolders.sort()
for subfolder in subfolders:
    params_n = {}
    event_n = int(subfolder[-3:])
    file_path = subfolder+'/gen.sh'
    with open(file_path, 'r') as file:
        sh_string = file.read()
    for key, pattern in patterns.items():
        match = re.search(pattern, sh_string)
        params_n[key] = float(match.group(1))
    params_n['truedL'] = (params_n['min_dL'] + params_n['max_dL'])/2
    params_n['truez'] = z_finder(params_n['truedL'],true_H0)
    params_all[event_n] = params_n

#%%
plot=False
n_events_sofar_post = 406
n_events_end_post = 429

for event_n in range(n_events_sofar_post,n_events_end_post):
    subfolder = 'event'+'{:03}'.format(event_n)
    files = os.listdir(subfolder)
    fits_files = [f for f in files if f.endswith('.fits')]
    filename = subfolder + '/' + fits_files[0]
    print('processing',filename)
    allz_galaxy_catalog = get_galaxy_catalog(euclid,filename) #allz_
    if len(galaxy_catalog) == 0:
        print(subfolder, 'localised where catalog empty')
        continue
    z_lower_bound, z_upper_bound = find_catalog_zlimits(allz_galaxy_catalog)
    galaxy_catalog = cut_catalog_z(allz_galaxy_catalog,z_lower_bound,z_upper_bound)
    true_ra, true_dec = params_all[event_n]['RA'], params_all[event_n]['Dec']
    true_z = params_all[event_n]['truez']
    true_dL = params_all[event_n]['truedL']
    if plot is True:
        plt.scatter(galaxy_catalog['RA'], galaxy_catalog['Dec'], c=galaxy_catalog['ProbDensity'], s=4, cmap='inferno')
        plt.colorbar(label='ProbabilityDensity')
        plt.scatter(true_ra, true_dec, marker='o', edgecolor='blue', facecolor='none', s=100,label='true_z='+f'{true_z:.3f}, true_dL='+f'{true_dL:.3f}')
        plt.title(f'Event {event_n}, (N={len(galaxy_catalog)})')
        plt.legend(bbox_to_anchor=(1, 1))
        plt.xlabel('RA (degrees)')
        plt.ylabel('Dec (degrees)')
        plt.show()
    zmeans = galaxy_catalog['zmean']
    zsigmas = galaxy_catalog['zsigma']
    p_reds = calculate_preds(zmeans, zsigmas, p_bg)
    posterior_nobeta = calculate_posterior_nobeta(H0_values, p_reds, galaxy_catalog)
    all_posteriors_nobeta[(event_n,true_z)] = posterior_nobeta
    if plot is True:
        plt.plot(H0_values,posterior_nobeta)
        plt.show()
    np.save(subfolder+'/posterior_nobeta.npy',posterior_nobeta)

print('POSTERIORS DONE')

#%% DELETING ALL POSTERIORS NO BETA
# import glob
# for folder, subfolders, files in os.walk(os.getcwd()):
#     npy_files = glob.glob(os.path.join(folder, '*.npy'))
#     for npy_file in npy_files:
#         os.remove(npy_file)

#%% PLOTTING INDIVIDUAL POSTERIORS NO BETA 
total_n = 402
all_posteriors_nobeta = {}
for event_n in range(total_n):
    subfolder = 'event'+'{:03}'.format(event_n)
    posterior_nobeta = np.load(subfolder+'/posterior_nobeta.npy')
    all_posteriors_nobeta[(event_n,params_all[event_n]['truez'])] = posterior_nobeta

import plotly.graph_objects as go
fig = go.Figure()

for i, (hostz, posterior_nobeta) in enumerate(all_posteriors_nobeta.items()):
    fig.add_trace(go.Scatter(
        x=H0_values,
        y=posterior_nobeta,
        mode='lines',
        name=f'z={hostz},i={i}'
    ))

fig.update_layout(
    title=f'Posteriors no betas',
    xaxis_title='H0',
    yaxis_title='posterior',
    legend_title='hostz'
)

html_file = 'posteriors_no_betas.html'
fig.write_html(html_file)
import webbrowser
webbrowser.open('file://' + os.path.realpath(html_file))

#%% PGW
# PGW_values_dict = {}
# for H0 in H0_values:
#     PGW_values = np.load(f'/Users/xq/Desktop/dark_sirens/betaMC/PGW_values_H0={H0}.npy')
#     plt.plot(np.linspace(0.01,1,25),PGW_values,label=f'H0={H0}')
# plt.legend()

#%% BETAS
## RAW BETAS
betas = np.load('../betaMC/betas_0923_pcat.npy')

#### CUBIC FITTING
# betas_values = np.load('../betaMC/betas_0923_pcat.npy')
# coefficients = np.polyfit(H0_values, betas_values, 3)
# beta_cubic_function = np.poly1d(coefficients)
# betas = beta_cubic_function(H0_values)

##### PURE CUBIC
# betas = H0_values**3

# plt.plot(H0_values,betas,label='smoothed (fitted cubic)')
# plt.plot(H0_values,betas_values,label='original')
# plt.legend()
# plt.title("Betas against H0")

#%% ADDING IN BETA
all_posteriors = {}
for hostz, posterior_nobeta in all_posteriors_nobeta.items():
    posterior = posterior_nobeta / (betas)
    posterior = normalize(H0_values, posterior)
    all_posteriors[hostz] = posterior

#%% PLOTTING INDIVIDUAL POSTERIORS WITH BETA 
fig = go.Figure()
for hostz, posterior in all_posteriors.items():
    fig.add_trace(go.Scatter(
        x=H0_values,
        y=posterior,
        mode='lines',
        name=f'z={hostz},i={i}'
    ))

fig.update_layout(
    title=f'Posteriors with betas',
    xaxis_title='H0',
    yaxis_title='posterior',
    legend_title='hostz'
)

fig.update_xaxes(range=[30,140])
fig.update_yaxes(range=[0,0.025])
html_file = 'posteriors_with_betas.html'
fig.write_html(html_file)
import webbrowser
webbrowser.open('file://' + os.path.realpath(html_file))

#%% LOG POSTERIOR
posterior_distributions = []
for hostz,posterior in all_posteriors.items():
    posterior_distributions.append(posterior)
posterior_distributions = np.array(posterior_distributions)

log_posteriors = np.log(posterior_distributions)
combined_log_posterior = np.sum(log_posteriors,axis=0)

H0_values_from40 = H0_values[4:]
combined_log_posterior_from40 = combined_log_posterior[4:]
scaleup_from40 = -min(combined_log_posterior_from40)
combined_log_posterior_from40_scaled = combined_log_posterior_from40+scaleup_from40
combined_posterior_from40 = np.exp(combined_log_posterior_from40_scaled)
plt.plot(H0_values_from40,combined_posterior_from40)

scaleup = -min(combined_log_posterior)
combined_log_posterior += scaleup
combined_posterior = np.exp(combined_log_posterior)

plt.plot(H0_values,combined_posterior)
plt.plot([true_H0,true_H0],[0,max(combined_posterior)],
         linestyle='--',label='true'+r'$H_0$'+f'={true_H0}')
plt.title('combined posterior')
plt.xlim(30,140)
plt.ylim(0,1.2*max(combined_posterior[3:]))
plt.show()
#%% PLOTTING COMBINED POSTERIOR
combined_posterior = np.ones(len(H0_values))
i=0
for hostz, posterior in all_posteriors.items():
    if i<300 or i>320:
        i+=1
        continue
    combined_posterior *= 100*posterior
    i+=1
plt.plot(H0_values,combined_posterior)
plt.plot([true_H0,true_H0],[0,max(combined_posterior)],
         linestyle='--',label='true'+r'$H_0$'+f'={true_H0}')
plt.title('combined posterior')
plt.xlim(30,140)
plt.ylim(0,1.2*max(combined_posterior[3:]))
plt.show()

#%% PLOTTING DISTRIBUTION OF Z EVENTS
events_z = []
for _, hostz in all_posteriors_nobeta.keys():
    events_z.append(hostz)
events_z = np.array(events_z)
plt.hist(events_z,bins=np.linspace(0,1,10))
plt.show()

plt.plot(events_z,np.ones(len(events_z)),'.')
plt.show()
# %%
# GENERATING NON DETECTED EVENT
#Draw parameters
# params_n = {}
# host_truez = 0.7
# host_dL = dL(host_truez,true_H0)
# host_ra = euclid['RA'][host_index]
# host_dec = euclid['Dec'][host_index]
# m1 = draw_from_mass_distr_m1()
# m2 = draw_from_mass_distr_m2(m1)
# t_start = draw_from_time()
# t_end = t_start + 7200
# print(n_events_sofar, 'params drawn')

# folder_name = 'not_det'
# os.makedirs(folder_name, exist_ok=True)
# script_content = sh_template.format(
#         RA=host_ra,
#         Dec=host_dec,
#         min_dL=host_dL-0.01,
#         max_dL=host_dL+0.01,
#         m1=m1,
#         m2=m2,
#         t_start=t_start,
#         t_end=t_end)

# file_path = os.path.join(folder_name, "gen.sh")
# with open(file_path, "w") as file:
#     file.write(script_content)
# os.chmod(file_path, 0o755)
# print(n_events_sofar, '.sh created')

# #Execute Bayestar
# os.chdir(folder_name)
# sh_files = [f for f in os.listdir() if f.endswith('.sh')]
# with subprocess.Popen(['bash', sh_files[0]], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL) as process:
#         process.communicate()  # Ensure the process completes

# %%

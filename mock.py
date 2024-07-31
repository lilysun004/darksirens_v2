#%% IMPORTS AND PARAMETERS
from pycbc.waveform import get_fd_waveform
from pycbc.filter import sigma
from pycbc.psd import analytical
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
from scipy.integrate import quad
import healpy as hp
from scipy.optimize import brentq

Omega_m = 0.319
Omega_lamb = 1- Omega_m
c = 299792.458
true_H0 = 67
H0_prior_min, H0_prior_max = 20, 140
dL_int_values = np.linspace(0,10000,1000)
prior_dL = dL_int_values**2

H0_values = np.linspace(H0_prior_min,H0_prior_max,25)

mmin, mmax = 2.2, 86.16
y1, y2 = 1.05, 5.17
bq, bbreak = 0.28, 0.41
mbreak = mmin + bbreak*(mmax - mmin)
a2 = mbreak ** (y2-y1)
m_values = np.linspace(mmin,mmax,1000)

snr_threshold = 12
snr_indiv_threshold = 4
min_triggers = 2
approximant = 'SEOBNRv4_ROM'
f_low = 20.0
delta_f = 1/40
duration = 4.0

#%% MATH FUNCTIONS
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

def normalize(x,y):
    C = np.trapz(y,x)
    if C <= 10e-100:
        return np.zeros(len(y)) 
    return 1/C*y

def gaussian_likelihood(x_values, x_mean, x_sigma):
    return (1.0 / (x_sigma * np.sqrt(2 * np.pi))) * np.exp(-0.5 * ((x_values - x_mean) / x_sigma) ** 2)

def p_bg_integrand(z):
    return r_c(z)**2/E(z)

def p_bg_func(z):
    numerator = p_bg_integrand(z)
    denominator = quad(p_bg_integrand,0,np.inf)[0]
    return numerator/denominator

def r_c(z):
    return quad(dL_integrand,0,z)[0]

def Vc_integrand(z):
    return r_c(z)**2 / E(z)

def V_c(z):
    return quad(Vc_integrand,0,z)[0]

def equal(value, target, tolerance=0.001):
    tolerance_value = target * tolerance
    return abs(value - target) <= tolerance_value

def confidence_interval(x,y,ci): # assumes x is equally spaced array!
    total_area = np.sum(y)
    sorted_indices = np.argsort(-y)
    cumulative_prob = np.cumsum(y[sorted_indices])
    threshold_index = np.argmax(cumulative_prob >= ci*total_area)
    mostprob_indices = sorted_indices[:threshold_index+1]
    interval_x = x[mostprob_indices]
    return min(interval_x), max(interval_x)

def min_triggers_reached(snr_list):
    count = sum(1 for snr in snr_list if snr > snr_indiv_threshold)
    return count >= min_triggers

#%% IMPORTANT FUNCTIONS
def choose_host_galaxy(euclid, possible_host_indexs):
    host_index = np.random.choice(possible_host_indexs)
    truera = euclid['RA'][host_index]
    truedec = euclid['Dec'][host_index]
    truez = euclid['ztrue'][host_index]
    return truera, truedec, truez

def p1(m1):
    if m1 >= mmin and m1 < mbreak:
        return m1**(-y1)
    if m1 >= mbreak and m1 <= mmax:
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

def check_event_detected(truera, truedec, truez, truedL):
    m1 = draw_from_mass_distr_m1()
    m2 = draw_from_mass_distr_m2(m1)
    inc = np.random.uniform(0,2*np.pi)
    hp, _ = get_fd_waveform(approximant=approximant,
                            mass1=m1,
                            mass2=m2,
                            delta_f=delta_f,
                            f_lower=f_low,
                            inclination=inc,
                            distance=truedL)
    psd_H1 = analytical.aLIGOZeroDetHighPower(len(hp), hp.delta_f, f_low)
    psd_L1 = analytical.aLIGOZeroDetHighPower(len(hp), hp.delta_f, f_low)
    psd_V1 = analytical.Virgo(len(hp), hp.delta_f, f_low)
    snr_H1 = sigma(hp, psd=psd_H1, low_frequency_cutoff=f_low)
    snr_L1 = sigma(hp, psd=psd_L1, low_frequency_cutoff=f_low)
    snr_V1 = sigma(hp, psd=psd_V1, low_frequency_cutoff=f_low)
    combined_snr = np.sqrt(snr_H1**2 + snr_L1**2 + snr_V1**2)
    if min_triggers_reached([snr_H1,snr_L1,snr_V1]) and combined_snr >= snr_threshold:
        return True
    else:
        return False

def generate_skymap(ra_star, dec_star, ra_sigma, dec_sigma, dL_star, nside=1024, dL_mean_scale=0.2, dL_sigma_scale=0.2):
    phi_star = ra_star
    theta_star = 90 - dec_star
    npix = hp.nside2npix(nside)
    pixis = range(npix)
    thetas, phis = hp.pix2ang(nside,pixis)
    ras = np.degrees(phis)
    decs = 90 - np.degrees(thetas)
    ra_diffs = ras - ra_star
    dec_diffs = decs - dec_star
    i_star = hp.ang2pix(nside, np.radians(theta_star), np.radians(phi_star))

    probs = np.exp(-0.5 * (ra_diffs**2 / ra_sigma**2 + dec_diffs**2 / dec_sigma**2))
    probs = probs / np.sum(probs)

    angles = np.degrees(hp.rotator.angdist((ras, decs), (ra_star, dec_star), lonlat=True))
    dL_means_locs = np.full(npix,dL_star)
    dL_means_scales = dL_mean_scale*(angles/90)*dL_star
    dL_means = np.random.normal(loc=dL_means_locs, scale=dL_means_scales)

    dL_sigmas = dL_sigma_scale*dL_means

    gw_df = pd.DataFrame()
    gw_df['RA'] = ras
    gw_df['Dec'] = decs
    gw_df['Prob'] = probs
    gw_df['DistMu'] = dL_means
    gw_df['DistSigma'] = dL_sigmas

    return gw_df

def get_mostprob_skymap(gw_df, prob_cutoff=0.9):
    prob = gw_df['Prob']
    sorted_indices = np.argsort(-prob)
    cumulative_prob = np.cumsum(prob[sorted_indices])
    threshold_index = np.argmax(cumulative_prob >= prob_cutoff)
    mostprob_indices = np.array(sorted_indices[:threshold_index + 1])
    mostprob_df = gw_df.iloc[mostprob_indices].copy()
    return mostprob_df

def find_dL_norm(row):
    p_dL_unnorm = gaussian_likelihood(dL_int_values, row['DistMu'], row['DistSigma'])
    dL_norm = 1/np.trapz(p_dL_unnorm*prior_dL,dL_int_values)
    return dL_norm

def add_dL_norms(mostprob_df):
    mostprob_df['DistNorm'] = mostprob_df.apply(find_dL_norm,axis=1)

def find_catalog_zlimits(mostprob_df):
    dL_values = np.linspace(0,2*hostdL,1000)
    p_dL = np.zeros(len(dL_values))
    prob = np.array(mostprob_df['Prob'])
    distmu = np.array(mostprob_df['DistMu'])
    distsigma = np.array(mostprob_df['DistSigma'])
    for i in range(len(prob)):
        p_dL += prob[i] * gaussian_likelihood(dL_values,distmu[i],distsigma[i])
    dL_lower_bound, dL_upper_bound = confidence_interval(dL_values,p_dL,0.9)
    z_lower_bound = z_finder(dL_lower_bound,H0_prior_min)
    z_upper_bound = z_finder(dL_upper_bound,H0_prior_max)
    return z_lower_bound, z_upper_bound

def clean_euclid(filename, gw_nside=1024): # do only once
    euclid_df = pd.read_parquet(filename)
    column_names = {'truez':'ztrue','obsz':'zmean'}
    euclid_df.rename(columns=column_names, inplace=True)
    euclid_df = euclid_df[euclid_df['ztrue'] < 1]
    euclid_df['zsigma'] = 0.05 * (1+euclid_df['zmean'])
    phis = np.deg2rad(euclid_df['RA'])
    thetas = np.deg2rad(90 - euclid_df['Dec'])
    healpix_indexs_all = hp.pixelfunc.ang2pix(gw_nside,thetas,phis)
    euclid_df['HP_Index'] = healpix_indexs_all
    return euclid_df

def cut_catalog(galaxy_catalog, zcatmin, zcatmax, mostprob_df):
    mostprob_indexs = mostprob_df.index.to_numpy()
    galaxy_catalog = galaxy_catalog[(galaxy_catalog['zmean'] > zcatmin) & (galaxy_catalog['zmean'] < zcatmax)]
    galaxy_catalog = galaxy_catalog[galaxy_catalog['HP_Index'].isin(mostprob_indexs)]
    galaxy_catalog = galaxy_catalog.reset_index(drop=True)

    return galaxy_catalog

def calculate_preds(zmeans, zsigmas, p_bg):
    p_reds = []
    for j in range(len(zmeans)):
        zmean = zmeans[j]
        zsigma = zsigmas[j]
        L_red = gaussian_likelihood(z_values,zmean,zsigma)
        p_red = normalize(z_values,L_red*p_bg)
        p_reds.append(p_red)
    p_reds = np.array(p_reds)
    return p_reds

def calculate_posterior_nobeta(H0_values, p_reds, mostprob_df):
    posterior = []
    for Hi, H0 in enumerate(H0_values):
        sum_over_gals = 0
        dL_values = np.array([dL(z,H0) for z in z_values])
        for j in range(len(zmeans)):
            healpix_index = healpix_indexs[j]
            prob_j = mostprob_df.loc[healpix_index,'Prob']
            dLmean = mostprob_df.loc[healpix_index,'DistMu']
            dLsigma = mostprob_df.loc[healpix_index,'DistSigma']
            dLnorm = mostprob_df.loc[healpix_index,'DistNorm']
            L_GW = prob_j * gaussian_likelihood(dL_values,dLmean,dLsigma) * dLnorm
            p_red = p_reds[j]
            to_integrate = L_GW*p_red
            integral = np.trapz(to_integrate,z_values)
            sum_over_gals += integral
        each_posterior_nobeta = sum_over_gals
        posterior.append(each_posterior_nobeta)
        print(f'H0 = {H0} done',end='\r')
    return np.array(posterior)

#%% GALAXY CATALOG PROCESSING
euclid = clean_euclid('subeuclid.parquet')
possible_host_indexs = euclid.index.to_numpy()

#%% P_BG 
z_values = np.linspace(0, 5, 1000)
p_bg = np.array([p_bg_func(z) for z in z_values])

#%% BETAS INTERPOLATION
betas_values = np.load('betas/betas_0729.npy')
coefficients = np.polyfit(H0_values, betas_values, 3)
beta_cubic_function = np.poly1d(coefficients)
betas = beta_cubic_function(H0_values)

plt.plot(H0_values,betas,label='smoothed (fitted cubic)')
plt.plot(H0_values,betas_values,label='original')
plt.legend()
plt.title("Betas against H0")

#%% BETAS CALCULATION ERF METHOD
# from math import erf
# betas = []
# dL_threshold = 1500
# z_values = np.linspace(0, 5, 1000)
# p_bg = np.array([p_bg_func(z) for z in z_values])

# euclid_p_reds = calculate_preds(np.array(euclid['zmean']), np.array(euclid['zsigma']), p_bg)
# euclid_pcat_values = normalize(z_values,np.sum(euclid_p_reds,axis=0))

# for H0 in H0_values:
#     dL_values = np.array([dL(z,H0) for z in z_values])
#     erf_args = np.array([(dL_threshold-dLeach) / (np.sqrt(2) * 0.01 * dLeach) for dLeach in dL_values])
#     erf_values = np.array([erf(arg) for arg in erf_args])
#     PGW_values = 0.5 * (1+erf_values)
#     plt.plot(z_values,PGW_values,label=H0)
#     beta = np.trapz(PGW_values*euclid_pcat_values,z_values)
#     betas.append(beta)
# plt.legend()
# plt.show()

# betas = np.array(betas)
# plt.plot(H0_values, betas)

#%% START / RESTART 
all_posteriors_nobeta = {}

#%% GENERATING H0 POSTERIOR IN A LOOP
n_events = 0
while n_events < 10:
    # Generating event
    hostra, hostdec, hostz = choose_host_galaxy(euclid,possible_host_indexs)
    hostdL = dL(hostz,true_H0)
    print(f'host: coords=({hostra,hostdec}), z={hostz}, dL={hostdL}')
    detected = check_event_detected(hostra, hostdec, hostz, hostdL)
    if detected is False:
        print('event not detected, skipped')
        continue
    gw_df = generate_skymap(hostra, hostdec, 2.5, 2.5, hostdL)
    print(n_events,'skymap generated')

    # Processing skymap and catalog
    mostprob_df = get_mostprob_skymap(gw_df)
    print(n_events,'most probable region found')
    add_dL_norms(mostprob_df)
    zcatmin, zcatmax = find_catalog_zlimits(mostprob_df)
    print(n_events,f"z limits: ({zcatmin},{zcatmax})")
    galaxy_catalog = cut_catalog(euclid,zcatmin, zcatmax,mostprob_df)
    zmeans = galaxy_catalog['zmean']
    zsigmas = galaxy_catalog['zsigma']
    healpix_indexs = galaxy_catalog['HP_Index']

    # Calculating
    p_reds = calculate_preds(zmeans, zsigmas, p_bg)
    posterior_nobeta = calculate_posterior_nobeta(H0_values, p_reds, mostprob_df)
    posterior_nobeta = normalize(H0_values,posterior_nobeta)
    all_posteriors_nobeta[(n_events,hostz)] = posterior_nobeta
    n_events += 1

# with open('saving_results/0725_all_posteriors_nobeta.json', 'w') as json_file:
#     json.dump(all_posteriors_nobeta, json_file)

#%% PLOTTING INDIVIDUAL POSTERIORS NO BETA 
for hostz, posterior_nobeta in all_posteriors_nobeta.items():
    plt.plot(H0_values,posterior_nobeta,label='host_z='+str(hostz))
plt.legend(fontsize='small', bbox_to_anchor=(1, 1))
plt.title('individual posteriors, no beta')
plt.show()

#%% ADDING IN BETA
all_posteriors = {}
for hostz, posterior_nobeta in all_posteriors_nobeta.items():
    posterior = posterior_nobeta / betas
    posterior = normalize(H0_values, posterior)
    all_posteriors[hostz] = posterior

#%% ADDING IN OWN BETA??
# all_posteriors = {}
# for hostz, posterior_nobeta in all_posteriors_nobeta.items():
#     posterior = posterior_nobeta / betas
#     posterior = np.normalize(z_values, posterior)
#     all_posteriors[hostz] = posterior

#%% PLOTTING INDIVIDUAL POSTERIORS WITH BETA 
for hostz, posterior in all_posteriors.items():
    plt.plot(H0_values,posterior,label='host_z='+str(hostz))
#plt.legend(fontsize='small', bbox_to_anchor=(1, 1))
plt.title('individual posteriors, beta')
plt.show()

#%% PLOTTING COMBINED POSTERIOR
combined_posterior = np.ones(len(H0_values))
for hostz, posterior in all_posteriors.items():
    combined_posterior *= 100*posterior
plt.plot(H0_values,combined_posterior)
plt.plot([true_H0,true_H0],[0,max(combined_posterior)],
         linestyle='--',label='true'+r'$H_0$'+f'={true_H0}')
plt.title('combined posterior')
plt.show()

#%% PLOTTING DISTRIBUTION OF Z EVENTS
events_z = np.array(list(all_posteriors_nobeta.keys()))
plt.hist(events_z,bins=np.linspace(0,1,10))
plt.show()

# %% DEBUGGING: PLOTTING SKYMAP PROB
plt.figure(figsize=(10, 5))
ra_bins = np.linspace(hostra - 10, hostra + 10, 50)
dec_bins = np.linspace(hostdec - 10, hostdec + 10, 50)
histprob, ra_edges, dec_edges = np.histogram2d(gw_df['RA'], gw_df['Dec'], bins=[ra_bins, dec_bins], weights=gw_df['Prob'])
plt.imshow(histprob.T, extent=[ra_edges[0], ra_edges[-1], dec_edges[0], dec_edges[-1]],origin='lower', aspect='auto', cmap='viridis')

plt.colorbar(label='proportional to probability')
plt.xlabel('RA (degrees)')
plt.ylabel('Dec (degrees)')
plt.show()

# %% DEBUGGING: PLOTTING SKYMAP DISTMU
plt.figure(figsize=(10, 5))
ra_bins = np.linspace(hostra - 10, hostra + 10, 50)
dec_bins = np.linspace(hostdec - 10, hostdec + 10, 50)
histprob, ra_edges, dec_edges = np.histogram2d(gw_df['RA'], gw_df['Dec'], bins=[ra_bins, dec_bins], weights=gw_df['DistMu'])
plt.imshow(histprob.T, extent=[ra_edges[0], ra_edges[-1], dec_edges[0], dec_edges[-1]],origin='lower', aspect='auto', cmap='viridis')

plt.colorbar(label='proportional to distance')
plt.xlabel('RA (degrees)')
plt.ylabel('Dec (degrees)')
plt.show()

# %%
dL_values = np.linspace(0,2*hostdL,1000)
probs = gw_df['Prob'].values
mus = gw_df['DistMu'].values
sigmas = gw_df['DistSigma'].values
X = dL_values[:, np.newaxis]
means = mus[np.newaxis, :]
sigmas = sigmas[np.newaxis, :]
likelihoods = gaussian_likelihood(X, means, sigmas)

#%%
p_dL = np.zeros(len(dL_values))
for i in range(len(gw_df['Prob'])):
    p_dL += gw_df['Prob'][i] * gaussian_likelihood(dL_values,gw_df['DistMu'][i],gw_df['DistSigma'][i])
plt.plot(dL_values,p_dL)
dL_lower_bound, dL_upper_bound = confidence_interval(dL_values,p_dL,0.9)
z_lower_bound = z_finder(dL_lower_bound,H0_prior_min)
z_upper_bound = z_finder(dL_upper_bound,H0_prior_max)

# %%

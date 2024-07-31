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

true_H0 = 67
Omega_m = 0.319
Omega_lamb = 1- Omega_m
c = 299792.458

# Define the template for the .sh file
sh_template = """lalapps_inspinj \\
-o inj.xml \\
--m-distr fixMasses --fixed-mass1 {m1} --fixed-mass2 {m2} \\
--t-distr uniform --time-step 7200 \\
--gps-start-time 1000000000 \\
--gps-end-time 1000007200 \\
--d-distr volume \\
--min-distance {min_dL}e3 --max-distance {max_dL}e3 \\
--l-distr fixed --longitude {RA} --latitude {Dec} --i-distr uniform \\
--f-lower 20 --disable-spin \\
--waveform SEOBNRv4_ROM

bayestar-sample-model-psd \\
-o psd.xml \\
--E1=EinsteinTelescopeP1600143 \\
--E2=EinsteinTelescopeP1600143 \\
--E3=EinsteinTelescopeP1600143 \\
--X1=CosmicExplorerP1600143

bayestar-realize-coincs \\
-o coinc.xml \\
inj.xml --reference-psd psd.xml \\
--detector E1 E2 E3 X1 \\
--measurement-error gaussian-noise \\
--snr-threshold 4.0 \\
--net-snr-threshold 12.0 \\
--min-triggers 2 \\
--keep-subthreshold

bayestar-localize-coincs coinc.xml
"""

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

def E(z):
    return np.sqrt(Omega_m*(1+z)**3 + Omega_lamb)

def dL_integrand(dummy):
    return 1/E(dummy)

def dL(z,H0):
    integral = quad(dL_integrand,0,z)[0]
    return c*(1+z)/H0 * integral

#%% Load Euclid
euclid = pd.read_parquet('../subeuclid.parquet')
possible_host_indexs = euclid.index.to_numpy()

#%% Generate Parameters
params = {}
n_events_sofar = 0
n_events = 10
while n_events_sofar < n_events:
    params_n = {}
    host_index = np.random.choice(possible_host_indexs)
    host_truez = euclid['ztrue'][host_index]
    host_dL = dL(host_truez,true_H0)
    if host_dL > 800:
        continue
    host_ra = euclid['RA'][host_index]
    host_dec = euclid['Dec'][host_index]
    m1 = draw_from_mass_distr_m1()
    m2 = draw_from_mass_distr_m2(m1)
    params_n = {'RA':host_ra,
                'Dec':host_dec,
                'min_dL':host_dL-0.01,
                'max_dL':host_dL+0.01,
                'm1':m1,
                'm2':m2,
                'truez':host_truez,
                'truedL':host_dL}
    params[n_events_sofar] = params_n
    n_events_sofar += 1

#%%
for i in range(n_events):
    folder_name = 'event_'+'{:03}'.format(i+1)
    os.makedirs(folder_name, exist_ok=True)
    
    script_content = sh_template.format(
        RA=params[i]['RA'],
        Dec=params[i]['Dec'],
        min_dL=params[i]['min_dL'],
        max_dL=params[i]['max_dL'],
        m1=params[i]['m1'],
        m2=params[i]['m2']
    )

    file_path = os.path.join(folder_name, "gen.sh")
    
    with open(file_path, "w") as file:
        file.write(script_content)
    
    # Make the script executable
    os.chmod(file_path, 0o755)

print("10 script files have been generated and saved in their respective folders.")

# %%
os.environ['LAL_DATA_PATH'] = '/Users/xq/Desktop/dark_sirens'
original_directory = os.getcwd()
# %%
subfolders = [f.path for f in os.scandir() if f.is_dir()]
subfolders.sort()
for subfolder in subfolders:
    os.chdir(subfolder)
    sh_files = [f for f in os.listdir() if f.endswith('.sh')]
    for sh_file in sh_files:
        try:
            print(os.getcwd())
            print(f"Running {subfolder}...")
            subprocess.run(['bash', sh_file], check=True)
        except subprocess.CalledProcessError as e:
            print(f"Error running {subfolder}: {e}")
        finally:
            os.chdir(original_directory)

print('Done running Bayestars on all possible events')
#%%
def find_index_from_coords(coords, big_indexs, sorter, max_nside):
    ra, dec = coords
    match_ipix = ah.lonlat_to_healpix(ra, dec, max_nside, order='nested')
    i = sorter[np.searchsorted(big_indexs, match_ipix, side='right', sorter=sorter)-1]
    return i

def find_indexs_in_region(probdensity, pixel_areas, total_prob=0.9):
    sorted_indexs = np.argsort(-probdensity)
    sorted_probdensity = probdensity[sorted_indexs]
    sorted_pixel_areas = pixel_areas[sorted_indexs]
    sorted_prob = sorted_probdensity * sorted_pixel_areas
    cumprob = np.cumsum(sorted_prob)
    threshold_index = cumprob.searchsorted(0.9)
    mostprob_nuniq_indexs = sorted_indexs[:threshold_index+1]
    return mostprob_nuniq_indexs

def get_galaxy_catalog(euclid, filename):
    skymap = QTable.read(filename)
    max_level = 29
    max_nside = ah.level_to_nside(max_level)
    level, ipix = ah.uniq_to_level_ipix(skymap['UNIQ'])
    big_indexs = ipix * (2**(max_level - level))**2
    sorter = np.argsort(big_indexs)

    probdensity = skymap['PROBDENSITY']
    pixel_areas = ah.nside_to_pixel_area(ah.level_to_nside(level))

    mostprob_nuniq_indexs = find_indexs_in_region(probdensity, pixel_areas)
    galaxy_catalog_list = []
    galaxy_nuniq_indexs = []
    mostprob_probdensities = []
    mostprob_distmus = []
    mostprob_distsigmas = []
    mostprob_distnorms = []

    for row in euclid.itertuples(index=False):
        coords = row.RA * u.deg, row.Dec * u.deg
        index = find_index_from_coords(coords, big_indexs, sorter, max_nside)
        galaxy_nuniq_indexs.append(index)
        if index in mostprob_nuniq_indexs:
            galaxy_catalog_list.append(row._asdict())
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

# %%
for subfolder in subfolders:
    files = os.listdir(subfolder)
    fits_files = [f for f in files if f.endswith('.fits')]
    if fits_files:
        event_n = int(subfolder[-3:])-1
        filename = subfolder + '/' + fits_files[0]
        print('processing ',filename)
        galaxy_catalog = get_galaxy_catalog(euclid,filename)
        if len(galaxy_catalog) == 0:
            continue
        plt.scatter(galaxy_catalog['RA'], galaxy_catalog['Dec'], c=galaxy_catalog['ProbDensity'], s=4, cmap='inferno')
        plt.colorbar(label='ProbabilityDensity')
        true_ra, true_dec = params[event_n]['RA'], params[event_n]['Dec']
        true_z = params[event_n]['truez']
        true_dL = params[event_n]['truedL']
        plt.scatter(true_ra, true_dec, marker='o', edgecolor='blue', facecolor='none', s=100,label='true_z='+f'{true_z:.3f}, true_dL='+f'{true_dL:.3f}')
        plt.title(f'Event {event_n}, (N={len(galaxy_catalog)})')
        plt.legend(bbox_to_anchor=(1, 1))
        plt.xlabel('RA (degrees)')
        plt.ylabel('Dec (degrees)')
        plt.show()

# %%

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
import json

true_H0 = 67
Omega_m = 0.319
Omega_lamb = 1- Omega_m
c = 299792.458

H0_prior_min, H0_prior_max = 20.0, 140.0
H0_values = np.arange(H0_prior_min,H0_prior_max+5.0,5.0)

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
"""
#
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


#%% DEFINING RANGE OF Z AND PGW DICTIONARY
z_values = np.linspace(0.01,1,25)
PGW_dict = {}
# key: H0_value
# value: array of P_GW against z_value

#%% DEFINING COMPUTE PGW FUNCTION
def compute_PGW(z,H0,n_draws):
    n_drawn_sofar = 0
    n_detected = 0
    while n_drawn_sofar < n_draws:
        for file in os.listdir():
            if file.endswith('.fits') or file.endswith('.xml') or file.endswith('.sh'):
                os.remove(file)
        params_n = {}
        host_dL = dL(z,H0)
        host_ra = np.random.uniform(-180,180)
        host_dec = np.random.uniform(-90,90)
        m1 = draw_from_mass_distr_m1()
        m2 = draw_from_mass_distr_m2(m1)
        t_start = draw_from_time()
        t_end = t_start + 7200
        script_content = sh_template.format(
        RA=host_ra,
        Dec=host_dec,
        min_dL=host_dL-0.01,
        max_dL=host_dL+0.01,
        m1=m1,
        m2=m2,
        t_start=t_start,
        t_end=t_end)

        # Create and run gen.sh
        file_path = "gen.sh"
        with open(file_path, "w") as file:
            file.write(script_content)
        os.chmod(file_path, 0o755)
        sh_files = [f for f in os.listdir() if f.endswith('.sh')]

        with subprocess.Popen(['bash', sh_files[0]], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL) as process:
            process.communicate()  # Ensure the process completes
        
        if os.path.getsize('coinc.xml') < 50 * 1024:
            print("No event detected")
        else:
            print('Event detected')
            n_detected += 1
        
        # Check if fits exists
        # fits_files = [f for f in os.listdir() if f.endswith('.fits')]
        # if fits_files:
        #     n_detected += 1
        
        # Clear fits and xml files, move on to next
        for file in os.listdir():
            if file.endswith('.xml') or file.endswith('.sh'):
                os.remove(file)

        n_drawn_sofar += 1

        print(f'H0={H0},z={z},drawn={n_drawn_sofar}/{n_draws},detected={n_detected}')
        
    return n_detected / n_draws

#%% GENERATE EVENTS AND SKYMAPS
n_draws = 20
for H0 in H0_values[-1:]:
    PGW_values = []
    for z in z_values:
        if len(PGW_values) > 2 and PGW_values[-1] == 0 and PGW_values[-2] == 0:
            print(f'H0={H0},z={z}, broke!')
            break
        PGW_each_z = compute_PGW(z,H0,n_draws)
        PGW_values.append(PGW_each_z)
        print(f'H0={H0}, z={z} done')
    PGW_values.extend([0] * (len(z_values) - len(PGW_values)))
    PGW_values = np.array(PGW_values)
    np.save(f'PGW_values_H0={H0}.npy',PGW_values)
    plt.plot(z_values,PGW_values)
    plt.title(f'PGW against z for H0={H0}')
    plt.show()

# with open("PGW_dict.json", "w") as file:
#     json.dump(PGW_dict, file)

#%% COMBINING DIFFERENT RUNS
for H0 in H0_values:
    ndraws20 = np.load(f'ndraws=20/PGW_values_H0={H0}.npy')
    ndraws30 = np.load(f'ndraws=30/PGW_values_H0={H0}.npy')
    PGW_values = 0.4*ndraws20 + 0.6*ndraws30
    np.save(f'PGW_values_H0={H0}.npy',PGW_values)

#%% PLOTTING
for H0 in H0_values:
    PGW_values = np.load(f'ndraws=20/PGW_values_H0={H0}.npy')
    plt.plot(z_values,PGW_values,label=H0)

plt.legend()

#%% READING INTO DICTIONARY
PGW_values_dict = {}
for H0 in H0_values:
    PGW_values = np.load(f'PGW_values_H0={H0}.npy')
    PGW_values_dict[H0] = PGW_values

#%%
euclid = pd.read_parquet('../subeuclid_fullsky.parquet')
euclid_catalog = euclid.sample(frac=0.05)
# euclid_catalog = euclid_catalog[(euclid_catalog['ztrue']<1)]
euclid_catalog.reset_index(inplace=True,drop=True)
print(euclid_catalog)
truez = np.array(euclid_catalog['ztrue'])
zmeans = np.array(euclid_catalog['zmean'])
zsigmas = np.array(euclid_catalog['zsigma'])
z_values_pcat = np.linspace(0, 5, 1000)
p_bg = np.array([p_bg_func(z) for z in z_values_pcat])

#%% FITTING SIGMOID
# from scipy.optimize import curve_fit

# def sigmoid(x, k, x0):
#     return 1 / (1 + np.exp(k * (x - x0)))

# initial_guess = [0.1, 50]
# PGW_dict = {}
# for H0, PGW_values in PGW_values_dict.items():
#     params, covariance = curve_fit(sigmoid, H0_values, PGW_values)
#     k, x0 = params
#     PGW = sigmoid(H0_values, k, x0)
#     PGW_dict[H0] = PGW
#     plt.plot(H0_values,PGW)

#%% CALCULATING PGW(z_i)
betas = []
for H0 in H0_values:
    PGW_values = PGW_values_dict[H0]
    PGW_catalog = np.interp(zmeans, z_values, PGW_values)
    beta = np.sum(PGW_catalog) / len(zmeans)
    betas.append(beta)

plt.plot(H0_values,betas)
plt.title('beta')
np.save('betas_0922.npy',betas)

#%% CALCULATING P_CAT USING GAUSSIAN
p_reds = []
for j in range(len(zmeans)):
    zmean = zmeans[j]
    zsigma = zsigmas[j]
    L_red = gaussian_likelihood(z_values_pcat,zmean,zsigma)
    p_red = normalize(z_values_pcat,L_red*p_bg)
    p_reds.append(p_red)
p_reds = np.array(p_reds)
pcat_values = np.sum(p_reds,axis=0)
pcat_values = normalize(z_values_pcat,pcat_values)
plt.scatter(z_values_pcat,pcat_values,s=0.5)

pcat_interpolated = np.interp(z_values, z_values_pcat, pcat_values)
plt.scatter(z_values,pcat_interpolated,s=0.5)

#%% CALCULATING BETA
betas = []
for H0, PGW in PGW_values_dict.items():
    beta = np.trapz(PGW*pcat_interpolated,z_values)
    betas.append(beta)
plt.plot(H0_values,betas)
np.save('betas_0921.npy',betas)
# %%

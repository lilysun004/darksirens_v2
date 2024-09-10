#%% IMPORTS AND PARAMETERS
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
from scipy.integrate import quad
from pycbc.waveform import get_fd_waveform
from pycbc.filter import matched_filter
from pycbc.psd import analytical

Omega_m = 0.319
Omega_lamb = 1- Omega_m
c = 299792.458

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

#%% FUNCTIONS
def E(z):
    return np.sqrt(Omega_m*(1+z)**3 + Omega_lamb)

def dL_integrand(dummy):
    return 1/E(dummy)

def dL(z,H0):
    integral = quad(dL_integrand,0,z)[0]
    return c*(1+z)/H0 * integral

def p_bg_integrand(z):
    return r_c(z)**2/E(z)

def p_bg_func(z):
    numerator = p_bg_integrand(z)
    denominator = quad(p_bg_integrand,0,np.inf)[0]
    return numerator/denominator

def r_c(z):
    return quad(dL_integrand,0,z)[0]

def gaussian_likelihood(x_values, x_mean, x_sigma):
    return (1.0 / (x_sigma * np.sqrt(2 * np.pi))) * np.exp(-0.5 * ((x_values - x_mean) / x_sigma) ** 2)

def normalize(x,y):
    C = np.trapz(y,x)
    #Suspicious limit, but if C is too small/0 the division throws an error
    if C <= 10e-100:
        return np.zeros(len(y)) 
    return 1/C*y

def min_triggers_reached(snr_list):
    count = sum(1 for snr in snr_list if snr > snr_indiv_threshold)
    return count >= min_triggers

#%% MASS DRAWING
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

#%% LOADING EUCLID
euclid_df = pd.read_parquet('subeuclid_all.parquet')
euclid_catalog = euclid_df.sample(frac=0.05)
euclid_catalog = euclid_catalog[(euclid_catalog['ztrue']<1)]
euclid_catalog.reset_index(inplace=True,drop=True)
print(euclid_catalog)

#%% PREPARING DATA AS ARRAYS
H0_values = np.linspace(20,140,25)
truez = np.array(euclid_catalog['ztrue'])
zmeans = np.array(euclid_catalog['zmean'])
zsigmas = np.array(euclid_catalog['zsigma'])
z_values = np.linspace(0.01,2,100)

p_bg_values = np.array([p_bg_func(z) for z in z_values])

#%% CALCULATING P_REDS
p_reds = []
L_reds = []
for j in range(len(zmeans)):
    zmean = zmeans[j]
    zsigma = zsigmas[j]
    L_red = gaussian_likelihood(z_values,zmean,zsigma)
    p_red = normalize(z_values,L_red*p_bg_values)
    p_reds.append(p_red)
    L_reds.append(L_red)
p_reds = np.array(p_reds)
L_reds = np.array(L_reds)

#%% P_CAT !!
pcat_values = np.sum(p_reds,axis=0)
pcat_values = normalize(z_values,pcat_values)
plt.scatter(z_values,pcat_values,s=0.5)

#%% PGW COMPUTE FUNCTIONS
def compute_PGW(z,H0,ndraws):
    detected = 0
    distance = dL(z,H0)
    for i in range(ndraws):
        ## Drawing algorithm
        m1 = draw_from_mass_distr_m1()
        m2 = draw_from_mass_distr_m2(m1)
        inc = np.random.uniform(0,2*np.pi)
        hp, _ = get_fd_waveform(approximant=approximant,
                            mass1=m1,
                            mass2=m2,
                            delta_f=delta_f,
                            f_lower=f_low,
                            inclination=inc,
                            distance=distance)
        psd_H1 = analytical.aLIGOZeroDetHighPower(len(hp), hp.delta_f, f_low)
        psd_L1 = analytical.aLIGOZeroDetHighPower(len(hp), hp.delta_f, f_low)
        psd_V1 = analytical.Virgo(len(hp), hp.delta_f, f_low)
        snr_H1 = sigma(hp, psd=psd_H1, low_frequency_cutoff=f_low)
        snr_L1 = sigma(hp, psd=psd_L1, low_frequency_cutoff=f_low)
        snr_V1 = sigma(hp, psd=psd_V1, low_frequency_cutoff=f_low)
        combined_snr = np.sqrt(snr_H1**2 + snr_L1**2 + snr_V1**2)
        if min_triggers_reached([snr_H1,snr_L1,snr_V1]) and combined_snr >= snr_threshold:
            detected += 1
    PGW = detected / ndraws
    return PGW

compute_PGW_vectorized = np.vectorize(compute_PGW)

#%%
import json
PGW_for_each_H0 = {}
betas = []
ndraws = 100
for H0 in H0_values:
    PGW_values = []
    for z in z_values:
        if len(PGW_values) > 2 and PGW_values[-1] == 0 and PGW_values[-2] == 0:
            print('computed z=',z,'H0=',H0,'broke')
            break
        PGW_value = compute_PGW(z,H0,ndraws)
        PGW_values.append(PGW_value)
        print('computed z=',z,'H0=',H0,'PGW=',PGW_value)
    PGW_values.extend([0] * (len(z_values) - len(PGW_values)))
    PGW_values = np.array(PGW_values)
    beta = np.trapz(PGW_values*pcat_values,z_values)
    PGW_for_each_H0[H0] = PGW_values
    betas.append(beta)
    print(H0,' done')
np.save('betas/betas_0801_cutcat1.npy',betas)
with open("betas/betas_0801_cutcat1.json", "w") as file:
    json.dump(PGW_for_each_H0, file)

#%% P_GW PLOTS AGAINST Z, FOR DIFFERENT H0
with open("betas/betas_0801_cutcat1.json", "r") as file:
    PGW_for_each_H0 = json.load(file)

for H0 in H0_values:
    plt.plot(z_values,PGW_for_each_H0[H0],label=H0)
plt.legend()
plt.show()

#%% BETA PLOT AGAINST H0
betas = np.load('betas/betas_0801_cutcat1.npy')
plt.plot(H0_values,betas)
# %%

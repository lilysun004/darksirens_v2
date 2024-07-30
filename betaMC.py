#%% IMPORTS AND PARAMETERS
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
from scipy.integrate import quad
from pycbc.waveform import get_fd_waveform
from pycbc.filter import sigma
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
approximant = 'IMRPhenomXAS'
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


#%% MASS DRAWING
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

# def p2(m1,m2):
#     return (1+bq)/m1 * (m2/m1)**bq / (1 - (mmin/m1) ** (1+bq))

# def draw_from_mass_distr_m2(m1):
#     p_m2_values = np.array([p2(m1,m2) for m2 in m_values])
#     p_m2_values = p_m2_values/np.sum(p_m2_values)
#     return np.random.choice(m_values,p=p_m2_values)

def draw_from_mass_distr_m2(m1):
    return np.random.uniform(mmin,m1) #bq=0 case

#%% LOADING EUCLID ENTIRE
# euclid_df = pd.read_parquet('euclid.parquet')
# column_names = {'ra_gal':'RA','dec_gal':'Dec','true_redshift_gal':'truez','observed_redshift_gal':'obsz'}
# euclid_df.rename(columns=column_names, inplace=True)

# subeuclid_df = euclid_df.sample(frac=0.001, random_state=1)
# subeuclid_df.to_parquet('subeuclid_0.001.parquet',index=False)

#%% LOADING SUBEUCLID
subeuclid_df = pd.read_parquet('subeuclid_small.parquet')
subeuclid_catalog = subeuclid_df[(subeuclid_df['truez']>0) & (subeuclid_df['truez']<1)]

#%% PREPARING DATA AS ARRAYS
H0_values = np.linspace(20,140,25)
truez = np.array(subeuclid_catalog['truez'])
zmeans = np.array(subeuclid_catalog['obsz'])
zsigmas = 0.05 * (1+zmeans) #model for photometric z errors
z_values = np.linspace(0.01,1,50)

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
        # psd = read.from_txt('o2sd.txt',len(hp),delta_f=delta_f,low_freq_cutoff=f_low)
        psd = analytical.aLIGODesignSensitivityT1800044(len(hp), hp.delta_f, f_low)
        snr = sigma(hp, psd=psd, low_frequency_cutoff=f_low)
        if snr > snr_threshold:
            detected += 1
    PGW = detected / ndraws
    return PGW

compute_PGW_vectorized = np.vectorize(compute_PGW)

#%%
PGW_for_each_H0 = {}
betas = []
ndraws = 500
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
np.save('betas/betas_0729.npy',betas)

#%% P_GW PLOTS AGAINST Z, FOR DIFFERENT H0
for H0 in H0_values:
    plt.plot(z_values,PGW_for_each_H0[H0],label=H0)
plt.legend()
plt.show()

#%% BETA PLOT AGAINST H0
plt.plot(H0_values,betas)

#%% GENERATING EVENT

## I referred to the DarkSirenStat package from
## https://github.com/CosmoStatGW/DarkSirensStat 
## Namely the SNRtools.py and betaMC.py files

## Not 100% sure how sigma is the SNR but that's what they did
## I tried reading the PSD file from the O2 run https://dcc.ligo.org/LIGO-G1801952/public
## but it's a pain to interpolate so for now I'm using a pycbc built in 

## Is this how they get the SNR

# mass1 = 30 #source frame masses
# mass2 = 20
# z = 0.05
# distance = dL(z,70)
# f_low = 20.0
# duration = 5.0
# sample_rate = 4096
# inclination = 2*np.pi
# approximant = 'IMRPhenomXAS'

# hp, _ = get_td_waveform(approximant=approximant,
#                         mass1=mass1,
#                         mass2=mass2,
#                         delta_t=1.0/sample_rate,
#                         f_lower=f_low,
#                         inclination=inclination,
#                         distance=distance)  # Convert Mpc to parsecs

# psd = analytical.aLIGOEarlyLowSensitivityP1200087(len(hp), hp.delta_f, f_low)
# snr = sigma(hp, psd=psd, low_frequency_cutoff=f_low)
# print(snr)

# def p0_unnorm(M1,M2):
#     num = (M2/M1)**bq
#     den = M1*(1-(mmin/M1)**(1+bq))
#     if M1 <= mmin or M1 >= mmax or M2 <= mmin or M2 >= mmax:
#         return 0
#     if M1 < mbreak:
#         return num/den * (M1/mbreak)**-y1
#     if M1 > mbreak:
#         return num/den * (M1/mbreak)**-y2

# m1_values = np.linspace(mmin, mmax, n_mass)
# m2_values = np.linspace(mmin, mmax, n_mass)
# m1_grid, m2_grid = np.meshgrid(m1_values, m2_values)
# p0_values = np.empty((n_mass,n_mass))
# for i in range(n_mass):
#     for j in range(n_mass):
#         p0_values[i,j] = p0_unnorm(m1_values[i],m2_values[j])
# p0_values = p0_values / np.sum(p0_values)

# m1_flat = m1_grid.flatten()
# m2_flat = m2_grid.flatten()
# p0_flat = p0_values.flatten()
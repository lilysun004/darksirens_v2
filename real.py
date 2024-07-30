#%% IMPORTS AND PARAMETERS
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
from scipy.integrate import quad
import healpy as hp
from scipy.optimize import brentq
from astropy.utils.data import download_file

Omega_m = 0.319
Omega_lamb = 1- Omega_m
c = 299792.458
true_H0 = 67
H0_prior_min, H0_prior_max = 20, 140
dL_int_values = np.linspace(0,10000,1000)

H0_values = np.linspace(H0_prior_min,H0_prior_max,25)

events_urls = {
    'GW170817': 'https://dcc.ligo.org/public/0146/G1701985/001/LALInference_v2.fits.gz',
    'GW190814': 'https://dcc.ligo.org/public/0169/P2000230/005/GW190814_skymap.fits.gz',
    'GW170814': 'https://dcc.ligo.org/public/0145/T1700453/001/LALInference_v1.fits.gz',
    'GW170608': 'https://dcc.ligo.org/public/0147/G1702263/001/LALInference-P.fits.gz',
    'GW170104': 'https://dcc.ligo.org/public/0141/T1700179/001/LALInference_f.fits.gz',
    'GW150914': 'https://dcc.ligo.org/public/0157/P1800381/007/GW150914_skymap.fits.gz',
    'GW151012': 'https://dcc.ligo.org/public/0157/P1800381/007/GW151012_skymap.fits.gz',
    'GW151226': 'https://dcc.ligo.org/public/0157/P1800381/007/GW151226_skymap.fits.gz',
    'GW170729': 'https://dcc.ligo.org/public/0157/P1800381/007/GW170729_skymap.fits.gz',
    'GW170809': 'https://dcc.ligo.org/public/0157/P1800381/007/GW170809_skymap.fits.gz',
    'GW170818': 'https://dcc.ligo.org/public/0157/P1800381/007/GW170818_skymap.fits.gz',
    'GW170823': 'https://dcc.ligo.org/public/0157/P1800381/007/GW170823_skymap.fits.gz'
}

event = 'GW170814'

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

#%% IMPORTANT FUNCTIONS
def read_skymap(event):
    filename = download_file(events_urls[event],cache=True)
    gw_map = hp.read_map(filename)
    gw_nside = hp.get_nside(gw_map)
    prob, distmu, distsigma, distnorm = hp.read_map(filename,field=range(4))

    gw_thetas, gw_phis = hp.pix2ang(gw_nside, np.arange(len(prob)))
    gw_ras = np.rad2deg(gw_phis)
    gw_decs = np.rad2deg(0.5 * np.pi - gw_thetas)

    gw_df = pd.DataFrame()
    gw_df['RA'] = gw_ras
    gw_df['Dec'] = gw_decs
    gw_df['Prob'] = prob
    gw_df['DistMu'] = distmu
    gw_df['DistSigma'] = distsigma
    gw_df['DistNorm'] = distnorm

    return gw_df, gw_nside

def get_mostprob_skymap(gw_df, prob_cutoff=0.9):
    prob = gw_df['Prob']
    sorted_indices = np.argsort(-prob)
    cumulative_prob = np.cumsum(prob[sorted_indices])
    threshold_index = np.argmax(cumulative_prob >= prob_cutoff)
    mostprob_indices = np.array(sorted_indices[:threshold_index + 1])
    mostprob_df = gw_df.iloc[mostprob_indices].copy()
    return mostprob_df

def find_catalog_zlimits(mostprob_df):
    dL_values = np.linspace(0,3000,1000)
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

def clean_glade(gw_nside):
    galaxy_df = pd.read_parquet('glade_cosmohub.parquet')
    column_names = {'ra':'RA','dec':'Dec','z_cmb':'zmean','z_err':'zsigma'}
    galaxy_df.rename(columns=column_names, inplace=True)
    galaxy_df = galaxy_df[(galaxy_df['zmean'] > 0) & (galaxy_df['zmean'] < 1)]
    phis = np.deg2rad(galaxy_df['RA'])
    thetas = np.deg2rad(90 - galaxy_df['Dec'])
    healpix_indexs_all = hp.pixelfunc.ang2pix(gw_nside,thetas,phis)
    galaxy_df['HP_Index'] = healpix_indexs_all
    galaxy_df = galaxy_df.reset_index(drop=True)
    return galaxy_df

def clean_des(event,gw_nside):
    galaxy_df = pd.read_parquet(event+'_des.parquet')
    column_names = {'ra':'RA','dec':'Dec','dnf_zmean_mof':'zmean','dnf_zsigma_mof':'zsigma','mag_auto_r':'MagAutoR','mag_aper_8_r':'MagAperR'}
    galaxy_df.rename(columns=column_names, inplace=True)
    galaxy_df = galaxy_df[(galaxy_df['zmean'] > 0) & (galaxy_df['zmean'] < 1)]
    phis = np.deg2rad(galaxy_df['RA'])
    thetas = np.deg2rad(90 - galaxy_df['Dec'])
    healpix_indexs_all = hp.pixelfunc.ang2pix(gw_nside,thetas,phis)
    galaxy_df['HP_Index'] = healpix_indexs_all
    galaxy_df = galaxy_df.reset_index(drop=True)
    return galaxy_df

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

#%% P_BG 
z_values = np.linspace(0, 5, 1000)
p_bg = np.array([p_bg_func(z) for z in z_values])

#%% READING DATA
catalog_used = 'des'

gw_df, gw_nside = read_skymap(event)
mostprob_df = get_mostprob_skymap(gw_df)

if catalog_used == 'glade':
    full_catalog = clean_glade(gw_nside)
elif catalog_used == 'des':
    full_catalog = clean_des(event,gw_nside)

#%% PROCESSING
zcatmin, zcatmax = find_catalog_zlimits(mostprob_df)
print(f"z limits: ({zcatmin},{zcatmax})")
galaxy_catalog = cut_catalog(full_catalog,zcatmin,zcatmax,mostprob_df)
print('number of galaxies=',len(galaxy_catalog))
zmeans = galaxy_catalog['zmean']
zsigmas = galaxy_catalog['zsigma']
healpix_indexs = galaxy_catalog['HP_Index']

p_reds = calculate_preds(zmeans, zsigmas, p_bg)
print('p_reds calculated')
posterior_nobeta = calculate_posterior_nobeta(H0_values, p_reds, mostprob_df)
posterior_nobeta = normalize(H0_values,posterior_nobeta)
plt.plot(H0_values,posterior_nobeta)
plt.show()

#%% BETAS SIMPLE
# dL_threshold = 2000
# betas = []
# for H0 in H0_values:
#     z_max = z_finder(dL_threshold,H0)
#     beta = V_c(z_max)
#     betas.append(beta)
# betas = np.array(betas)
# plt.plot(H0_values, betas)

#%% BETAS SEMIANAL
betas = np.load('betas/betas_des_o2_GW170814.npy')

#%% ADDING IN BETAS
posterior_beta = posterior_nobeta / betas
plt.plot(H0_values,posterior_beta)
plt.show()

# %%

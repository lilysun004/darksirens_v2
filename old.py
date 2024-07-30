#%% IMPORTS
import numpy as np
import scipy
import matplotlib.pyplot as plt
from astropy.utils.data import download_file
import healpy as hp
import pandas as pd
from scipy.optimize import brentq
from scipy.integrate import quad
from astropy.cosmology import FlatLambdaCDM

# https://dcc.ligo.org/LIGO-P1800381/public
# to do: https://dcc.ligo.org/LIGO-P2000223/public
events_urls = {
    'GW170817': 'https://dcc.ligo.org/public/0146/G1701985/001/LALInference_v2.fits.gz',
    #'GW190814': 'https://gracedb.ligo.org/api/superevents/S190814bv/files/LALInference.v1.fits.gz',
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

events_dL_limits = {
    'GW170814': {0.9:(300.2001334222815, 664.4429619746497),
                 0.997:(84.72314876584389, 797.8652434956638)},
    #'GW190814': {0.9:(156.70566210116345, 338.75316394805964)}, ## 2019 map
    'GW190814': {0.9:(190.6906906906907, 280.2802802802803), ## 2020 map
                0.997:(148.14814814814815, 316.3163163163163)},
    'GW170817': {0.9:(23.661625896991346, 48.12906567901955)},
    'GW151012': {0.9:(305.4602423892319, 1438.043348910345)},
    'GW170608': {0.9:(168.45332785546674, 442.3332282463276)},
    'GW150914': {0.9:(245.33121323198446, 575.5138235216477)},
    'GW151226': {0.9:(201.79984963482121, 597.291519231636)},
    'GW170809': {0.9:(547.3236002540558, 1296.5907357742633)},
    'GW170104': {0.9:(267.4712126677459, 1208.9698812582114)}
}

events_notes = {
    'GW170814': 'soares-santos paper, 504 Mpc, they used des',
    'GW190814': 'palmese 2020 paper, second smallest local, they used des',
    'GW170817': 'glade catalog only, des doesnt cover that area, well localised',
    'GW151012': 'extremely bad localisation, beta didnt work',
    'GW150914': 'not bad, the beta worked, good posterior??',
    'GW151226': 'not bad, the beta worked, good posterior??',
    'GW170729': 'too far, glade incomplete',
    'GW170809': 'without correction okay, beta squished too much',
    'GW170818': 'good localisation, without correction okay, beta squished too much',
    'GW170823': 'didnt load...',
    'GW170608': 'not bad, beta worked'
}

event = 'GW170814'
Omega_m = 0.3
Omega_lamb = 0.7
c = 299792.458
H0_prior_min, H0_prior_max = 20, 140

print(f'event selected: {event} \nnotes: {events_notes.get(event,'')}')

#%% LOADING ENTIRE DES CATALOG
des_df = pd.read_parquet('des.parquet')
print('loaded')
column_names = {'ra':'RA','dec':'Dec','dnf_zmean_mof':'zmean','dnf_zsigma_mof':'zsigma','mag_aper_8_r':'MagAperR'}
des_df.rename(columns=column_names, inplace=True)

#%% FUNCTIONS
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
    #Suspicious limit, but if C is too small/0 the division throws an error
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

#%% LOADING GW DATA
filename = 'events_gwmaps/'+event+'.fits.gz'
gw_map = hp.read_map(filename)
gw_nside = hp.get_nside(gw_map)

#Probability and dL gaussian, at each position
prob, distmu, distsigma, distnorm = hp.read_map(filename,field=range(4))

prob_max_i = np.argmax(prob)
dL_hat = distmu[prob_max_i] #dL at most probable location
sigma_dL_hat = distsigma[prob_max_i] #and its error
expected_z = brentq(dL_rootfinder,0,10,args=(70,dL_hat))

#Converting healpix theta & phi to ra and dec
gw_theta, gw_phi = hp.pixelfunc.pix2ang(gw_nside,prob_max_i)
gw_ra = np.rad2deg(gw_phi)
gw_dec = 90 - np.rad2deg(gw_theta)

gw_thetas, gw_phis = hp.pix2ang(gw_nside, np.arange(len(prob)))
gw_ras = np.rad2deg(gw_phis)
gw_decs = np.rad2deg(0.5 * np.pi - gw_thetas)

print(f'dL at max prob = {dL_hat}')
print(f'loc = ({gw_ra},{gw_dec})')
print(f'expected z around {expected_z}')

#Creating df for convenience
gw_df = pd.DataFrame()
gw_df['Prob'] = prob
gw_df['DistMu'] = distmu
gw_df['DistSigma'] = distsigma
gw_df['DistNorm'] = distnorm

#%% FINDING AND PLOTTING GW MOST PROBABLE REGION
prob_cutoff = 0.9

sorted_indices = np.argsort(-prob)
cumulative_prob = np.cumsum(prob[sorted_indices])
threshold_index = np.argmax(cumulative_prob >= prob_cutoff)
mostprob_indices = sorted_indices[:threshold_index + 1]

#Picks out subsection of xx localisation probability
mostprob_ras = gw_ras[mostprob_indices]
mostprob_decs = gw_decs[mostprob_indices]
mostprob_prob = prob[mostprob_indices]
mostprob_distmu = distmu[mostprob_indices]
mostprob_distsigma = distsigma[mostprob_indices]

threshold_prob = min(mostprob_prob)
filtered_gw_df = gw_df[gw_df['Prob'] > threshold_prob]
filtered_indexes = np.array(filtered_gw_df.index)

plt.figure(figsize=(10, 5))
ra_bins = np.linspace(min(mostprob_ras), max(mostprob_ras), 100)
dec_bins = np.linspace(min(mostprob_decs), max(mostprob_decs), 100)

histprob, ra_edges, dec_edges = np.histogram2d(mostprob_ras, mostprob_decs, bins=[ra_bins, dec_bins], weights=mostprob_prob)
plt.imshow(histprob.T, extent=[ra_edges[0], ra_edges[-1], dec_edges[0], dec_edges[-1]],origin='lower', aspect='auto', cmap='viridis')

plt.colorbar(label='proportional to probability')
plt.xlabel('RA (degrees)')
plt.ylabel('Dec (degrees)')
plt.title(f'GW Probability Map, {prob_cutoff*100}% region')
plt.show()

#%% CUT CATALOG, OLD VERSION (min and max dL within region)
n_sigma = 2 #2 or 3 or anything. if 3, dL lower bound could be negative...
dL_lower_bound = min(mostprob_distmu - n_sigma*mostprob_distsigma)
dL_upper_bound = max(mostprob_distmu + n_sigma*mostprob_distsigma)

if dL_lower_bound < 0: 
    z_lower_bound = 0
else:
    z_lower_bound = z_finder(dL_lower_bound,H0_prior_min)
z_upper_bound = z_finder(dL_upper_bound,H0_prior_max)

print('cutoff',prob_cutoff,', dL range: ',(dL_lower_bound,dL_upper_bound))
print(f"z limits: ({z_lower_bound},{z_upper_bound})")

#%% CUT CATALOG, NEW VERSION (marginalise dL whole sky, 90% CI)
dL_values = np.linspace(0,2*dL_hat,1000)
p_dL = np.zeros(len(dL_values))
for i in range(len(prob)):
    p_dL += prob[i] * gaussian_likelihood(dL_values,distmu[i],distsigma[i])
plt.plot(dL_values,p_dL)
plt.xlabel('dL')
plt.ylabel('Prob density')
plt.title('Prob distribution in dL, marginalised over whole sky')
plt.show()

dL_lower_bound, dL_upper_bound = confidence_interval(dL_values,p_dL,0.9)
z_lower_bound = z_finder(dL_lower_bound,H0_prior_min)
z_upper_bound = z_finder(dL_upper_bound,H0_prior_max)

print('cutoff',prob_cutoff,', dL range: ',(dL_lower_bound,dL_upper_bound))
print(f"z limits: ({z_lower_bound},{z_upper_bound})")

#%% IF Z-LIMITS ALREADY IN DICTIONARY
dL_lower_bound, dL_upper_bound = events_dL_limits[event][0.9]
z_lower_bound = z_finder(dL_lower_bound,H0_prior_min)
z_upper_bound = z_finder(dL_upper_bound,H0_prior_max)
print('cutoff',prob_cutoff,', dL range: ',(dL_lower_bound,dL_upper_bound))
print(f"z limits: ({z_lower_bound},{z_upper_bound})")

#%% GALAXY CATALOG PARAMETERS
zcatmin = z_lower_bound
zcatmax = z_upper_bound

# if I don't include this, in des there will be a bunch of galaxies with z = 0.14, zsigma = 1.9
zcatsigmaproblem = 1.9183961

#%% LOADING AND PROCESSING ENTIRE DES CATALOG
# Filter by zmean and zsigma
galaxy_catalog = des_df[(des_df['zmean'] > zcatmin) & (des_df['zmean'] < zcatmax)]
zcatsigmaproblemmask = np.isclose(galaxy_catalog['zsigma'], zcatsigmaproblem, atol=1e-4)
galaxy_catalog = galaxy_catalog[~zcatsigmaproblemmask]
print('filtered by z')

# Filter by magnitude
# galaxy_catalog['dL'] = np.array(dL(z,70) for z in galaxy_catalog['zmean'])
# galaxy_catalog['MagAbsR'] = galaxy_catalog['MagAutoR'] - 5*np.array([np.log10(eachdL*1e5) for eachdL in galaxy_catalog['dL']])
# galaxy_catalog = galaxy_catalog[(galaxy_catalog['MagAbsR']<-17.2)]
# galaxy_catalog = galaxy_catalog.reset_index(drop=True)

# Filtering by within region
phis = np.deg2rad(galaxy_catalog['RA'])
thetas = np.deg2rad(90 - galaxy_catalog['Dec'])
healpix_indexs_all = hp.pixelfunc.ang2pix(gw_nside,thetas,phis)
galaxy_catalog['HP_Index'] = healpix_indexs_all
galaxy_catalog = galaxy_catalog[galaxy_catalog['HP_Index'].isin(filtered_indexes)]
print('filtered by pixel')

galaxy_catalog = galaxy_catalog.reset_index(drop=True)

gal_ras = galaxy_catalog['RA']
gal_decs = galaxy_catalog['Dec']
zmeans = galaxy_catalog['zmean']
zsigmas = galaxy_catalog['zsigma']
healpix_indexs = galaxy_catalog['HP_Index']

plt.hist(zmeans, bins=30, edgecolor='black')
plt.title(f'galaxy histogram, {zcatmin:.3f} < z < {zcatmax:.3f}, prob > {threshold_prob:.3e}')
plt.xlabel('z')
plt.ylabel('count')
plt.show()
print(f'length of catalog = {len(galaxy_catalog)}')

max_dLmax = dL(max(zmeans),300)
print(f'Max dL_max (H0=300) = {max_dLmax}')

#%% LOADING AND PROCESSING DES CATALOG
galaxy_df = pd.read_parquet(event+'_des.parquet')
column_names = {'ra':'RA','dec':'Dec','dnf_zmean_mof':'zmean','dnf_zsigma_mof':'zsigma','mag_auto_r':'MagAutoR','mag_aper_8_r':'MagAperR'}
galaxy_df.rename(columns=column_names, inplace=True)

galaxy_catalog = galaxy_df[(galaxy_df['zmean'] > zcatmin) & (galaxy_df['zmean'] < zcatmax)]
zcatsigmaproblemmask = np.isclose(galaxy_catalog['zsigma'], zcatsigmaproblem, atol=1e-4)
galaxy_catalog = galaxy_catalog[~zcatsigmaproblemmask]
# galaxy_catalog['dL'] = np.array(dL(z,70) for z in galaxy_catalog['zmean'])
# galaxy_catalog['MagAbsR'] = galaxy_catalog['MagAutoR'] - 5*np.array([np.log10(eachdL*1e5) for eachdL in galaxy_catalog['dL']])
# galaxy_catalog = galaxy_catalog[(galaxy_catalog['MagAbsR']<-17.2)]
galaxy_catalog = galaxy_catalog.reset_index(drop=True)

phis = np.deg2rad(galaxy_catalog['RA'])
thetas = np.deg2rad(90 - galaxy_catalog['Dec'])
healpix_indexs_all = hp.pixelfunc.ang2pix(gw_nside,thetas,phis)
galaxy_catalog['HP_Index'] = healpix_indexs_all
galaxy_catalog = galaxy_catalog[galaxy_catalog['HP_Index'].isin(filtered_indexes)]
galaxy_catalog = galaxy_catalog.reset_index(drop=True)

gal_ras = galaxy_catalog['RA']
gal_decs = galaxy_catalog['Dec']
zmeans = galaxy_catalog['zmean']
zsigmas = galaxy_catalog['zsigma']
healpix_indexs = galaxy_catalog['HP_Index']

plt.hist(zmeans, bins=30, edgecolor='black')
plt.title(f'galaxy histogram, {zcatmin:.3f} < z < {zcatmax:.3f}, prob > {threshold_prob:.3e}')
plt.xlabel('z')
plt.ylabel('count')
plt.show()
print(f'length of catalog = {len(galaxy_catalog)}')

betas_semianal = np.load('betas_des_o2_GW170814.npy')

#%% LOADING AND PROCESSING GLADE CATALOG
galaxy_df = pd.read_parquet('glade_cosmohub.parquet')
column_names = {'ra':'RA','dec':'Dec','z_cmb':'zmean','z_err':'zsigma'}
galaxy_df.rename(columns=column_names, inplace=True)

galaxy_catalog = galaxy_df[(galaxy_df['zmean'] > zcatmin) & (galaxy_df['zmean'] < zcatmax)]
galaxy_catalog = galaxy_catalog.reset_index(drop=True)

phis = np.deg2rad(galaxy_catalog['RA'])
thetas = np.deg2rad(90 - galaxy_catalog['Dec'])
healpix_indexs_all = hp.pixelfunc.ang2pix(gw_nside,thetas,phis)
galaxy_catalog['HP_Index'] = healpix_indexs_all
galaxy_catalog = galaxy_catalog[galaxy_catalog['HP_Index'].isin(filtered_indexes)]
galaxy_catalog = galaxy_catalog.reset_index(drop=True)

gal_ras = galaxy_catalog['RA']
gal_decs = galaxy_catalog['Dec']
zmeans = galaxy_catalog['zmean']
zsigmas = galaxy_catalog['zsigma']
healpix_indexs = galaxy_catalog['HP_Index']

plt.hist(zmeans, bins=30, edgecolor='black')
plt.title(f'galaxy histogram, {zcatmin:.3f} < z < {zcatmax:.3f}, prob > {threshold_prob:.3e}')
plt.xlabel('z')
plt.ylabel('count')
plt.show()
print(f'length of catalog = {len(galaxy_catalog)}')

max_dLmax = dL(max(zmeans),300)
print(f'Max dL_max (H0=300) = {max_dLmax}')

betas_semianal = np.load('betas_glade_o2.npy')

#%% PLOTTING GALAXY DATA
## PLOT OF NUMBER DENSITY
histgal, ra_edges, dec_edges = np.histogram2d(gal_ras, gal_decs, bins=[ra_bins, dec_bins])
plt.imshow(histgal.T, extent=[ra_edges[0], ra_edges[-1], dec_edges[0], dec_edges[-1]],origin='lower', aspect='auto', cmap='gray')
plt.colorbar(label='Number Density')
plt.xlabel('RA (degrees)')
plt.ylabel('Dec (degrees)')
plt.title(f'Galaxy number density map, {prob_cutoff*100}% region')
plt.show()

## SCATTER PLOT OF REDSHIFTS
plt.scatter(gal_ras, gal_decs, c=zmeans, s=4, cmap='inferno')
plt.colorbar(label='Redshifts')
plt.title(f'Redshifts of galaxies (N={len(zmeans)})')
plt.xlabel('RA (degrees)')
plt.ylabel('Dec (degrees)')
plt.show()

#%% CALCULATING P_BG
zvalmin = zcatmin
zvalmax = zcatmax
zvaln = 1000

z_values = np.linspace(zvalmin,zvalmax,num=zvaln)
p_bg = np.array([p_bg_func(z) for z in z_values])

print(f'z_values_limits ({zvalmin},{zvalmax}), {zvaln} points')
plt.plot(z_values,p_bg)
plt.title('p_bg(z)')
plt.ylabel('p_bg')
plt.xlabel('z')
plt.show()

#%% MC FOR OVER/UNDERDENSITY
num_galaxies = len(zmeans)
num_samples_per_pixel = 10
samples = np.hstack([
    np.random.normal(loc=mean, scale=sigma, size=num_samples_per_pixel)
    for mean, sigma in zip(zmeans, zsigmas)
])
bins = np.linspace(zvalmin,zvalmax,101)
hist, bin_edges = np.histogram(samples, bins=bins)
bin_centers = (bin_edges[:-1] + bin_edges[1:]) / 2
bin_widths = np.diff(bin_edges)

pbgfuncarray = np.array([p_bg_func(z) for z in bin_centers])
pbgfuncarray = normalize(bin_centers, pbgfuncarray)
dNdzcom = pbgfuncarray * num_galaxies * num_samples_per_pixel * bin_widths
diff = hist - dNdzcom
plt.bar(bin_centers, diff, width=bin_widths, edgecolor='k', alpha=0.7)
plt.xlabel('z')
plt.ylabel('dN/dz')
plt.title('Histogram of dN/dz against z')
plt.show()

#%% MC FOR LUMINOSITY DISTANCE
num_pixels = len(mostprob_distmu)
num_samples_per_pixel = 1
samples = np.hstack([
    np.random.normal(loc=mean, scale=sigma, size=num_samples_per_pixel)
    for mean, sigma in zip(mostprob_distmu, mostprob_distsigma)
])
num_bins = 50
hist, bin_edges = np.histogram(samples, bins=num_bins)
bin_centers = (bin_edges[:-1] + bin_edges[1:]) / 2
bin_widths = np.diff(bin_edges)
plt.bar(bin_centers, hist, width=bin_widths, edgecolor='k', alpha=0.7)
plt.xlabel('dL')
plt.ylabel('dN/ddL')
plt.title('Histogram of dN/ddL against dL')
plt.show()

#%% CALCULATING P_RED
p_reds = []
for j in range(len(zmeans)):
    zmean = zmeans[j]
    zsigma = zsigmas[j]
    L_red = gaussian_likelihood(z_values,zmean,zsigma)
    p_red = normalize(z_values,L_red*p_bg)
    p_reds.append(p_red)

print('p_red calculated')
H0_values = np.linspace(H0_prior_min,H0_prior_max,25)

# p_reds = np.ones(len(zmeans))
    
#%% PLOTTING FIRST 20 P_RED
for j in range(20):
    plt.plot(z_values,p_reds[j],'.',label=str(j))

plt.xlim(zcatmin,zcatmax)
plt.legend()
plt.xlabel('z')
plt.ylabel('Prob')
plt.show()

#%% PLOTTING SUM OF P_REDS
sum_p_reds = np.zeros(len(p_red))
for j in range(len(zmeans)):
    sum_p_reds += p_reds[j] 

plt.plot(z_values,sum_p_reds,'.')
plt.title('Sum of p_reds')
plt.xlabel('z')
plt.xlim(zcatmin,zcatmax)
plt.ylabel('Prob')
plt.show()

#%% PLOTTING L_GW, P_RED AND PRODUCT AGAINST REDSHIFT
posterior = []
fig, axs = plt.subplots(3, 1, figsize=(6, 12))

for Hi,H0 in enumerate([140]): 
    sum_over_gals = 0
    dL_values = np.array([dL(z,H0) for z in z_values])

    for j in range(10):
        healpix_index = healpix_indexs[j]
        prob_j = prob[healpix_index]
        dLmean = distmu[healpix_index]
        dLsigma = distsigma[healpix_index]
        dLnorm = distnorm[healpix_index]

        L_GW = prob_j * gaussian_likelihood(dL_values,dLmean,dLsigma) * dLnorm

        p_red = p_reds[j]
        to_integrate = L_GW*p_red
        integral = np.trapz(to_integrate,z_values)
        sum_over_gals += integral
        #print(np.trapz(p_red,z_values)) # okay so it is all same scale
        #print(np.trapz(L_GW,z_values)) #roughly same, should be different...

        label = f"({prob_j:.2e}, {integral:.2e})"
        axs[0].plot(z_values,L_GW,label=label)
        axs[1].plot(z_values,p_red,label=label)
        axs[2].plot(z_values,to_integrate,label=label)

    axs[0].set_title('L_GW')
    axs[1].set_title('p_red')
    axs[2].set_title('product')
    axs[0].legend(fontsize='small')
    axs[1].legend(fontsize='small')
    axs[2].legend(fontsize='small')

#%% PLOTTING LIKELIHOOD GIVEN FIXED DLMEAN, ZMEAN, against H0 VALUES
for j in range(10):
    healpix_index = healpix_indexs[j]
    zmean = zmeans[j]
    dLmean = distmu[healpix_index]
    prob_j = prob[healpix_index]
    dL_values = [dL(zmean,eachH0) for eachH0 in H0_values]
    L = prob_j * gaussian_likelihood(dL_values,dLmean,dLsigma)
    plt.plot(H0_values,L,label=prob_j)
plt.legend()
plt.show()

#%% THE ABOVE BUT FAKE DATA
zmeans = [0.05,1]
prob_js = [0.1,0.05]
H0_values = np.linspace(20,140,100)
for j in range(2):
    zmean = zmeans[j]
    dLmean = dL(zmean,70)
    prob_j = prob_js[j]
    dL_values = np.array([dL(zmean,eachH0) for eachH0 in H0_values])
    L = prob_j * gaussian_likelihood(dL_values,dLmean,dLsigma)
    plt.plot(H0_values,L,label='prob='+str(prob_j)+',int='+str(np.trapz(dL_values,L)))
plt.legend()
plt.show()

#%% CALCULATING POSTERIOR
dL_max = 1100

posterior_nobeta = []
posterior_betasimple = []
posterior_betasemianal = []

for Hi,H0 in enumerate(H0_values):
    sum_over_gals = 0
    dL_values = np.array([dL(z,H0) for z in z_values])

    z_max = z_finder(dL_max,H0)
    beta_simple = V_c(z_max)
    beta_semianal = betas_semianal[Hi]

    for j in range(len(zmeans)):
        healpix_index = healpix_indexs[j]
        prob_j = prob[healpix_index]
        dLmean = distmu[healpix_index]
        dLsigma = distsigma[healpix_index]
        dLnorm = distnorm[healpix_index]

        L_GW = prob_j * gaussian_likelihood(dL_values,dLmean,dLsigma) * dLnorm
        p_red = p_reds[j]
        to_integrate = L_GW*p_red
        integral = np.trapz(to_integrate,z_values)
        sum_over_gals += integral

    each_posterior_nobeta = sum_over_gals
    each_posterior_betasimple = sum_over_gals/beta_simple
    each_posterior_betasemianal = sum_over_gals/beta_semianal
    print(f'H0 = {H0} done',end='\r')
    posterior_nobeta.append(each_posterior_nobeta)
    posterior_betasimple.append(each_posterior_betasimple)
    posterior_betasemianal.append(each_posterior_betasemianal)

#%% PLOTTING POSTERIOR NO BETA
plt.plot(H0_values,posterior_nobeta)
plt.xlabel(r'$H_0$')
plt.ylabel('probability density')
plt.title(r'$H_0$'+' posterior without correction')
max_H0_index = np.argmax(posterior_nobeta)
max_H0 = H0_values[max_H0_index]
plt.plot([max_H0,max_H0],[0,posterior_nobeta[max_H0_index]],
         linestyle='--',label='max '+r'$H_0$'+f'={max_H0}')
plt.legend(loc='best')
plt.show()

#%% PLOTTING POSTERIOR BETA SIMPLE
plt.plot(H0_values,posterior_betasimple)
plt.xlabel(r'$H_0$')
plt.ylabel('probability density')
plt.title(r'$H_0$'+' posterior, hom, dLmax='+str(dL_max))
max_H0_index = np.argmax(posterior_betasimple)
max_H0 = H0_values[max_H0_index]
plt.plot([max_H0,max_H0],[0,posterior_betasimple[max_H0_index]],
         linestyle='--',label='max '+r'$H_0$'+f'={max_H0}')
plt.legend(loc='best')
plt.show()

#%% PLOTTING POSTERIOR BETA SEMIANAL
plt.plot(H0_values,posterior_betasemianal)
plt.xlabel(r'$H_0$')
plt.ylabel('probability density')
plt.title(r'$H_0$'+' posterior, semianal')
max_H0_index = np.argmax(posterior_betasemianal)
max_H0 = H0_values[max_H0_index]
plt.plot([max_H0,max_H0],[0,posterior_betasemianal[max_H0_index]],
         linestyle='--',label='max '+r'$H_0$'+f'={max_H0}')
plt.legend(loc='best')
plt.show()

###################### TROUBLESHOOTING SECTION ######################
# %% REPRODUCING BETA HOM PLOT FROM SUPERLONG PAPER
H0_values = np.linspace(20,140,25)
dL_maxes = [500,1000,2000]
for dL_max in dL_maxes:
    all_betas = []
    for Hi, H0 in enumerate(H0_values):
        z_max = z_finder(dL_max,H0)
        beta = V_c(z_max)
        all_betas.append(beta)
    all_betas = np.array(all_betas)
    all_betas_norm = all_betas / all_betas[10]
    plt.plot(H0_values,all_betas_norm,label=dL_max)
plt.xticks(np.array(range(20,150,10)))
plt.yticks(np.array(range(0,7,1)))
plt.grid(True, which='both', axis='both')
plt.legend()
plt.show()
# THE BETA IS CORRECT.

#%% TRYING TO FIGURE OUT WHAT IS DLNORM
for i in mostprob_indices[:10]:
    dLmean = distmu[i]
    dLsigma = distsigma[i]
    dLnorm = distnorm[i]
    prob_i = prob[i]
    all_dLvalues = np.linspace(0,100000,100000)
    all_LGW = prob_i*gaussian_likelihood(all_dLvalues,dLmean,dLsigma)*dLnorm
    # dLnorm normalises the posterior below
    posterior = gaussian_likelihood(all_dLvalues,dLmean,dLsigma)*dLnorm*all_dLvalues**2
    all_integral = np.trapz(all_LGW,all_dLvalues)
    posterior_integral = np.trapz(posterior,all_dLvalues)
    print('likelihood int',all_integral)
    print('post int',posterior_integral)

# %% REPRODUCING BETA SEMIANAL PLOT FROM SUPERLONG PAPER
H0_values = np.linspace(20,140,25)
plt.plot(H0_values,betas_semianal)
plt.xticks(np.arange(20,150,10))
plt.yticks(np.arange(0,0.1,0.02))
plt.grid(True, which='both', axis='both')
plt.legend()
plt.show()
# %%

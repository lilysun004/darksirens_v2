#%% IMPORTS AND PARAMETERS
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
from scipy.integrate import quad
import healpy as hp
from scipy.optimize import brentq
from astropy.utils.data import download_file
from astropy.table import QTable
import astropy_healpix as ah
from astropy import units as u
from astropy.io import fits

#%%
euclid = pd.read_parquet('../subeuclid_rotated.parquet')

#%%
filename = '0.fits'
hdulist = fits.open(filename)
hdulist.info()
header = hdulist[1].header
skymap = QTable.read(filename)
max_level = 29
max_nside = ah.level_to_nside(max_level)
level, ipix = ah.uniq_to_level_ipix(skymap['UNIQ'])
big_indexs = ipix * (2**(max_level - level))**2
sorter = np.argsort(big_indexs)

probdensity = skymap['PROBDENSITY']
pixel_areas = ah.nside_to_pixel_area(ah.level_to_nside(level))
prob = probdensity * pixel_areas

def find_index_from_coords(coords):
    ra, dec = coords
    match_ipix = ah.lonlat_to_healpix(ra, dec, max_nside, order='nested')
    i = sorter[np.searchsorted(big_indexs, match_ipix, side='right', sorter=sorter)-1]
    return i

def find_indexs_in_region(skymap,total_prob=0.9):
    sorted_indexs = np.argsort(-probdensity)
    sorted_probdensity = probdensity[sorted_indexs]
    sorted_pixel_areas = pixel_areas[sorted_indexs]
    sorted_prob = sorted_probdensity * sorted_pixel_areas
    cumprob = np.cumsum(sorted_prob)
    threshold_index = cumprob.searchsorted(0.9)
    mostprob_nuniq_indexs = sorted_indexs[:threshold_index+1]
    return mostprob_nuniq_indexs

mostprob_nuniq_indexs = find_indexs_in_region(skymap)

galaxy_catalog_list = []
#galaxy_catalog = pd.DataFrame(columns=euclid.columns)

galaxy_nuniq_indexs = []

mostprob_probs = []
mostprob_distmus = []
mostprob_distsigmas = []
mostprob_distnorms = []

for row in euclid.itertuples(index=False):
    coords = row.RA * u.deg, row.Dec * u.deg
    index = find_index_from_coords(coords)
    galaxy_nuniq_indexs.append(index)
    if index in mostprob_nuniq_indexs:
        mostprob_probs.append(prob[index].value)
        mostprob_distmus.append(skymap[index]['DISTMU'].value)
        mostprob_distsigmas.append(skymap[index]['DISTSIGMA'].value)
        mostprob_distnorms.append(skymap[index]['DISTNORM'].value)
        #galaxy_catalog = galaxy_catalog.append(pd.Series(row._asdict()), ignore_index=True)
        galaxy_catalog_list.append(row._asdict())

galaxy_catalog = pd.DataFrame(galaxy_catalog_list)
galaxy_catalog['Prob'] = np.array(mostprob_probs)
galaxy_catalog['DistMu'] = np.array(mostprob_distmus)
galaxy_catalog['DistSigma'] = np.array(mostprob_distsigmas)
galaxy_catalog['DistNorm'] = np.array(mostprob_distnorms)
# print(galaxy_catalog)

ra_bins = np.linspace(min(galaxy_catalog['RA']), max(galaxy_catalog['RA']), 100)
dec_bins = np.linspace(min(galaxy_catalog['Dec']), max(galaxy_catalog['Dec']), 100)
histprob, ra_edges, dec_edges = np.histogram2d(galaxy_catalog['RA'], galaxy_catalog['Dec'], bins=[ra_bins, dec_bins])
plt.imshow(histprob.T, extent=[ra_edges[0], ra_edges[-1], dec_edges[0], dec_edges[-1]],origin='lower', aspect='auto', cmap='viridis')

#%%
plt.scatter(galaxy_catalog['RA'], galaxy_catalog['Dec'], c=galaxy_catalog['Prob'], s=4, cmap='inferno')
plt.colorbar(label='Probability')
plt.title(f'Probability Map (N={len(galaxy_catalog)})')
plt.xlabel('RA (degrees)')
plt.ylabel('Dec (degrees)')
plt.show()

#%% rotate
def radec_to_cartesian(ra_deg,dec_deg): ## ra, dec in degrees
    ra = np.deg2rad(ra_deg)
    dec = np.deg2rad(dec_deg)
    x = np.cos(ra) * np.cos(dec)
    y = np.sin(ra) * np.cos(dec)
    z = np.sin(dec)
    return np.array([x,y,z])

def find_angle_of_rot(v_old, v_new):
    cosine = np.dot(v_old, v_new) / (np.linalg.norm(v_old) * np.linalg.norm(v_new))
    return np.arccos(cosine)

def find_axis_of_rot(v_old, v_new):
    vector = np.cross(v_old, v_new)
    return vector / np.linalg.norm(vector)

def rotate(v,axis,angle):
    return v*np.cos(angle) + np.cross(axis,v)*np.sin(angle) + axis*np.dot(axis,v)*(1-np.cos(angle))

def cartesian_to_radec(v):
    vx, vy, vz = v[0], v[1], v[2]
    ra = np.arctan(vy/vx)
    dec = np.arcsin(vz)
    ra_deg = np.rad2deg(ra)
    dec_deg = np.rad2deg(dec)
    return ra_deg, dec_deg

def rotate_catalog(catalog, coords_old, coords_new): #in DEGREES
    ras = catalog['RA']
    decs = catalog['Dec']
    vectors = np.array([radec_to_cartesian(ra, dec) for ra,dec in zip(ras,decs)])
    v_old = radec_to_cartesian(*coords_old)
    v_new = radec_to_cartesian(*coords_new)
    angle = find_angle_of_rot(v_old,v_new)
    axis = find_axis_of_rot(v_old, v_new)
    new_vectors = np.array([rotate(vector,axis,angle) for vector in vectors])
    new_coords = np.array([cartesian_to_radec(vector) for vector in new_vectors])
    new_catalog = pd.DataFrame()
    new_catalog['RA'] = np.array(new_coords[:,0])
    new_catalog['Dec'] = np.array(new_coords[:,1])
    new_catalog['zmean'] = catalog['zmean']
    new_catalog['ztrue'] = catalog['ztrue']
    return new_catalog


# %%

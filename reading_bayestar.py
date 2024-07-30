#%% IMPORTS AND PARAMETERS
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
from scipy.integrate import quad
import healpy as hp
from scipy.optimize import brentq
from astropy.utils.data import download_file


#%%
from astropy.table import QTable
import astropy_healpix as ah

subeuclid = pd.read_parquet('subeuclid.parquet')

skymap = QTable.read('1.fits')

max_level = 29
max_nside = ah.level_to_nside(max_level)
level, ipix = ah.uniq_to_level_ipix(skymap['UNIQ'])
index = ipix * (2**(max_level - level))**2
sorter = np.argsort(index)

def find_nuniq_index_from_coords(coords):
    ra, dec = coords
    match_ipix = ah.lonlat_to_healpix(ra, dec, max_nside, order='nested')
    i = sorter[np.searchsorted(index, match_ipix, side='right', sorter=sorter)-1]
    return i

def find_nuniq_indexs_in_region(skymap,total_prob=0.9):
    probdensity = skymap['PROBDENSITY']
    pixel_areas = ah.nside_to_pixel_area(ah.level_to_nside(level))
    sorted_nuniq_indexs = np.argsort(-probdensity)
    sorted_probdensity = probdensity[sorted_nuniq_indexs]
    sorted_pixel_areas = pixel_areas[sorted_nuniq_indexs]
    sorted_prob = sorted_probdensity * sorted_pixel_areas
    cumprob = np.cumsum(sorted_prob)
    threshold_index = cumprob.searchsorted(0.9)
    mostprob_nuniq_indexs = sorted_nuniq_indexs[:threshold_index+1]
    return mostprob_nuniq_indexs

mostprob_nuniq_indexs = find_nuniq_indexs_in_region(skymap)

galaxy_catalog_list = []
#galaxy_catalog = pd.DataFrame(columns=subeuclid.columns)

galaxy_nuniq_indexs = []
for row in subeuclid.itertuples(index=False):
    coords = row.RA * u.deg, row.Dec * u.deg
    nuniq_index = find_nuniq_index_from_coords(coords)
    galaxy_nuniq_indexs.append(nuniq_index)
    if nuniq_index in mostprob_nuniq_indexs:
        #galaxy_catalog = galaxy_catalog.append(pd.Series(row._asdict()), ignore_index=True)
        galaxy_catalog_list.append(row._asdict())

galaxy_catalog = pd.DataFrame(galaxy_catalog_list)
print(galaxy_catalog)

ra_bins = np.linspace(min(galaxy_catalog['RA']), max(galaxy_catalog['RA']), 10)
dec_bins = np.linspace(min(galaxy_catalog['Dec']), max(galaxy_catalog['Dec']), 10)
histprob, ra_edges, dec_edges = np.histogram2d(galaxy_catalog['RA'], galaxy_catalog['Dec'], bins=[ra_bins, dec_bins])
plt.imshow(histprob.T, extent=[ra_edges[0], ra_edges[-1], dec_edges[0], dec_edges[-1]],origin='lower', aspect='auto', cmap='viridis')









#%%
from astropy.io import fits
from ligo.skymap.moc import uniq2nest

hdulist = fits.open('1.fits')
hdulist.info()
skymap_data = hdulist[1].data

prob_nuniq = skymap_data.field('PROBDENSITY')

#%%

from astropy import units as u

skymap = QTable.read('0.fits')
i = np.argmax(skymap['PROBDENSITY'])
uniq = skymap[i]['UNIQ']
skymap[i]['PROBDENSITY'].to_value(u.deg**-2)
level, ipix = ah.uniq_to_level_ipix(uniq)
nside = ah.level_to_nside(level)
ra, dec = ah.healpix_to_lonlat(ipix, nside, order='nested')

#%%
level, ipix = ah.uniq_to_level_ipix(skymap['UNIQ'])
nside = ah.level_to_nside(level)









#%%
nuniq_index = np.arange(0,len(prob_nuniq))
nested_index = uniq2nest(nuniq_index)[1]

prob_nested = np.zeros(max(nested_index)+1)

for ipix_nuniq in nuniq_index:
    ipix_nested = uniq2nest(ipix_nuniq)[1]
    prob_nested[ipix_nested] = prob_nuniq[ipix_nuniq]

prob = hp.reorder(prob_nested,n2r=True)
hp.mollview(prob)
# %%
nside = hp.pixelfunc.npix2nside(len(prob))
gw_thetas, gw_phis = hp.pix2ang(nside, np.arange(len(prob)))
gw_ras = np.rad2deg(gw_phis)
gw_decs = np.rad2deg(0.5 * np.pi - gw_thetas)
# %%
plt.figure(figsize=(10, 5))
ra_bins = np.linspace(min(gw_ras), max(gw_ras), 100)
dec_bins = np.linspace(min(gw_decs), max(gw_decs), 100)

histprob, ra_edges, dec_edges = np.histogram2d(gw_ras, gw_decs, bins=[ra_bins, dec_bins], weights=prob)
plt.imshow(histprob.T, extent=[ra_edges[0], ra_edges[-1], dec_edges[0], dec_edges[-1]],origin='lower', aspect='auto', cmap='viridis')
# %%

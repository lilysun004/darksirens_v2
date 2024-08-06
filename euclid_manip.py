#%%
import pandas as pd
import numpy as np

#%%
og = pd.read_parquet('subeuclid_all.parquet')
og_ras = np.array(og['RA'])

#%%
og2_ras = og_ras + 90
og3_ras = og_ras + 180
og4_ras = og_ras + 270

og_4times_ras = np.concatenate([og_ras,og2_ras,og3_ras,og4_ras])
def normalise_angles(angles):
    result = angles % 360
    result[result > 180] -= 360
    return result
og_4times_ras = normalise_angles(og_4times_ras)

# %%
og_4times = pd.concat([og] * 4, ignore_index=True)
og_4times['RA'] = og_4times_ras

#%%
og_8times = pd.concat([og_4times] * 2, ignore_index=True)

# %%
og_4times_decs = np.array(og_4times['Dec'])
mirror_decs = -og_4times_decs
og_8times_decs = np.concatenate([og_4times_decs,mirror_decs])
og_8times['Dec'] = og_8times_decs

# %%
og_8times.to_parquet('subeuclid_all_8times.parquet')
# %%
og_8times
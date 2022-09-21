import numpy as np
import forward_sub_csc as fwdc
from scipy import sparse as sp 

vals = np.array([1, 10, 7, 16])
rows = np.array([1, 3, 2, 4])
ind_ptr = np.array([1, 2, 3, 4, 5])

b = np.array([2 , 4, 6, 8])

x = fwdc.forward_sub_csc(vals, rows, ind_ptr, b)

print(x)
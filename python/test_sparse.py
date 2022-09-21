import numpy as np 
import forward_sub_r as fwdr
import forward_sub_u as fwdu
import forward_sub_csc as fwdc
from scipy import sparse as sp 

A = np.array([[1, 0, 0, 0],
              [0, 0, 7, 0],
              [0, 10, 0, 0],
              [0, 0, 0, 16]],float)

A_coo = sp.coo_matrix(A)
A_csr = sp.coo_matrix.tocsr(A_coo)
A_csc = sp.coo_matrix.tocsc(A_coo)

data2 = A_csc.data
ind = A_csc.indices + 1
ind_ptr = A_csc.indptr + 1

b = np.array([2,4,6,8])

data, rows, cols = scipy_to_fortran_indices(coo_matrix)
data, ind, ind_ptr = scipy_to_fortran_indices(csr_matrix)
data, ind, ind_ptr = scipy_to_fortran_indices(csc_matrix)

print(type(data))
print(type(rows))
print(type(cols))

data = np.array([1., 2., 1., 3., 4., 1.])
row = np.array([])
b = np.array([2., 4., 6.])


for  i  in range(0,3):
    row = sp.coo_matrix.getrow(A_coo, i)
    print(row)

for j in range(0,3):
    col = sp.coo_matrix.getcol(A_coo, j)
    print(col)

sp.coo_matrix.getrow(A_coo, 1)

row  = np.array([1, 2, 3])
col  = np.array([1, 2, 3])
data = np.array([1, 1, 1])
b = np.array([2,4,6])

A = sp.coo_matrix((data, (row, col)), shape=(4, 4))

print('exact', np.linalg.solve(A, b))

x1 = fwdr.forward_sub_row_ordered(data, row, col, b)
print(x1)

x2 = fwdu.forward_sub_unordered(data, row, col, b)
print(x2)

x3 = fwdc.forward_sub_csc(data2, ind, ind_ptr, b)
print(x3)

vals = np.array([1, 4, 7, 5, 8, 9])
rows = np.array([1,2,3,2,3,3])
ind_ptr = np.array([0,3,5,6])

x = fwdc.forward_sub_csc(vals, rows, ind_ptr, b)

print(x)
import numpy as np
import forward_sub_r as fwdr
import forward_sub_csc as fwdc 
from scipy import sparse as sp

def scipy_to_fortran_indices(A_format):

    if A_format.getformat() == "coo":

        data = A_coo.data
        rows = A_coo.row + 1
        cols = A_coo.col + 1

        return data, rows, cols

    elif A_format.getformat() == "csr":

        data = A_csr.data
        ind_ptr = A_csr.indptr + 1 
        cols = A_csr.indices + 1 

        return data, ind_ptr, cols

    elif A_format.getformat() == "csc":

        data = A_csc.data
        rows = A_csc.indices + 1
        ind_ptr = A_csc.indptr + 1

        return data, rows, ind_ptr
    
    else: 

        raise TypeError('Invalid format for input sparse matrix')

if __name__ == "__main__":

    A = np.array([[1, 0, 0],
                    [2, 1, 0],
                    [3, 4, 1]], float)

    A_coo = sp.coo_matrix(A)
    A_csr = sp.csr_matrix(A)
    A_csc = sp.csc_matrix(A)

    b = np.array([2., 4., 6.])

    print(scipy_to_fortran_indices(A_coo))
    print(scipy_to_fortran_indices(A_csr))
    print(scipy_to_fortran_indices(A_csc))

    data, rows, ind_ptr = scipy_to_fortran_indices(A_csc)

    x = fwdc.forward_sub_csc(data, rows, ind_ptr, b)

    print(x)
import numpy as np 
from scipy.linalg import lu
import solvers
import time

def test_fwd_sub():

    n = 10
    np.random.seed(seed=1)

    A = np.random.rand(n, n).asfortranarray()
    A = np.tril(A)
    b = np.arange(n)

    x = solvers.forward_sub(A, b)
    x_check = np.linalg.solve(A, b)

    abs_error = x - x_check
    rel_error = abs_error / x_check

    print('Abs Error:', abs_error)
    print('Rel Error:', rel_error)

def test_back_sub():

    n = 10
    np.random.seed(seed=1)

    A = np.random.rand(n, n)
    A = np.triu(A)

    b = np.arange(n)

    x = solvers.back_sub(A,b)
    x_check = np.linalg.solve(A, b)

    print('Error:', x - x_check)

def test_plu():

    n = 2
    np.random.seed(seed=1)

    A = np.random.rand(n, n)

    P,L,U = solvers.plu(A)
    p,l,u = lu(A)

    print(P - p.T)
    print(L - l)
    print(U - u)

def test_cholesky():

    A = np.array([[2, -1, 0],
                 [-1, 2, -1],
                 [0, -1, 2]], float)

    R = solvers.cholesky(A)

    L_exact = np.linalg.cholesky(A)

    print(R - L_exact.T)
    
if __name__ == "__main__":
  
    test_fwd_sub()
    test_back_sub()
    test_plu()
    test_cholesky()

    n = 10000
    np.random.seed(seed=1)

    start = time.time()
    start1 = time.time()

    A = np.reshape(np.arange(n ** 2), (n, n), order='C') 
    A = np.tril(A)

    print(np.isfortran(A))

    end1 = time.time()

    print('numpy time:', end1-start1)

    b = np.arange(n)

    start2 = time.time()

    x = solvers.forward_sub(A, b)

    end2 = time.time()

    print('solver time:', end2-start2)

    end = time.time()

    print('time: ', end - start)
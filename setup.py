from setuptools import find_packages
from numpy.distutils.core import setup, Extension

ext1 = Extension(name='dense_solvers',
                sources = ['src/dense/solvers/back_sub.f90', 'src/dense/solvers/cholesky.f90', 'src/dense/solvers/forward_sub.f90', 'src/dense/solvers/plu.f90'])

ext2 = Extension(name='sparse_solvers',
                sources = ['src/sparse/solvers/forward_sub_csc.f90', 'src/sparse/solvers/forward_sub_row_ordered.f90', 'src/sparse/solvers/forward_sub_unordered.f90'])

setup(name = "matrix_solvers",
      version = "0.0.1",
      package_dir = {"": "src"},
      packages = find_packages(where="src"),
      ext_modules = [ext1, ext2]
      )
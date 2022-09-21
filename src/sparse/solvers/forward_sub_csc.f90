subroutine forward_sub_csc(vals, rows, ind_ptr, b, x, n, nnz)

implicit none
integer :: n, nnz, j, k 
integer, intent(in) :: rows(nnz), ind_ptr(n+1)  
double precision, intent(in) :: vals(nnz), b(n)
double precision, intent(out) :: x(n)

!f2py intent(in) vals, rows, ind_ptr, b
!f2py intent(out) x
!f2py integer intent(hide), depend(b) :: n = size(b)
!f2py integer intent(hide), depend(vals) :: nnz = size(vals)

n = size(b)
x = b

do j = 1, n
    x(j) = x(j) / vals(ind_ptr(j)) 
    do k = ind_ptr(j) + 1, ind_ptr(j + 1) - 1
        x(rows(k)) = x(rows(k)) - vals(k) * x(j)
    end do 
end do

end subroutine
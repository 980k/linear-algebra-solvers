subroutine forward_sub_unordered(vals, rows, cols, b, x, n, nnz)

implicit none
integer :: n, nnz, k  
integer, intent(in) :: rows(nnz), cols(nnz)
double precision, intent(in) :: vals(nnz), b(n)
double precision, intent(out) :: x(n)
double precision :: diagonal(n)

!f2py intent(in) vals, rows, cols, b 
!f2py intent(out) x
!f2py integer intent(hide), depend(b) :: n = size(b)
!f2py integer intent(hide), depend(vals) :: nnz = size(vals)

n = size(b)
nnz = size(vals)
x = b
diagonal = [(0, k = 1,n )]

do k = 1, nnz 
    if (rows(k) > cols(k)) then 
        x(rows(k)) = x(rows(k)) - vals(k) * x(cols(k))
    else
        diagonal(rows(k)) = vals(k)
    end if 
end do 

do k = 1, n
    x(rows(k)) = x(rows(k)) / diagonal(k)
end do 

end subroutine
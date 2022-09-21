subroutine forward_sub_row_ordered(vals, rows, cols, b, x, n, nnz)

implicit none
integer :: n, nnz, k 
integer, intent(in) :: rows(nnz), cols(nnz)
double precision, intent(in) :: vals(nnz), b(n)
double precision, intent(out) :: x(n)

!f2py intent(in) vals, rows, cols, b 
!f2py intent(out) x
!f2py integer intent(hide), depend(b) :: n = size(b)
!f2py integer intent(hide), depend(vals) :: nnz = size(vals)

n = size(b)
nnz = size(vals)
x = b

do k = 1, nnz 
    if (rows(k) > cols(k)) then 
        x(rows(k)) = x(rows(k)) - vals(k) * x(cols(k))
    else
        x(rows(k)) = x(rows(k)) / vals(k)
    end if 
end do 

end subroutine
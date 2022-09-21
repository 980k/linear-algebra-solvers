subroutine forward_sub(A, b, x, n)

implicit none
integer :: n, i, j
double precision, intent(in) :: A(n,n), b(n)
double precision, intent(out) :: x(n)

!f2py intent(in) A, b
!f2py intent(out) x
!f2py integer intent(hide), depend(b) :: n = size(b)

n = size(b)
x = b 

x(1) = x(1) / A(1,1)

do i = 2, n
    do j = 1, i - 1
        x(i) = x(i) - (A(i,j) * x(j))
    end do

    x(i) = x(i) / A(i,i)

end do

end subroutine
subroutine back_sub(A, b, x, n)

implicit none
integer :: n, i, j
double precision, intent(in) :: A(n,n), b(n)   
double precision, intent(out) :: x(n)

!f2py intent(in) A, b
!f2py intent(out) x
!f2py integer intent(hide), depend(A) :: n = shape(A,0)

x = b

x(n) = b(n) / A(n, n)

do i = n-1, 1, -1
    do j = i+1, n
        x(i) = x(i) - (A(i,j) * x(j))
    end do

    x(i) = x(i) / A(i,i)

end do

end subroutine
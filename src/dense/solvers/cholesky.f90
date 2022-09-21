subroutine cholesky(A, R, n)
  
implicit none
integer ::  n, i, j, k
double precision, intent(in)  :: A(n,n)
double precision, intent(out) :: R(n,n)
double precision :: sum

!f2py intent(in) A
!f2py intent(out) R
!f2py integer intent(hide), depend(A) :: n = size(A,1)

n = size(A,1)
R = 0.0

do j = 1, n
    do i = 1, j
        sum = 0
        do k = 1, i-1    
             sum = sum + (R(k, i) * R(k, j))
        end do
        if (i == j) then
            R(i,i) = sqrt(A(i,i) - sum)
        else
            R(i,j) = (A(i,j) - sum) / R(i,i)
        end if

    end do
end do

end subroutine
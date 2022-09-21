subroutine plu(A, P, L, U, n)

implicit none
integer :: n, i, j, k, argmax(1)
double precision, intent(in) :: A(n,n)
double precision, intent(out) :: P(n,n), L(n,n), U(n,n)
double precision :: factor

!f2py intent(in) A
!f2py intent(out) P, L, U
!f2py integer intent(hide), depend(A) :: n = size(A,1)

U = A
n = size(A,1)
L = 0.0
P = 0.0

do i = 1, n
    P(i,i) = 1
end do

do k = 1, n-1
    argmax = maxloc(abs(U(k:, k)))
    i =  k - 1 + argmax(1)

    U([k, i],:) = U([i, k],:)
    L([k, i],:) = L([i, k],:)
    P([k, i],:) = P([i, k],:)

     do i = k+1, n
        factor = U(i,k) / U(k,k)
        L(i,k) = factor

        do j = k, n
            U(i,j) = U(i,j) - (factor * U(k,j))
        end do
    end do
end do

do i = 1, n
    L(i,i) = 1
end do

end subroutine
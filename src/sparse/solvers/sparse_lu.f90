subroutine sparse_lu_row_ordered(A_vals, A_ind_ptr, A_cols, n, nnz, L_vals, U_vals, L_ind_ptr, L_cols, U_ind_ptr, U_cols)

implicit none
integer i, j, temp_i, temp_k, diff, nnz, k, n, P(n), argmax(1)
integer, intent(in) :: A_cols(nnz), A_ind_ptr(n+1)
double precision, intent(in) :: A_vals(nnz)
double precision, allocatable, intent(out) :: L_vals(:), U_vals(:)
integer, allocatable, intent(out) :: L_ind_ptr(:), L_cols(:), U_ind_ptr(:), U_cols(:)
double precision :: factor

!U = A
nnz = size(A_vals)

P = [(k, k = 1,n )]

do k = 1, n-1
    argmax = maxloc(abs(U_vals(A_ind_ptr(k:))))
    i =  k - 1 + argmax(1)

    U_vals = A_vals
    U_ind_ptr = A_ind_ptr
    U_cols = A_cols

    ! swap two sets of vectors, need temporary variable, needs a for loop
    U_vals(U_ind_ptr(k:k+1)) = U_vals(U_ind_ptr(i:i+1))
    U_cols(U_ind_ptr(k:k+1)) = U_cols(U_ind_ptr(i:i+1))

    L_vals(L_ind_ptr(k:k+1)) = L_vals(L_ind_ptr(i:i+1))
    L_cols(L_ind_ptr(k:k+1)) = L_cols(L_ind_ptr(i:i+1))

    temp_k = U_ind_ptr(k+1) - U_ind_ptr(k)
    temp_i = U_ind_ptr(i+1) - U_ind_ptr(i)
    diff = temp_k - temp_i


    U_ind_ptr(k+1) =  U_ind_ptr(k) + temp_i

    do j = k+2, i-1
        U_ind_ptr(j) =  U_ind_ptr(j) + diff
    end do

    temp_k = L_ind_ptr(k+1) - L_ind_ptr(k)
    temp_i = L_ind_ptr(i+1) - L_ind_ptr(i)
    diff = temp_k - temp_i

    L_ind_ptr(k+1) =  L_ind_ptr(k) + temp_i
    do j = k+2, i-1
        L_ind_ptr(j) =  L_ind_ptr(j) + diff
    end do

    P([k, i]) = P([i, k])

!    do i = k+1, n
!        do j = k, n
            
!        end do
!    end do
!end do

! do i = 1, n
!     L(i,i) = 1
! end do

end subroutine
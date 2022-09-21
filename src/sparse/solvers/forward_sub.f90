program sparse_forward_sub 
    use  iso_fortran_env
    implicit none

    integer(4),   parameter :: ip = int64
    interface 
        subroutine forward_sub_row_ordered(vals, rows, ind_ptr, b, x)
        
        use  iso_fortran_env
        implicit none

        integer(4),   parameter :: ip = int64


     ! integer :: k, nnz, n, i 
    integer(ip) :: n, j, k 
    double precision, intent(in) :: vals(:), b(:)
    double precision, intent(out) :: x(:)
    ! double precision, allocatable :: diagonal(:)
    integer(ip),intent(in) :: rows(:), ind_ptr(:)

    end subroutine
    end interface
    
    double precision :: vals(6), b(3), x(6)
    integer(ip) :: rows(6), ind_ptr(4)

    vals = [1,4,7,5,8,9]
    b = [1,2,3]
    rows = [1, 2, 3,2,3,3]
    ind_ptr = [0,3,5,6]

    call forward_sub_row_ordered(vals, rows, ind_ptr, b, x)

    print "(3(1X,F6.1))", x 

end program 


subroutine forward_sub_row_ordered(vals, rows, ind_ptr, b, x)

! implicit none

! integer :: k, nnz, n, i

! integer(4),   parameter :: ip = int64

use  iso_fortran_env
implicit none

integer(4),   parameter :: ip = int64


integer(ip) :: n, j, k 
double precision, intent(in) :: vals(:), b(:)
double precision, intent(out) :: x(:)
! double precision, allocatable :: diagonal(:)
integer(ip), intent(in) :: rows(:), ind_ptr(:)

n = size(b)

! nnz = size(vals)
x = b * 1.0
print *, x
!diagonal = [(0, i = 1,n )]


! do k = 1, nnz 
!     if (rows(k) < cols(k)) then 
!         x(rows(k)) = x(rows(k)) - vals(k) * x(cols(k))
!     else
!         x(rows(k)) = x(rows(k)) / vals(k)
!     end if 
! end do 

! START: csc forward_sub 

do j = 1, n
    print *, "j", j 
    do k = ind_ptr(j) + 1, ind_ptr(j + 1)
        print *, "k", k
        if (rows(k) < j) then 
            x(rows(k)) = x(rows(k)) - vals(k) * x(j)
        else
            x(j) = x(j) / vals(k)
        end if 
    end do 
end do

! END: csc forward_sub

! do k = 1, nnz 
!     if (rows(k) < cols(k)) then 
!         x(rows(k)) = x(rows(k)) - vals(k) * x(cols(k))
!     else
!         diagonal(rows(k)) = vals(k)
!     end if 
! end do 

! do k = 1, n
!     x(rows(k)) = x(rows(k)) / diagonal(k)
! end do 

end subroutine
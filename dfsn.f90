program dfsn
implicit none
integer :: n=100,m=100
integer ::i,k,l=0,ierror
!n represents the time£¬m represents the space.
real :: f(100,100)=0.,fo(100,100),f1(100,100),f2(100,100),f3(100,100),f4(100,100)
real :: t0=0,td=1,x0=0,xd=1,dx,dt

dt=(td-t0)/real(n)
dx=(xd-x0)/real(m)
!dt=0.01
!dx=0.01
call initial(f,dx,m)

!call diff()

do k=1,n-1
call rk4(f1,f2,f3,f4,f,fo,k,m,dx,dt)
end do

open (unit=8,file='diff.dat',status='unknown',iostat=ierror)
write (8,100)f
100   format(100(e12.5,' '))
close (8)

continue
end program dfsn



subroutine initial(f,dx,m)
DIMENSION  f(100,100)
do i=1,m
f(1,i)=real(i)*dx
end do
continue
end subroutine initial


subroutine rk4(f1,f2,f3,f4,f,h,k,m,dx,dt)
DIMENSION  f(100,100),h(100,100),f1(100,100),f2(100,100),f3(100,100),f4(100,100)

call diff(f1,f,dx,k,m)
do i=1,m
f(k,i)=f(k,i)+.5*dt*f1(k,i)
end do
call diff(f2,f,dx,k,m)

do i=1,m
f(k,i)=f(k,i)+.5*dt*f2(k,i)
end do
call diff(f3,f,dx,k,m)

do i=1,m
f(k,i)=f(k,i)+dt*f3(k,i)
end do
call diff(f4,f,dx,k,m)

do i=1,m
f(k+1,i)=f(k,i)+dt*(f1(k,i)+2.*f2(k,i)+2.*f3(k,i)+f4(k,i))/6.
end do
continue
end subroutine rk4


subroutine diff(fo,f,dx,k,m)
DIMENSION  f(100,100),fo(100,100)
!boundary Conditions
f(k,1)=dx
f(k,m)=m*dx
!main Area
do i=2,(m-1)
fo(k,i)=(f(k,i+1)+f(k,i-1)-2.*f(k,i))/(dx*dx)
end do
fo(k,1)=dx
fo(k,m)=m*dx

end subroutine diff


      implicit real*8 (a-h,o-z)
      double complex z
      
      pi = 4.d0*datan2(1.d0,1.d0) ! achei na internet esse jeito para ser exatamente pi
      write(*,*) "Insira N:"
      read(*,*) n

      rho = 3**(1/dble(n))
      do k=0,(n-1)
            theta = (2*dble(k))/dble(n)
            x = rho*dcos(theta*pi)
            y = rho*dsin(theta*pi)
            z = dcmplx(x, y)
            write(*,*)"k=",k
            write(*,*) "forma polar: |z| =", rho, "theta = pi*", theta
            write(*,*) "forma cartesiana: ", z
      end do
      
      end
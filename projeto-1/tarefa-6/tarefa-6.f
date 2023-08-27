
      implicit real*8 (a-h,o-z)
      double complex z
      
      pi = 4.d0*datan2(1.d0,1.d0) ! achei na internet esse jeito para ser exatamente pi
      write(*,*) "Insira N:"
      read(*,*) n

      rho = 3**(1/dble(n))
      do k=0,(n-1)
            theta = (2*dble(k))/dble(n)
            x_w = rho*dcos(theta*pi)
            y_w = rho*dsin(theta*pi)

            ! z = w+2
            x_z = x_w + 2
            y_z = y_w

            z = dcmplx(x_z, y_z)
            write(*,*)"k=",k
            write(*,*) "z=", z
      end do
      
      end
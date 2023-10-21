      implicit real*8 (a-h,o-z)

      real*8 espac,busca_direta, xm, tolerancia, dif
      real*8 a(3), b(3)
      real*8 xnewt(3), asec(3), bsec(3), difs(3)
      real*8 resultados(3,3,100)  ! tabela de resultados
      logical terminamos

      !espac = 1d-1*dsqrt(5.d0)
      espac = 0.1d0
      data a / -10d0, -10d0, -10d0 /
      data b / -10d0, -10d0, -10d0 /

      tolerancia = 1d-6

      do i=1,3
         dif = 1.d0
         do while(dif.gt.0d0)
            a(i) = a(i) + espac
            b(i) = a(i) + espac
            dif = cf(b(i))*cf(a(i))
      !      write(1,*)a(i),b(i),dif
         end do
         write(*,*)"encontramos ponto de bisseção:",a(i),b(i)
         if(i.lt.3) then
            a(i+1)=b(i)
            b(i+1)=b(i)
         end if
      end do

      write(*,*)"Terminamos de pesquisar"
      xnewt = a
      asec = a
      bsec =  b

      ! calcular usando o método da bisseção

      write(*,*)"Método da bisseção:"

      do i=1,3
      write(*,*)"tentando i=", i
         niter = 0
         dif = 1.d0
         do while(dif.ge.tolerancia)
            xm = (b(i) + a(i))/2d0
            if( (cf(b(i))*cf(xm)).gt.0d0) then
               b(i) = xm
            else
               a(i) = xm
            end if

            dif = abs(b(i)-a(i))
            if (dif.lt.tolerancia) then
               !calcular xm novamente para imprimir o valor correto
               xm = (b(i) + a(i))/2d0
            end if
            write(*,*)xm
         end do
      end do

      write(*,*)"Método de Newton:"
      do i=1,3
      write(*,*)"tentando i=", i
         niter = 0
         dif = 1.d0
         do while(dif.ge.tolerancia)
            x_newt_antigo = xnewt(i) ! variável temporária p/ calcular precisão
            xnewt(i) = xnewt(i) - cf(xnewt(i))/df(xnewt(i))

            dif = abs(xnewt(i) - x_newt_antigo)
            write(*,*)xnewt(i)
         end do
      end do

      write(*,*)"Método da Secante:"
      do i=1,3
      write(*,*)"tentando i=", i
         niter = 0
         dif = 1.d0
         do while(dif.ge.tolerancia)
            xtemp = bsec(i) ! variável temporária pra guardar o valor antigo de x_n

            bsec(i) = bsec(i) - (cf(bsec(i)) * (bsec(i)-asec(i))
     &      / (cf(bsec(i))-cf(asec(i))))

            asec(i) = xtemp

            dif = abs(bsec(i)-asec(i))
            write(*,*)bsec(i)
         end do
      end do

      end

      function cf(x)
         real*8 cf,x
         cf = x**3d0 - 4d0*(x**2d0) - 59d0*x + 126d0
      end function

      function df(x)
         real*8 df,x
         df = 3d0*(x**2d0) - 8d0*x - 59d0
      end function

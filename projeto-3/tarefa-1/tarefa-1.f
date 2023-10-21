      implicit real*8 (a-h,o-z)

      real*8 valores_h(14)
      real*8 valores_tabela(7,14)
      data valores_h / 5d-1, 1d-1, 5d-2, 1d-2, 5.d-3, 1.d-3, 5.d-4,
     &1.d-4, 5.d-5, 1.d-5, 5.d-6, 1.d-6, 1.d-7, 1.d-8/

      x = 0.5d0

      do i=1,7
         do j=1,14
            valores_tabela(i,j) = 0.d0
         end do
      end do

      f1_correto = anal_f1(x)
      f2_correto = anal_f2(x)
      f3_correto = anal_f3(x)

      !write(*,*)f1_correto, f2_correto, f3_correto

      do i=1,14
         h = valores_h(i)
         valores_tabela(1,i) = f1_2f(x,h) - f1_correto
         valores_tabela(2,i) = f1_2t(x,h) - f1_correto
         valores_tabela(3,i) = f1_3s(x,h) - f1_correto
         valores_tabela(4,i) = f1_5s(x,h) - f1_correto
         valores_tabela(5,i) = f2_3s(x,h) - f2_correto
         valores_tabela(6,i) = f2_5s(x,h) - f2_correto
         valores_tabela(7,i) = f3_5a(x,h) - f3_correto
      end do

      ! fazer valores da tabela serem absolutos
      do j=1,7
         do i=1,14
            valores_tabela(j,i) = abs(valores_tabela(j,i))
         end do
      end do

      write(*,*)"Valores da tabela da primeira derivada:"
      ! printar valores da primeira tabela, de f'
      do i=1,14
         write(*,*) (valores_tabela(j,i), j=1,4)
      end do
      write(*,*)"Valor exato:", f1_correto

      !printar valores da segunda tabela, de f''
      write(*,*)"Valores da tabela da segunda derivada:"
      do i=1,14
         write(*,*) (valores_tabela(j,i), j=5,6)
      end do
      write(*,*)"Valor exato:", f2_correto

      write(*,*)"Valores da tabela da terceira derivada:"
      ! printar valores da terceira tabela, de f'''
      do i=1,14
         write(*,*) valores_tabela(7,i)
      end do
      write(*,*)"Valor exato:", f3_correto
      end

      function cf(x)
         real*8 x
         real*8 cf

         cf = dexp(x/2.d0)*dtan(2.d0*x)
      return
      end function cf

      function dsec2(x)
         ! sec²x
         real*8 x
         dsec2 = (1.d0/dcos(x))**2.d0
         return
      end function

      function anal_f1(x)
         ! f' analitico
         real*8 x
         real*8 anal_f1

         ds = dsec2(2.d0*x)
         dt = dtan(2.d0*x)

         anal_f1 = dexp(x/2.d0)*(2.d0*ds + 0.5d0*dt)
      return
      end function

      function anal_f2(x)
         ! f'' analitico
         real*8 x
         real*8 anal_f2

         ds = dsec2(2.d0*x)
         dt = dtan(2.d0*x)

         anal_f2 = dexp(x/2.d0)*(2.d0*ds + 0.25d0*dt + 8.d0*ds*dt)
      end function

      function anal_f3(x)
         ! f'' analitico
         real*8 x
         real*8 anal_f3

         ds = dsec2(2.d0*x)
         dt = dtan(2.d0*x)

         anal_f3 = dexp(x/2.d0)*(1.5d0*ds + (1.d0/8.d0)*dt + 12.d0*ds*dt
     &   + 16.d0*(ds**2.d0) + 32.d0*ds*(dt**2.d0))
      end function

      function f1_2f(x,h)
         real*8 cf
         external cf
         ! f'_{2f}
         real*8 x,h,f1_2f

         f1_2f = (cf(x+h)-cf(x))/h

      end function

      function f1_2t(x,h)
         ! f'_{2t}
         real*8 cf
         external cf
         real*8 x,h,f1_2t
         f1_2t = (cf(x)-cf(x-h))/h

      end function

      function f1_3s(x,h)
         real*8 cf
         external cf
         real*8 x,h,f1_3s
         f1_3s = (cf(x+h)-cf(x-h))/(2.d0*h)

      end function

      function f1_5s(x,h)
         real*8 cf
         external cf
         real*8 x,h, f1_5s
         f1_5s = (cf(x-2.d0*h) - 8.d0*cf(x-h)
     &   + 8.d0*cf(x+h) - cf(x+2.d0*h))/(12.d0 * h)
      end function

      function f2_3s(x,h)
         real*8 cf
         external cf
         real*8 x,h, f2_3s
         f2_3s = (cf(x+h) -2.d0*cf(x) + cf(x-h))/(h**2.d0)
      end function

      function f2_5s(x,h)
         real*8 cf
         external cf
         real*8 x,h, f2_5s
         f2_5s = (-1.d0*cf(x-2.d0*h) + 16.d0*cf(x-h) -30.d0*cf(x)
     &   +16.d0*cf(x+h) - cf(x+2.d0*h)) / (12.d0*(h**2.d0))
      end function

      function f3_5a(x,h)
         real*8 cf
         external cf
         real*8 x,h, f3_5a
         f3_5a = (-1.d0*cf(x- 2.d0*h) + 2.d0*cf(x-h) - 2.d0*cf(x+h)
     &   + cf(x+2.d0*h))/(2.d0*(h**3.d0))
      end function



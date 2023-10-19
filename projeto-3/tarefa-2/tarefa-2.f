      implicit real*8 (a-h,o-z)

      pi = 4.d0*datan(1.d0)
      e = dexp(1.d0)

      valor_analitico = (e - 1.d0)/(e + (4.d0*e*(pi**2.d0)))

      write(*,*)valor_analitico

      do i=2,12
         h = 1.d0/(3.d0*(2.d0**i))
         xt = trapezio(h)
         xs = simpson(h)
         xb = boole(h)

         et = abs(valor_analitico-xt)
         es = abs(valor_analitico-xs)
         eb = abs(valor_analitico-xb)

         write(*,*)et, es, eb
      end do

      end

      function cf(x)
         real*8 x
         real*8 cf
         pi = 4.d0*datan(1.d0)
         cf = dexp(-x)*dcos(2.d0*pi*x)
      end function

      function trapezio(h)
         real*8 h, cf, trapezio, a, b, soma
         integer*16 nparticoes
         external cf

         a = 0.d0
         b = 1.d0
         nparticoes = dint((b-a)/h)

         soma = 0.5d0 * (cf(a) + cf(b))
         do i=1,(nparticoes-1)
            soma = soma + cf(a + dble(i)*h)
         end do

         trapezio = h * soma
      end function

      function simpson(h)
         real*8 h, cf, simpson, a, b, soma
         integer*16 i, nparticoes
         external cf

         a = 0.d0
         b = 1.d0
         nparticoes = dint((b-a)/h)

         soma = cf(a) + cf(b)

         do i=1,nparticoes-1,2
            soma = soma + 4.d0*cf(a + dble(i)*h)
         end do

         do i=2,nparticoes-1,2
            soma = soma + 2.d0*cf(a + dble(i)*h)
         end do

         simpson = (h/3.d0) * soma
      end function

      function boole(h)
         real*8 h, cf, boole, a, b, soma
         integer*16 nparticoes, i
         external cf

         a = 0.d0
         b = 1.d0
         nparticoes = dint((b-a)/h)

         soma = 0.d0
         do i=0,nparticoes-1,4
            soma = soma + (2.d0*h/45.d0) * (7.d0*cf(a + dble(i)*h) +
     &          32.d0*cf(a + dble(i+1)*h) + 12.d0*cf(a + dble(i+2)*h) +
     &          32.d0*cf(a + dble(i+3)*h) + 7.d0*cf(a + dble(i+4)*h))
         end do

         boole = soma
      end function

      implicit real*8 (a-h,o-z)
      parameter(N_iteracoes=10000000)

      somatotal = 0.e0

      write(*,*)"Insira n"
      read(*,*)n

      do i=1,N_iteracoes
         x = rand()
         somatotal = somatotal + (x**n)
      end do

      xmedio = somatotal / real(N_iteracoes)
      write(*,*)"<x^n>:", xmedio

      end


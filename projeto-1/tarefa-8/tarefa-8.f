
      implicit real*8 (a-h,o-z)
      parameter(iterations=10000000)
      integer d

      open(unit=1, file='output.dat')

      write(*,*)"Insira d (número de dimensões):"
      read(*,*)d
      write(*,*)"Insira r:"
      read(*,*)r

      pi = 4.d0*datan2(1.d0,1.d0)

      do n=1,d
            ! precisamos ver se d é divisível por 2, pois assim sabemos qual versão da função gamma utilizar
            if (mod(n,2).eq.0) then
                  gamma = 1.e0
                  do i=1,int(n/2)
                        gamma = gamma * real(i)
                  end do
            else
                  gamma = sqrt(pi)
                  do i=1,n,2 ! temos que fazer o do usando numeros inteiros senão o compilador reclama
                        ! (mesmo sendo que o fortran 77 permite números reais no do)
                        gamma = gamma * (i/2.e0) ! portanto precisamos dividir por 2 aqui
                  end do
            end if

            v_calculado = ((pi**(n/2.e0)) / gamma) * (r**real(n))
            write(*,*) n, v_calculado
            write(1,*) n, v_calculado
      end do

      end
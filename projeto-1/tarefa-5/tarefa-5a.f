!     calcular lnx
      implicit real*8 (a-h,o-z)

      parameter (n_maximo_iteracoes=100000)
      parameter (precisao=1.d-5)

      write(*,*)"Insira x"
      read(*,*)x

      valor_correto = log(x)

      ! calcular usando série
      valor_aproximado = 0.d0

      do i=1,n_maximo_iteracoes
            valor_a_somar = ( (1-x)**i ) / i ! valor que vamos somar (na verdade subtrair) ao valor aproximado
            valor_aproximado = valor_aproximado - valor_a_somar

            difference = abs(valor_correto - valor_aproximado)
            if (difference.le.precisao) then
                  exit
            end if
      end do

      write(*,*)"valor aproximado obtido:", valor_aproximado
      write(*,*)"valor esperado (correto):", valor_correto
      write(*,*)"diferença entre os valores:", difference
      write(*,*)"iterações:", i

      end

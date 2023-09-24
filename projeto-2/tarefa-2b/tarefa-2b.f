      implicit real*8 (a-h,o-z)
      parameter(m=1000000)
      parameter(n=1000)
      integer*16 iposicoes(m)
      integer*16 ix_andarilho

      soma_x = 0.d0
      soma_x2 = 0.d0
      soma_x2_central = 0.d0

      open(unit=1, file='tarefa-2b-saida.dat')

      write(*,*) "insira o denominador de p em forma real"
      read(*,*)denom
      p = 1.e0/denom

      do i=1,m
         iposicoes(i) = 0_16
         ix_andarilho = 0_16
         do j=1,n
            ! O algoritmo é o seguinte: para não termos que usar if, criamos uma nova variável x = p - r.
            ! Note que x < 0 caso r > p, que corresponde a um passo à esquerda com probabilidade 1 - p = q
            ! E que x > 0 caso r < p, que tem probabilidade p
            ! Depois para pegar -1 ou +1, fazemos x/|x|
            r = rand()
            x = p - r
            ix = int(x/abs(x), 16)

            ix_andarilho = ix_andarilho + ix
         end do
         write(1,*)ix_andarilho
         !write(*,*)ix_andarilho

         iposicoes(i) = ix_andarilho

      end do

      close(1)

      do i=1,m
         ! calcular <x>
         soma_x = soma_x + real(iposicoes(i))
      end do
      soma_x = soma_x / real(m)

      do i=1,m
         ! calcular <x^2> e a disperção central sigma^2
         soma_x2 = soma_x2 + real(iposicoes(i)**2)
         soma_x2_central = soma_x2_central + ( (real(iposicoes(i))
     &   - soma_x)**2.e0)
      end do

      soma_x2 = soma_x2 / real(m)
      soma_x2_central = soma_x2_central / real(m)

      write(*,*)"<x>:", soma_x
      write(*,*)"<x2>:", soma_x2
      write(*,*)"<x2> central:", soma_x2_central

      end

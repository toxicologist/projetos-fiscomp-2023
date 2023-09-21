      implicit real*8 (a-h,o-z)
      parameter(m=1000000)
      parameter(n=1000)

      soma_x = 0.0
      soma_x2 = 0.0

      open(unit=1, file='tarefa-2b-saida.dat')

      write(*,*) "insira o denominador de p em forma real"
      read(*,*)denom
      p = 1.e0/denom

      do i=1,m
         ix_andarilho = 0
         do j=1,n
            ! O algoritmo é o seguinte: para não termos que usar if, criamos uma nova variável x = p - r.
            ! Note que x < 0 caso r > p, que corresponde a um passo à esquerda com probabilidade 1 - p = q
            ! E que x > 0 caso r < p, que tem probabilidade p
            ! Depois para pegar -1 ou +1, fazemos x/|x|
            r = rand()
            x = p - r
            ix = int(x/abs(x))

            ix_andarilho = ix_andarilho + ix
         end do
         write(1,*)ix_andarilho

         soma_x = soma_x + real(ix_andarilho)
         soma_x2 = soma_x2 + real(ix_andarilho**2)

      end do

      close(1)

      soma_x = soma_x / real(m)
      soma_x2 = soma_x2 / real(m)

      write(*,*)"<x>:", soma_x
      write(*,*)"<x2>:", soma_x2

      end

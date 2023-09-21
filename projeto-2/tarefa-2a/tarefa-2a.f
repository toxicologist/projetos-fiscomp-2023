      implicit real*8 (a-h,o-z)
      parameter(m=1000000)
      parameter(n=1000)

      soma_x = 0.0
      soma_x2 = 0.0

      open(unit=1, file='tarefa-2a-saida.dat')

      do i=1,m
         ix_andarilho = 0
         do j=1,n
            irand = 2*int(2.e0 * rand()) - 1
            ix_andarilho = ix_andarilho + irand
         end do
         !write(*,*)ix_andarilho
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

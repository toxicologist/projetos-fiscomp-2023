      implicit real*8 (a-h,o-z)
      parameter(n_andarilhos=2000)
      integer iposicao(2)

      soma_x = 0.0
      soma_x2 = 0.0

      write(*,*)"Insira a potência de n (10^potência)"
      read(*,*)npot

      open(unit=1, file='tarefa-3-saida.dat')

      n = 10**npot

      do i=1,n_andarilhos
         iposicao(1) = 0
         iposicao(2) = 0
         do j=1,n
            ! como queremos 4 possibilidades, com 0.25 de chance cada um, fazemos o seguinte:
            ! primeiro escolhemos qual das direções (x ou y) iremos andar,
            ! depois fazemos outro rand() para decidir se vamos +1 ou -1 naquela direção

            idir = int(2*rand()) + 1 ! será ou 1 ou 2

            ! para decidir +1 ou -1 usamos o algoritmo da tarefa 2
            irand = 2*int(2.e0 * rand()) - 1

            !write(*,*) idir, irand

            iposicao(idir) = iposicao(idir) + irand
         end do
         write(*,*)iposicao
         write(1,*)iposicao

      end do
      close(1)
      end

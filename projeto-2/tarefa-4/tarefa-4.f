      implicit real*8 (a-h,o-z)
      parameter(n_andarilhos=500) ! número de andarilhos
      parameter(itamanho_malha=3000) ! tamanho total da malha
      parameter(itamanho_particao=300) ! tamanho da subdivisão da malha
      parameter(n_passos=1000000) ! 1 milhão de passos
      parameter(n_iteracoes=2500) ! número de iterações/subdivisões do random walk
      integer iposicoes(n_andarilhos, 2) ! Matriz posição de cada um dos andarilhos

      open(unit=1, file='tarefa-4-saida.dat')

      ! primeiro inicializar a matriz iposicoes
      do i=1,n_andarilhos
         iposicoes(i,1) = 0
         iposicoes(i,2) = 0
      end do

      incremento_passos = n_passos/n_iteracoes ! Quantos passos damos em cada iteração
      i_n_divisoes_malha = itamanho_malha/itamanho_particao ! Quantas subdivisões temos em cada eixo da malha

      do niter=1,n_iteracoes
         write(*,*) "Iteração", niter, "de", n_iteracoes
         do j=( (niter-1)*incremento_passos ),(niter*incremento_passos)
            do i=1,n_andarilhos
               ! O seguinte código copiado da tarefa 3.

               ! como queremos 4 possibilidades, com 0.25 de chance cada um, fazemos o seguinte:
               ! primeiro escolhemos qual das direções (x ou y) iremos andar,
               ! depois fazemos outro rand() para decidir se vamos +1 ou -1 naquela direção

               idir = int(2*rand()) + 1 ! será ou 1 ou 2

               ! para decidir +1 ou -1 usamos o algoritmo da tarefa 2
               irand = 2*int(2.e0 * rand()) - 1

               iposicoes(i,idir) = iposicoes(i,idir) + irand
            end do
         end do
         ! Agora precisamos calcular a ENTROPIA do sistema. para fazer isso, vamos subdividir o espaço
         ! em uma malha de partição itamanho_particao.
         ! O tamanho total da malha, será de -3000 até 3000 nas duas direções (x e y)
         ! (escolhemos isso com base no gráfico da tarefa 3.)
         entropia = 0.e0
         do i=-i_n_divisoes_malha,i_n_divisoes_malha-1
            do j=-i_n_divisoes_malha,i_n_divisoes_malha-1
               n_dentro = 0
               do k=1,n_andarilhos
                  ! como calculamos Pi? simplesmente vemos quantos andarilhos estão dentro dessa célula, e dividimos pelo número total
                  ! de andarilhos!
                  ! Como calcular se está dentro:
                  ! i*itamanho_particao <= x_adarilho < (i+1)*itamanho_particao
                  ! e o mesmo para y
                  ! j*itamanho_particao <= y_andarilho < (j+1)*itamanho_particao
                  ix_andarilho = iposicoes(k, 1)
                  iy_andarilho = iposicoes(k, 2)

                  if ( ((i*itamanho_particao).le.ix_andarilho).and.
     &            ( ((i+1)*itamanho_particao).gt.ix_andarilho ).and.
     &            ( (j*itamanho_particao).le.iy_andarilho).and.
     &            ( ((j+1)*itamanho_particao).gt.iy_andarilho )) then
                     n_dentro = n_dentro + 1
                  end if
               end do
               pi = real(n_dentro)/real(n_andarilhos)
               if(pi.gt.0.e0)then
                  entropia = entropia - (pi * log(pi))
                  write(*,*)"Encontramos", n_dentro,
     &            "andarilhos no ponto", i, j, "pi=", pi
               end if
            end do
         end do
         write(*,*)"Entropia:", entropia
         ! no arquivo, escrevemos o número N de passos no eixo x, e a entropia no eixo Y
         write(1,*)niter*incremento_passos,entropia

      end do

      close(1)

      end

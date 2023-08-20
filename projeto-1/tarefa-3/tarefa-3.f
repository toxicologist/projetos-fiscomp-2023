      implicit real*8 (a-h,o-z)
      parameter (n_maximo_linhas=1000000)
      real*8 array_arquivo(n_maximo_linhas)
      open(unit=1, file='tarefa-3-entrada-1.in')

      do n=1,n_maximo_linhas
            read(1, *, end=200) a_linha
            array_arquivo(n) = a_linha
      end do

200   continue
      ! A última iteração do loop é quando ele sai do arquivo. Ou seja, o arquivo tem n-1 linhas
      n = n-1
      write(*,*) "Alcançamos o final do arquivo"
      write(*,*) "Numero de linhas N:", n
      close(1)

      write(*,*) "Insira M:"
      read(*,*) m

      ! agora vamos ordenar a lista
      do i=1,m
            a_menor = array_arquivo(i)
            i_posicao_menor = i
            ! O algoritmo de ordenar é o seguinte: Vamos passando pela lista, até encontrarmos uma linha
            ! que é menor do que a variável a_menor. assim, agora o menor valor é o dessa linha,
            ! e salvamos a posição dessa linha no i_posicao_menor.
            do j=i,n
                  if (a_menor.gt.array_arquivo(j)) then
                        a_menor = array_arquivo(j)
                        i_posicao_menor = j
                  end if
            end do

            ! no final de cada iteração, temos o menor número na lista de i até m. então,
            ! trocamos o número que está na posição i pelo verdadeiro menor número

            valor_antigo = array_arquivo(i)
            array_arquivo(i) = a_menor
            array_arquivo(i_posicao_menor) = valor_antigo

      end do

      ! agora vamos escrever no arquivo novo
      open(unit=2, file='ordenada')
      write(*,*) "M=", m
      write(2,*) "M=", m
      do i2=1,m
            write(*,*) array_arquivo(i2)
            write(2,*) array_arquivo(i2)
      end do
      close(2)
      end
c   programa 1.3: sorting
      parameter (i_tammax=10000)
      dimension a_numeros(i_tammax)
      dimension a_ordenada(i_tammax)
      real i_tam_real = 0

      write(*,*) 'insira M: '
      read(*,*) i_m  ! devemos ordernar M números do arquivo

      do i1=1,i_tammax
c        write(*,*) 'lendo', i1
        read(1,*,end=5) a_numeros(i1)
c        write(*,*) a_numeros(i1)
      end do


5     continue
      i_tam_real = i1 - 1

      if (i_tam_real.lt.i_m) then
            write(*,*) "ERRO: M é maior do N"
            goto 10
      endif

c     agora vamos ordenar a lista
      do i2=1,i_m
            a_menor = a_numeros(i2)
            i_posicao_menor = i2

            do i3=i2,i_tam_real
                  if (a_menor.gt.a_numeros(i3)) then
                        a_menor = a_numeros(i3)
                        i_posicao_menor = i3
                  endif
            end do

            a_temp_i2 = a_numeros(i2)  ! variável temporária para armazenar o valor antigo da posição i2
            a_numeros(i2) = a_menor ! agora o menor número vai para o "começo" da lista
            a_numeros(i_posicao_menor) = a_temp_i2
            
      end do
      
c     agora vamos escrever os números ordenados num arquivo novo
      do i4=1,i_m
            write(2,*) a_numeros(i4)
      end do

10    continue
      end
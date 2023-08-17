!     numeros primos 
      implicit real*8 (a-h,o-z)
      logical primo ! se um numero é primo ou não

      write(*,*) "Insira N:"
      read(*,*) n

      open(unit=1, file='primos-saida') ! arquivo de saída

      ntotal = 0 ! n total de primos
      
      do i=2,n ! começo em 2 pq assumo que 1 não é primo
            primo = .true.
            do j=2,(i-1)
                  if (mod(i,j).eq.0) then ! se o numero nao tem resto de divisão por um numero menor que ele, ele não é primo
                        primo = .false.
			exit
!                  else if(j.eq.(i-1)) then ! Se j == n-1, significa que chegamos no final do loop, ou seja, i é primo!
!                        write(*,*) "primo"
!                        ntotal = ntotal + 1
                  end if
            end do
            if (primo) then
                  write(*,*) i, "primo"
                  write(1,*) i
                  ntotal = ntotal + 1
            end if
      end do

      write(*,*) "N total de primos:", ntotal
      write(1,*) "N total de primos:", ntotal

      close(1)

      end
            

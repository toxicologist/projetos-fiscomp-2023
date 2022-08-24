c     programa 1.4
      parameter (eprec=1.e-5)

      write(*,*) 'insira x'
      read(*,*) a_x

      a_valor_referencia = cos(a_x)
      a_valor_aproximado = 1.e0

      do i1=1,20
            !write(*,*) a_valor_aproximado
            i_par_associado = 2 * i1  ! ou seja, 2, 4, 6, ...
            i_fatorial = 1

            do i2=i_par_associado,1,-1
                  i_fatorial = i_fatorial * i2
            end do

            a_somar = ( (-1) ** i1)
            a_somar = a_somar  * ( (a_x ** i_par_associado)
     &        / i_fatorial) ! valor que devo somar

            a_valor_aproximado = a_valor_aproximado + a_somar

            write(*,*) i1, i_par_associado, i_fatorial, a_valor_aproximado

            if (abs((a_valor_aproximado - 
     &       a_valor_referencia)).le.eprec) then
                  goto 5
            endif

      end do
5     continue
      write(*,*) 'valor calculado:', a_valor_aproximado
      write(*,*) 'valor referência:', a_valor_referencia
      
      end
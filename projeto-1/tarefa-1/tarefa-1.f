c     programa 1.1: bhaskara
      implicit real*8 (a-h,o-z)

      ! ler a, b, c
      write(*,*) "Insira a:"
      read(*,*) a
      write(*,*) "Insira b:"
      read(*,*) b
      write(*,*) "Insira c:"
      read(*,*) c

      delta = (b**2) - (4*a*c)

      if(delta.gt.0) then ! ver se delta é maior que 0
            x1 = ( -b + sqrt(delta) )/(2*a)
            x2 = ( -b - sqrt(delta) )/(2*a)
            write(*,*) "Duas raízes reais. x1=", x1, ", x2=", x2
      
      else if (delta.eq.0) then
            x = ( -b + sqrt(delta) )/(2*a)
            write(*,*) "Uma raiz real. x=", x

      else 
            write(*,*) "nenhuma raiz real"
      
      end if

      end
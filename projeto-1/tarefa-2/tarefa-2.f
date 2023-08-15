!     programa: triangulo de 2 vetores
      implicit real*8 (a-h,o-z)

      write(*,*)"Insira x1, y1, z1, x2, y2, z2, um de cada vez:"
      read(*,*)x1
      read(*,*)y1
      read(*,*)z1
      read(*,*)x2
      read(*,*)y2
      read(*,*)z2

      ! A área do triângulo é a mesma coisa que metade da área do paralelogramo
      ! Que é a mesma coisa que o produto vetorial. Logo, vamos calcular o produto vetorial, no vetor v3 = v1 x v2

      x3 = y1*z2 - z1*y2
      y3 = z1*x2 - x1*z2
      z3 = x1*y2 - x2*y1

      v3 = sqrt( x3**2 + y3**2 + z3**2 ) ! Magnitude do vetor

      area = v3 / 2
      write(*,*)"A área do triângulo é", area

      end
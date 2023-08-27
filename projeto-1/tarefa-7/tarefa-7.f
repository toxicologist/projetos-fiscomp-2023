
      implicit real*8 (a-h,o-z)
      parameter(iterations=1000000)
      integer d

      ! O algoritmo é o seguinte: calcular pontos aleatórios e ver quantos deles estão dentro ou fora da esfera 
      ! e calcular o volume a partir disso. como?
      ! Se vc esquematizar uma esfera de raio 1, em qualquer dimensão, ela será contida dentro de um cubo de raio 2
      ! centrado na origem (a esfera tem diâmetro 2.) Logo, calculamos primeiro a razão de pontos no primeiro quadrante
      ! (xi > 0) e depois extrapolamos isso para os outros quadrantes, calculando a partir do volume do cubo de 2^d.

      write(*,*)"Insira d (número de dimensões):"
      read(*,*)d

      volume_cubo = 2.e0**d

      n_dentro = 0

      do i=1,iterations
            distancia = 0.e0
            if (mod(i, iterations/10).eq.0) then
                  n_porcento = i/(iterations/100)
                  write(*,*) "porcentagem concluido:", n_porcento, "%"
            end if

            do j=1,d
                  xj = rand()
                  xj2 = xj**2.e0
                  distancia = distancia + xj2
            end do

            distancia = sqrt(distancia)

            if (distancia.le.1) then
                  n_dentro = n_dentro + 1
            end if
      end do

      razao_dentro = real(n_dentro)/real(iterations)
      volume_esfera = razao_dentro * volume_cubo
      write(*,*)
      write(*,*) "Volume da esfera: ", volume_esfera

      ! agora calcular usando gamma
      pi = 4.d0*datan2(1.d0,1.d0)

      ! precisamos ver se d é divisível por 2, pois assim sabemos qual versão da função gamma utilizar
      if (mod(d,2).eq.0) then
            gamma = 1.e0
            do i=1,int(d/2)
                  gamma = gamma * real(i)
            end do
      else
            gamma = sqrt(pi)
            do i=1,d,2 ! temos que fazer o do usando numeros inteiros senão o compilador reclama
                  ! (mesmo sendo que o fortran 77 permite números reais no do)
                  gamma = gamma * (i/2.e0) ! portanto precisamos dividir por 2 aqui
            end do
      end if

      v_calculado = (pi**(d/2.e0)) / gamma
      write(*,*)"Volume calculado com gamma:", v_calculado

      end
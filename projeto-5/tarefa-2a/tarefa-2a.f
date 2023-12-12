         implicit real*8 (a-h, o-z)
         real*8 p_ec(10000000,2)
         real*8 v_ec(10000000,2)
         real*8 p_verlet(10000000,2)
         real*8 v_verlet(10000000,2)

         pi = 4.d0*datan2(1.d0,1.d0)

         tau_total = 10d0
         dtau = 1d-4
         iteracoes = int(tau_total/dtau)
         a = 1d0
         a_marte = 1.662d0*a
         v_marte = 0.739d0

         open(file='orbita.dat', unit=1)
         open(file='1alei.dat',unit=2)
         open(file='2alei.dat', unit=3)

         p_ec(1,1) = 0d0
         p_ec(1,2) = a
         v_ec(1,1) = v_marte
         v_ec(1,2) = 0d0

         p_verlet(1,1) = p_ec(1,1)
         p_verlet(1,2) = p_ec(1,2)

         ymin = 10000d0
         ymax = 0d0

         ! para verificar se a órbita é elíptica, vamos descobrir qual é o y máximo e o y mínimo
         ! esse segundo será a distância do foco do sol, a um dos cantos da elipse
         ! o primeiro, subtraido pelo segundo, será a distância da origem até o segundo foco
         ! tendo isso, podemos verificar a 1a lei de kepler

         do i=2,iteracoes
            tempo = dble(i)*dtau
            p3 = pcubo(p_ec(i-1,1), p_ec(i-1,2))

            !verlet
            if (i.eq.2) then
               ! pular verlet, usar os valores de euler-cromer
               v_ec(i,1) = v_ec(i-1,1) - (p_ec(i-1,1)/p3)*dtau
               v_ec(i,2) = v_ec(i-1,2) - (p_ec(i-1,2)/p3)*dtau

               p_ec(i,1) = p_ec(i-1,1) + v_ec(i,1)*dtau
               p_ec(i,2) = p_ec(i-1,2) + v_ec(i,2)*dtau

               p_verlet(i,1) = p_ec(i,1)
               p_verlet(i,2) = p_ec(i,2)
            else
               p3 = pcubo(p_verlet(i-1,1),p_verlet(i-1,2))

               p_verlet(i,1) = 2d0*p_verlet(i-1,1) - p_verlet(i-2,1)
     &          - (p_verlet(i-1,1)/p3)*(dtau**2)
               p_verlet(i,2) = 2d0*p_verlet(i-1,2) - p_verlet(i-2,2)
     &          - (p_verlet(i-1,2)/p3)*(dtau**2)
            endif

            write(1,*)p_verlet(i,1), p_verlet(i,2)

            if (p_verlet(i,2).lt.ymin) then
               ymin = p_verlet(i,2)
            end if
            if (p_verlet(i,2).gt.ymax) then
               ymax = p_verlet(i,2)
            endif

            area = 0.5d0 * abs(p_verlet(i-1,1)*p_verlet(i,2)
     &      - p_verlet(i,1)*p_verlet(i-1,2))
            write(3,*)tempo, area


         end do


         foco = ymax - abs(ymin)
         write(*,*)ymin,ymax, foco

         ! agora verificar a 1a lei de kepler: calcular as distâncias em cada ponto a cada um dos focos
         do i=1,iteracoes
            tempo = dble(i)*dtau
            d1 = dsqrt(p_verlet(i,1)**2d0 + p_verlet(i,2)**2d0)
            d2 = dsqrt(p_verlet(i,1)**2d0 + (foco - p_verlet(i,2))**2d0)
            dist = d1+d2
            write(2,*)tempo,dist
         end do

         ! agora calcular as velocidades em Verlet
         ! vamos usar a derivdada simétrica de 5 pontos
         !do i=3,iteracoes-2
            ! começamos do 3 pq precisamos ter i-2 e i-1 válidos
         !   v_verlet(i,1) = (p_verlet(i-2,1) - 8d0*p_verlet(i-1,1)
     &   !    + 8d0*p_verlet(i+1,1) - p_verlet(i+2,1)) / (12d0*dtau)
         !   v_verlet(i,2) = (p_verlet(i-2,2) - 8d0*p_verlet(i-1,2)
     &   !    + 8d0*p_verlet(i+1,2) - p_verlet(i+2,2)) / (12d0*dtau)

          !  write(4,*)v_verlet(i,1), v_verlet(i,2)
         !end do


         end

         function pcubo(px,py)
            real*8 px, py, pcubo
            pcubo = (px**2d0 + py**2d0)**(3d0/2d0)
         end function

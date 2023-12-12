         implicit real*8 (a-h, o-z)
         real*8 p_ec(10000000,2)
         real*8 v_ec(10000000,2)
         real*8 p_verlet(10000000,2)
         real*8 v_verlet(10000000,2)

         pi = 4.d0*datan2(1.d0,1.d0)

         tau_total = 10d0
         dtau = 1d-5

         a = 1d0

         p_ec(1,1) = 0d0
         p_ec(1,2) = a
         v_ec(1,1) = 1d0/dsqrt(a)
         v_ec(1,2) = 0d0

         p_verlet(1,1) = p_ec(1,1)
         p_verlet(1,2) = p_ec(1,2)

         open(file='3alei.dat',unit=1)

         ! para verificar a 3a lei, vamos usar um exemplo simplificado para órbitas circulares
         ! e ir iterando em planetas imaginários até 5ua de raio

         do ip=1,10
            a = 0.5d0*dble(ip)
            p_ec(1,1) = a
            p_ec(1,2) = 0d0
            v_ec(1,1) = 0d0
            v_ec(1,2) = 1d0/dsqrt(a)

            p_verlet(1,1) = a
            p_verlet(1,2) = 0d0

            ! calcular periodo
            tau_total = 20d0*a
            iteracoes = int(tau_total/dtau)

            tempo_periodo = 0d0

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

            ! verificar se já deu 1 período
            if (tempo.gt.1d0)then
            if ((abs(p_verlet(1,1)-p_verlet(i,1)).lt.1d-3)
     &      .and.(abs(p_verlet(1,2)-p_verlet(i,2)).lt.1d-3)) then
               tempo_periodo = tempo
               goto 10
            endif
            endif
         end do

10       continue
         if (tempo_periodo.eq.0d0)then
            write(*,*)"Erro: nao achamos periodo p/",ip
         else
            write(*,*)"periodo p/",ip,tempo_periodo

            write(1,*)(a**3d0),(tempo_periodo**2d0)
         endif

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

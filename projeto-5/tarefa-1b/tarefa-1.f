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

            open(file='tarefa-1-saida-pec.dat', unit=1)
            open(file='tarefa-1-saida-pverlet.dat', unit=3)
            open(file='tarefa-1-saida-vec.dat', unit=2)
            open(file='tarefa-1-saida-verlet.dat', unit=4)

            p_ec(1,1) = a
            p_ec(1,2) = 0d0
            v_ec(1,1) = 0d0
            v_ec(1,2) = 1d0/dsqrt(a)

            p_verlet(1,1) = a
            p_verlet(1,2) = 0d0

            do i=2,iteracoes
               p3 = pcubo(p_ec(i-1,1), p_ec(i-1,2))

               v_ec(i,1) = v_ec(i-1,1) - (p_ec(i-1,1)/p3)*dtau
               v_ec(i,2) = v_ec(i-1,2) - (p_ec(i-1,2)/p3)*dtau

               p_ec(i,1) = p_ec(i-1,1) + v_ec(i,1)*dtau
               p_ec(i,2) = p_ec(i-1,2) + v_ec(i,2)*dtau

               write(1,*)p_ec(i,1),p_ec(i,2)
               write(2,*)v_ec(i,1),v_ec(i,2)

               !verlet
               if (i.eq.2) then
                  ! pular verlet, usar os valores de euler-cromer
                  p_verlet(i,1) = p_ec(i,1)
                  p_verlet(i,2) = p_ec(i,2)
               else
                  p3 = pcubo(p_verlet(i-1,1),p_verlet(i-1,2))

                  p_verlet(i,1) = 2d0*p_verlet(i-1,1) - p_verlet(i-2,1)
     &            - (p_verlet(i-1,1)/p3)*(dtau**2)
                  p_verlet(i,2) = 2d0*p_verlet(i-1,2) - p_verlet(i-2,2)
     &            - (p_verlet(i-1,2)/p3)*(dtau**2)
               endif

               write(3,*)p_verlet(i,1), p_verlet(i,2)

            end do

            ! agora calcular as velocidades em Verlet
            ! vamos usar a derivdada simétrica de 5 pontos
            do i=3,iteracoes-2
               ! começamos do 3 pq precisamos ter i-2 e i-1 válidos
               v_verlet(i,1) = (p_verlet(i-2,1) - 8d0*p_verlet(i-1,1)
     &         + 8d0*p_verlet(i+1,1) - p_verlet(i+2,1)) / (12d0*dtau)
               v_verlet(i,2) = (p_verlet(i-2,2) - 8d0*p_verlet(i-1,2)
     &         + 8d0*p_verlet(i+1,2) - p_verlet(i+2,2)) / (12d0*dtau)

               write(4,*)v_verlet(i,1), v_verlet(i,2)
            end do

            end

            function pcubo(px,py)
               real*8 px, py, pcubo
               pcubo = (px**2d0 + py**2d0)**(3d0/2d0)
            end function

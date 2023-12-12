      implicit real*8 (a-h, o-z)
      real*8 p_ec(10000000,2)
      real*8 v_ec(10000000,2)
      real*8 p_verlet(10000000,2)
      real*8 v_verlet(10000000,2)
      real*8 m_planetas(8), a_planetas(8)
      real*8 d_planetas(800,100000,2) ! armazena (dtau, delta) respectivo pra aquele planeta
      data m_planetas / 0.055d0, 0.817d0, 1.00d0, 0.107d0,
     &318d0, 95.2d0, 14.5d0, 17.1d0 /
      data a_planetas / 0.39d0, 0.72d0, 1.00d0, 1.52d0,
     &5.20d0, 9.58d0, 19.2d0, 30.1d0/
!      data a_planetas / 0.39d0, 0.72d0, 1.00d0, 1.52d0,
!     &5.20d0, 6.58d0, 8.2d0, 9.0d0/

      pi = 4.d0*datan2(1.d0,1.d0)

      open(file='tarefa-1c-saida-dec.dat', unit=1)
      open(file='tarefa-1c-saida-dverlet.dat', unit=2)
      open(file='dtaumax.dat', unit=3)

      ! iterar nos planetas
      !do ip=5,60
      do ip=3,4
         !a = dble(ip)*0.1d0*a_planetas(3)
         write(*,*)"Planeta",ip,"a",a
         a = a_planetas(ip)

         p_ec(1,1) = a
         p_ec(1,2) = 0d0
         v_ec(1,1) = 0d0
         v_ec(1,2) = 1d0/dsqrt(a)

         p_verlet(1,1) = a
         p_verlet(1,2) = 0d0

         iquanto=20

         iter_dtau = int(3.5*iquanto)

         !tau_total = 50d0
         tau_total = 20d0*a

         do j=1,iter_dtau
            potencia = dble(2*iquanto +j)/dble(iquanto)
            dtau = 10**(-potencia)
            iteracoes = int(tau_total/dtau)

            write(*,*)"dtau",dtau,j
            pmax_ec = 0d0
            pmin_ec = 10000000d0
            pmax_v = 0d0
            pmin_v = 10000000d0

            do i=2,iteracoes
               p3 = pcubo(p_ec(i-1,1), p_ec(i-1,2))

               v_ec(i,1) = v_ec(i-1,1) - (p_ec(i-1,1)/p3)*dtau
               v_ec(i,2) = v_ec(i-1,2) - (p_ec(i-1,2)/p3)*dtau

               p_ec(i,1) = p_ec(i-1,1) + v_ec(i,1)*dtau
               p_ec(i,2) = p_ec(i-1,2) + v_ec(i,2)*dtau

               !verlet
               if (i.eq.2) then
                  ! pular verlet, usar os valores de euler-cromer
                  p_verlet(i,1) = p_ec(i,1)
                  p_verlet(i,2) = p_ec(i,2)
               else
                  p3 = pcubo(p_verlet(i-1,1),p_verlet(i-1,2))

               p_verlet(i,1) = 2d0*p_verlet(i-1,1) - p_verlet(i-2,1)
     &          - (p_verlet(i-1,1)/p3)*(dtau**2)
               p_verlet(i,2) = 2d0*p_verlet(i-1,2) - p_verlet(i-2,2)
     &          - (p_verlet(i-1,2)/p3)*(dtau**2)
               endif

               ! calcular p
            p_modulo_ec = dsqrt(p_ec(i,1)**2d0 + p_ec(i,2)**2d0)
            p_modulo_v = dsqrt(p_verlet(i,1)**2d0 + p_verlet(i,2)**2d0)

               if (p_modulo_ec.gt.pmax_ec) then
                  pmax_ec = p_modulo_ec
               else if (p_modulo_ec.lt.pmin_ec) then
                  pmin_ec = p_modulo_ec
               end if
               if (p_modulo_v.gt.pmax_v) then
                  pmax_v = p_modulo_v
               else if (p_modulo_v.lt.pmin_v) then
                  pmin_v = p_modulo_v

               endif


            end do

            !write(*,*)"Pmax e min:", pmax_ec,pmin_ec,pmax_v,pmin_v

            d_ec = pmax_ec/pmin_ec - 1
            d_v = pmax_v/pmin_v - 1


            ! escrever no grafico valores p/ terra

            if (ip.eq.3)then
               write(1,*)potencia,d_ec
               write(2,*)potencia,d_v
            endif

            d_planetas(ip,j,1) = dtau
            d_planetas(ip,j,2) = d_ec

            write(*,*)"d ec:",d_ec,"d verlet:",d_v

            !if(d_ec.lt.1d-3)then
            !   goto 20
            !endif

         end do
20         continue
      end do

      ! agora processar os dados de d_planetas para fazer o gráfico de dtau_min x a
      write(*,*)"processando"
      !do ip=5,60
      !   write(*,*)"planeta",ip
      !   do j=1,iter_dtau
      !      if(d_planetas(ip,j,2).le.1d-3)then
      !         write(*,*)"saimos"
      !         goto 10
      !      endif
      !   end do
!10    !   write(3,*)dble(ip)*0.1d0*a_planetas(3),d_planetas(ip,j,1),j

      !end do

      end

      function pcubo(px,py)
         real*8 px, py, pcubo
         pcubo = (px**2d0 + py**2d0)**(3d0/2d0)
      end function

      !constante de prop = 0.00099 ~ 0.001

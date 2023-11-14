      implicit real*8 (a-h, o-z)

      pi = 4.d0*datan2(1.d0,1.d0)

      w0 = 0d0
      teta0 = pi*30d0/180d0
      teta0original = teta0
      total_tau = 40
      dtau = 1d-3
      iteracoes = int(total_tau/dtau)

      gamma = 0.5d0

      tetanovo = 0d0
      wnovo = 0d0

      open(file='tarefa-3-saida.dat', unit=1)

      do i=1,iteracoes
         tempo = dble(i)*dtau
         write(1,*) tempo, teta0

         wnovo = w0 - (dsin(teta0) + gamma*w0)*dtau
         tetanovo = teta0 + wnovo*dtau

         w0 = wnovo
         teta0 = tetanovo
      end do

      end

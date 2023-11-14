      implicit real*8 (a-h, o-z)

      pi = 4.d0*datan2(1.d0,1.d0)

      w0 = 0d0
      teta0 = pi*10d0/180d0 ! teta0 = 10 graus
      teta0original = teta0
      total_tau = 100
      dtau = 2d-2
      iteracoes = int(total_tau/dtau)

      tetanovo = 0d0
      wnovo = 0d0

      e_mec_anal = 1d0 - dcos(teta0) + 0.5d0*(w0**2d0)

      open(file='tarefa-1-saida.dat', unit=1)
      open(file='saida-analitica.dat', unit=2)
      open(file='energia-harm.dat', unit=3)
      open(file='energia-anal.dat', unit=4)

      do i=1,iteracoes
         tempo = dble(i)*dtau
         write(1,*) tempo, teta0

         wnovo = w0 - teta0*dtau
         tetanovo = teta0 + wnovo*dtau

         ! calcular analitico
         teta_anal = teta0original*dcos(tempo)
         write(2,*) tempo, teta_anal

         ! calcular energia
         e_mec = 1d0 - dcos(teta0) + 0.5d0*(w0**2d0)

         write(3,*) tempo, e_mec
         write(4,*) tempo, e_mec_anal

         w0 = wnovo
         teta0 = tetanovo
      end do


      end

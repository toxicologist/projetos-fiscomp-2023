      implicit real*8 (a-h, o-z)

      pi = 4.d0*datan2(1.d0,1.d0)

      w0 = 0d0
      teta0 = 0d0!pi*30d0/180d0
      teta0original = teta0
      total_tau = 10d0*2d0*pi
      dtau = 1d-3
      iteracoes = int(total_tau/dtau)

      gamma = 0.5d0
      ani = (2d0)/(3d0)

      tetanovo = 0d0
      wnovo = 0d0

      open(file='tarefa-4d-saide.dat', unit=1)
      write(*,*)"Insira alpha"
      read(*,*)alpha

      write(*,*)"Insira t_trans"
      read(*,*)t_trans

      write(*,*)"Insira teta0"
      read(*,*)teta0new
      write(*,*)"Insira w0"
      read(*,*)w0new

      do i=1,iteracoes
         tempo = dble(i)*dtau

         write(1,*) tempo, teta0
         write(2,*) tempo, w0

         ! calcular energia
         e_mec = 1d0 - dcos(teta0) + 0.5d0*(w0**2d0)

         write(3,*) tempo, e_mec

         !write(*,*)alpha*dsin(ani*tempo), alpha, ani, tempo

         wnovo = w0 -
     &   (dsin(teta0) + gamma*w0 - alpha*dsin(ani*tempo))*dtau

         tetanovo = teta0 + wnovo*dtau

         w0 = wnovo
         teta0 = tetanovo

         teta0 = teta0 - dble(int(teta0/pi))*2d0*pi
      end do

      end

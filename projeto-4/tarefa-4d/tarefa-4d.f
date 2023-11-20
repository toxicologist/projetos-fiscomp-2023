      implicit real*8 (a-h, o-z)

      pi = 4.d0*datan2(1.d0,1.d0)

      w0 = 0d0
      teta0 = 0d0!pi*30d0/180d0
      teta0original = teta0
      total_tau = 5d0*2d0*pi

      write(*,*)"insira o total tau"
      read(*,*)total_tau

      dtau = 1d-3
      iteracoes = int(total_tau/dtau)

      gamma = 0.5d0
      ani = (2d0)/(3d0)

      tetanovo = 0d0
      wnovo = 0d0
      tetanewnovo = 0d0
      wnewnovo = 0d0

      open(file='tarefa-4d-teta.dat', unit=1)
      open(file='tarefa-4d-w.dat', unit=2)

      write(*,*)"Insira alpha"
      read(*,*)alpha

      write(*,*)"Insira t_trans"
      read(*,*)t_trans

      !write(*,*)"Insira teta0new"
      !read(*,*)teta0new
      write(*,*)"Insira w0new"
      read(*,*)w0new

      teta0new=0d0

      dteta = 0d0
      dw = 0d0

      do i=1,iteracoes
         tempo = dble(i)*dtau

         dteta = abs(teta0 - teta0new)
         dw = abs(w0 - w0new)


         if (tempo.gt.t_trans) then
            write(1,*) tempo, dteta
            write(2,*) tempo, dw
        endif

         wnovo = w0 -
     &   (dsin(teta0) + gamma*w0 - alpha*dsin(ani*tempo))*dtau

         wnewnovo = w0new -
     &   (dsin(teta0new) + gamma*w0new - alpha*dsin(ani*tempo))*dtau

         tetanovo = teta0 + wnovo*dtau
         tetanewnovo = teta0new + wnewnovo*dtau

         w0 = wnovo
         teta0 = tetanovo

         w0new = wnewnovo
         teta0new = tetanewnovo

         !teta0 = teta0 - dble(int(teta0/pi))*2d0*pi
         !teta0new = teta0new - dble(int(teta0new/pi))*2d0*pi
      end do

      end

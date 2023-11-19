      implicit real*8 (a-h, o-z)
      implicit integer*16 (i-n)

      pi = 4.d0*datan2(1.d0,1.d0)

      w0 = 0d0
      teta0 = 0d0
      teta0original = teta0
      total_tau = 1000d0*2d0*pi
      !total_tau = 1d4*2d0*pi
      dtau = 1d-3
      iteracoes = dint(total_tau/dtau)
      gamma = 0.15d0
      ani = (2d0)/(3d0)

      tetanovo = 0d0
      wnovo = 0d0

      open(file='tarefa-4b-saida.dat', unit=1)

      write(*,*)"Insira alpha"
      read(*,*)alpha

      write(*,*)"Insira t_trans"
      read(*,*)t_trans

      write(*,*)"Insira teta0"
      read(*,*)teta0
      write(*,*)"Insira w0"
      read(*,*)w0

      text = 2d0*pi/ani

      do i=1,iteracoes
         tempo = dble(i)*dtau

         !write(1,*)tempo, text, mod(tempo,text)

         if ((( mod(tempo,text)).lt.1d-3).and.(tempo.gt.t_trans))then
            write(1,*) teta0, w0
         endif

         wnovo = w0 -
     &   (dsin(teta0) + gamma*w0 - alpha*dsin(ani*tempo))*dtau

         tetanovo = teta0 + wnovo*dtau

         w0 = wnovo
         teta0 = tetanovo

         teta0 = teta0 - dble(int(teta0/pi))*2d0*pi
      end do

      end

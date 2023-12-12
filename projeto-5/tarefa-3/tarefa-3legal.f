      implicit real*8 (a-h, o-z)
      real*8 p_t(100000000, 2)
      real*8 p_j(100000000, 2)
      real*8 at(2),aj(2)

      open(file='terra.dat',unit=1)
      open(file='jupiter.dat', unit=2)

      pi = 4.d0*datan2(1.d0,1.d0)

      tau_total = 2d0*pi*30d0 ! 30 anos
      dtau = 1d-3

      p_t(1,1) = 1d0
      p_t(1,2) = 0d0
      p_j(1,1) = 5.2d0
      p_j(1,2) = 0d0

      v_tx = 0d0
      v_ty = 1d0
      v_jx = 0d0
      v_jy = 1d0/dsqrt(5.2d0)

      iteracoes = tau_total/dtau

      iunidade = 10000

      ! fazer iterações ser divisível por iunidade (p ficar bonitinha a divisao no progresso)
      if (mod(iteracoes,iunidade).ne.0) then
         iteracoes = (iteracoes/iunidade + 1)*iunidade
      endif

      do i=2,iteracoes
         if (mod(i,iunidade).eq.0) then
            write(*,*)'progresso:',int((dble(i)/dble(iteracoes))*100)
         endif

         ! equações de movimento p/ terra e júpiter
         call acel_t(p_t(i-1,1),p_t(i-1,2),p_j(i-1,1),p_j(i-1,2), at)
         call acel_j(p_j(i-1,1),p_j(i-1,2),p_t(i-1,1),p_t(i-1,2), aj)

         if (i.eq.2) then
            ! usar euler-cromer

            ! terra
            v_tx = v_tx - at(1)*dtau
            v_ty = v_ty - at(2)*dtau
            p_t(i,1) = p_t(i-1,1) + v_tx*dtau
            p_t(i,2) = p_t(i-1,2) + v_ty*dtau

            ! jupiter
            v_jx = v_jx - aj(1)*dtau
            v_jy = v_jy - aj(2)*dtau
            p_j(i,1) = p_j(i-1,1) + v_jx*dtau
            p_j(i,2) = p_j(i-1,2) + v_jy*dtau

         else
            ! terra
            p_t(i,1) = 2d0*p_t(i-1,1) - p_t(i-2,1) +
     &      at(1)*(dtau**2d0)
            p_t(i,2) = 2d0*p_t(i-1,2) - p_t(i-2,2) +
     &      at(2)*(dtau**2d0)

            !jupiter
            p_j(i,1) = 2d0*p_j(i-1,1) - p_j(i-2,1) +
     &      aj(1)*(dtau**2d0)
            p_j(i,2) = 2d0*p_j(i-1,2) - p_j(i-2,2) +
     &      aj(2)*(dtau**2d0)
            endif

         write(1,*)p_t(i,1),p_t(i,2)!, at
         write(2,*)p_j(i,1),p_j(i,2)

      end do

      end

      subroutine acel_t(px,py,pjx,pjy,at)
         ! modifica a aceleração da terra dados p_t e p_j
         real*8 px,py,pjx,pjy,atsx,atsy,mu_j,mu_t,atjx,atjy,p3
         real*8 at(2)

         mu_t = 1d0/(3.33d5)
         mu_j = 31800d0/(3.33d5)

         p3 = (px**2d0 + py**2d0)**1.5d0
         p3j = ( (px-pjx)**2d0 + (py-pjy)**2d0 )**1.5d0

         atsx = -px/p3
         atsy = -py/p3

         atjx = -(px-pjx)/p3j
         atjy = -(py-pjy)/p3j

         at(1) = atsx + mu_j*atjx
         at(2) = atsy + mu_j*atjy

      end subroutine

      subroutine acel_j(px,py,ptx,pty,aj)
         ! modifica a aceleração de jupiter dados p_t e p_j
         real*8 px,py,ptx,pty,ajsx,ajsy,mu_j,mu_t,ajtx,ajty,p3
         real*8 aj(2)

         mu_t = 1d0/(3.33d5)
         mu_j = 31800d0/(3.33d5)

         p3 = (px**2d0 + py**2d0)**1.5d0
         p3t = ( (px-ptx)**2d0 + (py-pty)**2d0 )**1.5d0

         ajsx = -px/p3
         ajsy = -py/p3

         ajtx = -(px-ptx)/p3t
         ajty = -(py-pty)/p3t

         aj(1) = ajsx + mu_j*ajtx
         aj(2) = ajsy + mu_j*ajty

      end subroutine






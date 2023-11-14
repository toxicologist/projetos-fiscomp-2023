      implicit real*8 (a-h, o-z)

      pi = 4.d0*datan2(1.d0,1.d0)

      w0 = 0d0

      write(*,*)"Insira o angulo maximo inicial"
      read(*,*)iangulomax

      open(file='tarefa-2-saida.dat', unit=1)
      open(file='periodos-analitico.dat', unit=2)

      iangulomin = -iangulomax

      total_tau = 100
      dtau = 1d-6
      iteracoes = int(total_tau/dtau)

      tetanovo = 0d0
      wnovo = 0d0

      do iang=iangulomin,iangulomax
         teta0 = pi*dble(iang)/180d0
         teta0original = teta0

         ! Para calcular o período analítico, vamos alterando h conforme chegamos próximo de 0
         ! (isso faz com que tenhamos melhor precisão nos resultados, pois precisamos de subdivisões menores)
         ! E para teta = 0, não teríamos integral nem oscilação, e portanto fazemos simplesmente 2pi, para ter continuidade no gráfico.
         if (abs(iang).lt.10) then
            h = 1d-9
         else if (abs(iang).lt.20) then
            h = 1d-8
         else
            h = 1d-7
         endif
         if (teta0original.eq.0d0) then
            t_anal = 2d0*pi
         else
            t_anal = periodo_anal(teta0original, h)
         endif

         ! Para checar o periodo, vamos calcular quanto tempo passa entre duas mudanças de sinal,
         ! e multiplicar isso por 2

         t_periodo_inicio = 0d0
         t_periodo_fim = 0d0

         do i=1,iteracoes
            tempo = dble(i)*dtau

            wnovo = w0 - dsin(teta0)*dtau
            tetanovo = teta0 + wnovo*dtau

            if ((wnovo*w0).lt.0d0) then
               if (t_periodo_inicio.eq.0d0)then
                  t_periodo_inicio = tempo
               else if (t_periodo_fim.eq.0d0)then
                  t_periodo_fim = tempo
               end if
            end if

            if ((t_periodo_fim*t_periodo_inicio).ne.0d0) then
               goto 10
            end if

            w0 = wnovo
            teta0 = tetanovo
         end do
10       t_periodo = 2d0*(t_periodo_fim - t_periodo_inicio)
         write(*,*)"Angulo:",iang,"graus. Periodo calculado:",t_periodo,
     &   "Periodo analitico:", t_anal!, "h=",h
         write(1,*)iang,t_periodo
         if (t_anal.gt.0d0) then
            write(2,*)iang,t_anal
         endif
      end do

      end

      function periodo_anal(teta, h)
         implicit real*8 (a-h, o-z)
         real*8 teta, periodo_anal, h, soma, x, simpson, a, b
         ! vamos utilizar a regra de Simpson mas pular a primeira e a última iteração
         ! pois lá teríamos divisão por 0

         teta = dabs(teta)

         a = 0d0
         b = teta

         nparticoes = dint((b-a)/h)

         soma = 0d0

         do i=1,nparticoes-1,2
            x = a + dble(i)*h
            soma = soma + 4.d0/dsqrt(dcos(x)-dcos(teta))
         end do

         do i=2,nparticoes-1,2
            x = a + dble(i)*h
            soma = soma + 2.d0/dsqrt(dcos(x)-dcos(teta))
         end do

         simpson = (h/3.d0) * soma
         simpson = 2d0*dsqrt(2d0)*simpson

         periodo_anal = simpson

      end function

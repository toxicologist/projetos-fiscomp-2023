************** Exemplos de xprogramas que mostrarão o uso dos comandos 
************** do FORTRAN 77 ****************
*     Variáveis e constantes:
*     As variáveis são separadas de acordo com o tamanho de memória que 
*	ocumpam para seu armazenamento.
         Variáveis ---> as que podem assumir distintos valores no decorrer 
                        do programa
	 Constantes ---> são fixas no  decorrer do programa
*	 Tipos de variáveis:
	 inteira (são os inteiros - não tem a parte ponto flutuante) Ex. 
	     i1 = 2, i3 = 33445
	 reais (são os números reais geral) ai1 = 2.33454, avo=6.02e23 
	 complexas (pares de números reais) Ex. a1=(2.34,0.34),api=(0.e0,3.1416e0)
	 characters (sao aquelas que asumem valores que são caracteres)
	 
         lógicas (que podem ser .true. ou .false.) Ex. al1=.true., al2 =.false.
!
	 As variáveis são também distinguidas pelo espaço requerido ao seu 
	armazenamento. A unidade que medimos  é o byte, que  é o agregado de 
	8 bits, i.  e., 1 byte= 8 bits. 
          Os tamanhos das variáveis inteiras  são:
	            byte --> 1 byte
	            integer*4 -->inteira de 4 bytes
	            integer*8 --> inteira de 8 bytes 
                    Pode m assumir os seguintes valores:
                    INTEGER*1 –128 a 127, ou BYTE 
                    INTEGER*2 –32,768 a 32,767
                    INTEGER*4 –2,147,483,648 a 2,147,483,647 (padrão)
	
	            O Defaut da máquina e integer*4, assim se colocar
 
	            integer ia1   (a variável ia1 será integer*4)
          Os tamanhos das variáveis reais  são:

	            Precisão simples, 6 casas decimais (padrão):
                    REAL*4  (padrão), ou simplesmente REAL 
                    Precisão dupla, 15 casas decimais (padrão):
                    REAL*8 ou DOUBLE PRECISION
		    Complexo de simples precisão
	            COMPLEX*8  (padrão), ou simplesmente COMPLEX
	            COMPLEX*16 (parte real e imaginária em dupla precisão) 
	  Os tamanhos das variáveis holeriths ou caracteres são:
	            character*n  (n=1,2,3,....), são o número letras que 
			   compõe a variável
><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
!  A primeria etapa na confecçao do programa é a  declaração das variáveis
***************************************************
! ATENÇÃO - ATENÇÃO  -ATENÇÃO 
*
*     No decorrer deste curso exigiremos a NÃO VIOLAÇÃO da sintaxe do 
*     FORTRAN, que é a seguinte:
*
*     
*     variáveis inteiras são as que se iniciam como: a,b,c,d,f,g,h; o,p,q,
*     r,s,t,u,v,x,z, e as inteiras as que iniciam como i,j,k,l,m,n
*     isto e reais (a-h,o-z) e inteiras (i-n)
*	      Consideraremos os exemplos abaixo para declaração de variáveis
****************************************************************************
	Exemplo 1
<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
C     programa.f
      real*8 a3,a1  !variáveis de preciso dupla
      integer*8 ia1 !inteiros de precisão dupla
C     final da declaração de variáveis
      a1 = 1.2d-35
      a3 = a1*a1
      a4 = a3
      write(*,*)'a3 =',a3 !escreve o resultado de a3
      write(*,*)'a4 =',a4 !escreve o resultado de a4
      end  !sempre o programa em que terminar com end (fim dos comandos)
<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
     Se voce compilar o programa acima, que se compila da seguinte forma
     
        gfortran programa1.f -o program1.exe
     
      (será gerado o executável programa1.exe 
	
     Se você rodar o programa da seguinte forma
         
          ./programa1.exe

     O resultado será
	
      a3 =   1.4400000000000001E-070
      a4 =   0.00000000  

     Enquanto a3 da o resultado esperado, a4 não dá o resultado esperado.
	
     A razão se deve ao fato de a4 ser uma variável real (comeca com a), 
     e como não foi declarada como dupla precisão segue o default sendo 
     de simples precisão. A operação a4=a3 não dará a precisão pois a4 não tem os 
     bytes necessários para dar o valor correto
     
     Repare que todo programa tem que terminar com o comando --> end
	
	Exemplo 2
<><><><><><><><><><><><><><><><><><><><><><><><><><><><>
C     programa2.f
      implicit real*8 (a-h,o-z)
      complex z1,z3  !variável complexa de simples precisão
      complex*16 z2  !variável complexa de dupla precisão
      character*6 h1,h3 !variável hollerith (caractere de 6 letras)
      character*9 h2
C     final da declaração de variáveis
      z1 =(1.e0,0.5e0)
      z2 =(1.d0,0.3d0)
      h1='aleluiaaaa'
      h2='aleluiaaaa'
      h3='tomara'
      z3 = z1*z2
      write(*,*) 'z1*z2=',z1*z2
      write(*,*) 'h1 -->',h1,' h2-->',h2,' h3 -->',h3
      end
<><><><><><><><><><><><><><><><><><><><><><><><><><><><>
      No programa acima, na primeira linha declaramos que todas 
      as variáveis que comecam de (a-h) ou (o-z) são reais de dupla
      precisão, e a variável z1 é complexa de simples precisão e as 
      variáveis h1 e h2 são holerith de 6 characteres
      
      Se você compila-lo:

	gfortran program2.f -o nomequequizer.exe
     
         e executá-lo

        ./nomequequizer.exe

      você terá a resposta

 z1*z2=z3 = ( 0.850000024    , 0.800000012    )
 h1 -->alelui h2-->tomara

	            
	Note que a variável h1, só apareceu --> alelui, porque ela foi
declarada como tamanho 6. O programa só pega os primeiros 5 caracteres 


Declaração de vetores e matrizes

Neste caso queremos que: SEMPRE SEJAM SEGUIDOS A SINTAXE DO FORTRAN:

  Vetores e matrizes reais tem que comecar com (a-h,o-z) e inteiros (i-n).

Como vetores e matrizes possuem as mais diversas dimensões. é  interessante 
introduzir o comando: PARAMETER Com este commando introduzimos 
constantes que nos auxiliarão a declaração das dimensões. Vejamos o exemplo:

Exemplo 3
<><><><><><><><><><><><><><><><><><><><><><><><><><><><>
      parameter(idim1=10,idim2=100) !idim1 e idim2 serão constantes no programa
      dimension a1(idim1),a2(-idim1:0,2:50),a3(idim1,idim1+idim2,3) 
      dimension ia1(-8:8),ia2(idim1*idim2,idim1)
      real*8 av1(-idim1:idim1)
      double precision av11(idim1,-2:idim2)
      complex z1(idim2,idim2,idim1)
      complex*16 z11(idim2,idim2,idim1)
      character*10 h(idim1)
C
C	a1 -->real 4 (default)  vetor com componentes 1,2,...,idim1 
C	a2 -->real 4 (default)  matriz de duas componentes primeira -idim1,....,0 e segunda componente 2,3,...50
C	a3 --> real 4 (default) matriz de três componentes ,.....
C	av1 --> real 8  matriz de precisão dupla com uma componente que vai
C	de -idim1 ate idim1
C       av11 --> real 8 matriz de três  componentes, ....
C       z1 --> complex 8 (default) matriz de três componentes
C       z11 --> complex 16  matriz de três componentes de precisão dupla
C	h ---> vetor de uma coluna com 10 caracteres em cada componente
      write(*,*) ' Nao vai fazer nada!'
       end 
<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
	Operações algébricas:  São as usuais +,-,*(multiplicação) e 
        **(exponenciacao)
	Exemplos:

<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
       programa4.f
        a=3.67
        ia = 4.67
        ia1 = a  ! ia1 ficará com o valor 4
        ia2 = ia1/4  ! o resultado será a parte inteira  porque ia é inteira
        a = 3/4   ! o resultado será zero porque foi a divisão entre  
C                 !dois inteiros que dá um inteiro
        a1 =4.*(3/4) ! o resultado será zero porque a operação 
C                    !3/4 tem parte inteira  nula
        write(*,*) 'ia1=',ia1
        write(*,*) 'ia2=',ia2
        write(*,*) 'a=',a
        write(*,*) 'a1=',a1
        end
<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
	so compilar e rodar este programa você obterá 
ia1=           3
 ia2=           0
 a=   0.00000000    
 a1=   0.00000000 
      Conforme comentado no programa

 Operações ja construídas no FORTRAN:

   Existem  as funções jáa embutidas na compilação de seu programa,
como: sin(x), cos(x), log(x) --> logarítmo na base Neperiana, bem como 
as funções inversas trigonométricas asin(x), atan(x), acos(x),etc... 
as funções exponenciais exp(x) e as funções hiperbólicas cosh(x),sinh(x),
tanh(x), etc, sqrt(x), no cartão de referência do curso existe mais algumas, 
mas uma busca simples na internet te daráa lista completa das mesmas.


Operadores e operações lógicas:
     
     Os operadores lógicos usuais são .eq. (igual), .lt. (menor que),
.le. (menor ou igual), .gt. (maior que), .ge. (maior ou igual), .or. (ou) 
.and. (e) .ne. (diferente) . Estas operações quando realizadas do 
resultado T (verdadeiro) ou F (falso)

Exemplo:
<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
        logical alo1
        a1 = 2
        a2 = 3
        alo1 = a1.gt.a2
        write(*,*) 'a1.lt.a2 ',a1.lt.a2,'alo1=',alo1
        
        end
	
Compilando e rodando o programa você obterá

 a1.lt.a2 ---> T alo1= F

<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

  Comandos de leitura e escrita 

  Os comados mais usuais são o read() e write().
  
   Exemplos:
	read(1,*) a1,a2,a3  !você estará lendo na unidade 1 as variáveis a1,a2,a3
	read(3,*) a1,(a(j),j=1,10),aa1

	read(*,*) a1,aa1,ia1   !você estará lendo na tela as três variáveis 
(o programa ficara esperando voce dar as variáveis). Assim  recomendamos 
fazer:
	write(*,*) 'De os valores de a1,aa1,ia1:'
	read(*,*) a1,aa1,ia1
	write(4,*) ' saiu os dados -->',a1,aa1,ia1  !escreve na unidade 4 
os dados a1,aa1,ia1.

Atencao: Por razões históricas: write(6,*)  e o mesmo que write(*,*)
	 a unidade 5 tambẽm não pode  ser usada 
Exemplo:
<>>><><><><><><><><><><><><><><><><><>
        dimension a(20)
        read(3,*) a1,(a(j),j=1,5),aa1 !dados no arquivo fort.1 (um dado por linha)
        write(*,*) 'a1 =',a1  ! escreve na tela
        write(*,*) 'vetor lido --->',(a(k),k=1,5)  !escreve na tela em uma linha
        end
<>>><><><><><><><><><><><><><><><><><>

       O dado de entrada está na unidade 3, e como não foi especificado o 
nome do arquivo o mesmo será fort.3. O dado de entrada em fort.3 será do tipo
1.11
3.4 
4.5 
4.6 
4.7 
4.8 
455.3

A saida do programa apos sua execução será:

 a1 =   1.11000001    
 vetor lido --->   3.40000010       4.50000000       4.59999990       4.69999981       4.80000019   

Repare que depois de 6 dígitos tem uma sobras, que estão além da precisão das 
sua variáveis que são de dupla precisão

<><><><><><><><><> ATENCAO: PONTO IMPORTANTE  <><><><><><><>
  Sempre que definir uma variável real definila com a terminação de acordo 
  com a precisão

  Ex. Ao invés de: a =0 escreva : a= 0.e0 (se simples precisão) ou a=0.d0
     se a precisao for dupla
      a3 = 3.4d0 ao invés de a=3.4, etc...

<>>><><><><><><><><><><><><><><><><><>

	Se quizermos dar o nome de um arquivo na unidade de leitura fazemos 
como no exemplo abaixo
<>>><><><><><><><><><><><><><><><><><>
C	Programaex5.f
	dimension a(20)
	open(unit=3,file='dado-entrada') ! o arquivo de entrada --> dado-entrad
	dimension a(20)
	open(unit=3,file='dado-entrada') ! o arquivo de entrada --> dado-entrad
C		                    tudo que fizer na unidade 3 será no arquivo C	                            dado-entrada
	open(unit=12,file='saida-minha')  ! o arquivo de saída --> saida-minha
C	                            tudo que fixe na unidade 12 será no arquivo
C			            saida-minha
	read(3,*) a1,(a(j),j=1,5),aa1 !dados no arquivo fort.1 (um dado por linha)
	write(*,*) 'a1 =',a1  ! escreve na tela
	write(*,*) 'vetor lido --->',(a(k),k=1,5)  !escreve na tela em uma linha
	close(3)  !fechou a unidade 3
	close(12)  !fechou a unidade 12
	open(unit=3,file='novos-dados' ) ! abriu a unidade 3 como novos-dados
	write(3,*) ' caramba mudei de ideia'  ! vai sair no arquivo: novos-dados
	close(3) ! fechou a unidade 
	end
<>>><><><><><><><><><><><><><><><><><>
	Se quizermos ter uma formatação dos seus resultados, os formatos mais 
populares são: 
         variáveis inteiras --> iw (w --> número de espaços)
	 variáveis reais --> fw.d  (w --> número de espacos, sendo que 
         serão gastos  para a parte fracionária)
	 variáveis characteres --> aw (w-->número de espaços)
         Os formatos de saida são dados no comando FORMAT que está na linha 
           cujo apelido foi informado no comando WRITE correspondente
         Alguns comandos interessantes que podem ser colocados no FORMAT
             'oque quiser' !coloca exatamente o que esta entre ''
	     1x, 2x ,... --> pula 1,2,... espacos
              / --> vai para outra linha
	  Vejamos um exemplo
<><><><><><><><><><><><><><><><><><><><><><><><><><><><>
C       Programaex9.f
        dimension a(4)
        character*7 h1,h2
        a(1) = acos(-1.e0)
        a(2) = exp(1.0)
        a(3) =1244.022444
        a(4) =cos(a(3)*a(1))
        h1 ='Aleluia'
        h2 ='irmao'
        write(3,4) (a(i),i=1,3),h1,h2,a(4) ! a linha 4 tem o formato
4     format('dados de a:',3(f10.5,'|'),a8,' para quem',a7,'||',/,'
     &so para testar na outra linha',4x,' pulou quatro espacos')
        end
_____________________ A saida do programa sera __________________
dados de a:   3.14159|   2.71828|1244.02246| Aleluia para quemirmao  ||
     so para testar na outra linha     pulou quatro espacos
   0.99751|
________________________________________________________________________
<><><><><><><><><><><><><><><><><><><><><><><><><><><><>

   Comandos de repetição (é o comando DO) Temos os seguintes tipos no  exemplo 
abaixo

<><><><><><><><><><><><><><><><><><><><><><><><><><><><>
C    o do mais simples
	do 100 i1 =1,4 ! faz a repetição dos comandos ate a linha com o 
C	               ! apelido 100, e  i1 varia de 1 a 4 de um em um 
100	   a = a+ i1
C ou equivalentemente usando o comando: continue ( que só fala paqra continuar)
	do 100 i1 =1,4 ! faz a repetição dos comandos ate a linha com o 
C	               ! apelido 100, e  i1 varia de 1 a 4 de um em um 
	   a = a+ i1
100     continue  
	
	Outro exemplo
	
	do 10 i2 =-2,6,3  !faz i2 variar de -2 a 6 de 3 em 3 ate a linha com 10
	   do 11 i3=-4,2  !faz i3 variar de -4 a 2 de um em um ate linha 11
	     a1 = a1 + 1.e0
11         continue
	   a1 = a1+10.e0
10      continue
	 
	Outros exemplos sem mencionar a linha de termino das ações

	do  i1 =1,4 ! faz a repetição dos comandos ate a end do do seu laco
C	               ! apelido 100, e  i1 varia de 1 a 4 de um em um 
	   a = a+ i1
	end do
C
	Outro exemplo
	
	do  i2 =-2,6,3  !faz i2 variar de -2 a 6 de 3 em 3 ate o end do externo
	   do  i3=-4,2  !faz i3 variar de -4 a 2 de um em um ate o end do intermo
	     a1 = a1 + 1.e0
           end do
	   a1 = a1+10.e0
	end do
	O uso do: do while  
	Exemplo
	  a = -1.e0
	  do while(a.lt.0) !repete as operações até seu END DO,  enquanto a for negativo
	     a = a + 0.5e0
	     b = b+ sin(b)
	  enddo
<><><><><><><><><><><><><><><><><><><><><><><><><><><><>
	Os comandos condicionais: O If (o comando que faz o computador 
ser altamente eficiente para cálculos).  Vejamos os exemplos

C   o if simples
	if(a.lt.0) b = b +a   !executa a ação b = b+a se a condição a<o for satisfeita
C o if com mais comandos
	if(a.lt.0) then !faz as opera coes caso a condição a<0 for satisfeita,
C			! as operaçôes vão ate o ENDIF
		a = a + 1.e0
	        b = 1*sin(b)
	endif
C o if com mais condições
	if(a.lt.0) then !faz as operações caso a condição a<0 for satisfeita,
C			! as operações vão ate o endif
		a = a + 1.e0
	else ! se a condição não for satisfeita faca os comandos ate o endif
	        b = 1*sin(b)
	endif
C 
C	o comando: GOTO
C
C	Veja o exemplo
	if(a.lt.0 ) goto 11  ! se a condição for satisfeita vai para a linha 
<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>>
C  programaex1.f
      parameter (idimax=100, nmax=2, api = acos(-1.e0))
      real*8 dpi,ad1(2*idimax)
C     final das declarações de variáveis
C
C     Comando de leituras de dados
C
      open(unit=1,file='dado.in')  ! nome ao arquivo com dado de entrada
      open(unit=2,file='dado.out') ! nome ao arquivo com dado de saída
C
C       comandos de opera coes
C
      asum = 0.e0
      aleluia = 1.e0
      dpi = acos(-1.d0)  ! aqui teremos o valor de pi em dupla  precisão
      do j1 =1,2*idimax
          ad1(j1) = 0.d0 !colocamos d0 por ser dupla precisão
      end do
      a = -1000.e0
C       outro exemplo
      do i=1,100
          a = a +1.e0
          if(a.lt.O) goto 4
      end do
4      continue
C repare que o exemplo acima é análogo ao
C
        a = -1000.e0
        do while(a.lt.0)
          a = a+1.e0
        end do
        end
<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>>
	vamos dar um exemplo de um programa com os vários 
	comandos acima mencionados
<><><><><><><><><><><><><><><><><><><><><><><><><><><><>
C  programaex6.f
        parameter (idimax=100, nmax=2, api = acos(-1.e0))
        dimension i1(idimax),ai2(nmax,idimax)
        real*8 dpi,ad1(2*idimax)
C     final das declarações de variáveis
C     
C     Comando de leituras de dados
C       
      open(unit=1,file='dado.in')  ! nome ao arquivo com dado de entrada
      open(unit=2,file='dado.out') ! nome ao arquivo com dado de saída
C
C       comandos de operações
C
      asum = 0.e0
      aleluia = 1.e0
      dpi = acos(-1.d0)  ! aqui teremos o valor de pi em dupla  precisão
      do j1 =1,2*idimax
          ad1(j1) = 0.d0 !colocamos d0 por ser dupla precisão
      end do
      aai = 0.e0
      do ik1 =-2,5
          read(1,*) ad1(ik1)  ! dará erro se não tiver 45 dados no 
C                            ! arquivo dado.in
          aad = aad + ad1(ik1)
          do j1 =-2,56
            if (aad.gt.15) goto 10
          end do
10        continue
14        continue
          do kk =1,10
            if(aleluia.gt.0) then
               aleluia = -aleluia
               goto 14  !repare que você pode sair do laço do DO 
            else
               aleluia = 2.e0*aleluia
            endif
          end do
          aai =aai + ik1
      end do
      rewind(1)   ! este comando faz o ponteiro de leitura ou escrita da 
C                 ! unidade (1 no caso) voltar ao início
C
C
      do i2=1,50
         read(1,*,end=24) ad1(i2) !aqui se os dados acabarem ele vai 
C                                 para   a linha 24 não dando erro
      end do
24    continue

C
C       vai escrever os resultados
      write(2,*) (ad1(io),io=1,10)  ! escreve os dados
C
C       fechar os arquivos abertos
C
      close(1)
      close(2)
      end
<><><><><><><><><><><><><><><><><><><><><><><><><><><><>
C  programaex7.f
        parameter (idimax=100, nmax=2, api = acos(-1.e0))
        dimension i11(idimax),ai2(nmax,idimax)
        real*8 dpi,ad1(idimax)
C     final das declarações de variáveis
C
C     Comando de leituras de dados
C       
      open(unit=1,file='dado.in')  ! nome ao arquivo com dado de entrada
      open(unit=2,file='dado.out') ! nome ao arquivo com dado de saída
C
C       comandos de operações
C
      write(*,*) 'passou aqui 0'
      asum = 0.e0
      aleluia = 1.e0
      dpi = acos(-1.d0)  ! aqui teremos o valor de pi em dupla  precisão
      write(*,*) 'passou aqui 1'
      do j1 =1,2*idimax
C	  write(*,*) 'j1 =',j1
          ad1(j1) = 0.d0 !colocamos d0 por ser dupla precisão
      end do
15    continue
      write(*,*) 'passou aqui 2'
      write(*,*) 'valores de ia1,ia2,aa,bb?' !pede na tela os valores
      read(*,*) ia1,ia2,aa,bb !lê na tela os valores 
      if((ia1.gt.ia2).or.(aa.ge.bb)) then
      write(*,*) 'ia1 maior que ia2, ou então aa maior ou igual a bb rep
     &are que a linha e maior que o tamanho de 72, neste caso tem que c
     1olocar algum caracter como continuacao, & ou um numero de um digit
     1o'
      else
	 write(*,*) 'não satisfez!'
      endif
C
	
      do i1=1,45
          read(1,*) ad1(i1)  ! dará erro se não tiver 45 dados no 
C                            ! arquivo dado.in
          aad = aad + ad1(i1)
          do j1 =-2,56
            if (aad.gt.15) goto 10
          end do
10        continue
          do kk =1,10
            if(aleluia.gt.0) then
               aleluia = -aleluia
               goto 15  !repare que você pode sair do laço do DO
            else
               aleluia = 2.e0*aleluia
            endif
          end do
          aleluia = aleluia
      end do
      rewind(1)   ! este comando faz o ponteiro de leitura ou escrita da 
C                 ! unidade (1 no caso) voltar ao início
C
C
      do i2=1,50
         read(1,*,end=15) ad1(i2) !aqui se os dados acabarem ele vai para 
C                                 ! a linha 14 não dando erro
      end do
C       vai escrever os resultados
      write(2,*) (ad1(io),io=1,10)  ! escreve os dados
C
C       fechar os arquivos abertos
C
      close(1)
      close(2)
      end
<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
     Functions e subrotinas: 
     Sao unidade externas ao programa principal (tem que ter as suas 
variáveis definidas dentro de sua unidade) e são acessadas pelo programa 
principal. A FUNCTION são como as funções usuais, podendo ter vários 
argumentos e serem operadas em uma linha de comando. A saída sempre será 
um número apenas. A subrotina (subroutine) poderá ter vários argumentos 
de entrada e de saída, ou mesmo os de saída serem os de entrada. Vamos 
mostrar incialmente um exemplo do uso de function
<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
C	programa4.f
	implicit real*8(a-h,o-z)  !todas as variáveis serão de dupla precisão
	dimension a1(20,2:30) ! automaticamente será de dupla precisão
	real*4 aiai1  !escolhi variável de simples precisão
	complex z1(100)  ! será complexo de simples precisão
C
	write(*,*) ' me de o valor de m.'
	read(*,*) m
	api = acos(-1.d0)
	do i1=1,20
	 do j1 = 4,15
	  a1(i1,j1)= dsin(api*m/dsqrt(2.d0))
	  write(2,*) 'i1,j1=',i1,j1,'a1-->',a1(i1,j1)
	 end do
	end do
	o1 = f1(2.d0,1.d0)
	write(*,*) 'o1 =',o1
100	o2 =o1 +f1(o1,2*o1) +f1(o1,o1) + sin(f1(o1,2.d0-o1))
	write(*,*) 'o2 =',o2
	aiai1 =o1 +f1(o1,2*o1) +f1(o1,o1) + sin(f1(o1,2.d0-o1))
	write(*,*) 'aiai1 =',aiai1   ! repare que foi truncado para 
C				     ! simples precisão pois as 
C				     !variáveis e FUNCTIONs  eram 
C				     !de dupla e aiai1 e' simples
C
C	Se a function fosse de simples precisão o programa não 
C	compilaria devido a linha 100 acima, pois a variável o2 
C       teria uma precisão maior que aquela dada pela function
	aa2 = 0.334d0
	aa3 = -0.45d0
	aaa = g1(aa2)*f1(aa2,aa3)
	write(*,*) 'aaa --->',aaa

	end
C++++++++++++++++++++++++++++++++++++++++++++++++
C
C	function  nome:f1(y1,y2) 
C
C	Calcula a rebimbeta da parafuseta a partir de y1 e y2
C
C++++++++++++++++++++++++++++++++++++++++++++++++
	function f1(y1,y2)
	implicit real*8 (a-h,o-z)
	dimension a1(2,2)
	do i1=1,2
	  do j1 =1,2
	   a1(i1,j1) = 0.e0
	  end do
	end do
	aa = y1 +sin(y2)
	if(aa.ge.0) then
	  f1 = aa
	else
	  f1 = sin(aa)
	endif
	return   ! a function após o cálculo retorna no programa 
C		 ! principal com o comando --> return
	end function f1
C++++++++++++++++++++++++++++++++++++++++++++++++
C
C	function  nome:g1(y1) 
C
C	Calcula a parafuseta da rebimbeta  a partir de y1 
C
C++++++++++++++++++++++++++++++++++++++++++++++++
	
C
	function g1(y1)
	implicit real*8 (a-h,o-z)
	dimension a1(2,2)
	aa = y1 +sin(y1)
	g1 = aa
	return
	end function g1
<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><
  Daremos um exemplo de subrotina
<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><
C       programa4.f
        implicit real*8(a-h,o-z)  !todas as variáveis serão de dupla precisão
        dimension a1(20,2:30) ! automaticamente será de  dupla precisão
        real*4 aiai1  !escolhi variável de simples precisão
        complex z2(10,10),zz2 ! será complexa de simples precisão
        complex*16 z1(100)  ! será complexo de dupla precisão
        dimension amora(30)
C
        write(*,*) ' me de o valor de m.'
        read(*,*) m
        api = acos(-1.d0)
        do i1=1,20
         do j1 = 4,15
          a1(i1,j1)= dsin(api*m/dsqrt(2.d0))
          write(2,*) 'i1,j1=',i1,j1,'a1-->',a1(i1,j1)
         end do
        end do
C
        x1 = 1.d0+a1(20,3)
        x2 = 2.d0+ a1(2,28)
        x3 = 1.d0
        write(*,*) 'antes x1,x2,x3 -->',x1,x2,x3
        call subrot1(x1,x2,x3,amora) ! chama a subrotina com as entradas x1,x2 e x3
C                              ! vai voltar os valores que os equivalentes
C                              ! da subrotina tomaram
C                           ! a matrix amora tem que ser do mesmo tipo e 
C                           ! dimensão que a ,matrix abobora na subrotina
        write(*,*) 'x1 =',x1,'x2=',x2,'x3 =',x3
        write(*,*) amora
C
        end
C
C ------------> subrotina subrot1
C
        subroutine subrot1(abacaxi, amortadela, salamei,abobora)
        implicit real*8 (a-h,o-z)
        dimension abobora(30)
        abacaxi = abacaxi + amortadela
        salame = amortadela
        write(*,*) 'dentro abacaxi =',abacaxi
        do i =1,30
          abobora(i) = i
        end do
        return
        end subroutine subrot1
<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><
        Exemplo de uso do gerador de números pseudo-aleatórios
            a função intrínseca rand() da um numero "aleatório" 
            entre 0 e 1. O início da sequência  é dada pela 
            semente iseed (faz uma primeira vez rand(iseed)). A
            sequência será sempre a mesma para dado valor de 
            "iseed". No exemplo abaixo calculamos o primeiro,
	    segundo e terceiro momentos do número aleatório.
<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><
C       Program: gerador.f
        iseed =10
        asum1 = 0.e0
        asum2 = 0.e0
        asum3 = 0.e0
        rr =rand(iseed)
        write(*,*) 'N?'
        read(*,*) N
        write(*,*) 'valor de N -->',N
        do i1 =1,N
          rr = rand()
          asum1 = asum1 +rr
          asum2 = asum2 +rr*rr
          asum3 = asum3 +rr*rr*rr
        end do
        write(*,*) '<rr> =',asum1/N  !mẽdia dos números aleatórios
        write(*,*) '<rr**2> =',asum2/N ! segundo momento
        write(*,*) '<rr**3> =',asum3/N ! terceiro momento
        stop
        end
<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><
 
~                  

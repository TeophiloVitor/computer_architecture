#Aluno: Teophilo Vitor de Carvalho Clemente
#Matricula: 20190080555

.data
	#VALORES
	A: .float 2.0
	B: .float 3.0
	C: .float 0.0

	#AUXILIARES
	DOIS: .float 2.0
	DEZ: .float 10.0
	ZERO: .float 0.0

	#TEXTOS
	msg1: .ascii "\n Raiz não encontrada!"
	msg2: .ascii "\n Raiz encontrada! "

.text
	main:
		move $t0, $zero #index=0
		li $t4, 10 #Maximo de iterações
		
		l.s $f12, ZERO
		l.s $f2, A
		l.s $f4, B
		l.s $f6, C
		l.s $f8, DOIS
		l.s $f10, DEZ

	while:
		beq $t0, $t4, exitWhile # para uma raiz nao encontrada

		sub.s $f6, $f4, $f2 # f6 = B-A
 		div.s $f6, $f6, $f8 # f6 = (B-A)/2
 		add.s $f6, $f2, $f6 # x = A + (B-A)/2
 
 		mul.s $f7, $f6, $f6 # x^2= x*x		
		mul.s $f7, $f7, $f6 # x^3= x^2*x
    		sub.s $f7, $f7, $f10 # f = x^3-10.0
 
 		c.eq.s $f7, $f12 #caso a raiz seja raiz encontrada
 		bc1t raiz 
 
 		#F(a)
 		mul.s $f5, $f2, $f2 # f5 = x*x		
		mul.s $f5, $f5, $f2 # f5 = x^2*x
    		sub.s $f5, $f5, $f10 # f = x^3-10.0
 
 		mul.s $f5, $f5, $f7 # Calc = F(A) * F(x)
 		c.le.s $f5, $f12 # Se F(A) * F(x) < 0  
		bc1t RaizInAP # Sim esta entre A e P
		bc1f RaizInBP # Se nao esta entre B e P
	
 		addi $t0, $t0, 1 # i = i + 1
 		
		j while
 		
     		exitWhile:
     			addi $v0, $zero, 4
			la $a0, msg1
			syscall	
			
			li $v0, 10
			syscall
			
		raiz:
			addi $v0, $zero, 4
			la $a0, msg2
			syscall
			
			li $v0, 2 
			mov.s $f12, $f6
			syscall

			li $v0, 10
			syscall

		RaizInAP:
			add.s $f4, $f6, $f12 # B = P 
			
			j while
			
     		RaizInBP:
     			add.s $f2, $f6, $f12 # A = P
			
			j while

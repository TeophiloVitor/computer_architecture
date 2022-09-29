#Aluno: Teophilo Vitor de Carvalho Clemente
#Matricula: 20190080555

.data
	msg1:  .ascii   "\nACERTOS: "
	acerto:   .word 0  # Contabilização de acertos
	
	msg2:  .ascii   "\nERROS: "
	erro:  .word 0  # Contabilização de erros

	ref:   .word  2,  3, 11, 16, 21, 13, 64, 48, 19, 11,  3, 22,  4, 27,  6, 11 # Array ref
	cache: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 # Inicializando com zeros
	size:  .word 16 # Tam array de ref
	
.text
	main:
		li $t0, 0 # t0 = 0 índice para ref
		li $t1, 0 # t1 = 0 índice para cache
		
		li $t2, 0 # t2 = 0 corresponde ao valor atual do array ref
		li $t3, 0 # t3 = 0 corresponde ao valor atual do array cache
		
		lw   $s0, size     # s0 = 16 do tam do array
		lw   $s1, acerto   # s1 = acertos
		lw   $s2, erro     # s2 = erros
		
		li   $t4, 0        # t4 = 0 corresponde a contagem de loop

	loop:
		beq  $t4, $s0, end   # se t4 for igual a 16, segue para end
    		addi $t4, $t4, 1     # t4 = t4 + 1
    
		lw   $t2, ref($t0)   # t2 será igual a ref[t0]
		div  $t2, $s0        # Divisão
		mfhi $t1             # Resto da divisão
		mul  $t1, $t1, 4     # t1 = t1 * 4
		
		addi $t0, $t0, 4     # t0 = t0 + 4
		
		lw   $t3, cache($t1) # t3 = cache[t1]
		bne  $t3, $t2, if    # mandará para o if se t3 != t2, ou seja, cache[t1] != ref[t0]
		
		j loop               # retornar ao loop
		
		
	if:
		sw   $t2, cache($t1) # t2 será igual a cache[t1]
		addi $s2, $s2, 1     # s2 = s2 + 1
		j loop               # retornar ao loop
	
		
	end:
		sub $s1, $s0, $s2  # s1 = s0 - s2
	
		#Realizar a impressão dos acertos
		li $v0, 4
		la $a0, msg1
		syscall
		li $v0, 1
		move $a0, $s1
		syscall
	
		#Realizar a impressão dos erros
		li $v0, 4
		la $a0, msg2
		syscall
		li $v0, 1
		move $a0, $s2
		syscall
	
		#Encerra o programa
		li $v0, 10
		syscall
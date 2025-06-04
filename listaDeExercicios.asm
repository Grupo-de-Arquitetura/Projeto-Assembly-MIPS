.data

minhaString1: .asciiz "Luiz Felipe"
minhaString2: .asciiz "Eloisa Samara Silva Lucena"

.text

j main

strcnp:

strcat:

strcmp: #recebe em $a0 e $a1 os endereços para a comparação de strings
	#retorna um inteiro em $v0 que quando é zero indica que as strings são iguais

	add $t0, $a0, $0 #carrega em $t0 o endereço da primeira string
	add $t1, $a1, $0 #carrega em $t1 o endereço da segunda string
	add $t2, $0, $0  #registrador $t2 auxilia a execução da função
	add $t3, $0, $0  #registrador $t3 auxilia a execução da função
	add $t4, $0, $0  #registrador $t4 auxilia a execução da função
	
	continuarStrcmp:
	
		lb $t2, 0($t0)    #carrega o caractere no endereço em $t0 em $t2
		lb $t3, 0($t1)    #carrega o caractere no endereço em $t1 em $t3
		
		sub $t4, $t2, $t3 #compara os caracteres de $t2 e $t3 por subtração
		
		bne $t4, $0, finalizarStrcmp #se a comparação for diferente de zero 
					     #então finalize a função
					     #senão faça a próxima verificação
					     
		beq $t2, $0, finalizarStrcmp #se a comparação for igual a zero e um dos caracteres é nulo 
					     #então finalize a função
					     #senão incremente a posição das strings
		
			addi $t0, $t0, 1     #incrementa o endereço em $t0
			addi $t1, $t1, 1     #incrementa o endereço em $t1
			
			j continuarStrcmp    #mantêm a repetição da função
		
	finalizarStrcmp:
	
		add $v0, $t4, $0  	     #carrega o valor da comparação em $v0 (retorno)
		jr $ra           	     #volta para a main
	

memcpy: #recebe em $a0 o endereço de destino, em $a1 o endereço de origem e em $a1 o número de bytes a serem copiados
	#retorna em $v0 o endereço da string de destino

	add $t0, $a0, $0 #registra o endereço de $a0 em $t0 (destino)
	add $t1, $a1, $0 #registra o endereço de $a1 em $t1 (origem)
	add $t2, $a2, $0 #registra o valor de $a2 em $t2
	add $t3, $0, $0  #o registrador $t3 auxilia a execução da função
	
	continuarMemcpy:
		beq $t2, $0, finalizarMemcpy #verifica se o número de bytes a serem copiados chegou a zero
					     #se verdade a função entra em finalização
					     #senão continuar a função
			lb $t3, 0($t1)       #carrega em $t3 o valor no endereço registrado em $t1
			sb $t3, 0($t0)       #carrega o valor de $t3 no endereço registrado em $t0
			
			addi $t0, $t0, 1     #incrementa o endereço em $t0
			addi $t1, $t1, 1     #incrementa o endereço em $t1
			addi $t2, $t2, -1    #decrementa o valor de bytes a serem copiados
			
			j continuarMemcpy    #mantêm a repetição da função
	
	finalizarMemcpy:
		add $v0, $a0, $0 	     #carrega o endereço do destino no registrador $v0 (retorno)
		jr $ra           	     #volta para a main



strcpy: #recebe em $a0 e em $a1 os endereços para a cópia de uma string com origem em $a1 e destino em $a0
	#retorna em $v0 o endereço da stirng de destino

	add $t0, $a0, $0 #registra o endereço de $a0 em $t0 (destino)
	add $t1, $a1, $0 #registra o endereço de $a1 em $t1 (origem)
	add $t2, $0, $0  #o registrador $t2 é responsável por auxiliar a operação
	
	continuarStrcpy:
		
		lb $t2, 0($t1) #carrega em $t2 o caractere no endereço em $t1
		
		beq $t2, $0, finalizarStrcpy #se na posição atual da string de origem não existir o caractere nulo
					     #então continue a operação 
					     #senão finalize a função
			sb $t2, 0($t0)       #carrega no endereço atual da string de destino o caractere atual da string de origem
			
			addi $t0, $t0, 1     #incrementa o endereço registrado em $t0
			addi $t1, $t1, 1     #incrementa o endereço registrado em $t1
			
			j continuarStrcpy    #mantêm a repetição da função
	
	finalizarStrcpy:

		sb $t2, 0($t0)               #carrega o valor nulo encontrado na string de origem na string destino
		add $v0, $a0, $0             #carrega o endereço da string de destino em $a0 em $v0 (retorno)
		jr $ra                       #volta para a main

main:

	la $s0, minhaString1 #registra o endereço da minhaString1 em $s0
	la $s1, minhaString2 #registra o endereço da minhaString2 em $s1
	
	#registra o endereço 0x10010040 em $s3
		lui $s2, 0x00001001
		ori $s2, 0x00000040
	
	#chamada da função strcpy
		add $a0, $s2, $0 #registra o endereço em $s2 como parâmetro em $a0
		add $a1, $s0, $0 #registra o endereço em $s0 como parâmetro em $a1
	
		jal strcpy       #chama a função strcpy
		add $s0, $v0, $0 #registra o retorno da função em $s0
	
	#registra o endereço 0x10010060 em $s3
		lui $s2, 0x00001001
		ori $s2, 0x00000060
	
	#chamada da função strcpy
		add $a0, $s2, $0 #registra o endereço em $s2 como parâmetro em $a0
		add $a1, $s1, $0 #registra o endereço em $s1 como parâmetro em $a1
	
		jal strcpy       #chama a função strcpy
		add $s1, $v0, $0 #registra o retorno da função em $s1
	
	#registra o endereço 0x10010080 em $s3
		lui $s2, 0x00001001
		ori $s2, 0x00000080
	
	#chamada da função memcpy
		add $a0, $s2, $0 #registra o endereço em $s2 como parâmetro em $a0
		add $a1, $s0, $0 #registra o endereço em $s0 como parâmetro em $a1
		addi $a2, $0, 4  #carrega o valor 4 como parâmetro em $a2
	
		jal memcpy       #chama a função memcpy
		add $s2, $v0, $0 #registra o retorno da função em $s2
	
	#chamada da função strcmp
		add $a0, $s2, $0 #registra o endereço em $s2 como parâmetro em $a0
		add $a1, $s2, $0 #registra o endereço em $s1 como parâmetro em $a1
	
		jal strcmp       #chama a função strcmp
		add $s3, $v0, $0 #registra o retorno da função em $s3
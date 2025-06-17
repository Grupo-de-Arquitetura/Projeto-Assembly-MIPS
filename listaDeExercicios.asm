.data

minhaString1: .asciiz "Luiz Felipe"
minhaString2: .asciiz "Eloisa Samara Silva Lucena"

.text

j main

strcat: #recebe em $a0 e $a1 os endere�os para a concatena��o de strings
	 #retorna o endere�o de $a0 definido como destino enquanto $a1 � a fonte
	 
	add $t0, $a0, $0 #recebe o endere�o da string destino
	add $t1, $a1, $0 #recebe o endere�o da string fonte
	add $t2, $0, $0  #registrador auxiliar para o funcionamento da fun��o
	
	percorrerDestinoStrcat:
		lb $t2, 0($t0) #carrega o caractere presente no endere�o em $t0
		beq $t2, $0, copiarFonteStrcat #verifica se o caractere carregado n�o � nulo
						   #se for nulo, v� para a copiarFonteStrcat
			addi $t0, $t0, 1 #incrementa o endere�o em $t0
			
			j percorrerDestinoStrcat #mant�m a repeti��o de percorrerDestinoStrcat
	
	copiarFonteStrcat:
		lb $t2, 0($t1) #carrega o caractere no endere�o da string fonte
		beq $t2, $0, finalizarStrcat #verifica se o caractere � nulo
						 #se for nulo finalize a fun��o
						 #sen�o continue a fun��o
			sb $t2, 0($t0) #carrega o caractere em $t2 no endere�o em $t0
			
			addi $t0, $t0, 1 #incrementa o endere�o em $t0
			addi $t1, $t1, 1 #incrementa o endere�o em $t1
			
			j copiarFonteStrcat #mant�m a repeti��o de copiarFonteStrcat
	
	finalizarStrcat:
		sw $0, 0($t0) #carrega o caractere nulo no final da string destino
		
		add $v0, $a0, $0 #carrega o endere�o da string fonte em $v0
		jr $ra #volta para a main

strcnp: #recebe em $a0 e $a1 os endere�os para compara��o de strings
	 #recebe em $a2 o n�mero m�ximo de caracteres a serem comparados
	 #retorna um inteiro em $v0 que quando � zero indica que as strings s�o iguais
	 
	add $t0, $a0, $0 #recebe em $t0 o endere�o da string da primeira entrada
	add $t1, $a1, $0 #recebe em $t2 o endere�o da string da segunda entrada
	add $t2, $a2, $0 #carrega em $t2 o valor do n�mero m�ximo de caracteres a serem comparados
	add $t3, $0, $0  #registrador auxiliar para a execu��o da fun��o
	add $t4, $0, $0  #registrador auxiliar para a execu��o da fun��o
	
	continuarStrcnp:
		
		lb $t3, 0($t0) #carrega em $t3 o valor registrado no endere�o de mem�ria em $t0
		lb $t4, 0($t1) #carrega em $t4 o valor registrado no endere�o de mem�ria em $t1
		
		sub $t4, $t4, $t3 #carrega em $t4 a diferen�a entre os caracteres das strings em $t3 e $t4
		
		beq $t2, $0, finalizarStrcnp #finaliza a fun��o caso $t2 chegue a zero
			bne $t4, $0, finalizarStrcnp #finaliza a fun��o caso os caracteres sejam diferentes
				beq $t3, $0, finalizarStrcnp #finaliza a fun��o se um dos caracteres for nulo
				
					addi $t0, $t0, 1 #incrementa o endere�o da primeira string
					addi $t1, $t1, 1 #incrementa o endere�o da segunda string
					addi $t2, $t2, -1 #decrementa o n�mero de caracteres a serem comparados
					
					j continuarStrcnp #continua a execu��o da fun��o
	
	finalizarStrcnp:
		add $v0, $t4, $0 #carrega o resultado da compara��o da fun��o em $v0
		jr $ra #volta para a main

strcmp: #recebe em $a0 e $a1 os endere�os para a compara��o de strings
	#retorna um inteiro em $v0 que quando � zero indica que as strings s�o iguais

	add $t0, $a0, $0 #carrega em $t0 o endere�o da primeira string
	add $t1, $a1, $0 #carrega em $t1 o endere�o da segunda string
	add $t2, $0, $0  #registrador $t2 auxilia a execu��o da fun��o
	add $t3, $0, $0  #registrador $t3 auxilia a execu��o da fun��o
	add $t4, $0, $0  #registrador $t4 auxilia a execu��o da fun��o
	
	continuarStrcmp:
	
		lb $t2, 0($t0)    #carrega o caractere no endere�o em $t0 em $t2
		lb $t3, 0($t1)    #carrega o caractere no endere�o em $t1 em $t3
		
		sub $t4, $t2, $t3 #compara os caracteres de $t2 e $t3 por subtra��o
		
		bne $t4, $0, finalizarStrcmp #se a compara��o for diferente de zero 
					     #ent�o finalize a fun��o
					     #sen�o fa�a a pr�xima verifica��o
					     
		beq $t2, $0, finalizarStrcmp #se a compara��o for igual a zero e um dos caracteres � nulo 
					     #ent�o finalize a fun��o
					     #sen�o incremente a posi��o das strings
		
			addi $t0, $t0, 1     #incrementa o endere�o em $t0
			addi $t1, $t1, 1     #incrementa o endere�o em $t1
			
			j continuarStrcmp    #mant�m a repeti��o da fun��o
		
	finalizarStrcmp:
	
		add $v0, $t4, $0  	     #carrega o valor da compara��o em $v0 (retorno)
		jr $ra           	     #volta para a main
	

memcpy: #recebe em $a0 o endere�o de destino
	 #recebe em $a1 o n�mero de bytes a serem copiados
	 #retorna em $v0 o endere�o da string de destino

	add $t0, $a0, $0 #registra o endere�o de $a0 em $t0 (destino)
	add $t1, $a1, $0 #registra o endere�o de $a1 em $t1 (origem)
	add $t2, $a2, $0 #registra o valor de $a2 em $t2
	add $t3, $0, $0  #o registrador $t3 auxilia a execu��o da fun��o
	
	continuarMemcpy:
		beq $t2, $0, finalizarMemcpy #verifica se o n�mero de bytes a serem copiados chegou a zero
					     #se verdade a fun��o entra em finaliza��o
					     #sen�o continuar a fun��o
			lb $t3, 0($t1)       #carrega em $t3 o valor no endere�o registrado em $t1
			sb $t3, 0($t0)       #carrega o valor de $t3 no endere�o registrado em $t0
			
			addi $t0, $t0, 1     #incrementa o endere�o em $t0
			addi $t1, $t1, 1     #incrementa o endere�o em $t1
			addi $t2, $t2, -1    #decrementa o valor de bytes a serem copiados
			
			j continuarMemcpy    #mant�m a repeti��o da fun��o
	
	finalizarMemcpy:
		add $v0, $a0, $0 	     #carrega o endere�o do destino no registrador $v0 (retorno)
		jr $ra           	     #volta para a main



strcpy: #recebe em $a0 e em $a1 os endere�os para a c�pia de uma string com origem em $a1 e destino em $a0
	#retorna em $v0 o endere�o da stirng de destino

	add $t0, $a0, $0 #registra o endere�o de $a0 em $t0 (destino)
	add $t1, $a1, $0 #registra o endere�o de $a1 em $t1 (origem)
	add $t2, $0, $0  #o registrador $t2 � respons�vel por auxiliar a opera��o
	
	continuarStrcpy:
		
		lb $t2, 0($t1) #carrega em $t2 o caractere no endere�o em $t1
		
		beq $t2, $0, finalizarStrcpy #se na posi��o atual da string de origem n�o existir o caractere nulo
					     #ent�o continue a opera��o 
					     #sen�o finalize a fun��o
			sb $t2, 0($t0)       #carrega no endere�o atual da string de destino o caractere atual da string de origem
			
			addi $t0, $t0, 1     #incrementa o endere�o registrado em $t0
			addi $t1, $t1, 1     #incrementa o endere�o registrado em $t1
			
			j continuarStrcpy    #mant�m a repeti��o da fun��o
	
	finalizarStrcpy:

		sb $t2, 0($t0)               #carrega o valor nulo encontrado na string de origem na string destino
		add $v0, $a0, $0             #carrega o endere�o da string de destino em $a0 em $v0 (retorno)
		jr $ra                       #volta para a main

main:

	la $s0, minhaString1 #registra o endere�o da minhaString1 em $s0
	la $s1, minhaString2 #registra o endere�o da minhaString2 em $s1
	
	#registra o endere�o 0x10010040 em $s2
		lui $s2, 0x00001001
		ori $s2, 0x00000040
	
	#chamada da fun��o strcpy
		add $a0, $s2, $0 #registra o endere�o em $s2 como par�metro em $a0
		add $a1, $s0, $0 #registra o endere�o em $s0 como par�metro em $a1
	
		jal strcpy       #chama a fun��o strcpy
		add $s0, $v0, $0 #registra o retorno da fun��o em $s0
	
	#registra o endere�o 0x10010060 em $s2
		lui $s2, 0x00001001
		ori $s2, 0x00000060
	
	#chamada da fun��o strcpy
		add $a0, $s2, $0 #registra o endere�o em $s2 como par�metro em $a0
		add $a1, $s1, $0 #registra o endere�o em $s1 como par�metro em $a1
	
		jal strcpy       #chama a fun��o strcpy
		add $s1, $v0, $0 #registra o retorno da fun��o em $s1
	
	#registra o endere�o 0x10010080 em $s3
		lui $s2, 0x00001001
		ori $s2, 0x00000080
	
	#chamada da fun��o memcpy
		add $a0, $s2, $0 #registra o endere�o em $s4 como par�metro em $a0
		add $a1, $s0, $0 #registra o endere�o em $s0 como par�metro em $a1
		addi $a2, $0, 4  #carrega o valor 4 como par�metro em $a2
	
		jal memcpy       #chama a fun��o memcpy
		add $s2, $v0, $0 #registra o retorno da fun��o em $s2
	
	#chamada da fun��o strcmp
		add $a0, $s0, $0 #registra o endere�o em $s2 como par�metro em $a0
		add $a1, $s2, $0 #registra o endere�o em $s4 como par�metro em $a1
	
		jal strcmp       #chama a fun��o strcmp
		add $s3, $v0, $0 #registra o retorno da fun��o em $s3





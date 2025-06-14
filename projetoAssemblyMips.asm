.data

minhaEstrutura: .space 13042

.text

j main

strncpy: #recebe em $a0 e em $a1 os endere�os para a c�pia de uma string com origem em $a1 e destino em $a0
	  #carrega em $a2 o número máximo de caracteres que devem ser copiados
	  #retorna em $v0 o endere�o da string de destino

	add $t0, $a0, $0 #registra o endere�o de $a0 em $t0 (destino)
	add $t1, $a1, $0 #registra o endere�o de $a1 em $t1 (origem)
	add $t2, $a2, $0 #carrega o número máximo de caracteres em $t2
	add $t3, $0, $0  #o registrador $t3 � respons�vel por auxiliar a opera��o
	
	continuarStrncpy:
		
		lb $t3, 0($t1) #carrega em $t2 o caractere no endere�o em $t1
		
		beq $t2, $0, finalizarStrncpy #se o número de caracteres máximo chegar a zero encerre a função
			beq $t3, $0, finalizarStrncpy #se na posi��o atual da string de origem n�o existir o caractere nulo
					                #ent�o continue a opera��o 
					                #sen�o finalize a fun��o
				sb $t3, 0($t0)         #carrega no endere�o atual da string de destino o caractere atual da string de origem
			
				addi $t0, $t0, 1       #incrementa o endere�o registrado em $t0
				addi $t1, $t1, 1       #incrementa o endere�o registrado em $t1
				addi $t2, $t2, -1      #decrementa o número de caracteres máximo
			
				j continuarStrncpy      #mant�m a repeti��o da fun��o
	
	finalizarStrncpy:

		sb $0, 0($t0)               #carrega o valor nulo no ultimo caractere da string destino
		add $v0, $a0, $0            #carrega o endere�o da string de destino em $a0 em $v0 (retorno)
		jr $ra                      #volta para a main


adicionarMorador: #registra em $a0 o endereço do apartamento em que deve ser adicionado
		    #registra em $a1 o endereço do nome do morador a ser adicionado
		    
		    
	add $t0, $a0, $0 #registra em $t0 o endereço do apartamento
	add $t1, $a1, $0 #registra em $t1 o endereço da string nome
	lb  $t2, 1($t0)  #carrega em $t2 o número atual de moradores no apartamento
	add $t3, 5($t0)  #registra em $t3 o endereço do primeiro elemento da lista de moradores
	add $t4, $0, $0  #registrador $t4 será auxiliar para o funcionamento da função
	add $t5, $0, $0  #registrador $t5 será auxiliar para o funcionamento da função
	
	slti $t4, $t2, 5 #se o número atual de moradores for menor que 5 carrega 1 em $t4
			   #senão carrega 0 em $t4
	
	beqz $t4, finalizarAdicionarMorador #se o valor carregado em $t4 for zero encerre a função
						 #senão adicione o nome do morador a lista
		repetirEncontrarEndereco:
			add $t4, $t2, $0 #carrega em $t4 o número de posições ocupadas na lista de moradores
			add $t5, $t3, $0 #registra em $t5 o endereço da posição zero do array de moradores
			beqz $t4, finalizarEncontrarEndereco #verifica se foi encontrada a próxima posição livre
				addi $t5, $t5, 51 #registra em $t5 o endereço da próxima posição da lista
				addi $t4, $t4, -1 #decrementa o número de posições ocupadas
				j repetirEncontrarEndereco
		finalizarEncontrarEndereco:
		
		#início da chamada da função strncpy
			addi $sp, $sp, -36
			sw $ra, 0($sp)
			sw $a0, 4($sp)
			sw $a1, 8($sp)
			sw $t0, 12($sp)
			sw $t1, 16($sp)
			sw $t2, 20($sp)
			sw $t3, 24($sp)
			sw $t4, 28($sp)
			sw $t5, 32($sp)
			
			add $a0, $t5
			add $a1, $a1
			addi $a2, $0, 50
			
			jal strncpy
			
			lw $ra, 0($sp)
			lw $a0, 4($sp)
			lw $a1, 8($sp)
			lw $t0, 12($sp)
			lw $t1, 16($sp)
			lw $t2, 20($sp)
			lw $t3, 24($sp)
			lw $t4, 28($sp)
			lw $t5, 32($sp)
			addi $sp, $sp, 36
		#fim da chamada da função strncpy
		
		addi $t2, $t2, 1
		sw $t2, 1($t0)
	finalizarAdicionarMorador:
		jr $ra

buscar: #recebe no registrador $a0 o primeiro endere�o da estrutura 
	 #recebe no registrador $a1 o numero do apartamento a ser encontrado
	 #caso n�o seja encontrado, ele retorna a posi��o do apartamento de n�mero zero (exce��o)
	
	addi $t0, $a0, 2 #registra em $t0 o endere�o do primeiro apartamento da estrutura
			   #subsequentemente ele regista o endere�o dos apartamentos atualmente sendo avaliados
			   
	add $t1, $a1, $0 #registra em $t1 o n�mero do apartamento a ser encontrado
	lb $t2, 0($t0)   #registra em $t2 o n�mero do apartamento atualmente sendo avaliado
	
	
	repetirBuscar:
		
		beq $t1, $t2, retornarEncontrado  #se o n�mero do apartamento procurado for igual ao do apartamento avaliado $t1 = $t2
						      #ent�o retorne o n�mero do apartamento encontrado
						      #sen�o v� para a primeira posi��o do pr�ximo apartamento
						 
		beq $t2, 5, retornarNaoEncontrado #se o n�mero do apartamento atual for o �ltimo (40) 
						      #retorne o primeiro apartamento da estrutura (exce��o)
						 
			addi $t0, $t0, 326 #avan�a $t0 para a posi��o do pr�ximo apartamento da estrutura
			lb $t2, 0($t0) #registra o n�mero do apartamento atualmente sendo avaliado
			j repetirBuscar #volta para o in�cio da repeti��o para avaliar o novo
			
		 
		
	retornarEncontrado:
		addi $v0, $t0, 0
		jr $ra
		
	retornarNaoEncontrado:
		addi $t0, $a0, 1
		addi $v0, $t0, 0
		jr $ra


limpar: #recebe no registrador $a0 a primeiro endere�o da estrutura e em $a1 o n�mero do apartamento para torna-lo vazio

	#inicio da chamada da fun��o buscar
	
		addi $sp, $sp, -12 #rezerva espa�o no stack pointer para o par�metro da fun��o e o valor de retorno ($a0 e $ra)
	
		sw $ra, 0($sp) #no espa�o reservado armazena o valor de retorno desta fun��o
		sw $a0, 4($sp) #armazena o par�mentro da fun��o em $a0 para que ele seja preservado durante a chamada de outra fun��o
		sw $a1, 8($sp) #armazena o par�mentro da fun��o em $a1 para que ele seja preservado durante a chamada de outra fun��o
	
		add $a0, $a0, $0
		add $a1, $a1, $0
		jal buscar 
	
		lw $ra, 0($sp) #recupera do espa�o reservado o valor de retorno desta fun��o
		lw $a0, 4($sp) #recupera o par�mentro da fun��o em $a0 que foi preservado durante a chamada de outra fun��o
		lw $a1, 8($sp) #armazena o par�mentro da fun��o em $a1 que foi preservado durante a chamada de outra fun��o
	
		addi $sp, $sp, 12 #libera espa�o no stack pointer
	
	#fim da chamada da fun��o buscar
	
	addi $t0, $v0, 0 #registra em #t0 o valor retornado pela fun��o buscar rm $v0
	
	sb $0, 1($t0) #armazena 0 no endere�o respons�vel por registrar o numero de moradores atualmente no apartamento
	sb $0, 2($t0) #armazena 0 no endere�o respons�vel por registrar o numero de carros atualmente no apartamento
	sb $0, 3($t0) #armazena 0 no endere�o respons�vel por registrar o numero de motos atualmente no apartamento
	sb $0, 4($t0) #armazena 0 no endere�o respons�vel por registrar o numero de veiculos atualmente no apartamento
	
	jr $ra


formatar: #recebe no registrador $a0 o primeiro endere�o da estrutura e torna todos os apartamentos vazios

	sb $0, 0($a0)
	sb $0, 1($a0)
	addi $t0, $a0, 2 #guarda no registrador $t0 o primeiro endere�o do apartamento que esta sendo verificado atualmente
	addi $t1, $0, 1  #guarda no registrador $t1 o numero que ser� preenchido no apartamento avaliado
	add $t2, $0, $0  #o registrador $t2 � usado para armazenar endere�os diferentes de $t0
	add $t3, $0, $0  #o registrador $t3 � usado para armazenar os valores que se deseja consultar

	repetirFormatar:

		sb $t1, 0($t0) #carrega na mem�ria o numero correto do apartamento

		lb $t3, 1($t0) #carrega no registrador $t3 o valor do numero de moradores no apartamento
	
		beq $t3, $0, continuarFormatar #se o numero de moradores no apartamento for zero, v� para continar
					          #sen�o chame a fun��o limpar para este apartamento		
					
			#inicio da chamada da fun��o limpar apartamento
		
				addi $sp, $sp, -24 #reserva espa�o no stack pointer para: 
						     #registrar o endere�o de retorno no $ra 
						     #preservar as variaveis da fun��o
		
				sw $ra, 0($sp) #no espa�o reservado armazena o valor de retorno desta fun��o
				sw $a0, 4($sp) #armazena o par�mentro da fun��o em $a0 para que ele seja preservado durante a chamada de outra fun��o
				sw $t0, 8($sp) #armazena o valor de $t0 para que ele seja preservado durante a chamada de outra fun��o
				sw $t1, 12($sp) #armazena o valor de $t0 para que ele seja preservado durante a chamada de outra fun��o
				sw $t2, 16($sp) #armazena o valor de $t0 para que ele seja preservado durante a chamada de outra fun��o
				sw $t3, 20($sp) #armazena o valor de $t0 para que ele seja preservado durante a chamada de outra fun��o
			

				addi $a0, $a0, 0 #passa como par�metro para a pr�xima fun��o o primeiro endere�o da estrutura
				addi $a1, $t1, 0 #passa como par�metro para a pr�xima fun��o o n�mero do apartamento a ser limpo
				jal limpar #vai para a fun��o limpar e o endere�o da pr�xima instru��o � armzenado em $ra
		
				lw $ra, 0($sp) #recupera o valor de retorno desta fun��o em $ra
				lw $a0, 4($sp) #recupera o par�mentro da fun��o em $a0 que foi preservado durante a chamada de outra fun��o
				lw $t0, 8($sp) #recupera o valor de $t0 que foi preservado durante a chamada de outra fun��o
				lw $t1, 12($sp) #recupera o valor de $t0 que foi preservado durante a chamada de outra fun��o
				lw $t2, 16($sp) #recupera o valor de $t0 que foi preservado durante a chamada de outra fun��o
				lw $t3, 20($sp) #recupera o valor de $t0 que foi preservado durante a chamada de outra fun��o
			
		
				addi $sp, $sp, 24 #libera espa�o no stack pointer
		
			#fim da chamada da fun��o de limpar apartamento
		

		continuarFormatar:

			beq $t1, 40, sairFormatar #se o numero do apartamento verificado � o ultimo (40), ent�o volte para a main
						  #sen�o incremente o n�mero do apartamento e volte para repetir
		
				addi $t1, $t1, 1 #incrementa o numero do apartamento que esta sendo verificado
				addi $t0, $t0, 326 #armazena em $t0 o endere�o para o proximo apartamento a ser verificado
				j repetirFormatar #retorne para a repeti��o

	sairFormatar:
		jr $ra #volta para a main




main: #onde a chamada das opera��es e intera��o com o usuario ocorrem
lui $s0, 0x00001001

addi $a0, $s0, 0
jal formatar

addi $a0, $s0, 0
addi $a1, $0, 3
jal buscar




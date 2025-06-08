.data

.text

j main


strcpy: #recebe em $a0 e em $a1 os endereços para a cópia de uma string com origem em $a1 e destino em $a0
	 #retorna em $v0 o endereço da string de destino

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



buscar: #recebe no registrador $a0 o primeiro endereço da estrutura 
	#recebe no registrador $a1 o numero do apartamento a ser encontrado
	#caso não seja encontrado, ele retorna a posição do apartamento de número zero (exceção)
	
	addi $t0, $a0, 1 #registra em $t0 o endereço do primeiro apartamento da estrutura
			   #subsequentemente ele regista o endereço dos apartamentos atualmente sendo avaliados
			   
	addi $t1, $a1, 0 #registra em $t1 o número do apartamento a ser encontrado
	lb $t2, 0($t0) #registra em $t2 o número do apartamento atualmente sendo avaliado
	
	
	repetirBuscar:
		
		beq $t1, $t2, retornarEncontrado #se o número do apartamento procurado for igual ao do apartamento avaliado $t1 = $t2
						 #então retorne o número do apartamento encontrado
						 #senão vá para a primeira posição do próximo apartamento
						 
		beq $t2, 5, retornarNaoEncontrado #se o número do apartamento atual for o último (40) 
						   #retorne o primeiro apartamento da estrutura (exceção)
						 
			addi $t0, $t0, 326 #avança $t0 para a posição do próximo apartamento da estrutura
			lb $t2, 0($t0) #registra o número do apartamento atualmente sendo avaliado
			j repetirBuscar #volta para o início da repetição para avaliar o novo
			
		 
		
	retornarEncontrado:
		addi $v0, $t0, 0
		jr $ra
		
	retornarNaoEncontrado:
		addi $t0, $a0, 1
		addi $v0, $t0, 0
		jr $ra


limpar: #recebe no registrador $a0 a primeiro endereço da estrutura e em $a1 o número do apartamento para torna-lo vazio

	#inicio da chamada da função buscar
	
		addi $sp, $sp, -12 #rezerva espaço no stack pointer para o parâmetro da função e o valor de retorno ($a0 e $ra)
	
		sw $ra, 0($sp) #no espaço reservado armazena o valor de retorno desta função
		sw $a0, 4($sp) #armazena o parâmentro da função em $a0 para que ele seja preservado durante a chamada de outra função
		sw $a1, 8($sp) #armazena o parâmentro da função em $a1 para que ele seja preservado durante a chamada de outra função
	
		addi $a0, $a0, 0
		addi $a1, $a1, 0
		jal buscar 
	
		lw $ra, 0($sp) #recupera do espaço reservado o valor de retorno desta função
		lw $a0, 4($sp) #recupera o parâmentro da função em $a0 que foi preservado durante a chamada de outra função
		lw $a1, 8($sp) #armazena o parâmentro da função em $a1 que foi preservado durante a chamada de outra função
	
		addi $sp, $sp, 12 #libera espaço no stack pointer
	
	#fim da chamada da função buscar
	
	addi $t0, $v0, 0 #registra em #t0 o valor retornado pela função buscar rm $v0
	
	sb $0, 1($t0) #armazena 0 no endereço responsável por registrar o numero de moradores atualmente no apartamento
	sb $0, 2($t0) #armazena 0 no endereço responsável por registrar o numero de carros atualmente no apartamento
	sb $0, 3($t0) #armazena 0 no endereço responsável por registrar o numero de motos atualmente no apartamento
	sb $0, 4($t0) #armazena 0 no endereço responsável por registrar o numero de veiculos atualmente no apartamento
	
	jr $ra


formatar: #recebe no registrador $a0 o primeiro endereço da estrutura e torna todos os apartamentos vazios

	addi $t0, $a0, 1 #guarda no registrador $t0 o primeiro endereço do apartamento que esta sendo verificado atualmente
	addi $t1, $0, 0 #guarda no registrador $t1 o numero que será preenchido no apartamento avaliado
	addi $t2, $0, 0 #o registrador $t2 é usado para armazenar endereços diferentes de $t0
	addi $t3, $0, 0 #o registrador $t3 é usado para armazenar os valores que se deseja consultar

	repetirFormatar:

		sb $t1, 0($t0) #carrega na memória o numero correto do apartamento

		lb $t3, 1($t0) #carrega no registrador $t3 o valor do numero de moradores no apartamento
	
		beq $t3, $0, continuarFormatar #se o numero de moradores no apartamento for zero, vá para continar
					       #senão chame a função limpar para este apartamento		
					
			#inicio da chamada da função limpar apartamento
		
				addi $sp, $sp, -24 #reserva espaço no stack pointer para armazenar o endereço de retorno no $ra e preservar as variaveis da função
		
				sw $ra, 0($sp) #no espaço reservado armazena o valor de retorno desta função
				sw $a0, 4($sp) #armazena o parâmentro da função em $a0 para que ele seja preservado durante a chamada de outra função
				sw $t0, 8($sp) #armazena o valor de $t0 para que ele seja preservado durante a chamada de outra função
				sw $t1, 12($sp) #armazena o valor de $t0 para que ele seja preservado durante a chamada de outra função
				sw $t2, 16($sp) #armazena o valor de $t0 para que ele seja preservado durante a chamada de outra função
				sw $t3, 20($sp) #armazena o valor de $t0 para que ele seja preservado durante a chamada de outra função
			

				addi $a0, $a0, 0 #passa como parâmetro para a próxima função o primeiro endereço da estrutura
				addi $a1, $t1, 0 #passa como parâmetro para a próxima função o número do apartamento a ser limpo
				jal limpar #vai para a função limpar e o endereço da próxima instrução é armzenado em $ra
		
				lw $ra, 0($sp) #recupera o valor de retorno desta função em $ra
				lw $a0, 4($sp) #recupera o parâmentro da função em $a0 que foi preservado durante a chamada de outra função
				lw $t0, 8($sp) #recupera o valor de $t0 que foi preservado durante a chamada de outra função
				lw $t1, 12($sp) #recupera o valor de $t0 que foi preservado durante a chamada de outra função
				lw $t2, 16($sp) #recupera o valor de $t0 que foi preservado durante a chamada de outra função
				lw $t3, 20($sp) #recupera o valor de $t0 que foi preservado durante a chamada de outra função
			
		
				addi $sp, $sp, 24 #libera espaço no stack pointer
		
			#fim da chamada da função de limpar apartamento
		

		continuarFormatar:

			beq $t1, 5, sairFormatar #se o numero do apartamento verificado é o ultimo (40), então volte para a main
						  #senão incremente o número do apartamento e volte para repetir
		
				addi $t1, $t1, 1 #incrementa o numero do apartamento que esta sendo verificado
				addi $t0, $t0, 326 #armazena em $t0 o endereço para o proximo apartamento a ser verificado
				j repetirFormatar #retorne para a repetição

	sairFormatar:
		jr $ra #volta para a main




main: #onde a chamada das operações e interação com o usuario ocorrem
lui $s0, 0x00001001

addi $a0, $s0, 0
jal formatar

addi $a0, $s0, 0
addi $a1, $0, 3
jal buscar




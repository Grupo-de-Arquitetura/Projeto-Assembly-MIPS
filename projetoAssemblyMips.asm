.data

nome1: .asciiz "Luiz"
nome2: .asciiz "Eloisa"
nome3: .asciiz "Henrique"
nome4: .asciiz "Marconi"
nome5: .asciiz "Vera"
nome6: .asciiz "Paulo"

certo: .asciiz "Certo"
errado: .asciiz "Errado"

tipo1: .asciiz "m"
modelo1: .asciiz "Toyota"
cor1: .asciiz "Vermelho"

tipo2: .asciiz "c"
modelo2: .asciiz "Honda"
cor2: .asciiz "Azul"

tipo3: .asciiz "m"
modelo3: .asciiz "Honda"
cor3: .asciiz "Verde"

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


infoApartamento: #recebe em $a0 o número do apartamento

	#inicio da chamada da função buscar
		addi $sp, $sp, -8
		sw $ra, 0($sp)
		sw $a0, 4($sp)



buscarVeiculo: #recebe em $a0 o endereço da lista de veiculos
		 #recebe em $a1 o endereço do caractere do tipo do veiculo
		 #recebe em $a2 o endereço da string modelo do veiculo
		 #recebe em $a3 o endereço da string cor do veiculo
		 
	add $t0, $a0, $0 #registra em $t0 o endereço da lista de veiculos
	lb $t1, 0($a1)   #carrega em $t1 o caractere do tipo do veiculo
	add $t2, $a2, $0 #registra em $t2 o endereço do modelo do veiculo
	add $t3, $a3, $0 #registra em $t3 o endereço do cor do veiculo
	add $t4, $0, $0  #registrador $t4 é auxiliar para o funcionamento da função
	add $t5, $0, $0  #registrador $t5 é auxiliar para o funcionamento da função
	
	lb $t5, -256($t0)
	addi $t4, $t5, -1  #carrega o valor 1 em $t4 (contador)
			
	j iniciarBuscarVeiculo
		
	repetirBuscarVeiculo:
		beqz $t4, finalizarBuscarVeiculo #verifica se o contador é igual a zero
							#retorne exceção 1
		addi $t4, $t4, -1 #decremente contador
		addi $t0, $t0, 33 #registre a próxima posição da lista de veiculos em $t5
				
	iniciarBuscarVeiculo:
		
		lb $t5, 0($t0) #carrega o tipo do veiculo avaliado
		bne $t1, $t5, repetirBuscarVeiculo #se o tipo dos veiculos for diferente volte para o começo
			
		#inicio da chamada das funções strcmp
			
			addi $sp, $sp, -44
			sw $ra, 0($sp)
			sw $a0, 4($sp)
			sw $a1, 8($sp)
			sw $a2, 12($sp)
			sw $a3, 16($sp)
			sw $t0, 20($sp)
			sw $t1, 24($sp)
			sw $t2, 28($sp)
			sw $t3, 32($sp)
			sw $t4, 36($sp)
			sw $t5, 40($sp)
				
				addi $a0, $t5, 1 #registra o endereço do modelo do veiculo avaliado
				add $a1, $t2, $0 #registra o endereço do modelo do veiculo procurado
				jal strcmp       #verifica se a modelo do veiculo avaliado é igual ao procurado
				bnez $v0, naoEncontrou #se os modelos forem diferentes volte para o começo
			
				lw $t3, 32($sp)   #recupera o valor de $t3 do stack pointer
				lw $t5, 40($sp)   #recupera o valor de $t5 do stack pointer
			
				addi $a0, $t5, 22 #registra o endereço da cor do veiculo avaliado
				add $a1, $t3, $0  #registra o endereço da cor do veiculo procurado
				jal strcmp        #verifica se a cor do veiculo avaliado é igual ao procurado
				bnez $v0, naoEncontrou #se os modelos forem diferentes volte para o começo
				
				j encontrou
				
				naoEncontrou:
					addi $v1, $0, 1 #não foi encontrado o veiculo (exceção 1)
					j terminarBuscarVeiculo
			
				encontrou:
					add $v1, $0, $0 #o veículo foi encontrado, não há exceção
				
				terminarBuscarVeiculo:
				
			lw $ra, 0($sp)
			lw $a0, 4($sp)
			lw $a1, 8($sp)
			lw $a2, 12($sp)
			lw $a3, 16($sp)
			lw $t0, 20($sp)
			lw $t1, 24($sp)
			lw $t2, 28($sp)
			lw $t3, 32($sp)
			lw $t4, 36($sp)
			lw $t5, 40($sp)
			addi $sp, $sp, 44
		#final da chamada das funções strcmp
			
		bnez $v1, repetirBuscarVeiculo #se as cores forem diferentes volte para o começo
		
	finalizarBuscarVeiculo:
		jr $ra


removerAutomovel: #recebe em $a0 o numero do apartamento
		    #recebe em $a1 o endereço do caractere do tipo do veiculo
		    #recebe em $a2 o endereço da string modelo do veiculo
		    #recebe em $a3 o endereço da string cor do veiculo
		    
	#início da chamada da função buscar
		addi $sp, $sp, -12
		sw $ra, 0($sp)
		sw $a0, 4($sp)
		sw $a1, 8($sp)
	
		add $a0, $a0, $0 #carrega em $a0 o número do apartamento a ser encontrado
		jal buscar       #retorna em $v0 o endereço do apartamento com este número
	
		lw $ra, 0($sp)
		lw $a0, 4($sp)
		lw $a1, 8($sp)	  
		addi $sp, $sp, 12
	#final da chamada da função buscar
	
	beq $v1, 1, erroApartamentoNaoEncontrado
	
	add $t0, $v0, $0 #registra em $t0 o endereço do apartamento
	add $t1, $a1, $0 #registra em $t1 o endereço do tipo do veiculo
	add $t2, $a2, $0 #registra em $t2 o endereço da string modelo do veiculo
	add $t3, $a3, $0 #registra em $t3 o endereço da string cor do veiculo
	lb  $t4, 4($t0)  #carrega em $t4 o número de veiculos adicionados no apartamento
	addi $t5, $v0, 260  #registra o endereço da lista de automoveis do apartamento
	add $t6, $0, $0  #registrador $t6 é auxiliar para o funcionamento da função
	add $t7, $0, $0  #registrador $t7 é auxiliar para o funcionamento da função
	
	lb $t6, 0($t1)  		#carrega em $t6 o tipo do veículo
	
	beq $t6, 99, busqueVeiculo  #se o tipo do veiculo for um carro
					#realize a busca
	beq $t6, 109, busqueVeiculo #se o tipo do veiculo for uma moto
					#realize a busca
					#senão retorne exceção 3
					
		j erroTipoInvalido
		
	busqueVeiculo:
	
		#inicio da chamada da função strcmp
			addi $sp, $sp, -52
			sw $ra, 0($sp)
			sw $a0, 4($sp)
			sw $a1, 8($sp)
			sw $a2, 12($sp)
			sw $a3, 16($sp)
			sw $t0, 20($sp)
			sw $t1, 24($sp)
			sw $t2, 28($sp)
			sw $t3, 32($sp)
			sw $t4, 36($sp)
			sw $t5, 40($sp)
			sw $t6, 44($sp)
			sw $t7, 48($sp)
			
			add $a0, $t5, $0
			add $a1, $a1, $0
			add $a2, $a2, $0
			add $a3, $a3, $0
			
			jal buscarVeiculo
				 
			lw $ra, 0($sp)
			lw $a0, 4($sp)
			lw $a1, 8($sp)
			lw $a2, 12($sp)
			lw $a3, 16($sp)
			lw $t0, 20($sp)
			lw $t1, 24($sp)
			lw $t2, 28($sp)
			lw $t3, 32($sp)
			lw $t4, 36($sp)
			lw $t5, 40($sp)
			lw $t6, 44($sp)
			lw $t7, 48($sp)
			addi $sp, $sp, 52
		#final da chamada da função strcmp
		
		beq $v1, 1, erroVeiculoNaoEncontrado
			add $t6, $v0, $0
		
		beq $t5, $t6, removerPosicao1
			removerUltimaPosicao:
			beq $t6, 109, decrementarMotos
				j decrementarCarros
			
		removerPosicao1:
			lb $t7 , 4($t0)
			beq $t7, 1, removerUltimaPosicao
			
			lb $t6, 33($t5)
			sb $t6, 0($t5)
			
			addi $t5, $t5, 1
			addi $t6, $t5, 33
			
			#inicio da chamada das funções strcpy
				addi $sp, $sp, -52
				sw $ra, 0($sp)
				sw $a0, 4($sp)
				sw $a1, 8($sp)
				sw $a2, 12($sp)
				sw $a3, 16($sp)
				sw $t0, 20($sp)
				sw $t1, 24($sp)
				sw $t2, 28($sp)
				sw $t3, 32($sp)
				sw $t4, 36($sp)
				sw $t5, 40($sp)
				sw $t6, 44($sp)
				sw $t7, 48($sp)
			
				add $a0, $t5, $0
				add $a1, $t6, $0
				addi $a2, $0, 21
				jal strncpy      #copia a string modelo da posição 2 na posição 1
				
				lw $t5, 40($sp)
				lw $t6, 44($sp)
				
				addi $t5, $t5, 21
				addi $t6, $t5, 33
				addi $a2, $0, 11
				jal strncpy      #copia a string cor da posiçao 2 na posição 1
			
				lw $ra, 0($sp)
				lw $a0, 4($sp)
				lw $a1, 8($sp)
				lw $a2, 12($sp)
				lw $a3, 16($sp)
				lw $t0, 20($sp)
				lw $t1, 24($sp)
				lw $t2, 28($sp)
				lw $t3, 32($sp)
				lw $t4, 36($sp)
				lw $t5, 40($sp)
				lw $t6, 44($sp)
				lw $t7, 48($sp)
				addi $sp, $sp, 52
			#final da chamada das funções strcpy
			
			lb $t6, 0($t2)
			beq $t6, 109, decrementarMotos
				decrementarCarros:
					lb $t6, 2($t0)
					addi $t6, $t6, -1
					sb $t6, 2($t0)
					j decrementarVeiculos
			
			decrementarMotos:
				lb $t6, 3($t0)
				addi $t6, $t6, -1
				sb $t6, 3($t0)
			
			decrementarVeiculos:
				lb $t6, 4($t0)
				addi $t6, $t6, -1
				sb $t6, 4($t0)
				
				add $v1, $0, $0
				
				bnez $t2, finalizarRemoverAutomovel #se o número de moradores for zero
				lb $t2, 2($t0) #carrega em $t2 o número de carros
				bnez $t2, finalizarRemoverAutomovel #se o número de carros for zero
				lb $t2, 3($t0) #carrega em $t2 o número de motos
				bnez $t2, finalizarRemoverAutomovel #se o número de motos for zero
			               	 #se todos eles forem zero:
				lb $t2, 0($s0)
				addi $t2, $t2, -1 #decrementa o número de apartamentos preenchidos
				sb $t2, 0($s0)
				
				j finalizarRemoverAutomovel
			
	erroTipoInvalido:
		addi $v1, $0, 3 #carrega o valor 2 no registrador $v1 (exceção 3)
		j finalizarRemoverAutomovel
		
	erroVeiculoNaoEncontrado:
		addi $v1, $0, 2 #carrega o valor 2 no registrador $v1 (exceção 2)
		j finalizarRemoverAutomovel
	
	erroApartamentoNaoEncontrado:
		addi $v1, $0, 1 #carrega o valor 1 no registrador $v1 (exceção 1)

	finalizarRemoverAutomovel:
		jr $ra

adicionarAutomovel: #recebe em $a0 o numero do apartamento
		      #recebe em $a1 o endereço do tipo do veiculo
		      #recebe em $a2 o endereço do modelo do veiculo
		      #recebe em $a3 o endereço da cor do veiculo
		      
	#início da chamada da função buscar
		addi $sp, $sp, -12
		sw $ra, 0($sp)
		sw $a0, 4($sp)
		sw $a1, 8($sp)
	
		add $a0, $a0, $0 #carrega em $a0 o número do apartamento a ser encontrado
		jal buscar       #retorna em $v0 o endereço do apartamento com este número
	
		lw $ra, 0($sp)
		lw $a0, 4($sp)
		lw $a1, 8($sp)	  
		addi $sp, $sp, 12
	#final da chamada da função buscar
	
	beq $v1, 1, erroApartamentoNaoEncontradoAdicionarAutomovel #verifica se foi encontrado o apartamento
	
	add $t0, $v0, $0 #registra em $t0 o endereço do apartamento
	add $t1, $a1, $0 #registra em $t1 o endereço do tipo do veiculo
	add $t2, $a2, $0 #registra em $t2 o endereço do modelo do veiculo
	add $t3, $a3, $0 #registra em $t3 o endereço da cor do veiculo
	lb  $t4, 2($t0)  #carrega em $t4 o número atual de carros no apartamento
	lb  $t5, 3($t0)  #carrega em $t5 o numero atual de motos no apartamento
	lb  $t6, 4($t0)  #carrega em $t6 o numero atual de veiculos no apartamento
	addi $t7, $t0, 260 #registra em $t7 o endereço da lista de veiculos
	add $t8, $0, $0  #registrador $t8 será auxiliar para o funcionamento da função
	add $t9, $0, $0  #registrador $t9 será auxiliar para o funcionamento da função
	
	beq $t4, 1, erroAdicionarAutomovel #verifica se há um carro no apartamento
		lb $t8, 0($t1) #carrega o caractere tipo de veículo que deve adicionar
		
		beq $t8, 99, verifiqueDisponibilidadeCarro  #se for um carro verifique se há uma moto
							         #senão verifique se pode adicionar uma moto
			j verifiqueMoto		    
			
		verifiqueDisponibilidadeCarro:
			lb $t9, 3($t0)                   #carrega o número de motos no apartamento
			bnez $t9, erroAdicionarAutomovel #se o número de motos for diferente de zero
							     #adicione o carro
							     #senão retorne exceção 2
		
			j adicionarVeiculoPosicao1
		
		verifiqueMoto:
			
			beq $t5, 2, erroAdicionarAutomovel #verifica se há duas motos no apartamento
			beq $t8, 109, adicionarVeiculoPosicao1 #se for uma moto adicione
							           #senão retorne exceção 3
			
				j tipoInvalidoAdicionar
			adicionarVeiculoPosicao1:
				beq $t6, 0, adicioneVeiculoPosicao
					addi $t7, $t7, 33 #adiciona veiculo na posicao 2
				adicioneVeiculoPosicao:
					#inicio da chamada das funções strncpy
						addi $sp, $sp, -60
						sw $ra, 0($sp)
						sw $a0, 4($sp)
						sw $a1, 8($sp)
						sw $a2, 12($sp)
						sw $a3, 16($sp)
						sw $t0, 20($sp)
						sw $t1, 24($sp)
						sw $t2, 28($sp)
						sw $t3, 32($sp)
						sw $t4, 36($sp)
						sw $t5, 40($sp)
						sw $t6, 44($sp)
						sw $t7, 48($sp)
						sw $t8, 52($sp)
						sw $t9, 56($sp)
					
						lb $t1, 0($t1) #carrega o caractere tipo do veiculo em $t1
						sb $t1, 0($t7) #carrega o caractere em $t1 no endereço em $t7
						
						lw $t2, 28($sp)
						lw $t7, 48($sp)
						
						addi $a0, $t7, 1 #registra em $a0 o endereço de destino da string
						add $a1, $t2, $0 #registra em $t2 o endereço da string modelo
						addi $a2, $0, 21 #carrega o número máximo de caracteres a serem copiados
						jal strncpy      #copia a string do modelo do veiculo
					
						lw $t3, 32($sp)
						lw $t7, 48($sp)
					
						addi $a0, $t7, 22 #registra em $a0 o endereço de destino da string
						add $a1, $t3, $0  #registra em $a1 o endereço da string cor
						addi $a2, $0, 11  #carrega o número máximo de caracteres a serem copiados
						jal strncpy       #copia a string da cor do veiculo
					
						lw $ra, 0($sp)
						lw $a0, 4($sp)
						lw $a1, 8($sp)
						lw $a2, 12($sp)
						lw $a3, 16($sp)
						lw $t0, 20($sp)
						lw $t1, 24($sp)
						lw $t2, 28($sp)
						lw $t3, 32($sp)
						lw $t4, 36($sp)
						lw $t5, 40($sp)
						lw $t6, 44($sp)
						lw $t7, 48($sp)
						lw $t8, 52($sp)
						lw $t9, 56($sp)
					#final da chamada das funções strncpy
					
					bnez $t2, incrementarValores #se o número de moradores for zero
					lb $t2, 2($t0) #carrega em $t2 o número de carros
					bnez $t2, incrementarValores #se o número de carros for zero
					lb $t2, 3($t0) #carrega em $t2 o número de motos
					bnez $t2, incrementarValores #se o número de motos for zero
		               			 #se todos eles forem zero:
		               			 
					lb $t2, 0($s0)
					addi $t2, $t2, 1 #incrementa o número de apartamentos preenchidos
					sb $t2, 0($s0)
					
					j incrementarValores
	
	tipoInvalidoAdicionar:
		addi $v1, $0, 3 #carrega o valor 3 em $v1 (exceção 3)
		j finalizarAdicionarAutomovel
	
	erroAdicionarAutomovel:
		addi $v1, $0, 2 #carrega o valor 2 em $v1 (exceção 2)
		j finalizarAdicionarAutomovel
	
	erroApartamentoNaoEncontradoAdicionarAutomovel:
		addi $v1, $0, 1 #carrega o valor 1 em $v1 (exceção 1)
		j finalizarAdicionarAutomovel
	
	incrementarValores:
		lb $t8, 0($t1)
		beq $t8, 109, incrementarMotos
			lb $t9, 2($t0)
			addi $t9, $t9, 1
			sb $t9, 2($t0)
			
			j incrementarVeiculos
		incrementarMotos:
			lb $t9, 3($t0)
			addi $t9, $t9, 1
			sb $t9, 3($t0)
			
		incrementarVeiculos:
			lb $t9, 4($t0)
			addi $t9, $t9, 1
			sb $t9, 4($t0)
			
	finalizarAdicionarAutomovel:
		jr $ra

removerMorador: #recebe em $a0 o numero do apartamento
		  #recebe em $a1 o endereço do nome do morador a ser removido
	
	#início da chamada da função buscar
		addi $sp, $sp, -12
		sw $ra, 0($sp)
		sw $a0, 4($sp)
		sw $a1, 8($sp)
	
		add $a0, $a0, $0 #carrega em $a0 o número do apartamento a ser encontrado
		jal buscar       #retorna em $v0 o endereço do apartamento com este número
	
		lw $ra, 0($sp)
		lw $a0, 4($sp)
		lw $a1, 8($sp)	  
		addi $sp, $sp, 12
	#final da chamada da função buscar
	
	beq $v1, 1, erroApartamentoNaoEncontradoRemoverMorador
	
	addi $t0, $v0, 5 #registra em $t0 o endereço 0 da lista de nomes do apartamento
	add $t1, $a1, $0 #registra em $t1 o endereço do nome a ser removido
	lb $t2, 1($v0)   #carrega em $t2 o número de moradores no apartamento
	add $t3, $0, $0  #registrador $t3 é auxiliar para o funcionamento da função
	add $t4, $0, $0  #registrador $t3 é auxiliar para o funcionamento da função
	
	add $t3, $t2, $0
	add $t4, $t0, $0
	repetirProcurarMorador:
		beqz $t3, erroMoradorNaoEncontrado
		
		#inicio da chamada da função strcmp
			addi $sp, $sp, -32
			sw $ra, 0($sp)
			sw $a0, 4($sp)
			sw $a1, 8($sp)
			sw $t0, 12($sp)
			sw $t1, 16($sp)
			sw $t2, 20($sp)
			sw $t3, 24($sp)
			sw $t4, 28($sp)
			
			add $a0, $t0, $0 #registra em $a0 o endereço da primeira string
			add $a1, $t1, $0 #registra em $a1 o endereço da segunda string
			jal strcmp       #compara as duas strings e retorna o resultado em $v0
			
			lw $ra, 0($sp)
			lw $a0, 4($sp)
			lw $a1, 8($sp)
			lw $t0, 12($sp)
			lw $t1, 16($sp)
			lw $t2, 20($sp)
			lw $t3, 24($sp)
			lw $t4, 28($sp)
			addi $sp, $sp, 32
		#final da chamada da função strcmp
		
		beqz $v0, reescreverMorador
			addi $t4, $t4, 51 #registra a próxima posição da lista de nomes
			addi $t3, $t3, -1 #decrementa o número de moradores a serem avaliados
			j repetirProcurarMorador 
	
	reescreverMorador:
		add $t3, $t2, $0
		beq $t3, 1, limparApartamento
		add $t3, $t0, $0 #registra o endereço do nome do morador encontrado
		
		encontrarUltimoElemento:
			beq $t2, 1, encontrouUltimoElemento
				addi $t3, $t3, 51
				addi $t2, $t2, -1
				j encontrarUltimoElemento
		
		encontrouUltimoElemento:
			#inicio da chamada da função strcpy
				addi $sp, $sp, -32
				sw $ra, 0($sp)
				sw $a0, 4($sp)
				sw $a1, 8($sp)
				sw $t0, 12($sp)
				sw $t1, 16($sp)
				sw $t2, 20($sp)
				sw $t3, 24($sp)
				sw $t4, 28($sp)
			
				add $a0, $t0, $0 #registra em $a0 o endereço da primeira string
				add $a1, $t3, $0 #registra em $a1 o endereço da segunda string
				addi $a2, $0, 51 #carrega o número máximo de caracteres que devem ser copiados
				jal strncpy       #copia a segunda string no endereço da primeira
			
				lw $ra, 0($sp)
				lw $a0, 4($sp)
				lw $a1, 8($sp)
				lw $t0, 12($sp)
				lw $t1, 16($sp)
				lw $t2, 20($sp)
				lw $t3, 24($sp)
				lw $t4, 28($sp)
				addi $sp, $sp, 32
			#final da chamada da função strcpy
			
			add $v1, $0, $0 #carrega o valor 0 em $v1 (não houve exceção)
			lb $t0, -4($t4)
			addi $t0, $t0, -1
			sb $t0, -4($t4)
			j finalizarRemoverMorador
	
	limparApartamento:
	#inicio da chamada da função limpar
		addi $sp, $sp, -28
		sw $ra, 0($sp)
		sw $a0, 4($sp)
		sw $a1, 8($sp)
		sw $t0, 12($sp)
		sw $t1, 16($sp)
		sw $t2, 20($sp)
		sw $t3, 24($sp)
			
		add $a0, $a0, $0  #registra em $a0 o numero do apartamento		
		jal limpar        #esvazia apartamento
			
		lw $ra, 0($sp)
		lw $a0, 4($sp)
		lw $a1, 8($sp)
		lw $t0, 12($sp)
		lw $t1, 16($sp)
		lw $t2, 20($sp)
		lw $t3, 24($sp)
		addi $sp, $sp, 28
	#fim da chamada da função limpar
	
		add $v1, $0, $0 #carrega o valor 0 em $v1 (não houve exceção)
		
		j finalizarRemoverMorador
		
	erroApartamentoNaoEncontradoRemoverMorador:
		addi $v1, $0, 1 #carrega o valor 1 em $v1 (exceção 1)
		j finalizarRemoverMorador
		
	erroMoradorNaoEncontrado:
		addi $v1, $0, 2 #carrega o valor 2 em $v1 (exceção 2)
			
	finalizarRemoverMorador:
		jr $ra

adicionarMorador: #recebe em $a0 o numero do apartamento
		    #recebe em $a1 o endereço do nome do morador a ser adicionado
	
       #inicio da chamada da função buscar
       	addi $sp, $sp, -12 #reserva espaço no stack pointer
       	sw $ra, 0($sp)     #armazena o endereço de retorno no stack pointer
       	sw $a0, 4($sp)     #armazena o parâmetro $a0 no stack pointer
       	sw $a1, 8($sp)     #armazena o parâmetro $a1 no stack pointer
       	
       	add $a0, $a0, $0   #carrega o número do apartamento a ser buscado
       	jal buscar #retorna em $v0 o endereço do apartamento a ser buscado
       		    #caso não seja encontrado o apartamento retorna o valor 1 em $v1
       	
       	lw $ra, 0($sp)     #recupera o endereço de retorno do stack
       	lw $a0, 4($sp)
       	lw $a1, 8($sp)
       	addi $sp, $sp, 12  #libera espaço no stack pointer
       #final da chamada da função buscar
       
       beq $v1, 1, erroAoAdicionarMorador
       
	add $t0, $v0, $0 #registra em $t0 o endereço do apartamento
	add $t1, $a1, $0 #registra em $t1 o endereço da string nome
	lb  $t2, 1($t0)  #carrega em $t2 o número atual de moradores no apartamento
	add $t3, $t0, 5  #registra em $t3 o endereço do primeiro elemento da lista de moradores
	add $t4, $0, $0  #registrador $t4 será auxiliar para o funcionamento da função
	add $t5, $0, $0  #registrador $t5 será auxiliar para o funcionamento da função
	
	slti $t4, $t2, 5 #se o número atual de moradores for menor que 5 carrega 1 em $t4
			   #senão carrega 0 em $t4
	
	beqz $t4, erroMaximoNumeroDeMoradores #se o valor carregado em $t4 for zero encerre a função
						 #senão adicione o nome do morador a lista
		add $t4, $t2, $0 #carrega em $t4 o número de posições ocupadas na lista de moradores
		add $t5, $t3, $0 #registra em $t5 o endereço da posição zero do array de moradores

		repetirEncontrarEndereco:
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
			
			add $a0, $t5, $0 #registra em $a0 o endereço da primeira posição livre da lista de moradores
			add $a1, $a1, $0 #registra em $a1 o endereço do nome que desejamos adicionar
			addi $a2, $0, 50 #carrega o número máximo de caracteres como 50
			
			jal strncpy #copia o nome que desejamos adicionar na primeira posição livre
				     #limite de 50 caracteres
			
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
		
		add $t3, $t2, $0 #carrega o número de moradores no apartamento em $t3
		
		bnez $t3, continuarAdicionarMorador #se o número de moradores for zero
		lb $t3, 2($t0) #carrega em $t2 o número de carros
		bnez $t3, continuarAdicionarMorador #se o número de carros for zero
		lb $t3, 3($t0) #carrega em $t2 o número de motos
		bnez $t3, continuarAdicionarMorador #se o número de motos for zero
		               #se todos eles forem zero:
		lb $t3, 0($s0)
		addi $t3, $t3, 1 #incrementa o número de apartamentos preenchidos
		sb $t3, 0($s0)
		
		continuarAdicionarMorador:
		
		addi $t2, $t2, 1 #incrementa o número de moradores no apartamento
		sb $t2, 1($t0)   #carrega no apartamento o número de moradores incrementado
		
		add $v1, $0, $0  #retorna zero em $v1 (não houve exceção)
		j finalizarAdicionarMorador
	
	erroMaximoNumeroDeMoradores:
		addi $v1, $0, 2 #carrega 2 em $v1 (exceção 2)
		
	erroAoAdicionarMorador:
		addi $v1, $0, 1 #carrega 1 em $v1 (exceção 1)
	finalizarAdicionarMorador:
		jr $ra           #volta para a main



buscar: #recebe no registrador $a0 o numero do apartamento a ser encontrado
	 #caso seja encontrado, retorna o endereço do apartamento
	 #caso n�o seja encontrado, ele retorna o valor 1 no registrador $v1(exce��o)
	
	addi $t0, $s0, 2 #registra em $t0 o endere�o do primeiro apartamento da estrutura
			   #subsequentemente ele regista o endere�o dos apartamentos atualmente sendo avaliados
			   
	add $t1, $a0, $0 #registra em $t1 o n�mero do apartamento a ser encontrado
	lb $t2, 1($s0)   #carrega em $t2 o número de apartamentos da estrutura
	lb $t3, 0($t0)   #registra em $t3 o n�mero do apartamento atualmente sendo avaliado
	
	
	repetirBuscar:
		
		beq $t1, $t3, retornarEncontrado    #se o n�mero do apartamento procurado for igual ao do apartamento avaliado $t1 = $t2
						        #ent�o retorne o n�mero do apartamento encontrado
						        #sen�o v� para a primeira posi��o do pr�ximo apartamento
						 
		beq $t3, $t2, retornarNaoEncontrado #se o n�mero do apartamento atual for igual ao numero de apartamentos da estrutura 
						        #houve uma exceção
						 
			addi $t0, $t0, 326 #registra em $t0 a posi��o do pr�ximo apartamento
			lb $t3, 0($t0)     #registra o n�mero do apartamento atualmente sendo avaliado
			j repetirBuscar    #volta para o in�cio da repeti��o para avaliar o novo
			
		 
		
	retornarEncontrado:
		addi $v0, $t0, 0 #registra o endereço do apartamento encontrado em $v0
		add $v1, $0, $0  #carrega zero no $v1 (não houve exceção)
		j finalizarBuscar
		
	retornarNaoEncontrado:
		addi $v1, $0, 1 #carrega no $v1 o valor 1 (exceção)
		
	finalizarBuscar:
		jr $ra          #volta para a main


limpar: #recebe em $a0 o n�mero do apartamento para torna-lo vazio
	 #caso o apartamento não exista, retorna o valor 1 em $v1

	 #inicio da chamada da fun��o buscar
	
		addi $sp, $sp, -8 #reserva espa�o no stack pointer
	
		sw $ra, 0($sp) #armazena o valor de retorno desta fun��o
		sw $a0, 4($sp) #armazena o par�mentro da fun��o em $a0
	
		add $a0, $a0, $0
		jal buscar 
	
		lw $ra, 0($sp) #recupera o valor de retorno desta fun��o
		lw $a0, 4($sp) #recupera o par�mentro da fun��o em $a0
	
		addi $sp, $sp, 8 #libera espa�o no stack pointer
	
	#fim da chamada da fun��o buscar
	
	beq $v1, 1, erroAoLimpar #confere se foi encontrado um apartamento com o número recebdo
	
	addi $t0, $v0, 0 #registra em #t0 o valor retornado pela fun��o buscar rm $v0
	
	sb $0, 1($t0) #carrega 0 no endere�o do numero de moradores no apartamento
	sb $0, 2($t0) #carrega 0 no endere�o do numero de carrosno apartamento
	sb $0, 3($t0) #carrega 0 no endere�o do numero de motos no apartamento
	sb $0, 4($t0) #carrega 0 no endere�o do numero de veiculos no apartamento
	
	add $v1, $0, $0 #carrega o valor 0 em $v1 (não houve exceção)
	
	j finalizarLimpar
	
	erroAoLimpar:
	addi $v1, $0, 1 #carrega o valor 1 em $v1 (exceção)
	
	finalizarLimpar:
	lb $t1, 0($s0)
	addi $t1, $t1, -1
	sb $t1, 0($s0)
	
	jr $ra          #volta para a main


formatar: #carrega no registrador $a0 o número de apartamentos da estrutura

	sb $0, 0($s0)  #primeiro byte da estrutura indica quantos apartamentos estão atualmente ocupados
	sb $a1, 1($s0) #segundo byte da estrutura indica o número de apartamentos existentes
	
	addi $t0, $s0, 2 #registra no registrador $t0 endere�o do primeiro apartamento
	lb   $t1, 1($s0) #carrega em $t1 o número de apartamentos a serem inicializados
	addi $t2, $0, 1  #carrega em $t2 o numero do primeiro apartamento
	add  $t3, $0, $0 #registrador $t3 é auxiliar para o funcionamento da função
	add  $t4, $0, $0 #registrador $t4 é auxiliar para o funcionamento da função

	repetirFormatar:

		sb $t2, 0($t0) #carrega na mem�ria o numero correto do apartamento

		lb $t4, 1($t0) #carrega no registrador $t4 o numero de moradores no apartamento
	
		beq $t4, $0, continuarFormatar #se o numero de moradores no apartamento for zero, v� para continar
					          #sen�o chame a fun��o limpar para este apartamento		
					
			#inicio da chamada da fun��o limpar apartamento
		
				addi $sp, $sp, -28 #reserva espa�o no stack pointer para: 
						     #registrar o endere�o de retorno no $ra 
						     #preservar as variaveis da fun��o
		
				sw $ra, 0($sp) #armazena o valor de retorno desta fun��o
				sw $a0, 4($sp) #armazena o par�mentro da fun��o em $a0
				sw $t0, 8($sp) #armazena o valor de $t0
				sw $t1, 12($sp) #armazena o valor de $t1
				sw $t2, 16($sp) #armazena o valor de $t2
				sw $t3, 20($sp) #armazena o valor de $t3
				sw $t4, 24($sp) #armazena o valor de $t4
			

				addi $a0, $a0, 0 #passa como par�metro primeiro endere�o da estrutura
				addi $a1, $t2, 0 #passa como par�metro o n�mero do apartamento a ser limpo
				jal limpar       #vai para a fun��o limpar
		
				lw $ra, 0($sp)  #recupera o valor de retorno desta fun��o
				lw $a0, 4($sp)  #recupera o par�metro da fun��o em $a0
				lw $t0, 8($sp)  #recupera o valor de $t0
				lw $t1, 12($sp) #recupera o valor de $t1
				lw $t2, 16($sp) #recupera o valor de $t2
				lw $t3, 20($sp) #recupera o valor de $t3
				lw $t4, 24($sp) #recupera o valor de $t4
			
		
				addi $sp, $sp, 28 #libera o espa�o no stack pointer
		
			#fim da chamada da fun��o de limpar apartamento
		

		continuarFormatar:

			beq $t2, $t1, sairFormatar #se o numero de apartamentos adicionados for igual ao máximo encerre a função
						      #sen�o incremente o n�mero do apartamento e verifique a próxima posição
		
				addi $t0, $t0, 326  #armazena em $t0 o endere�o para o proximo apartamento a ser verificado
				addi $t2, $t2, 1    #incrementa o numero do apartamento que esta sendo verificado
				
				
				j repetirFormatar   #repita a função

	sairFormatar:
		jr $ra #volta para a main




main: #onde a chamada das opera��es e intera��o com o usuario ocorrem
	lui $s0, 0x00001001
	ori $s0, 0x00000190
	
	lui $s7, 0x00001001
	ori $s7, 0x00000120

	addi $a0, $s0, 0
	addi $a1, $0, 6
	jal formatar
	
	la $s1, nome1
	la $s2, nome2
	la $s3, nome3
	la $s4, nome4
	la $s5, nome5
	la $s6, nome6
	
	addi $a0, $0, 1
	add $a1, $s1, $0
	jal adicionarMorador
	
	addi $a0, $0, 1
	add $a1, $s1, $0
	jal removerMorador
	
	addi $a0, $0, 2
	add $a1, $s2, $0
	jal adicionarMorador
		
	addi $a0, $0, 3
	add $a1, $s3, $0
	jal adicionarMorador
	
	addi $a0, $0, 2
	add $a1, $s2, $0
	jal removerMorador
	
	addi $a0, $0, 4
	add $a1, $s4, $0
	jal adicionarMorador	
	
	addi $a0, $0, 5
	add $a1, $s5, $0
	jal adicionarMorador	
	
	addi $a0, $0, 3
	add $a1, $s3, $0
	jal removerMorador
	
		
	
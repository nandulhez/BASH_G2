#!/bin/bash


# Trabalho G2 - RSYNC e SCP
# Luís Fernando de Carvalho
# Sistemas para Internet - Desenvolvimento de Redes

#O Script tem o objetivo de armazenar as informações adicionadas nas variaveis e por fim montar um comando Rsync para enviar #o backup para outro servidor.
# Este script sincroniza arquivos com o rsync ou os sobreescreve com o scp
# 

echo *********************Sistema de Backup************************

principal() 

{                       # Função principal do programa
	clear               # limpa a tela
	echo "[1] Defina Arquivo/Diretorio" 
    echo "[2] Copia local"  
    echo "[3] Sair"
    

    echo
    echo -n "Qual a opcao desejada ? "
    read opcao          # faz a leitura da variável "opcao", 
                        # que será utilizada no comando case
                        # para indicar qual a opção a ser utilizada

                        # caso o valor da variável "opcao"...
    case $opcao in
        1)              # seja igual a "1", então faça as instruções abaixo
            clear
			defini_arquivos      
		;;                                
        2)
            clear
			copia_local         
		;; 
 
     	3)
            clear
            exit ;;

        *)              
            clear
            echo "Opcao desconhecida."
            read pause
            principal   
        ;;
    esac
}



defini_arquivos() {             # Essa função o usuario define o arquivo ou diretorio para realizar um backup de um arquivo ou diretório remotamente
	echo "Defina parametro RSYNC?"
	read PARAMETRO				# Essa variável recebe um parametro do rsync ex -a
	echo "Defina o pc de origem? "
	read PC_ORIGEM				# Armazena o PC de origem do arquivo/diretorio a ser copiado
	echo "Defina o pc de destino? "
	read PC_DESTINO 				# Máquina de destino para onde a copia do arquivo/diretorio vai ser enviada
	echo "Defina o caminho de origem "
	read CAM_ORIGEM					# Localização do arquivo/diretorio que será copiado
	echo "Defina o arquivo?"
	read ARQUIVO					# Nome do arquivo a ser copiado
	echo "Defina o caminho de destino? "
	read CAM_DESTINO				# Local onde a copia será armazenada
	echo  "PORTA"
	read  PORTA	

    rsync $PARAMETRO "ssh -p $PORTA" $PC_ORIGEM $CAM_ORIGEM/$ARQUIVO $PC_DESTINO:$CAM_DESTINO 
  

    read pause          # usado para pausar a execução do script
    principal           # volta para a função principal
}

copia_local(){
	echo "Defina parametro RSYNC?"
	read PARAMETRO
	echo "Defina o pc de origem? "
	read PC_ORIGEM
	echo "Defina o arquivo?"
	read ARQUIVO
	echo "Defina o caminho de origem "
	read CAM_ORIGEM
	echo "Defina local voce quer salvar? "
	read CAM_DESTINO
	 
	
	rsync $PARAMETRO $CAM_ORIGEM/$ARQUIVO localhost:$CAM_DESTINO
	
	
}



opcao_invalida() {      # função da opção inválida
    clear
    echo "Opcao desconhecida."
    read pause
    principal
}

principal               # o script começa aqui, as funções das linhas anteriores
                        # são lidas pelo interpretador bash e armazenadas em memória.

                        # o bash não tem como adivinhar qual das funções ele deve 
                        # executar, por isto o a execução do script realmente começa
                        # quando aparece uma instrução fora de uma função, neste caso,
# chamando a função principal

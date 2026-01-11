; *********************************************************************************
; *
; * FC-UAN
; *
; *********************************************************************************
; *********************************************************************************
; *
; * Module: 	ac2021-22-L06a.asm
; * Description : Este é um programa simples de teste das interrupções.
; *		Há apenas uma rotina de interrupção. Esta incrementa um contador
; *		e mostra o seu valor no display hex de cada vez que o botão (servido
; *		por interrupção) for pressionado.
; *
; *********************************************************************************

; *********************************************************************************
; * Constantes
; *********************************************************************************
OUTPUT	EQU	8000H		; endereço do porto de saída (display hex).

; *********************************************************************************
; * Stack 
; *********************************************************************************
PLACE		2000H
pilha:		TABLE 100H		; espaço reservado para a pilha
fim_pilha:				

; *********************************************************************************
; * Dados
; *********************************************************************************
PLACE		2200H
; espaço para declarar quaisquer variáveis que o programa possa usar ...
; ...

; Tabela de vectores de interrupção
tab:		WORD	rot0

; *********************************************************************************
; * Código
; *********************************************************************************
PLACE	0

main:
	MOV	BTE, tab		; incializa BTE
	MOV	SP, fim_pilha	; incializa SP
	MOV	R0, 0			; inicializa contador
	EI0					; permite interrupções tipo 0
	EI 
fim:	JMP	fim			; fica à espera

; *********************************************************************************
;* ROTINAS
; *********************************************************************************

;* -- Rotina de Serviço de Interrupção 0 -------------------------------------------
;* 
;* Description: trata interrupções do botão de pressão.
;*
;* Parameters: 	--
;* Return: 	--  
;* Destroy: none
;* Notes: --	

rot0:
	PUSH	R1			; guarda registo de trabalho	
	MOV		R1, OUTPUT	; endereço do porto do display
	ADD		R0, 1		; incrementa contador
	MOVB 	[R1], R0	; actualiza display
	POP		R1			; restaura registo de trabalho
	RFE					; regressa

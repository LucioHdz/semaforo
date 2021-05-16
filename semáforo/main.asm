__CONFIG _CP_OFF & _WDT_OFF & _PWRTE_ON & _XT_OSC


;____________________________________________________
;||------------------------------------------------||
;||	SEMÁFORO DE DOS VIAS CON INTERRUPTORES PARA    ||
;||	PEATONES,DESARROLLADO POR:					   ||
;||	JESSICA LILIAN BECERRA HERNANDEZ			   ||
;||	VALERIA MONROY MIRANDA						   ||
;||	JOSE LUCIO HERNANDEZ NOGUEZ					   ||
;||________________________________________________||
;----------------------------------------------------


PROCESSOR 		16F84A			;PROCESADOR A USAR ES EL DEL PIC16F84A
#INCLUDE 		<P16F84A.INC>	;LIBRERIA DEL MICROCONTROLADOR


;________________________________________________________
;				CONFIGURACION DE PUERTOS
;________________________________________________________


ORG 		0X00			;ORIGEN

BSF			STATUS,RP0		;BANCO DE MEMORIA 0
MOVLW		B'00000001'		;PUERTO RA1 COMO ENTRADA
MOVWF 		TRISA

CLRF 		TRISB			;PUERTOS RB0-7 COMO SALIDAS
BCF 		STATUS,RP0		;CAMBIO DE BANCO DE MEMORIA AL BANCO 1


CBLOCK 0x10		    ; Almacenamiento Temporal
	contador1
	contador2
	contador3
	Paso
ENDC



INICIO

;MOVFW		PORTA			;MOVER LOS REGISTROS DE A --> W
;ANDLW		B'1'			;0,1
;CALL		CASOS			;



;CASOS
;ADDWF		PCL,F			;SUMA PARA ACCEDER A LA TABLA

;NOP			
;CALL		RUTA			;DONDE VA EL RECORRIDO


;RUTA	
;MOVFW		Paso
;CALL 		SABERPASO

;============================================
;				BUCLE DEL SEMAFORO
;============================================


CASO1

MOVLW		B'00010001'		;ROJO1 ENCENDIDIO VERDE2 ENCENDIDO
MOVWF		TRISB			;COLOCAMOS LOS VALORES EN PORTB
MOVLW		D'0'
MOVWF		Paso					
CALL		RETARDO			;RETARDO
CALL		AMARILLO2

AMARILLO2
MOVLW		B'00001001'		;ENCENDEMOS AMARILLO1 ROJO1						0	0	1	0	0	1	0	0	
MOVWF		TRISB			;COLOCAMOS LOS VALORES EN EL SEMAFORO			-	-	R2	V2	A2	A1	V1	R1
MOVLW		D'1'
MOVWF		Paso
CALL		RETARDO2	
CALL		CASO2

CASO2

MOVLW		B'00100010'		;VERDE1 ENCENDIDIO ROJO 2 ENCENDIDO
MOVWF		TRISB			;COLOCAMOS LOS VALORES EN EL SEMAFORO
MOVLW		D'2'
MOVWF		Paso
CALL		RETARDO			;RETARDO
CALL		AMARILLO1


AMARILLO1

MOVLW		B'00100100'		;ENCENDEMOS AMARILLO1
MOVWF		TRISB			;COLOCAMOS LOS VALORES EN EL SEMAFORO
MOVLW		D'3'
MOVWF		Paso
CALL		RETARDO2			;RETARDO
CALL		CASO1

;SABERPASO

;ADDWF	PCL,F

;CALL	P_2		
;CALL	P_2
;CALL	P_3
;CALL	P_4


;P_1

;CALL 	RETARDO2
;CALL	AMARILLO2

;P_2

;CALL	RETARDO2
;CALL	CASO2

;P_3

;CALL 	RETARDO2
;CALL	AMARILLO1

;P_4

;CALL	RETARDO2
;CALL	CASO1

RETARDO
	clrf   	 contador1		;LIMPIAMOS CONTADOR1
	clrf	 contador2		;LIMPIAMOS CONTADOR1
	movlw	 D'10'							
	movwf	 contador3		
delay1	  
	decfsz contador1,F		;CONTADOR1 - 1
	goto   delay1			
	decfsz contador2,F		;CONTADOR2 - 1
	goto   delay1
	decfsz contador3,F		;CONTADOR3 - 1
	goto   delay1
    return

;_____________________________________________________
;____________________PULSADORES-AMARILLO_______________________      


RETARDO2
	clrf   	 contador1		;LIMPIAMOS CONTADOR1
	clrf	 contador2		;LIMPIAMOS CONTADOR1
	movlw	 D'5'							
	movwf	 contador3		
delay2	  
	decfsz contador1,F		;CONTADOR1 - 1
	goto   delay2			
	decfsz contador2,F		;CONTADOR2 - 1
	goto   delay2
	decfsz contador3,F		;CONTADOR3 - 1
	goto   delay2
    return
          

END



section .bss
        buffer resb 128 ; Reserva un buffer de 128 bytes

section .data
        mensaje db 'Seleccione una opcion: ', 0xA ; Mensaje a mostrar seguido de un salto de línea
        opciones db ' 1. Suma - 2. Resta - 3. Multiplicacion - 4. Division - 5. Residuo de una division', 0xA ; Opciones
	msg_suma db 'Sumando...', 0xA
	msg_resta db 'Restando...', 0xA
	fin db 0 ; Terminador nulo

section .text
        global _start

_start:
        ; Escribir el mensaje en la consola
        mov eax, 4          ; Número de llamada del sistema sys_write
        mov ebx, 1          ; Descriptor de archivo 1 (stdout)
        mov ecx, mensaje    ; Dirección del mensaje que se va a escribir
        mov edx, 25         ; Longitud del mensaje (24 bytes)
        int 0x80

        ; Escribir las opciones en la consola
        mov eax, 4
        mov ebx, 1
        mov ecx, opciones
        mov edx, 83        ; Longitud del mensaje opciones

        int 0x80            ; Interrupción para hacer la llamada al sistema

        ; Leer del teclado
        mov eax, 3          ; Número de llamada del sistema sys_read
        mov ebx, 0          ; Descriptor de archivo 0 (stdin)
        mov ecx, buffer     ; Dirección del buffer donde almacenar la entrada
        mov edx, 128        ; Número máximo de bytes a leer
        int 0x80            ; Interrupción para hacer la llamada al sistema

	; Comprobar si el primer carácter ingresado es '1'
	cmp byte [buffer], '1' ; Comparar el primer carácter con '1'
	je sumar             ; Si es igual, saltar a la funcion sumar

	; Comprobar si el primer carácter ingresado es '2'
	cmp byte [buffer], '2' ; Comparar el primer carácter con '2'
	je restar            ; Si es igual, saltar a la funcion restar

	jmp salir

sumar:
        ; Escribir el mensaje de sumando en la consola
        mov eax, 4          ; Número de llamada del sistema sys_write
        mov ebx, 1          ; Descriptor de archivo 1 (stdout)
        mov ecx, msg_suma    ; Dirección del mensaje que se va a escribir
        mov edx, 11         ; Longitud del mensaje (42 bytes)
	
	int 0x80
	jmp salir


restar:
	; Realizar la resta
	; Escribir el mensaje de restando en la consola
	mov eax, 4          ; Número de llamada del sistema sys_write
	mov ebx, 1          ; Descriptor de archivo 1 (stdout)
	mov ecx, msg_resta
	mov edx, 12

	int 0x80
	jmp salir

; Salir
salir:
        mov eax, 1          ; Número de llamada del sistema sys_exit
        xor ebx, ebx        ; Código de salida 0
        int 0x80

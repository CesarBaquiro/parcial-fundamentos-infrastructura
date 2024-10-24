section .bss
        buffer resb 128 ; Reserva un buffer de 128 bytes
        result_buffer resb 12 ; Buffer para almacenar el resultado como cadena

section .data
        mensaje db 'Seleccione una opcion: ', 0xA, 0
	opciones db ' 1. Suma - 2. Resta - 3. Multiplicacion - 4. Division - 5. Residuo de una division', 0xA ; Opciones
        msg_suma db '---Sumar---', 0xA, 0
        msg_resta db '---Restar---', 0xA, 0
        num1 dd 0 ; Se crea el número 1 en 0
        num2 dd 0 ; Se crea el número 2 en 0
        res dd 0 ; Se crea la variable del resultado
        msg_resultado db 'Resultado:', 0xA, 0

section .text
        global _start

_start:
        ; Escribir el mensaje de selección
        mov eax, 4
        mov ebx, 1
        mov ecx, mensaje
        mov edx, 25
        int 0x80

        ; Escribir las opciones en la consola
        mov eax, 4
        mov ebx, 1
        mov ecx, opciones
        mov edx, 83
        int 0x80

        ; Leer la opción seleccionada
        mov eax, 3
        mov ebx, 0
        mov ecx, buffer
        mov edx, 1
        int 0x80

        ; Comprobar si el primer carácter ingresado es '1'
        cmp byte [buffer], '1'
        je sumar

        ; Comprobar si el primer carácter ingresado es '2'
        cmp byte [buffer], '2'
        je restar

        jmp salir



sumar:
        ; Escribir el mensaje de sumando en la consola
        mov eax, 4
        mov ebx, 1
        mov ecx, msg_suma
        mov edx, 12
        int 0x80

	; Leer el primer número
        mov eax, 3
        mov ebx, 0
        mov ecx, buffer
        mov edx, 12
        int 0x80

        ; Convertir el número de ASCII a binario (manejo de un solo dígito por ahora)
        sub byte [buffer], '0'
        movzx eax, byte [buffer]

	; Cargar el numero en num1
        mov [num1], eax

        ; Leer el segundo número
        mov eax, 3
        mov ebx, 0
        mov ecx, buffer
        mov edx, 12
        int 0x80

        ; Convertir el número de ASCII a binario (manejo de un solo dígito por ahora)
        sub byte [buffer], '0'
        movzx eax, byte [buffer]
	int 0x80

	; Cargar el numero en num2
        mov [num2], eax

        ; Realizar la suma
        mov eax, [num1]
        add eax, [num2]
        mov [res], eax
	int 0x80

        ; Convertir el resultado a cadena
        call convertir_a_cadena

        ; Imprimir el resultado
        mov eax, 4
        mov ebx, 1
        mov ecx, msg_resultado
        mov edx, 10
 
        mov eax, 4
        mov ebx, 1
        mov ecx, result_buffer
        mov edx, 12
        int 0x80

        jmp salir

restar:
        ; Escribir el mensaje de restando en la consola
        mov eax, 4
        mov ebx, 1
        mov ecx, msg_resta
        mov edx, 12
        int 0x80

        ; Leer el primer número
        call leer_numero
        mov [num1], eax

        ; Leer el segundo número
        call leer_numero
        mov [num2], eax

        ; Realizar la resta
        mov eax, [num1]
        sub eax, [num2]
        mov [res], eax

        ; Convertir el resultado a cadena
        call convertir_a_cadena

        ; Imprimir el resultado
        mov eax, 4
        mov ebx, 1
        mov ecx, msg_resultado
        mov edx, 10
        int 0x80

        mov eax, 4
        mov ebx, 1
        mov ecx, result_buffer
        mov edx, 12
        int 0x80

        jmp salir

; Funcion para leer un número desde el teclado
leer_numero:
        mov eax, 3
        mov ebx, 0
        mov ecx, buffer
        mov edx, 12
        int 0x80
        ; Convertir el número de ASCII a binario
        sub byte [buffer], '0'
        movzx eax, byte [buffer]
        ret

; Funcion para convertir un número en una cadena
convertir_a_cadena:
        mov eax, [res]
        mov ecx, result_buffer
        mov ebx, 10
        mov edi, ecx
    .loop:
        xor edx, edx
        div ebx
        add dl, '0'
        dec edi
        mov [edi], dl
        test eax, eax
        jnz .loop
        ret

salir:
        mov eax, 1
        xor ebx, ebx
        int 0x80


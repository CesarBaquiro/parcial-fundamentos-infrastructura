section .bss
        buffer resb 128 ; Reserva un buffer de 128 bytes
        num1 resb 10    ; Buffer para el primer número
        num2 resb 10    ; Buffer para el segundo número
        resultado resb 20 ; Buffer para el resultado

section .data
        mensaje db 'Seleccione una opcion:', 0xA ; Mensaje a mostrar seguido de un salto de línea

	msg_num1 db 'Ingrese el primer numero', 0xA
	msg_num2 db 'Ingrese el segundo numero', 0xA

        opciones db ' 1. Suma - 2. Resta - 3. Multiplicacion - 4. Division - 5. Residuo de una division - 6. Salir', 0xA ; Opciones
	msg_suma db '---SUMAR---', 0xA
        msg_resta db '---RESTAR---', 0xA
	msg_mult db '---MULTIPLICAR---', 0xA
        msg_div db '---DIVIDIR---', 0xA
        msg_mod db '---CALCULAR RESIDUO---', 0xA
        msg_resultado db 'El resultado es: ', 0xA
        fin db 0 ; Terminador nulo

section .text
        global _start

_start:
main_loop:
        ; Escribir el mensaje en la consola
        mov eax, 4
        mov ebx, 1
        mov ecx, mensaje
        mov edx, 23
        int 0x80

        ; Escribir las opciones en la consola
        mov eax, 4
        mov ebx, 1
        mov ecx, opciones
        mov edx, 94 ; Longitud del mensaje opciones
        int 0x80

        ; Leer del teclado
        mov eax, 3
        mov ebx, 0
        mov ecx, buffer
        mov edx, 128
        int 0x80

        ; Comprobar la opción ingresada
        cmp byte [buffer], '1' ; Suma
        je sumar
        cmp byte [buffer], '2' ; Resta
        je restar
        cmp byte [buffer], '3' ; Multiplicación
        je multiplicar
        cmp byte [buffer], '4' ; División
        je dividir
        cmp byte [buffer], '5' ; Residuo
        je residuo
        cmp byte [buffer], '6' ; Salir
        je salir

        jmp main_loop ; Volver al inicio si la opción no es válida

sumar:

	; Mensaje indicando la operacion a realizar
        mov eax, 4
        mov ebx, 1
        mov ecx, msg_suma
        mov edx, 12
        int 0x80

	; Mensaje para el ingreso del numero 1
        mov eax, 4
        mov ebx, 1
        mov ecx, msg_num1
        mov edx, 25 ; Longitud del mensaje Ingrese el primer numer
        int 0x80

        ; Leer el primer número
        mov eax, 3
        mov ebx, 0
        mov ecx, num1
        mov edx, 10
        int 0x80

	; Mensaje para el ingreso del numero 2
        mov eax, 4
        mov ebx, 1
        mov ecx, msg_num2
        mov edx, 26 ; Longitud del mensaje opciones
        int 0x80

        ; Leer el segundo número
        mov eax, 3
        mov ebx, 0
        mov ecx, num2
        mov edx, 10
        int 0x80

        ; Convertir los números de texto a enteros
        mov ecx, num1
        call str2intNum1
        mov ebx, eax ; Guardar el primer número en ebx

        ; Convertir el segundo número de texto a entero
        mov ecx, num2
        call str2intNum2
        add ebx, eax ; Sumar el segundo número al primero

        ; Imprimir el resultado
        call print_result

	jmp main_loop

restar:

        ; Mensaje indicando la operacion a realizar
        mov eax, 4
        mov ebx, 1
        mov ecx, msg_resta
        mov edx, 13
        int 0x80

        ; Mensaje para el ingreso del numero 1
        mov eax, 4
        mov ebx, 1
        mov ecx, msg_num1
        mov edx, 25 ; Longitud del mensaje Ingrese el primer numer
        int 0x80

        ; Leer el primer número
        mov eax, 3
        mov ebx, 0
        mov ecx, num1
        mov edx, 10
        int 0x80

        ; Mensaje para el ingreso del numero 2
        mov eax, 4
        mov ebx, 1
        mov ecx, msg_num2
        mov edx, 26 ; Longitud del mensaje opciones
        int 0x80


        ; Leer el segundo número
        mov eax, 3
        mov ebx, 0
        mov ecx, num2
        mov edx, 10
        int 0x80

        ; Convertir los números de texto a enteros
        mov ecx, num1
        call str2intNum1
        mov ebx, eax ; Guardar el primer número en ebx

        ; Convertir el segundo número de texto a entero
        mov ecx, num2
        call str2intNum2
        add ebx, eax ; Sumar el segundo número al primero

        ; Imprimir el resultado
        call print_result
        jmp main_loop

multiplicar:

        ; Mensaje indicando la operacion a realizar
        mov eax, 4
        mov ebx, 1
        mov ecx, msg_mult
        mov edx, 18
        int 0x80

        ; Mensaje para el ingreso del numero 1
        mov eax, 4
        mov ebx, 1
        mov ecx, msg_num1
        mov edx, 25 ; Longitud del mensaje Ingrese el primer numer
        int 0x80

        ; Leer el primer número
        mov eax, 3
        mov ebx, 0
        mov ecx, num1
        mov edx, 10
        int 0x80

        ; Mensaje para el ingreso del numero 2
        mov eax, 4
        mov ebx, 1
        mov ecx, msg_num2
        mov edx, 26 ; Longitud del mensaje opciones
        int 0x80

        ; Leer el segundo número
        mov eax, 3
        mov ebx, 0
        mov ecx, num2
        mov edx, 10
        int 0x80

        ; Convertir los números de texto a enteros
        mov ecx, num1
        call str2intNum1
        mov ebx, eax ; Guardar el primer número en ebx

        ; Convertir el segundo número de texto a entero
        mov ecx, num2
        call str2intNum2
        add ebx, eax ; Sumar el segundo número al primero

        ; Imprimir el resultado
        call print_result
        jmp main_loop

dividir:

        ; Mensaje indicando la operacion a realizar
        mov eax, 4
        mov ebx, 1
        mov ecx, msg_div
        mov edx, 14
        int 0x80

        ; Mensaje para el ingreso del numero 1
        mov eax, 4
        mov ebx, 1
        mov ecx, msg_num1
        mov edx, 25 ; Longitud del mensaje Ingrese el primer numer
        int 0x80

        ; Leer el primer número
        mov eax, 3
        mov ebx, 0
        mov ecx, num1
        mov edx, 10
        int 0x80

        ; Mensaje para el ingreso del numero 2
        mov eax, 4
        mov ebx, 1
        mov ecx, msg_num2
        mov edx, 26 ; Longitud del mensaje opciones
        int 0x80

        ; Leer el segundo número
        mov eax, 3
        mov ebx, 0
        mov ecx, num2
        mov edx, 10
        int 0x80

        ; Convertir los números de texto a enteros
        mov ecx, num1
        call str2intNum1
        mov ebx, eax ; Guardar el primer número en ebx

        ; Convertir el segundo número de texto a entero
        mov ecx, num2
        call str2intNum2
        add ebx, eax ; Sumar el segundo número al primero

        ; Imprimir el resultado
        call print_result
        jmp main_loop

residuo:

        ; Mensaje indicando la operacion a realizar
        mov eax, 4
        mov ebx, 1
        mov ecx, msg_mod
        mov edx, 23
        int 0x80

        ; Mensaje para el ingreso del numero 1
        mov eax, 4
        mov ebx, 1
        mov ecx, msg_num1
        mov edx, 25 ; Longitud del mensaje Ingrese el primer numer
        int 0x80

        ; Leer el primer número
        mov eax, 3
        mov ebx, 0
        mov ecx, num1
        mov edx, 10
        int 0x80

        ; Mensaje para el ingreso del numero 2
        mov eax, 4
        mov ebx, 1
        mov ecx, msg_num2
        mov edx, 26 ; Longitud del mensaje opciones
        int 0x80

       ; Leer el segundo número
        mov eax, 3
        mov ebx, 0
        mov ecx, num2
        mov edx, 10
        int 0x80

        ; Convertir los números de texto a enteros
        mov ecx, num1
        call str2intNum1
        mov ebx, eax ; Guardar el primer número en ebx

        ; Convertir el segundo número de texto a entero
        mov ecx, num2
        call str2intNum2
        add ebx, eax ; Sumar el segundo número al primero

        ; Imprimir el resultado
        mov eax, edx
        call print_result
        jmp main_loop

salir:
        ; Salir del programa
        mov eax, 1
        xor ebx, ebx
        int 0x80


; Función para convertir una cadena a un entero
str2intNum1:
        mov eax, 0
        mov ecx, 10
        mov esi, num1 ; Dirección del buffer que contiene el número
        next_char1:
                movzx edx, byte [esi]
                cmp edx, '0'
                jl end_str2intNum1
                cmp edx, '9'
                jg end_str2intNum1
                sub edx, '0'
                imul eax, ecx
                add eax, edx
                inc esi
                jmp next_char1
        end_str2intNum1:
                ret


; Función para convertir una cadena a un entero
str2intNum2:
        mov eax, 0
        mov ecx, 10
        mov esi, num2 ; Dirección del buffer que contiene el número 2
        next_char2:
                movzx edx, byte [esi]
                cmp edx, '0'
                jl end_str2intNum2
                cmp edx, '9'
                jg end_str2intNum2
                sub edx, '0'
                imul eax, ecx
                add eax, edx
                inc esi
                jmp next_char2
        end_str2intNum2:
                ret


; Función para convertir un entero a una cadena
int2str:
        mov ecx, resultado ; Dirección del buffer que contiene el resultado
        mov ebx, eax ; Valor a convertir
        mov eax, 0
        next_digit:
                xor edx, edx
                div ecx
                add dl, '0'
                dec ecx
                mov [ecx], dl
                test ebx, ebx
                jnz next_digit
                ret


print_result:
        ; Imprimir el mensaje de resultado
        mov eax, 4
        mov ebx, 1
        mov ecx, msg_resultado
        mov edx, 16
        int 0x80

        ; Convertir el resultado a cadena y mostrar
        mov eax, ebx ; El resultado está en ebx
        call int2str ; Convertir el entero a cadena

        ; Imprimir la cadena resultante
        mov eax, 4
        mov ebx, 1
        mov ecx, resultado ; Dirección del buffer que contiene el resultado
        mov edx, 128       ; Longitud máxima del resultado
        int 0x80

        ret





section .bss
        buffer resb 128 ; Reserva un buffer de 128 bytes
        num1 resb 16    ; Buffer para el primer número
        num2 resb 16    ; Buffer para el segundo número
        result resb 16  ; Buffer para el resultado

section .data
        mensaje db 'Seleccione una opcion: ', 0xA
        opciones db '1. Suma - 2. Resta - 3. Multiplicacion - 4. Division - 5. Residuo', 0xA
        entrada_num db 'Ingrese el primer numero: ', 0xA
        segundo_num db 'Ingrese el segundo numero: ', 0xA
        resultado_msg db 'El resultado es: ', 0xA

section .text
        global _start

_start:
        ; Mostrar el menú de opciones
        mov eax, 4          ; Número de llamada del sistema sys_write
        mov ebx, 1          ; Descriptor de archivo 1 (stdout)
        mov ecx, mensaje    ; Dirección del mensaje
        mov edx, 24         ; Longitud del mensaje
        int 0x80

        mov eax, 4
        mov ebx, 1
        mov ecx, opciones
        mov edx, 90
        int 0x80

        ; Leer la opción ingresada
        mov eax, 3
        mov ebx, 0
        mov ecx, buffer
        mov edx, 1          ; Leer solo un carácter (opción)
        int 0x80

        ; Convertir el carácter a su valor numérico
        sub byte [buffer], '0'

        ; Comparar la opción y saltar a la función correspondiente
        cmp byte [buffer], 1
        je sumar
        cmp byte [buffer], 2
        je restar
        cmp byte [buffer], 3
        je multiplicar
        cmp byte [buffer], 4
        je dividir
        cmp byte [buffer], 5
        je residuo

sumar:
        ; Pedir los números
        call leer_numeros

        ; Realizar la suma
        mov eax, [num1]
        add eax, [num2]

        ; Guardar el resultado
        mov [result], eax

        ; Mostrar el resultado
        call mostrar_resultado
        jmp salir

restar:
        ; Pedir los números
        call leer_numeros

        ; Realizar la resta
        mov eax, [num1]
        sub eax, [num2]

        ; Guardar el resultado
        mov [result], eax

        ; Mostrar el resultado
        call mostrar_resultado
        jmp salir

multiplicar:
        ; Implementar la multiplicación aquí

dividir:
        ; Implementar la división aquí

residuo:
        ; Implementar el residuo aquí

leer_numeros:
        ; Leer el primer número
        mov eax, 4
        mov ebx, 1
        mov ecx, entrada_num
        mov edx, 26
        int 0x80

        mov eax, 3
        mov ebx, 0
        mov ecx, num1
        mov edx, 16
        int 0x80

        ; Convertir el primer número
        call convertir_a_numero
        mov [num1], eax

        ; Leer el segundo número
        mov eax, 4
        mov ebx, 1
        mov ecx, segundo_num
        mov edx, 26
        int 0x80

        mov eax, 3
        mov ebx, 0
        mov ecx, num2
        mov edx, 16
        int 0x80

        ; Convertir el segundo número
        call convertir_a_numero
        mov [num2], eax
        ret

convertir_a_numero:
        ; Convierte el número leído (en formato ASCII) a un valor numérico
        xor eax, eax
        xor ebx, ebx
convertir_loop:
        mov bl, byte [ecx]
        cmp bl, 0xA        ; Verificar si es salto de línea
        je convertir_fin
        sub bl, '0'
        imul eax, eax, 10
        add eax, ebx
        inc ecx
        jmp convertir_loop
convertir_fin:
        ret

mostrar_resultado:
        ; Mostrar el mensaje de resultado
        mov eax, 4
        mov ebx, 1
        mov ecx, resultado_msg
        mov edx, 17
        int 0x80

        ; Convertir el resultado a formato ASCII y mostrarlo
        mov eax, [result]
        call convertir_a_ascii

        ; Mostrar el resultado convertido
        mov eax, 4
        mov ebx, 1
        mov ecx, result
        mov edx, 16
        int 0x80
        ret

convertir_a_ascii:
        ; Convertir el número en eax a una cadena ASCII en result
        xor ebx, ebx
        mov ecx, result + 15
        mov byte [ecx], 0
convertir_a_ascii_loop:
        xor edx, edx
        div dword [10]     ; Dividir eax por 10
        add dl, '0'
        dec ecx
        mov [ecx], dl
        test eax, eax
        jnz convertir_a_ascii_loop
        ret

salir:
        mov eax, 1
        xor ebx, ebx
        int 0x80

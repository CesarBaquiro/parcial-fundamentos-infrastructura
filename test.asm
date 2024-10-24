section .data
    prompt1 db 'Ingrese el primer numero (o "exit" para salir): ', 0
    prompt2 db 'Ingrese el segundo numero: ', 0
    prompt_op db 'Ingrese la operacion (+, -, *, /): ', 0
    result_msg db 'El resultado es: ', 0
    error_msg db 'Error: Division por cero!', 0
    invalid_input_msg db 'Error: Entrada invalida!', 0
    exit_msg db 'Saliendo...', 0
    newline db 0xA, 0  ; Nueva línea

section .bss
    number1 resb 20     ; Buffer para el primer número (incluyendo espacio para "exit")
    number2 resb 20     ; Buffer para el segundo número
    operation resb 2    ; Buffer para la operación
    result resb 20      ; Buffer para el resultado en ASCII

section .text
    global _start

_start:
    ; Bucle principal para realizar operaciones
main_loop:
    ; Solicitar el primer número
    mov rax, 1
    mov rdi, 1
    mov rsi, prompt1
    mov rdx, 50
    syscall

    ; Leer el primer número
    mov rax, 0
    mov rdi, 0
    mov rsi, number1
    mov rdx, 20
    syscall

    ; Verificar si el usuario desea salir
    mov rsi, number1
    call check_exit
    cmp rax, 1          ; Si rax es 1, se quiere salir
    je exit_program

    ; Solicitar el segundo número
    mov rax, 1
    mov rdi, 1
    mov rsi, prompt2
    mov rdx, 30
    syscall

    ; Leer el segundo número
    mov rax, 0
    mov rdi, 0
    mov rsi, number2
    mov rdx, 20
    syscall

    ; Solicitar la operación
    mov rax, 1
    mov rdi, 1
    mov rsi, prompt_op
    mov rdx, 40
    syscall

    ; Leer la operación
    mov rax, 0
    mov rdi, 0
    mov rsi, operation
    mov rdx, 2
    syscall

    ; Convertir los números de ASCII a enteros
    mov rsi, number1
    call ascii_a_entero
    cmp rax, 0          ; Verifica si la conversión fue exitosa
    jl invalid_input     ; Si rax < 0, fue una entrada inválida
    mov rbx, rax        ; Guardar el primer número en rbx

    mov rsi, number2
    call ascii_a_entero
    cmp rax, 0          ; Verifica si la conversión fue exitosa
    jl invalid_input     ; Si rax < 0, fue una entrada inválida
    mov rcx, rax        ; Guardar el segundo número en rcx

    ; Realizar la operación
    mov al, [operation]
    cmp al, '+'         ; Suma
    je suma
    cmp al, '-'         ; Resta
    je resta
    cmp al, '*'         ; Multiplicación
    je multiplicacion
    cmp al, '/'         ; División
    je division

    ; Si la operación no es válida, volver a imprimir el mensaje de entrada inválida
    jmp invalid_input

suma:
    add rbx, rcx
    jmp imprimir_resultado

resta:
    sub rbx, rcx
    jmp imprimir_resultado

multiplicacion:
    imul rbx, rcx
    jmp imprimir_resultado

division:
    cmp rcx, 0
    je error_division
    xor rdx, rdx        ; Limpiar rdx antes de la división
    idiv rcx            ; Dividir rbx entre rcx
    jmp imprimir_resultado

error_division:
    ; Mostrar mensaje de error
    mov rax, 1
    mov rdi, 1
    mov rsi, error_msg
    mov rdx, 30
    syscall
    jmp main_loop       ; Regresar al inicio del bucle principal

imprimir_resultado:
    ; Mostrar el resultado
    mov rsi, rbx
    call int_to_string
    mov rax, 1
    mov rdi, 1
    mov rsi, result
    mov rdx, 20
    syscall

    ; Nueva línea
    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

    jmp main_loop       ; Regresar al inicio del bucle principal

invalid_input:
    ; Mostrar mensaje de entrada inválida
    mov rax, 1
    mov rdi, 1
    mov rsi, invalid_input_msg
    mov rdx, 30
    syscall
    jmp main_loop       ; Regresar al inicio del bucle principal

exit_program:
    ; Mostrar mensaje de salida
    mov rax, 1
    mov rdi, 1
    mov rsi, exit_msg
    mov rdx, 20
    syscall

    ; Salir del programa
    mov rax, 60
    xor rdi, rdi
    syscall

; Función: ascii_a_entero
; Convierte una cadena de caracteres ASCII a un entero en rax
ascii_a_entero:
    xor rax, rax        ; Limpiar rax (resultado)
    xor rbx, rbx        ; Limpiar rbx (acumulador)
    mov rdi, rsi        ; Puntero a la cadena de entrada

convertir_loop:
    mov al, [rdi]       ; Leer el siguiente carácter
    cmp al, 0           ; Verificar si es el fin de la cadena
    je fin_conversion
    cmp al, '0'
    jl fin_conversion    ; Salir si no es un dígito
    cmp al, '9'
    jg fin_conversion    ; Salir si no es un dígito
    sub al, '0'         ; Convertir de ASCII a número
    imul rbx, rbx, 10   ; Multiplicar acumulador por 10
    add rbx, rax        ; Sumar el dígito al acumulador
    inc rdi             ; Avanzar al siguiente carácter
    jmp convertir_loop

fin_conversion:
    mov rax, rbx        ; Devolver el número convertido
    ret

; Función: int_to_string
; Convierte el entero en RAX a una cadena ASCII en RDI
int_to_string:
    test rax, rax
    jz es_cero           ; Si el número es cero, maneja esto
    mov rdi, result     ; Preparar el puntero para la cadena de resultado
    xor rcx, rcx        ; Contador de caracteres
convertir_loop_2:
    xor rdx, rdx         ; Limpiar el residuo
    mov rbx, 10          ; Divisor para la conversión a ASCII
    div rbx              ; Dividir rax entre 10
    add dl, '0'          ; Convertir el residuo en un carácter ASCII
    push rdx             ; Almacenar el carácter en la pila
    inc rcx              ; Contar el carácter
    test rax, rax        ; Verificar si rax es 0
    jnz convertir_loop_2 ; Si no, repetir

    ; Escribir los caracteres en el buffer
    mov rbx, rcx         ; Número de caracteres
pop_loop:
    pop rax              ; Recuperar el carácter de la pila
    mov [rdi], al        ; Guardar el carácter en el resultado
    inc rdi              ; Mover el puntero hacia adelante
    dec rbx
    jnz pop_loop

    mov byte [rdi], 0    ; Añadir terminador nulo
    ret

es_cero:
    mov byte [result], '0'  ; Si el número es 0, poner '0'
    mov byte [result + 1], 0 ; Añadir terminador nulo
    ret

; Función: check_exit
; Verifica si el usuario ha escrito "exit"
check_exit:
    mov rsi, number1     ; Puntero a la cadena
    mov rdi, exit_msg
    mov rbx, 4           ; Longitud de "exit"
    mov rdx, 0           ; Inicializa rdx en 0
next_char:
    cmp byte [rsi + rdx], [rdi + rdx] ; Comparar caracteres
    jne not_exit
    inc rdx
    cmp rdx, rbx
    jl next_char
    mov rax, 1          ; Indicar que se desea salir
    ret
not_exit:
    xor rax, rax        ; Indicar que no se desea salir
    ret

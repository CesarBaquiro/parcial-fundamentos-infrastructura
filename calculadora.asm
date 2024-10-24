section .bss
    buffer resb 128 ; Reserva un buffer de 128 bytes

section .data
    mensaje db 'Seleccione una opcion: ', 0xA ; Mensaje a mostrar seguido de un salto de línea
    opciones db ' 1. Suma - 2. Resta - 3. Multiplicacion - 4. Division - 5. Residuo de una division ', 0xA ; Opciones
    fin db 0 ; Terminador nulo

section .text
    global _start

_start:
    ; Escribir el mensaje en la consola
    mov eax, 4          ; Número de llamada del sistema sys_write
    mov ebx, 1          ; Descriptor de archivo 1 (stdout)
    mov ecx, mensaje    ; Dirección del mensaje que se va a escribir
    mov edx, 24         ; Longitud del mensaje (24 bytes)
    int 0x80

    ; Escribir las opciones en la consola
    mov eax, 4
    mov ebx, 1
    mov ecx, opciones
    mov edx, 90         ; Longitud del mensaje opciones

    int 0x80            ; Interrupción para hacer la llamada al sistema

    ; Leer del teclado
    mov eax, 3          ; Número de llamada del sistema sys_read
    mov ebx, 0          ; Descriptor de archivo 0 (stdin)
    mov ecx, buffer     ; Dirección del buffer donde almacenar la entrada
    mov edx, 128        ; Número máximo de bytes a leer
    int 0x80            ; Interrupción para hacer la llamada al sistema

    ; Escribir la entrada leída en la consola
    mov eax, 4          ; Número de llamada del sistema sys_write
    mov ebx, 1          ; Descriptor de archivo 1 (stdout)
    mov ecx, buffer     ; Dirección del buffer que contiene la entrada
    mov edx, 128        ; Longitud máxima a escribir
    int 0x80            ; Interrupción para hacer la llamada al sistema

    ; Salir
    mov eax, 1          ; Número de llamada del sistema sys_exit
    xor ebx, ebx        ; Código de salida 0
    int 0x80

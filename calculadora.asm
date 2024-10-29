section .data


        ; Mensajes

        mensaje            db              10,'Seleccione una opcion:',0
        lmensaje           equ             $ - mensaje

        msg_num1            db              10,'Numero 1: ',0
        lmsg_num1           equ             $ - msg_num1

        msg_num2            db              'Numero 2: ',0
        lmsg_num2           equ             $ - msg_num2

        opciones            db              10,'1. Suma - 2. Resta - 3. Multiplicacion - 4. Division - 5. Residuo de una division - 6. Salir',10,0
        lopciones           equ             $ - opciones


        msg_suma db '---SUMAR---', 10,0
        lmsg_suma equ $ - msg_suma

        msg_resta db '---RESTAR---', 10,0
        lmsg_resta equ $ - msg_resta
        
        msg_mult db '---MULTIPLICAR---', 10,0
        lmsg_mult equ $ - msg_mult
        
        msg_div db '---DIVIDIR---', 10,0
        lmsg_div equ $ - msg_div
        
        msg_mod db '---CALCULAR RESIDUO---', 10,0
        lmsg_mod equ $ - msg_mod

        msg_resultado            db              10,'El resultado es: ',0
        lmsg_resultado           equ             $ - msg_resultado


section .bss
        opcionSeleccionada:         resb    2
        num1:           resb    2
        num2:           resb    2
        resultado:      resb    2


section .text
        global _start

_start:
main_loop:
        ; Imprimimos en pantalla el mensaje 1
        mov eax, 4
        mov ebx, 1
        mov ecx, mensaje
        mov edx, lmensaje
        int 80h

        ; Imprimimos en pantalla el mensaje 1
        mov eax, 4
        mov ebx, 1
        mov ecx, opciones
        mov edx, lopciones
        int 80h

        ; Leer del teclado
        mov ebx, 0
        mov ecx, opcionSeleccionada
        mov edx, 2
        mov eax, 3
        int 80h

        mov ah, [opcionSeleccionada]        ; Movemos la opcion seleccionada a el registro AH
        sub ah, '0'             ; Convertimos el valor ingresado de ascii a decimal

        ; Comparamos la opcion seleccionada para saber que operacion realizar.
        ; JE = Jump if equal = Saltamos si el valor comparado es igual

        cmp ah, 1
        je sumar

        cmp ah, 2
        je restar

        cmp ah, 3
        je multiplicar

        cmp ah, 4
        je dividir

        cmp ah, 5
        je residuo

        cmp ah, 6
        je salir

        jmp main_loop ; Volver al inicio si la opción no es válida

sumar:

        ; Mensaje indicando la operacion a realizar
        mov eax, 4
        mov ebx, 1
        mov ecx, msg_suma
        mov edx, lmsg_suma
        int 80h

        ; Mensaje para el ingreso del numero 1
        mov eax, 4
        mov ebx, 1
        mov ecx, msg_num1
        mov edx, lmsg_num1 ; Longitud del mensaje Ingrese el primer numer
        int 80h

        ; Leer el primer número
        mov eax, 3
        mov ebx, 0
        mov ecx, num1
        mov edx, 2
        int 80h

        ; Mensaje para el ingreso del numero 2
        mov eax, 4
        mov ebx, 1
        mov ecx, msg_num2
        mov edx, lmsg_num2 ; Longitud del mensaje opciones
        int 80h

        ; Leer el segundo número
        mov eax, 3
        mov ebx, 0
        mov ecx, num2
        mov edx, 2
        int 80h

                ; Imprimimos en pantalla el mensaje de resultado
        mov eax, 4
        mov ebx, 1
        mov ecx, msg_resultado
        mov edx, lmsg_resultado
        int 80h

        ; Movemos los numeros ingresados a los registro AL y BL
        mov al, [num1]
        mov bl, [num2]

        ; Convertimos los valores ingresados de ascii a decimal
        sub al, '0'
        sub bl, '0'

        ; Sumamos el registro AL y BL
        add al, bl

        ; Convertimos el resultado de la suma de decimal a ascii
        add al, '0'

        ; Movemos el resultado a un espacio reservado en la memoria
        mov [resultado], al

        ; Imprimimos en pantalla el resultado
        mov eax, 4
        mov ebx, 1
        mov ecx, resultado
        mov edx, 2
        int 80h

        jmp main_loop

restar:

        ; Mensaje indicando la operacion a realizar
        mov eax, 4
        mov ebx, 1
        mov ecx, msg_resta
        mov edx, lmsg_resta
        int 80h

       ; Mensaje para el ingreso del numero 1
        mov eax, 4
        mov ebx, 1
        mov ecx, msg_num1
        mov edx, lmsg_num1 ; Longitud del mensaje Ingrese el primer numer
        int 80h

        ; Leer el primer número
        mov eax, 3
        mov ebx, 0
        mov ecx, num1
        mov edx, 2
        int 80h

        ; Mensaje para el ingreso del numero 2
        mov eax, 4
        mov ebx, 1
        mov ecx, msg_num2
        mov edx, lmsg_num2 ; Longitud del mensaje opciones
        int 80h

        ; Leer el segundo número
        mov eax, 3
        mov ebx, 0
        mov ecx, num2
        mov edx, 2
        int 80h

                ; Imprimimos en pantalla el mensaje de resultado
        mov eax, 4
        mov ebx, 1
        mov ecx, msg_resultado
        mov edx, lmsg_resultado
        int 80h

         ; Movemos los numeros ingresados a los registro AL y BL
        mov al, [num1]
        mov bl, [num2]

        ; Convertimos los valores ingresados de ascii a decimal
        sub al, '0'
        sub bl, '0'

        ; Restamos el registro AL y BL
        sub al, bl

        ; Convertimos el resultado de la resta de decimal a ascii
        add al, '0'

        ; Movemos el resultado a un espacio reservado en la memoria
        mov [resultado], al

                ; Imprimimos en pantalla el resultado
        mov eax, 4
        mov ebx, 1
        mov ecx, resultado
        mov edx, 1
        int 80h

        jmp main_loop

multiplicar:

        ; Mensaje indicando la operacion a realizar
        mov eax, 4
        mov ebx, 1
        mov ecx, msg_mult
        mov edx, lmsg_mult
        int 80h

        ; Mensaje para el ingreso del numero 1
        mov eax, 4
        mov ebx, 1
        mov ecx, msg_num1
        mov edx, lmsg_num1 ; Longitud del mensaje Ingrese el primer numer
        int 80h

        ; Leer el primer número
        mov eax, 3
        mov ebx, 0
        mov ecx, num1
        mov edx, 2
        int 80h

        ; Mensaje para el ingreso del numero 2
        mov eax, 4
        mov ebx, 1
        mov ecx, msg_num2
        mov edx, lmsg_num2 ; Longitud del mensaje opciones
        int 80h

        ; Leer el segundo número
        mov eax, 3
        mov ebx, 0
        mov ecx, num2
        mov edx, 2
        int 80h

         ; Imprimimos en pantalla el mensaje de resultado
        mov eax, 4
        mov ebx, 1
        mov ecx, msg_resultado
        mov edx, lmsg_resultado
        int 80h

               ; Movemos los numeros ingresados a los registro AL y BL
        mov al, [num1]
        mov bl, [num2]

        ; Convertimos los valores ingresados de ascii a decimal
        sub al, '0'
        sub bl, '0'

        ; Multiplicamos. AX = AL X BL
        mul bl

        ; Convertimos el resultado de la resta de decimal a ascii
        add ax, '0'

        ; Movemos el resultado a un espacio reservado en la memoria
        mov [resultado], ax

        ; Imprimimos en pantalla el resultado
        mov eax, 4
        mov ebx, 1
        mov ecx, resultado
        mov edx, 1
        int 80h

        jmp main_loop

dividir:

        ; Mensaje indicando la operacion a realizar
        mov eax, 4
        mov ebx, 1
        mov ecx, msg_div
        mov edx, lmsg_div
        int 80h

        ; Mensaje para el ingreso del numero 1
        mov eax, 4
        mov ebx, 1
        mov ecx, msg_num1
        mov edx, lmsg_num1 ; Longitud del mensaje Ingrese el primer numer
        int 80h

        ; Leer el primer número
        mov eax, 3
        mov ebx, 0
        mov ecx, num1
        mov edx, 2
        int 80h

        ; Mensaje para el ingreso del numero 2
        mov eax, 4
        mov ebx, 1
        mov ecx, msg_num2
        mov edx, lmsg_num2 ; Longitud del mensaje opciones
        int 80h

        ; Leer el segundo número
        mov eax, 3
        mov ebx, 0
        mov ecx, num2
        mov edx, 2
        int 80h

         ; Imprimimos en pantalla el mensaje de resultado
        mov eax, 4
        mov ebx, 1
        mov ecx, msg_resultado
        mov edx, lmsg_resultado
        int 80h

               ; Movemos los numeros ingresados a los registro AL y BL
        mov al, [num1]
        mov bl, [num2]

        ; Igualamos a cero los registros DX y AH
        mov dx, 0
        mov ah, 0

        ; Convertimos los valores ingresados de ascii a decimal
        sub al, '0'
        sub bl, '0'

        ; Division. AL = AX / BL. AX = AH:AL
        div bl

        ; Convertimos el resultado de la resta de decimal a ascii
        add ax, '0'

        ; Movemos el resultado a un espacio reservado en la memoria
        mov [resultado], ax

        ; Imprimimos en pantalla el resultado
        mov eax, 4
        mov ebx, 1
        mov ecx, resultado
        mov edx, 1
        int 80h

        jmp main_loop

residuo:

        ; Mensaje indicando la operacion a realizar
        mov eax, 4
        mov ebx, 1
        mov ecx, msg_mod
        mov edx, lmsg_mod
        int 80h

        ; Mensaje para el ingreso del numero 1
        mov eax, 4
        mov ebx, 1
        mov ecx, msg_num1
        mov edx, lmsg_num1 ; Longitud del mensaje Ingrese el primer numer
        int 80h

        ; Leer el primer número
        mov eax, 3
        mov ebx, 0
        mov ecx, num1
        mov edx, 2
        int 80h

        ; Mensaje para el ingreso del numero 2
        mov eax, 4
        mov ebx, 1
        mov ecx, msg_num2
        mov edx, lmsg_num2 ; Longitud del mensaje opciones
        int 80h

        ; Leer el segundo número
        mov eax, 3
        mov ebx, 0
        mov ecx, num2
        mov edx, 2
        int 80h

                ; Imprimimos en pantalla el mensaje de resultado
        mov eax, 4
        mov ebx, 1
        mov ecx, msg_resultado
        mov edx, lmsg_resultado
        int 80h

         ; Movemos los numeros ingresados a los registro AL y BL
        mov al, [num1]
        mov bl, [num2]

        ; Convertimos los valores ingresados de ascii a decimal
        sub al, '0'
        sub bl, '0'

        ; Sumamos el registro AL y BL
        add al, bl

        ; Convertimos el resultado de la suma de decimal a ascii
        add al, '0'

        ; Movemos el resultado a un espacio reservado en la memoria
        mov [resultado], al

        ; Imprimimos en pantalla el resultado
        mov eax, 4
        mov ebx, 1
        mov ecx, resultado
        mov edx, 2
        int 80h

        jmp main_loop

salir:
        ; Salir del programa
        mov eax, 1
        xor ebx, ebx
        int 80h



;Desarrolladores
;El ingeeee Daniel Gonzalez
;El tech Cesar Baquiro

section .bss
	buffer resb 128

section .text
	global _start

_start:
	;Leer el teclado
	mov eax 3 ;Llamada al sistema sys_read
	mov ebx, 0 ; Descriptor de archivo stdin
	mov ecx, buffer ; Dirección del buffer
	mov edx, 128 ; Tamaño máximo a leer
	int 0x80 ; In

	mov ebx, 1 ; Descriptor de archivo stdout

print_result:
	; Salir
	mov eax, 1 ; Llamada al sistema sys_exit
	xor ebx, ebx ; Código de salida 0
	int 0x80

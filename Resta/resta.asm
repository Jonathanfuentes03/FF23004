section .data
    num1    dw 100         ; Primer número
    num2    dw 15         ; Segundo número
    num3    dw 25          ; Tercer número
    newline db 10, 0

section .bss
    buffer  resb 16       ; Para conversión de entero a string

section .text
    global _start

_start:
    ; Cargar números en registros de 16 bits
    mov ax, [num1]
    sub ax, [num2]
    sub ax, [num3]
    ; Resultado final en AX

    ; Convertir AX a 32 bits para impresión
    movsx eax, ax        ; Sign-extend AX → EAX

    ; Convertir a cadena
    call int_to_str

    ; Imprimir
    call print_buffer

    ; Salto de línea
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    ; Salida del programa
    mov eax, 1
    xor ebx, ebx
    int 0x80

; ----------------------------
; int_to_str - convierte EAX a cadena en buffer
; ----------------------------
int_to_str:
    mov edi, buffer + 15
    mov byte [edi], 0
    cmp eax, 0
    jge .loop
    neg eax
    mov bl, '-'
    jmp .loop

.loop:
    xor edx, edx
    mov ecx, 10
.next:
    div ecx
    add dl, '0'
    dec edi
    mov [edi], dl
    xor edx, edx
    test eax, eax
    jnz .next

    cmp bl, '-'
    jne .done
    dec edi
    mov [edi], bl

.done:
    mov esi, edi
    ret

; ----------------------------
; print_buffer - imprime el valor en ESI
; ----------------------------
print_buffer:
    mov eax, 4
    mov ebx, 1
    mov ecx, esi
    mov edx, 0

.count:
    cmp byte [ecx + edx], 0
    je .print
    inc edx
    jmp .count

.print:
    int 0x80
    ret

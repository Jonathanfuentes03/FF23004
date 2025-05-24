section .data
    num1    db 7             ; Primer número (8 bits)
    num2    db 9             ; Segundo número (8 bits)
    newline db 10, 0

section .bss
    buffer  resb 16

section .text
    global _start

_start:
    ; Cargar números de 8 bits
    mov al, [num1]
    mov bl, [num2]

    ; Multiplicación (resultado en AX = AL * BL)
    mul bl                  ; unsigned: AL * BL → AX

    ; Guardar resultado en AX → copiar a EAX para convertir
    movzx eax, ax           ; expandir AX a EAX para imprimir

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

    ; Salir
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
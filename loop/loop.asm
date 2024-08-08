section .data

    ; String terminada em \0 a ser impressa...
    msg db 'Maria tinha um carneirinho, sua lã era branca como a neve.', 10, 0

section .bss

    pstr resb 8     ; ponteiro de 8 bytes para receber endereços 64 bits.
    char resb 1     ; ponteiro de 1 byte para receber caracteres.

section .text

    global _start

_start:

    mov rax, msg    ; precisamos do endereço da mensagem em rax
    call print_str  ; chamada da sub-rotina

_exit:

    mov rax, 60
    mov rdi, 0
    syscall

; -----------------------------------------------------------------------------
; Lê e imprime caracteres da string no endereço em rax até encontrar \0
; -----------------------------------------------------------------------------
; Uso: mov rax, MEM
;      call print_str
; -----------------------------------------------------------------------------
print_str:
    .loop:
        mov cl, byte [rax]  ; move para cl o byte no endereço em rax
        cmp cl, 0           ; compara byte em cl com zero (\0)
        je .endsub          ; se igual, sai da sub-rotina...
        mov [char], cl      ; salva o byte em char
        mov [pstr], rax     ; registra o endereço da mensagem em pstr
        mov rsi, char       ; passa o endereço de char para rsi       
        call write_char     ; imprime caractere
        mov rax, [pstr]     ; recupera o endereço da mensagem em pstr
        inc rax             ; incrementa o endereço da mensagem em rax
        jmp .loop           ; repete...
    .endsub:
    ret

; -----------------------------------------------------------------------------
; Escreve na saída padrão o caractere (byte) em rsi
; -----------------------------------------------------------------------------
; Uso: mov rsi, MEM
;      call write_char
; -----------------------------------------------------------------------------
write_char:
    mov rax, 1      ; chamada de sistema sys_write
    mov rdi, rax    ; escreve em stdout
    mov rdx, 1      ; imprime apenas 1 byte
    syscall
    ret             ; salta para a linha seguinte à chamada




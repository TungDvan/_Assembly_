;nasm -f elf print.asm
;ld -m elf_i386 -s -o print print.o
;./print

section .data
    msg db 'Hello World!', 10       ; Chuoi 'Hellop World!', '\n' (vi trong ASCII '\n' = 10)
    len equ $-msg                   ; Chieu dai cua chuoi   

section .text
    global _start

_start:
    mov eax, 4                      ; [4] Che do Write
    mov ebx, 1                      ; [1] stdout
    mov ecx, msg                    
    mov edx, len
    int 0x80                        ; Call

_last:
    mov eax, 1                      ; [1] Che do Exit
    int 0x80                        ; Call                          
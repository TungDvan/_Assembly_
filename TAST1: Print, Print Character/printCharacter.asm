;nasm -f elf printCharacter.asm
;ld -m elf_i386 -s -o printCharacter printCharacter.o
;./printCharacter

section .data
    msg1 db 'Input: '
    len1 equ $-msg1

    msg2 db 'Output: '
    len2 equ $-msg2

    newLine db 10
    lenNewLine equ $-newLine

section .bss 
    msg3 resb 100
    len3 resb 100

section .text
    global _start

_start:
    ;Hien 'Input: '
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, len1
    int 0x80

    ;Nhap tu ban phim
    mov eax, 3
    mov ebx, 0
    mov ecx, msg3
    mov edx, 100
    int 0x80
    mov [len3], eax

    ;Hien Output
    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, len2
    int 0x80

    ;Xu ly bai toan
    xor esi, esi
    
    step1:
    cmp esi, [len3]
    jge _last
    mov ecx, msg3
    add ecx, esi
    cmp byte [ecx], 'A'
    jl step2
    cmp byte [ecx], 'Z'
    jle print
    cmp byte [ecx], 'a'
    jl step2
    cmp byte [ecx], 'z'
    jle print
    jmp step2

_last:
    mov eax, 4
    mov ebx, 1
    mov ecx, newLine
    mov edx, lenNewLine
    int 0x80

    mov eax, 1
    int 0x80

print:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg3
    add ecx, esi
    mov edx, 1
    int 0x80

    inc esi
    jmp step1

step2:
    inc esi
    jmp step1

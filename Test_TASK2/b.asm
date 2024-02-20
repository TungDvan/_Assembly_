section .data
    msg db "Nhap so nguyen am n: "
    len equ $-msg

    n db '0'
    tmp dd 0

section .text
global _start

_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, len
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, n
    mov edx, 100
    int 0x80

    sub eax, 1
    mov ebx, ecx
    mov ecx, eax
    call _stringToNum

    mov dword [tmp], eax

    mov eax, 1
    mov ebx, dword [tmp]
    int 0x80


_stringToNum:   ;numlen: ecx        string: ebx
    xor eax, eax
    xor edx, edx
    xor esi, esi

    sub ecx, 1
    add esi, 1

    LOOP:
        mov edx, 10
        mul edx
        mov dl, [ebx + esi]
        sub dl, '0'
        add eax, edx
        add esi, 1
        loop LOOP

    mov edx, 0xffffffff
    sub edx, eax
    mov eax, edx
    
    xor esi, esi
    ret; eax = number




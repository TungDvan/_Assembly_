_printArr:

    mov esi, 0
    Looq:
        mov eax, dword [arr + 4 * esi]
        call _numToString

        mov eax, 0x4
        mov ebx, 0x1
        mov ecx, num2
        mov edx, ebp
        int 0x80

        mov eax, 0x4
        mov ebx, 0x1
        mov ecx, blankSpace
        mov edx, 0x1
        int 0x80

        inc esi
        cmp esi, [count]
        jne Looq

    mov eax, 0x4
    mov ebx, 0x1
    mov ecx, endLine
    mov edx, 0x1
    int 0x80

    ret
;INPUT: numLen = ECX, string = EBX
;OUTPUT: number = EAX

_stringToNum: ; Numlen: ecx, String: ebx
    xor edx, edx    
    xor eax, eax
    xor esi, esi

    mov dl, [ebx + esi]
    cmp dl, [minus]   
    jne continu3
    inc esi
    dec ecx
    mov [flag], esi
    continu3:
    L0OP:
        mov edx, 0xa
        mul edx
        mov dl, [ebx + esi]
        sub edx, 0x30
        add eax, edx
    inc esi
    loop L0OP

    mov esi, [flag]
    cmp esi, 0x1
    jne c0ntinu3
        mov ecx, 0xffffffff
        sub ecx, eax
        mov eax, ecx
    c0ntinu3:
    xor esi, esi
ret     ;
;INPUT: number = EAX
;OUTPUT: string = [num2]
;           len = ebp

_numToString: ;ARGS(int(EAX))
    mov ecx, 0

    mov [flag], ecx
    cmp eax, 2147483648
    jna c0nt1nu3
        inc ecx
        mov edx, 0x1
        mov [flag], edx
        mov edx, 0xffffffff
        sub edx, eax
        mov eax, edx
    c0nt1nu3:

    execute:
        xor edx, edx
        mov ebx, 10
        div ebx
        add edx, 0x30
        push edx
        inc ecx
    cmp eax, 0

    jne execute

    mov edx, 0x1
    cmp [flag], edx
    jne Cont1nue
        mov dl, [minus]
        push edx
    Cont1nue:

    mov ebp, 0
    L00P:
        pop edx
        mov [num2 + ebp], edx
        inc ebp
    loop L00P
ret
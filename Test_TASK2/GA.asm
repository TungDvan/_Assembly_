_getArray: ; edi = 0 (danh dau arr[edi])

    mov [cnt], ecx      ;[cnt]: so luong phan tu trong mang

    mov eax, 0x4            ;
    mov ebx, 0x1            ;
    mov ecx, msg2           ; Hien "Nhap n so nguyen"
    mov edx, length2        ;
    int 0x80                ; 

    LO0P:

        mov eax, 0x4        ;
        mov ebx, 0x1        ;
        mov ecx, msg3       ; Hien "arr["
        mov edx, msgLen3    ;
        int 0x80            ;

        xor eax, eax
        mov eax, edi
        call _numToString   ;input: number = eax
                            ;output: string = [num2]


        ; mov [num2], eax

        mov eax, 0x4        ;
        mov ebx, 0x1        ;
        mov ecx, num2       ; hien 'n'
        mov edx, 0x4        ;
        int 0x80            ;

        mov eax, 0x4        ;
        mov ebx, 0x1        ;
        mov ecx, msg4       ; Hien ']'
        mov edx, msgLen4    ;
        int 0x80            ;

        mov eax, 0x3        ;
        mov ebx, 0x0        ;
        mov ecx, Ai         ; nhap so arr[esi]
        mov edx, 0xa        ;
        int 0x80            ;

        dec eax             ;
        mov ebx, ecx        ;
        mov ecx, eax        ;
        call _stringToNum   ; Input     lenNum = ecx
                            ;           string = ebx
                            ; Output    number = eax

        mov dword [arr + 4 * edi], eax ; arr[edi] = _stringToNum(input)
        ; xor eax, eax
        ; mov eax, dword [arr + 4*edi] ; arr[edi] = _stringToNum(input)

        inc edi 
        cmp edi, [count]
        jne LO0P
    ret
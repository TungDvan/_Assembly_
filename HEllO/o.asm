section .data
    msg1 db 'Nhap so n: '
    len1 equ $-msg1

    msg2 db 'So n: '
    len2 equ $-msg2

    endLine db 0xa
    lenEnd equ $-endLine

    number dw 0                 ;
    dau db 0                    ; 0 la so duong, 1 la so am
    string times 35 db '', 0    ;


section .text
    global _start:

_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, len1
    int 0x80

    mov eax, 3
    mov ebx, 1
    mov ecx, string
    mov edx, 0x23           ; 0x23 = 35
    int 0x80

    sub eax, 1
    mov ebx, ecx
    mov ecx, eax
    call _stringToNum
    ; input: string = ecx, lenNum = ecx
    ; output: number = eax   

    mov dword [number], eax
    xor eax, eax
    mov eax, dword [number]

    call _numToString
    ; input: number = eax
    ; output: string, lenNum = esi

    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, len2
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, string
    mov edx, esi
    int 0x80   

    mov eax, 4
    mov ebx, 1
    mov ecx, endLine
    mov edx, lenEnd
    int 0x80

    call _end

_stringToNum:
    ; input: string = ebx, lenNum = ecx
    ; output: number = eax
    xor eax, eax
    xor esi, esi

    ; esi la danh dau ki tu thu x
    ; eax luu gia tri
    ; edx luu he so 10 va gia tri cua ki tu

    mov byte [dau], 0x0     ; danh dau la so duong
    cmp byte [ebx], 0x2d    ; 0x2d = '-'
    jne step1
    add esi, 1              ; 1 la am, 0 la duong
    mov byte [dau], 0x1
    step1:
        xor edx, edx
        mov edx, 0xa
        mul edx
        mov dl, byte [ebx + esi]
        sub edx, 0x30       ; 0x30 = '0'
        add eax, edx
        add esi, 1
        cmp esi, ecx
        jl step1

    cmp byte [dau], 0x1     ; 1 la am, 0 la duong
    jne step2
    neg eax
    step2:
        xor esi, esi
        xor ecx, ecx
        xor edx, edx
        xor ebx, ebx
ret

_numToString:
    ; input: number = eax
    ; output: string, lenNum = esi
    xor ebx, ebx
    xor ecx, ecx
    xor esi, esi
    
    mov byte [dau], 0x0         ; danh dau la so duong (0)

    test eax, eax
    jns step3                   ; nhay neu khong am
    mov byte [dau], 0x1
    neg eax

    step3:
        xor edx, edx
        mov ebx, 0xa            ; chia lien tiep cho 10
        div ebx
        add edx, 0x30           ; 0x30 = '0'
        push edx
        add ecx, 0x1
        cmp eax, 0x0
        jne step3

    cmp byte [dau], 0x1
    jne step4
    mov edx, 0x2d
    push edx
    add ecx, 0x1

    step4:
        pop edx
        mov [string + esi], edx
        add esi, 1
        cmp esi, ecx
        jl step4

    ;        cmp byte[dau], 0x1
    ;        jne step4
    ;            mov byte [string + esi], 0x2d       ; 0x2d = '-'
    ;            add esi, 1

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
ret

_end:
    mov eax, 1
    int 0x80
section .data
    msg db "Nhap so nguyen duong n: "
    len equ $-msg
    msg1 db "So vua nhap: "
    len1 equ $-msg1


    minus db '-'
    flag db 0  
    

    num dd 0                    ; luu gia tri
    dau db 1                    ; Luu dau (0 duong, 1 am)
    string times 35 db ''       ; luu string        

section .text
global _start

_start:

    ;Hien "Nhap n:"
    mov eax, 4          
    mov ebx, 1           
    mov ecx, msg
    mov edx, len
    int 0x80

    ; Nhap n tu ban phim
    mov eax, 3
    mov ebx, 0
    mov ecx, num
    mov edx, 10
    int 0x80

    ; Chuyen string sang number --> luu voa [num]
    sub eax, 1
    mov ebx, ecx
    mov ecx, eax

    call _stringToNum
    mov dword [num], eax

    ; Hien "So vua nhap: "
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, len1
    int 0x80

    ;Chuyen number --> string (luu vao [string])
    ;xor eax, eax
    mov eax, [num]
    call _numToString

    mov eax, 4
    mov ebx, 1
    mov ecx, string
    mov edx, ebp
    int 0x80
    

    ;Ket thuc chuong trinh
    call _end



_stringToNum: ; Numlen: ecx, String: ebx
    xor edx, edx    
    xor eax, eax
    xor esi, esi
    mov [dau], esi
    cmp byte [ebx], '-'
    jne step1
    add esi, 1
    sub ecx, 1
    mov [dau], esi

    step1:
        mov edx, 10
        mul edx
        mov dl, [ebx + esi]
        sub edx, '0'
        add eax, edx
        add esi, 1
        cmp ecx, esi
        jne step1

    mov esi, [dau]
    cmp esi, 0
    je step2
    neg eax
    step2:
        xor esi, esi
ret

_numToString:
    mov ecx, 0
    mov [dau], ecx

    test eax, eax
    jns step3
    neg eax
    add ecx, 1
    mov [dau], ecx

    step3:
        xor edx, edx
        mov ebx, 10
        div ebx
        add edx, '0'
        push edx
        add ecx, 1
        cmp eax, 0
        jne step3

    mov edx, 1
    cmp [dau], edx
    jne step4
    mov dl, '-'
    push edx
    step4:
        mov ebp, 0
        LOOP:
            pop edx
            mov [string + ebp], edx
            add ebp, 1
        loop LOOP
ret
    
_end:
    mov eax, 1
    int 0x80


    
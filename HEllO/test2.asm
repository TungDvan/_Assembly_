section .data
; string
    msg1 db "Nhap so luong cua mang: "
    len1 equ $-msg1
    msg2 db "Nhap arr["
    len2 equ $-msg2
    msg3 db "]: "
    len3 equ $-msg3
    msg4 db "Mang truoc khi sap xep: "
    len4 equ $-msg4
    msg5 db "Mang sau khi sap xep: "
    len5 equ $-msg5
    endLine db 0xa          ; 0xa = /n
    lenEnd equ $-endLine
    space db 0x20           ; 0x20 = ' '
    lenSpace equ $-space

; variable
    string times 20 db '', 0    ; Chuoi
    number dd 0                 ; Gia tri
    n dd 0                      ; So luong phan tu cua arr
    sign db 0                   ; 0 la am, 1 la duong
    arr times 300 dd '', 0      ; Mang

section .text
global _start

_start:

    mov eax, 0x4                ;
    mov ebx, 0x1                ;
    mov ecx, msg1               ; Hien "Nhap so luong cua mang: "
    mov edx, len1               ;
    int 0x80                    ;

    mov eax, 0x3                ;
    mov ebx, 0x0                ;
    mov ecx, string             ; Nhap n
    mov edx, 0x14   ; 0x14 = 20 ;
    int 0x80                    ;

    sub eax, 0x1
    mov ebx, ecx
    mov ecx, eax
    call _stringToNum
    ; input: string = ebx, lenNum = ecx
    ; output: number = eax
    mov [n], eax
    xor eax, eax

    xor edi, edi                ;
    xor eax, eax                ;
    ;mov eax, [n]               ; Nhap mang arr[]
    ;mov edi, eax               ;
    call _getArr                ;

    mov eax, 0x4                ;
    mov ebx, 0x1                ;
    mov ecx, msg4               ; Hien "Mang truoc khi sap xep: "
    mov edx, len4               ;
    int 0x80                    ;

    xor edi, edi                ;
    xor eax, eax                ; Hien cac phan tu trong mang
    call _printArr              ; 

    mov eax, 0x4                ;
    mov ebx, 0x1                ;
    mov ecx, endLine            ; \n
    mov edx, lenEnd             ;
    int 0x80                    ;

    mov eax, 0x4                ;
    mov ebx, 0x1                ;
    mov ecx, msg5               ; Hien "Mang truoc sau khi sap xep: "
    mov edx, len5               ;
    int 0x80                    ;

    call _selection_Sort
    call _printArr

    mov eax, 0x4                ;
    mov ebx, 0x1                ;
    mov ecx, endLine            ; \n
    mov edx, lenEnd             ;
    int 0x80                    ;

    call _end


_stringToNum:           
; step1, step2
; input: string = ebx, lenNum = ecx
; output: number = eax
    xor eax, eax
    xor esi, esi

    ; esi la danh dau ki tu thu x
    ; eax luu gia tri
    ; edx luu he so 10 va gia tri cua ki tu

    mov byte [sign], 0x0     ; danh dau la so duong
    cmp byte [ebx], 0x2d    ; 0x2d = '-'
    jne step1
    add esi, 1              ; 1 la am, 0 la duong
    mov byte [sign], 0x1
    step1:
        xor edx, edx
        mov edx, 0xa
        mul edx
        mov dl, byte [ebx + esi]
        sub edx, 0x30       ; 0x30 = '0'
        add eax, edx
        add esi, 0x1
        cmp esi, ecx
        jl step1

    cmp byte [sign], 0x1     ; 1 la am, 0 la duong
    jne step2
    neg eax
    step2:
        xor esi, esi
        xor ecx, ecx
        xor edx, edx
        xor ebx, ebx
ret

_numToString:               
; step3, step4
; input: number = eax
; output: string, lenNum = esi
    xor ebx, ebx
    xor ecx, ecx
    xor esi, esi
    
    mov byte [sign], 0x0         ; danh dau la so duong (0)

    test eax, eax
    jns step3                   ; nhay neu khong am
    mov byte [sign], 0x1
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

    cmp byte [sign], 0x1
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

_getArr:
; step5                    
; input: [n]
; output: arr[], edi = 0
    xor ebp, ebp            ; luu gia tri a[ebp] + xac dinh vong lap
    step5:
        mov eax, 0x4                        ;
        mov ebx, 0x1                        ;
        mov ecx, msg2                       ; Hien "Nhap arr["
        mov edx, len2                       ;
        int 0x80                            ;

        mov eax, ebp                        ;
        xor esi, esi                        ;
        call _numToString                   ; ebp -> "ebp"
        ; input: number = eax               ;
        ; output: string, lenNum = esi      ; 

        mov eax, 0x4                        ;
        mov ebx, 0x1                        ;
        mov ecx, string                     ; Hien "ebp"
        mov edx, esi                        ;
        int 0x80                            ;

        mov eax, 0x4                        ;
        mov ebx, 0x1                        ;
        mov ecx, msg3                       ; Hien "]"
        mov edx, len3                       ;
        int 0x80                            ;

        mov eax, 0x3                        ;
        mov ebx, 0x0                        ;
        mov ecx, string                     ; Nhap arr[ebp]
        mov edx, 0x14                       ;
        int 0x80                            ;

        sub eax, 0x1                        ;
        mov ebx, ecx                        ;
        mov ecx, eax                        ; "arr[ebp]" = arr[ebp]
        call _stringToNum                   ;
        ; input: string = ebx, lenNum = ecx ;
        ; output: number = eax              ;


        mov dword [arr + ebp * 4], eax      ; arr[ebp] vao mang
        add ebp, 0x1
        cmp ebp, [n]
        jl step5
    
    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    xor ebp, ebp
    xor edi, edi
ret

_printArr:
; step6
; input: [n],
; output: = NULL
    xor ebp, ebp
    step6:
        mov eax, [arr + ebp * 4]
        call _numToString

        mov eax, 0x4            ;
        mov ebx, 0x1            ;
        mov ecx, string         ; Hien arr[]
        mov edx, esi            ;
        int 0x80                ;

        mov eax, 0x4            ;
        mov ebx, 0x1            ;
        mov ecx, space          ; Hien ' '
        mov edx, lenSpace       ;
        int 0x80                ;

        add ebp, 0x1
        cmp ebp, [n]
        jl step6

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    xor ebp, ebp
ret

_selection_Sort:
    xor eax, eax    ; i
    xor ebx, ebx    ; j
    xor ecx, ecx    ;tmp1
    xor edx, edx    ;tmp2
    xor ebp, ebp    ;tmp3
    xor esi, esi

    ForI:
        cmp eax, [n]
        jge step7       ; neu i >= n --> END
        mov ecx, eax    ; tmp = i    
        mov edx, [arr + eax * 4]    ; tmp2 = a[tmp]

        add eax, 0x1            ;
        mov ebx, eax            ; j = i + 1
        sub eax, 0x1            ;
        
        ForJ:
            cmp ebx, [n]        ; 
            jge step8          ; neu j >= n --> thoat vong J
            cmp edx, [arr + ebx * 4]
            jle step9           ; neu tmp2 <= a[j] --> tiep tuc vong J
            mov ecx, ebx
            mov edx, [arr + 4 * ecx]
            step9:
                add ebx, 0x1
                jmp ForJ

    step8:
        mov ebp, [arr + 4 * eax]
        mov [arr + 4 * eax], edx
        mov [arr + 4 * ecx], ebp    
        add eax, 0x1
        jmp ForI


    step7:
ret

_end:
    mov eax, 0x1
    int 0x80
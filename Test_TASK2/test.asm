section .data
; msg
    msg1 db 'Nhap n: '
    length1 equ $-msg1

    msg2 db 'Nhap n so nguyen', 0xa
    length2 equ $-msg2

    msg3 db 'arr['
    msgLen3 equ $-msg3

    msg4 db '] = '
    msgLen4 equ $-msg4

    msg5 db 'Mang truoc khi sap xep: '
    msgLen5 equ $-msg5

    msg6 db 'Mang sau khi sap xep: '
    msgLen6 equ $-msg6

    blankSpace db ' '

    endLine db 0xa

    minus db '-'

; var
    arr times 400 dd 0
    Ai times 11 db 0        ; Nơi lưu giá trị của mảng
    n db '0'
    cnt dd 0                ; chắc là đánh dấu xem mảng có bao nhiêu phần tử
    count dd 0              ; chắc là đánh dấu sau khi chuyển từ chữ số sang kí tự
    flag db 0               ; đánh dấu số âm hay số dương
    num2 times 35 db ''
    num2Len equ $-num2

section .text
    global _start

; func
_start:
    mov eax, 0x4                ;
    mov ebx, 0x1                ;
    mov ecx, msg1               ; Hiện "nhập n:""
    mov edx, length1            ;
    int 0x80                    ;

    mov eax, 0x3                ;
    mov ebx, 0                  ; Nhập n từ bàn phím
    mov ecx, n                  ;
    mov edx, 0xa                ;
    int 0x80

    dec eax             ; Trừ đi 1 đơn vị vì nhập xong có cả kí tự \n
    mov ebx, ecx        ; ebx đang lưu giá địa chỉ của n
    mov ecx, eax        ; ecx đang lưu chiều dài của n
    call _stringToNum

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
_stringToNum: ; Numlen: ecx, String: ebx
    xor edx, edx        ;edx = 0
    xor eax, eax        ;eax = 0; lưu giá trị
    xor esi, esi        ;esi = 0 đánh dấu thứ tự địa chỉ

    mov dl, [ebx + esi] ; dl lưu giá trị (dưới dạng kí tự) của con trỏ [ebx + esi]
    cmp dl, [minus]     ; So sánh giá trị đó với kí tự '-'
    jne continu3        ; Nếu không phải '-' thì nhảy


    inc esi             ; tăng giá trị lên 1 đơn vị để đến kí tự tiếp theo
    dec ecx             ; giảm chiều dài chuối đi 1 đvi, vì có dấu '-'
    mov [flag], esi     ; Chuyển giá trị của biến flag giá trị 1, đánh dấu xem nó có phải số âm hay không
                        ; 1 thì là số âm, còn 0 mặc định là số dương


    continu3:
    L0OP:
        mov edx, 0xa    ; edx = 10
        mul edx         ; eax *= 10
        mov dl, [ebx + esi]; dl để lưu kí tự thứ esi
        sub edx, 0x30   ; EDX = GIÁ TRỊ; đưa kí tự về giá trị bằng cách trừ đi '0'
        add eax, edx    ; EAX += EDX
    inc esi
    loop L0OP           ; giảm giá trị của ecx đi 1 đvi, nếu ecx vấn lớn hơn 0 thi thực hiện nhãn L0OP tiếp

    ; Cuối cùng thì giá trị được lưu lại ở EAX

    mov esi, [flag]     ;Chuyển giá trị flag đã vào thanh esi 
    cmp esi, 0x1        ; so sánh xem thanh esi với 1
    jne c0ntinu3        ; Nếu số dương thì làm sạch thanh ESI
        mov ecx, 0xffffffff     ;
        sub ecx, eax            ; Chuyển số dương thành số [âm - 1] đơn vị
        mov eax, ecx            ;
    c0ntinu3:
    xor esi, esi
    ret

    ;Cuối cung thì giá trị được lưu ở thanh EAX
    ; EAX = giá trị
    ; ESI = 0
    ; EDX = 0
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    mov dword [count], eax      ; chuyển giá trị của từ kí tự sang số vào biến count

    xor edi, edi                ; EDI = 0, để đánh dấu hiện phần arr[edi]
    mov ecx, eax                ; ECX = EAX (số lượng phần tử của mảng)
    call _getArray              ; gọi hàm lấy chuối


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
_getArray: 

    mov [cnt], ecx              ; chuyển biến cnt = só lượng phân tử của mảng

    mov eax, 0x4                ;
    mov ebx, 0x1                ;
    mov ecx, msg2               ; Hiện "nhập n số nguyên"
    mov edx, length2            ;
    int 0x80                    ;

    LO0P:

        mov eax, 0x4            ;
        mov ebx, 0x1            ;
        mov ecx, msg3           ; Hiện "Arr["
        mov edx, msgLen3        ;
        int 0x80                ;

        xor eax, eax            ; EAX = 0
        mov eax, edi            ; EAX = EDI
        call _numToString       ;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

_numToString: ;ARGS(int(EAX))
    mov ecx, 0                  ;ECX = 0

    mov [flag], ecx             ; đánh dấu flag là số âm (0)
    cmp eax, 2147483648         ; so sánh số EAX với số âm, 
    jna c0nt1nu3                ; Nếu là số âm thì nhảy 
        inc ecx                 ; ecx lên 1 đơn vị
        mov edx, 0x1                ;
        mov [flag], edx             ; đánh dấu flag là số dương (1)
        mov edx, 0xffffffff         ;
        sub edx, eax                ;chuyển số dương thành số âm - 1
        mov eax, edx                ;
    c0nt1nu3:

    ;EAX = số âm

    execute:
        xor edx, edx                ; EDX = 0
        mov ebx, 10                 ; EBX = 10
        div ebx                     ; chia số âm EAX cho 10
        add edx, 0x30               ; số dư chuyển thành kí tự bằng cách cộng với '0'
        push edx                    ; đẩy edx vào ngăn xếp
        inc ecx                     ; tăng ecx lên 1 đơn vị, nhằm xác định số lần lặp
    cmp eax, 0
    jne execute

    mov edx, 0x1
    cmp [flag], edx                 ; Nếu là số dương (0 ban đầu) thì nhảy
    jne Cont1nue                    ; Nếu không bằng 1 thì nhảy (tức là số dương)
        mov dl, [minus]             ; đẩy vào ngăn xếp dấu -
        push edx                    ;
    Cont1nue:

    mov ebp, 0                      ; EBP = 0 (đánh dấu thứ tự của địa chỉ)
    L00P:
        pop edx                     ;Lấy giá trị của ngăn xếp từ trên xuống
        mov [num2 + ebp], edx
        inc ebp
    loop L00P
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


        ; mov [num2], eax

        mov eax, 0x4            ;
        mov ebx, 0x1            ;
        mov ecx, num2           ; hiện số n trong "Arr[n]: "
        mov edx, 0x4            ;
        int 0x80                ;

        mov eax, 0x4            ;
        mov ebx, 0x1            ;
        mov ecx, msg4           ; Hiện dấu ']'
        mov edx, msgLen4        ;
        int 0x80                ;

        mov eax, 0x3            ;
        mov ebx, 0x0            ;
        mov ecx, Ai             ; Nhập giá trị arr[n]
        mov edx, 0xa            ;
        int 0x80                ;

        dec eax                 ; giảm EAX đi 1 đv (chiều dài của chuỗi)
        mov ebx, ecx            ; EBX = địa chỉ của thằng kia        
        mov ecx, eax            ; đặt vòng lặp cho ecx
        call _stringToNum

        mov dword [arr + 4 * edi], eax ; arr[edi] = _stringToNum(input)
        ; xor eax, eax
        ; mov eax, dword [arr + 4*edi] ; arr[edi] = _stringToNum(input)

        inc edi 
        cmp edi, [count]
        jne LO0P
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    mov eax, 0x4            ;
    mov ebx, 0x1            ;
    mov ecx, msg5           ; Hiện "mảng trước khi sắp xếp"
    mov edx, msgLen5        ;
    int 0x80                ;

    mov ecx, dword [count]
    call _printArr


    call _selectionSort

    mov eax, 0x4
    mov ebx, 0x1
    mov ecx, msg6
    mov edx, msgLen6
    int 0x80

    mov ecx, dword [count]
    call _printArr


    call _exit



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

_selectionSort:
    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    xor edi, edi
    xor esi, esi
    ForI:
        mov edx, esi
        mov edi, esi

        ForJ:
            mov eax, dword [arr + 4 * edx] 
            mov ecx, dword [arr + 4 * edi]

            cmp eax, ecx
            jl continue
            mov edx, edi
            continue:
                inc edi
                cmp edi, [count]
                jne ForJ
        ; swap arr[edx], arr[esi]
        mov eax, dword [arr + 4 * edx] 
        mov ecx, dword [arr + 4 * esi]
        mov dword [arr + 4 * edx], ecx
        mov dword [arr + 4 * esi], eax

        inc esi
        cmp esi, [count]
        jne ForI
    ret

_ignoreMinus:
    inc esi
    ret

_toMinus:
    mov edx, 0xffffffff
    ret

_exit:
    mov eax, 0x1
    int 0x80
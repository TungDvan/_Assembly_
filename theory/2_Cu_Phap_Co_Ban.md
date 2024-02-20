# ASSEMBLY - Basic Syntax

- Một chương trình assembly bao gồm 3 phần sau:

    ```asm
    section .data
    
    section .bss

    section. text
    ```

## Data Section

- Phần `data` được sử dụng để khai báo dữ liệu hoặc hằng số khởi tạo. Dữ liệu này không thay đổi khi chạy. Bạn có thể khai báo các giá trị không đổi, tên tệp hoặc kích thước bộ đệm khác nhau, v.v. trong phần này.

- Cú pháp khai báo phần dữ liệu là 

    ```asm
    section .data
    ```

## Bss Section

- Phần `bss` được sử dụng để khai báo các biến. Cú pháp khai báo phần bss là:

    ```asm
    section .bss
    ```

## Text Section

- Phần ``text` được sử dụng để giữ mã thực tế. Phần này phải bắt đầu bằng khai báo `_start global`, thông báo cho **kernel** biết nơi bắt đầu thực thi chương trình.

- Cú pháp khai báo phần văn bản là:

    ```asm
    section.text
    global _start
    _start:
    ```

## Comments

- Comments bắt đầu bằng dấu chấm phẩy (;). Nó có thể chứa bất kỳ ký tự in được nào kể cả ký tự trống. Nó có thể tự xuất hiện trên một dòng, như sau:

    ```asm
    ; Tùng đẹp trai có một không có hai
    ```

    hoặc, trên cùng một dòng cùng với một hướng dẫn, như:

    ```asm
    add eax, ebx     ; thêm ebx vào eax
    ```

## Các câu lệnh ngôn ngữ Assembly

- Các chương trình hợp ngữ bao gồm ba loại câu lệnh:

    ```
    - Executable instructions or instructions
    - Assembler directives or pseudo-ops, and
    - Macros.
    ```

    - Các `executable instructions` hoặc đơn giản là `instructions` cho bộ xử lý biết phải làm gì. Mỗi lệnh bao gồm một mã hoạt động (opcode). Mỗi lệnh thực thi sẽ tạo ra một lệnh ngôn ngữ máy.

    - Các chỉ thị hoặc lệnh giả của trình `Assembler directives` hoặc `pseudo-ops` (gọi tắt là `biên dịch mã`) cho trình biên dịch biết về các khía cạnh khác nhau của quy trình lắp ráp. Đây là những không thể thực thi được và không tạo ra hướng dẫn ngôn ngữ máy.

    - Macros (Macros cho phép bạn tạo ra các khối mã nguồn có thể được sử dụng nhiều lần và giúp giảm lặp lại mã)

## Cú pháp các câu lệnh trong Assembly

- Các câu lệnh hợp ngữ được nhập một câu lệnh trên mỗi dòng. Mỗi câu lệnh tuân theo định dạng sau: 

    ```
    [label]   mnemonic   [operands]   [;comment]
    ```

- **[label]**: Đây là phần tùy chọn, đại diện cho nhãn (label). Nhãn là một ký tự hoặc chuỗi ký tự được đặt tên để định danh một địa chỉ cụ thể trong chương trình. Nhãn thường được sử dụng để xác định điểm đến cho các lệnh nhảy (jump) và để dễ dàng tham chiếu đến các vị trí trong mã nguồn.

    - **Ví dụ:**

        ```asm
        loop_start: ; Đây là nhãn
                    ; Các lệnh trong vòng lặp
        ```

- **mnemonic**: Là từ viết tắt hoặc từ ngữ được sử dụng để mô tả một lệnh máy cụ thể. Mnemonic giúp lập trình viên hiểu rõ chức năng của lệnh mà không cần phải nhớ mã máy tương ứng.

    - **Ví dụ:**

        ```asm
            mov eax, 1  ; Đây là lệnh di chuyển giá trị 1 
                        ; vào thanh ghi eax
        ```

- **[operands]**: Là phần tùy chọn, đại diện cho các toán hạng của lệnh. Toán hạng là dữ liệu hoặc địa chỉ mà lệnh sẽ thao tác. Số lượng và loại toán hạng phụ thuộc vào lệnh cụ thể.

    - **Ví dụ:**


        ```asm
        add eax, ebx    ; Lệnh cộng giữa thanh ghi 
                        ; eax và thanh ghi ebx
        ```

- **comment:** Là phần tùy chọn, đại diện cho chú thích. Bất kỳ nội dung nào sau dấu chấm phẩy (;) sẽ được coi là chú thích và không ảnh hưởng đến việc thực thi chương trình. Chú thích giúp giải thích ý nghĩa của mã nguồn.

    - **Ví dụ:**

        ```asm
        cmp eax, 10 ; So sánh thanh ghi eax với giá trị 10
        ```

- Một số ví dụ điển hình

```asm
int count       ; tăng biến count lên 1 đơn vị

mov total, 48   ; di chuyển giá trị 48 vào biến total

add  ah, bh     ; thêm nội dung của thanh ghi bh vào thanh ghi ah
```

## Chương trình HELLO WORLD trên assembly

- Chương trình sau hiện "Hello World!" lên màn hình:

```asm
section	.data   
    msg db 'Hello, world!', 0xa     ; chuỗi sẽ in ra màn hình
    len equ $ - msg                 ; chiều dài của chuỗi
    
section	.text
    global _start        ; phải được khai báo cho tình liên kết
	
_start:	                ; cho biết điểm vào của trình liên kết
    mov	eax,4           ; chế độ hiện (4)
    mov	ebx,1           ; mô tả tập tin (stdout)
    mov	ecx,msg         ; chuỗi để in
    mov	edx,len         ; chiều dài chuỗi
    int	0x80            ; gọi hệ thống
        
    mov	eax,1           ; chế độ thoát (1)
    int	0x80            ; gọi hệ thống
```

- Khi đoạn mã trên được biên dịch và thực thi, nó tạo ra kết quả sau:

    ```
    Hello, world!
    ```

## Biên dịch và liên kết một chương trình hợp ngữ trong NASM

- Đảm bảo rằng bạn đã đặt đường dẫn của các tệp nhị phân `nasm` và `ld` trong biến môi trường PATH của mình. Bây giờ, hãy thực hiện các bước sau để biên dịch và liên kết chương trình trên

    - Nhập mã trên bằng trình soạn thảo văn bản và lưu dưới dạng `hello.asm`.

    - Đảm bảo rằng bạn đang ở trong cùng thư mục với nơi bạn đã lưu `hello.asm`.

    - Để lắp ráp chương trình, gõ `nasm -f elf hello.asm`

    - Nếu có bất kỳ lỗi nào, bạn sẽ được nhắc về điều đó ở giai đoạn này. Nếu không, một tệp đối tượng của chương trình có tên `hello.o` sẽ được tạo.

    - Để liên kết tệp đối tượng và tạo tệp thực thi có tên hello, hãy nhập `ld -m elf_i386 -s -o hello hello.o`.

    - Thực thi chương trình bằng cách gõ `./hello`

- Nếu bạn đã làm mọi thứ chính xác, nó sẽ hiển thị **'Hello World!'** trên màn hình.
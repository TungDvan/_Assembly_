# NASM

## MÔ TẢ

- Trong bài viết này chúng ta sẽ tìm hiểu cách viết chương trình x86 bằng cách sử dụng NASM.

- Chương trình sẽ sử dụng `mov` và `int` để thoát với mã trạng thái được đặt vào thanh `ebx`

### NASM LÀ GÌ

- `NASM` là một loại cú pháp được thiết kế dựa trên cú pháp intel cho `x86`. Công dụng của nó là tạo ra một cách tiếp cận đơn giản hơn cho cú pháp theo cách mà người dùng phổ thông dễ tiếp cận hơn `x86` mà bạn thường thấy trên các hệ thống `linux` sử dụng kết hợp các cú pháp khác nhau

### CHƯƠNG TRÌNH ĐẦU TIÊN


#### **Tạo một file NASM**

- Trên `linux`, để mở một tệp tin hoặc bắt đầu soạn thảo với `nano`, bạn có thể mở Terminal và sử dụng lệnh sau:

```
nano file
nano file.type
```
- Với ngôn ngữ NASM thì loại file sẽ đuôi `.asm` hoặc `.as` hoặc `.s` (có thể đặt bất kì đuôi nào trong 3 đuôi trên)

    - Ví dụ: `nano first.asm`, `nano first.as`, `nano first.s`

#### **Viết một chương trình**

- Điều chúng ta sắp làm là chúng ta sẽ khai báo một phần. Và có thể có những phần khác nhau nhưng đây sẽ phần chúng ta khai báo để bắt đầu:

```asm
section .data

section. text
```

- Phần `section .data` là phần lưu trữ các biến trong bộ nhớ khi chương trình chạy và những phần này sẽ không thể thay đổi giá trị khi chạy chương trình.

- Phần `section .text` là phần lưu trữ mã code của chương trình. 

    - Điều chúng ta cần làm là cho chương trình biết nơi nó phải bắt đầu, chúng ta khai báo:
    ```asm
    section .data

    section. text
        global _start:
    _start:
    ```

    - Điều đang làm là nó đang khai báo cái gì đó được gọi là nhãn `_start:`. Về cơ bản chương trình nó được thực thi thì đến `global _start:` nó sẽ nhảy đến phần nhãn `_start:` để thực hiện các dòng lệnh bên dưới `_start:`
        
        - **CHÚ Ý**: Phải ghi đúng là `global _start`, nếu ghi khác thì chương trình sẽ không thể biên dịch được và bị lỗi như sau:

        ```
        ld: warning: cannot find entry symbol _start; defaulting to 0000000008049000
        ```

    - Chúng ta sẽ di chuyển một số dữ liệu trong các thanh ghi nên chúng ta sẽ học cách di chuyển dữ liệu trong các thanh ghi. Việc này  sử dụng một câu lệnh có tên là `mov`.

    - Lệnh `mov` là lệnh sẽ di chuyển dữ liệu từ từ vị trí này sang vị trị khác. Có rất nhiều cách khác nhau để chúng ta làm việc với lệnh di chuyển, nhưng theo cách sắp làm sau đây là di chuyển một giá trị tĩnh giống như một số nguyên vào thanh ghi:

    ```asm
    section .data

    section. text
        global _start:
    _start:
        mov eax, 1  ; Di chuyển giá trị 1 vào thanh ghi eax
        mov ebx, 1  ; Di chuyển giá trị 1 vào thanh ghi ebx

    ```
    - Và nếu muốn kết thúc chương trình thì điều cần làm được gọi là ngắt, chúng ta sẽ nói `int 80h`. `h` là viết tắt của `hexa` nên chúng ta đang nói `80` trong hệ thập lục phân làm việc. Như vậy khi chương trình khi gặp một ngắt việc thì máy tính sẽ truy cập hệ thống và thực hiện một số hành động dựa trên giá trị mà chúng ta đặt trong thanh ghi `eax`.

    ```asm
    section .data

    section. text
        global _start:
    _start:
        mov eax, 1  ; Di chuyển giá trị 1 vào thanh ghi eax
        mov ebx, 4  ; Di chuyển giá trị 4 vào thanh ghi ebx
        int 0x80    ; Thực hiện ngắt
    ```

    - Công dụng của `eax` là cho hệ điều hành biết chúng ta muốn làm gì khi có lệnh ngắt `int 0x80`. Trong trường hợp này giá trị `1` được truyền vào `eax` là nó cho chúng ta biết rằng muốn chạy lệnh gọi hệ thống thoát.

    - Lệnh gọi hệ thống thoát là nó sẽ kết thúc chương trình và nó sẽ đặt mã trạng thái thoát và mã trạng thái chỉ cho biết rằng chương trình có thành công hay không, mã trạng thái sẽ là bất cứ thứ gì đưa vào `ebx` (trong TH này thì nó là `4`).

#### Chạy chương trình

- Khi ra ngoài terminal thì ta sẽ sửu dụng các câu lệnh sau để có thể chạy một chương trình `ASM` mà  ta vừa soạn:

```text
nasm -f elf file_name.type_file
ld -m elf_i386 -s -o file_name file_name.o
```

- Ví dụ: với `first.asm` ở trên

```
nasm -f elf first.asm
ld -m elf_i386 -s -o first first.o
```

- Sau khi gõ câu lệnh đầu tiên thì sẽ có một file được tạo ra và file đó là file đối tượng (`.o`). Và để liên kết file đối tượng và tạo ra một file thực thi thì chúng ta gõ câu lệnh thứ hai (trong vị dụ trên thi sau khi gõ ta sẽ thấy có 3 file là: `test.asm`, `test.o`, `test`)

- Để chạy chương trình chúng ta sẽ gõ `./tên_file_thực_thi`

    - Ví dụ : `./first`

- Như ở trên đã nói thì nếu mà chương trình chạy thành công thì chương trình sẽ đặt mã trạng thái là bất cứ thứ gì đưa vào thanh `ebx`, vậy nên để biết chương trình có chạy thành công hay không chúng ta sử dụng câu lệnh `echo $?` để kiểm tra và nó sẽ hiện giá trị của thanh `ebx  `

    - Ví dụ: với chương trình trên
    ```
    nano first.asm
    nasm -f elf first.asm
    ld -m elf_i386 -s -o first first.o  
    ./first

    echo $?
    ```
    
    Thì màn hình sẽ hiện `4`

## THỬ THÁCH NHO NHỎ CUỐI BÀI

- Hãy đoán xem là chương trình này sau khi biên dịch khi gõ `echo $?` ở `terminal` thì sẽ hiện ra như thế nào:

    ```asm
    section .data

    section .text
    global _start

    mov eax, 1
    mov ebx, 1
    int 0x80

    _start:
    mov eax, 1
    mov ebx, 2
    int 0x80 
    ```

- Đáp án ở cuối bài 2 (phần tiếp theo). Gợi ý: màn hình sẽ hiện một trong hai số sau (1 hoặc 2)


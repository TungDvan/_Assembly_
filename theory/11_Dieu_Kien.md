# Assembly - Conditions

- Việc thực thi có điều kiện trong hợp ngữ được thực hiện bằng một số lệnh lặp và phân nhánh. Các lệnh này có thể thay đổi luồng điều khiển trong một chương trình. Việc thực thi có điều kiện được quan sát trong hai trường hợp:

    - **TH1: Nhảy vô điều kiện:** Điều này được thực hiện bởi lệnh `jmp`. Thực thi có điều kiện thường liên quan đến việc chuyển quyền điều khiển đến địa chỉ của lệnh không tuân theo lệnh hiện đang thực thi. Việc chuyển giao quyền điều khiển có thể tiến tới để thực hiện một tập lệnh mới hoặc lùi lại để thực hiện lại các bước tương tự.

    - **TH2: Nhảy có điều kiện:** Điều này được thực hiện bằng một tập hợp các lệnh nhảy j&lt;condition&gt; tùy thuộc vào điều kiện. Các lệnh có điều kiện chuyển điều khiển bằng cách ngắt luồng tuần tự và chúng thực hiện điều đó bằng cách thay đổi giá trị **offset** trong `IP`.

## Hướng dẫn CMP

- Lệnh `cmp` so sánh hai toán hạng. Nó thường được sử dụng trong thực thi có điều kiện. Lệnh này về cơ bản trừ một toán hạng với toán hạng kia để so sánh xem các toán hạng có bằng nhau hay không. Nó không làm phiền các toán hạng đích hoặc nguồn. Nó được sử dụng cùng với lệnh nhảy có điều kiện để ra quyết định.

    ### Cú pháp

    ```
    CMP destination, source
    ```

- `cmp` so sánh hai trường dữ liệu số. Toán hạng đích **destination** có thể nằm trong `thanh ghi` hoặc trong `bộ nhớ`. Toán hạng nguồn **source** có thể là `dữ liệu`, `thanh ghi` hoặc `bộ nhớ không đổi` (tức thời).

## Nhảy vô điều kiện

- Như đã đề cập trước đó, điều này được thực hiện bởi lệnh `jmp`. Thực thi có điều kiện thường liên quan đến việc chuyển quyền điều khiển đến địa chỉ của lệnh không tuân theo lệnh hiện đang thực thi. Việc chuyển giao quyền điều khiển có thể tiến tới để thực hiện một tập lệnh mới hoặc lùi lại để thực hiện lại các bước tương tự.

    ### Cú pháp

    - Lệnh `jmp` cung cấp tên nhãn nơi luồng điều khiển được truyền ngay lập tức. Cú pháp của lệnh `jmp` là

        ```
        jmp label
        ```

- Ví dụ

    ```asm
    mov eax, 1
    mov ebx, 2
    jmp step1

    mov ebx, 1

    step1:
        int 0x80
    ```

## Nhảy có điều kiện

- Nếu một số điều kiện xác định được thỏa mãn trong bước nhảy có điều kiện, luồng điều khiển sẽ được chuyển sang lệnh đích. Có rất nhiều lệnh nhảy có điều kiện tùy thuộc vào điều kiện và dữ liệu.

- Sau đây là các lệnh nhảy có điều kiện được sử dụng trên dữ liệu đã ký được sử dụng cho các phép tính số học (phần này để Tiếng Anh bởi nó dẽ nhớ với cú pháp)

    |Instruction|Description|	Flags tested|
    |--|--|--|
    |JE/JZ      |Jump Equal or Jump Zero|ZF|
    |JNE/JNZ    |Jump not Equal or Jump Not Zero|ZF|
    |JG/JNLE	|Jump Greater or Jump Not Less/Equal	|OF, SF, ZF|
    |JGE/JNL	|Jump Greater/Equal or Jump Not Less	|OF, SF|
    |JL/JNGE	|Jump Less or Jump Not Greater/Equal	|OF, SF|
    |JLE/JNG	|Jump Less/Equal or Jump Not Greater	|OF, SF, ZF|

- Sau đây là các lệnh nhảy có điều kiện được sử dụng trên dữ liệu chưa được ký được sử dụng cho các phép toán logic

    |Instruction|Description|Flags tested|
    |--|--|--|
    |JE/JZ	|Jump Equal or Jump Zero	|ZF
    |JNE/JNZ	|Jump not Equal or Jump Not Zero	|ZF
    |JA/JNBE	|Jump Above or Jump Not Below/Equal	|CF, ZF
    |JAE/JNB	|Jump Above/Equal or Jump Not Below	|CF
    |JB/JNAE	|Jump Below or Jump Not Above/Equal	|CF
    |JBE/JNA	|Jump Below/Equal or Jump Not Above	|AF, CF

- Các lệnh nhảy có điều kiện sau đây có những cách sử dụng đặc biệt và kiểm tra giá trị của `flag`

    Instruction	|Description	|Flags tested
    |--|--|--|
    |JXCZ	|Jump if CX is Zero	|none
    |JC	|Jump If Carry	|CF
    |JNC	|Jump If No Carry	|CF
    |JO	|Jump If Overflow	|OF
    |JNO	|Jump If No Overflow	|OF
    |JP/JPE	|Jump Parity or Jump Parity Even	|PF
    |JNP/JPO	|Jump No Parity or Jump Parity Odd	|PF
    |JS	|Jump Sign (negative value)	|SF
    |JNS	|Jump No Sign (positive value)	|SF
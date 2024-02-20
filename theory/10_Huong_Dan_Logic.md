# Assembly - Logical Instructions

- Tập lệnh bộ xử lý cung cấp các lệnh `and`, `or`, `xor`, `test` và `not` Boolean logic để kiểm tra, thiết lập và xóa các bit theo nhu cầu của chương trình.

- Định dạng cho các hướng dẫn này

    ||||
    |--|--|--|
    |STT||Định dạng|
    |1|and|and operand1, operand2|
    |2|or|or operand1, operand2|
    |3|xor|xor operand1, operand2|
    |4|test|test operand1, operand2|
    |5|not|not operand1|
    ||||

- Toán hạng đầu tiên **operand1** trong tất cả các trường hợp có thể nằm trong `thanh ghi` hoặc trong `bộ nhớ`. Toán hạng thứ hai **operand2** có thể nằm trong `thanh ghi/bộ nhớ` hoặc `giá trị tức thời` (không đổi). Tuy nhiên, không thể thực hiện được các thao tác từ bộ nhớ đến bộ nhớ. Các lệnh này so sánh hoặc khớp các bit của toán hạng và đặt các cờ `CF`, `OF`, `PF`, `SF` và `ZF`.


## Lệnh AND

- Lệnh `and` được sử dụng để hỗ trợ các biểu thức logic bằng cách thực hiện thao tác `and` theo bit. Phép toán `and` theo bit trả về 1, nếu các bit khớp từ cả hai toán hạng là 1, nếu không nó trả về 0. Ví dụ:

    ```
                Operand1: 	01010110
                Operand2: 	00111110
    --------------------------------
    After AND -> Operand1:	00010110
    ```

- Phép toán `and` có thể được sử dụng để xóa một hoặc nhiều bit. Ví dụ: giả sử thanh ghi `bl` chứa `0011 1010`. Nếu bạn cần xóa các bit bậc cao về `0`, bạn `and` nó bằng 0FH.

    ```
                bl      : 	0011 1010
                0FH     : 	0000 1111
    ----------------------------------
    After AND -> bl     :	0000 1010
    ```

- Hãy lấy một ví dụ khác. Nếu bạn muốn kiểm tra xem một số đã cho là `số lẻ` hay `số chẵn`, một phép kiểm tra đơn giản là kiểm tra bit có trọng số nhỏ nhất của số đó. Nếu đây là `1` thì số đó là `số lẻ`, nếu `0` thì số đó là `số chẵn`

    ```
                141      : 	1000 1101
                0FH     : 	0000 0001
    ----------------------------------
    After AND -> bl     :	0000 0001   -> số lẻ
    ```

## Lệnh OR

- Lệnh `or` được sử dụng để hỗ trợ biểu thức logic bằng cách thực hiện thao tác OR theo bit. Toán tử bitwise `or` trả về 1, nếu các bit khớp từ một hoặc cả hai toán hạng là một. Nó trả về 0, nếu cả hai bit đều bằng 0.

    ```
                Operand1: 	01010110
                Operand2: 	00111110
    --------------------------------
    After OR -> Operand1:	01111110
    ```

- Hoạt động `or` có thể được sử dụng để thiết lập một hoặc nhiều bit. Ví dụ: giả sử thanh ghi `al` chứa 0011 1010, bạn cần đặt bốn bit thứ tự thấp, bạn có thể `or` nó với giá trị 0000 1111, tức là FH.

    ```
                al      : 	0011 1010
                OF      : 	0000 1111
    -----------------------------------
    After OR -> al      :	0011 1111
    ```

## Lệnh XOR

- Lệnh `xor` thực hiện thao tác `xor` theo bit. Hoạt động `xor` đặt bit kết quả thành 1, khi và chỉ khi các bit từ toán hạng khác nhau. Nếu các bit trong toán hạng giống nhau (cả 0 hoặc cả 1), bit kết quả sẽ bị xóa thành 0.

    ```
                 Operand1: 	01010110
                 Operand2: 	00111110
    --------------------------------
    After XOR -> Operand1:	01101000
    ```

- `xor` một toán hạng với chính nó sẽ thay đổi toán hạng thành 0 . Điều này được sử dụng để xóa thanh ghi.

    ```
                al      : 	0101 0110
                al      : 	0101 0110
    ---------------------------------
    After XOR -> al     :	0000 0000
    ```

## Lệnh TEST

- Lệnh `test` hoạt động giống như lệnh `and`, nhưng không giống như lệnh `and`, nó không thay đổi toán hạng đầu tiên. Vì vậy, nếu chúng ta cần kiểm tra xem một số trong thanh ghi là chẵn hay lẻ, chúng ta cũng có thể thực hiện việc này bằng lệnh `test` mà không thay đổi số ban đầu.

    ```asm
    test    al, 01H
    jz      EVEN_NUMBER
    ```
- Ứng dụng khác của lệnh test: Kiểm tra xem một thanh ghi có giá trị âm hay không:


    ```asm
    mov ax, -5
    test ax, ax
    js negative_flag_set
    ```

    - Nếu `ax` là một số âm, cờ `sign flag` sẽ được thiết lập, và điều kiện nhảy sẽ được thực hiện.

## Lệnh NOT

- Lệnh `not` thực hiện thao tác `not` theo bit. Hoạt động `not` đảo ngược các bit trong toán hạng. Toán hạng có thể ở trong thanh ghi hoặc trong bộ nhớ.

    ```             
                    Operand1:    0101 0011
    After NOT ->    Operand1:    1010 1100
    ```
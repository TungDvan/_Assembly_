# Assembly - Loops

- Lệnh `jmp` có thể được sử dụng để thực hiện các vòng lặp. 
    - Ví dụ: đoạn mã sau có thể được sử dụng để thực thi phần thân vòng lặp 10 lần.

        ```asm
        mov cl, 10
        step1:
            ; code
            dec cl
            jnz step1
        ```

- Tuy nhiên, tập lệnh bộ xử lý bao gồm một nhóm các lệnh vòng lặp để thực hiện phép lặp. Lệnh `loop` cơ bản có cú pháp sau:

    ```
    loop 	label
    ```

    - Trong đó, nhãn là nhãn đích xác định lệnh đích như trong lệnh nhảy. Lệnh `loop` giả định rằng thanh ghi `ecx` chứa số vòng lặp. Khi lệnh vòng lặp được thực thi, thanh ghi `ecx` giảm dần và bộ điều khiển nhảy tới nhãn đích cho đến khi giá trị thanh ghi `ecx`, tức là bộ đếm đạt đến giá trị 0.

    - Đoạn mã trên có thể được viết là:

        ```asm
        mov cl, 10
        step1:
            ; code
            loop step1
        ```

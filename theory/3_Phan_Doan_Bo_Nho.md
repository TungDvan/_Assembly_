# Assembly - Memory Segments

- Chúng ta đã thảo luận về ba phần của một chương trình lắp ráp. Những phần này cũng đại diện cho các phân đoạn bộ nhớ khác nhau.

- Điều thú vị là nếu bạn thay thế từ khóa `section` bằng `segment`, bạn sẽ nhận được kết quả tương tự. Hãy thử đoạn mã sau:

    ```asm
    segment	.data   
        msg db 'Hello, world!', 0xa     ; chuỗi sẽ in ra màn 
                                        ;hình
        len equ $ - msg                 ; chiều dài của chuỗi
        
    segment	.text
        global _start     ; phải được khai báo cho tình liên kết
        
    _start:	              ; cho biết điểm vào của trình liên kết
        mov	eax,4         ; chế độ hiện (4)
        mov	ebx,1         ; mô tả tập tin (stdout)
        mov	ecx,msg       ; chuỗi để in
        mov	edx,len       ; chiều dài chuỗi
        int	0x80          ; gọi hệ thống
            
        mov	eax,1         ; chế độ thoát (1)
        int	0x80          ; gọi hệ thống
    ```

- Khi đoạn mã trên được biên dịch và thực thi, nó tạo ra kết quả sau:

    ```
    Hello, world!
    ```

## Phân đoạn bộ nhớ

- Mô hình bộ nhớ được phân đoạn, chia bộ nhớ hệ thống thành các nhóm phân đoạn độc lập được tham chiếu bởi các con trỏ nằm trong các thanh ghi phân đoạn. Mỗi phân đoạn được sử dụng để chứa một loại dữ liệu cụ thể. Một phân đoạn được sử dụng để chứa mã lệnh, phân đoạn khác lưu trữ các phần tử dữ liệu, và phân đoạn thứ ba giữ ngăn xếp chương trình.

- Theo cuộc thảo luận ở trên, chúng ta có thể chỉ định các phân đoạn bộ nhớ khác nhau như

    - **Data segment** (Phân đoạn dữ liệu): Nó được biểu thị bằng phần `.data` và `.bss`. Phần `.data` dùng để khai báo vùng bộ nhớ, nơi lưu trữ các phần tử dữ liệu cho chương trình. Phần này không thể được mở rộng sau khi các phần tử dữ liệu được khai báo và nó vẫn ở trạng thái tĩnh trong suốt chương trình.
        - Phần `.bss` cũng là phần bộ nhớ tĩnh chứa các bộ đệm cho dữ liệu sẽ được khai báo sau trong chương trình. Bộ nhớ đệm này không được lấp đầy.

    - **Code segment** (Phân đoạn mã): Nó được biểu thị bằng phần .text . Điều này xác định một vùng trong bộ nhớ lưu trữ mã lệnh. Đây cũng là một khu vực cố định.

    - **Stack** (Ngăn xếp): Phân đoạn này chứa các giá trị dữ liệu được truyền cho các hàm và thủ tục trong chương trình.
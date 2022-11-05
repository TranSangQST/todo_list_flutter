
## Thông tin cá nhân:
- MSSV: 19120347
- Họ tên: Trần Ngọc Sang
- Github: (Public sau ngày 07/11/2022)
    + https://github.com/TranSangQST/todo_list_flutter


## Yêu cầu:

1. Cho người dùng tạo TODO có chọn thời gian TODO
2. Trang chính cho chọn xem TODO theo All/Today/Upcoming
3. Hiển thị danh sách TODO theo từng loại All/Today/Upcoming
4. Search TODO list
5. Thông báo notification trước khi TODO list xảy ra 10 phút (Sử dụng https://pub.dev/packages/flutter_local_notifications)
6. Đánh dầu 1 TODO đã xong và remove khỏi danh sách TODO
7. Yêu cầu sử dụng Local Storage để lưu trữ danh sách TODO, nếu ứng dụng tắt đi thì TODO vẫn còn lưu trư khi chạy lại.

## Link video:
- https://youtu.be/5uitlYMI7NQ
- Dự phòng : https://drive.google.com/drive/folders/1xT2gn_jAo0NC_XrmhlGvOI6-RlQrfAgd?usp=sharing
 



## DEMO

1. Mở ứng dụng:

2. Các Tab:

- **ALL**

  - Mặc định sẽ hiện ở tab ALL:
  - Tất cả các Tasks (Có thời gian và không có thời gian đều hiện lên):
    + Ví du: 
      * Bamily và Subin không có thời gian
      * Các Tasks còn lại có thời gian


- **Today**

  - Hiển thị các task cũ chưa làm (Overdue)
  - Và hiển thị các task trong ngày


- **Up Coming**

  - Hiển thị các task cũ chưa làm (Overdue)
  - Và hiển thị các task từ hôm nay đến những ngày tiếp theo


- => **YÊU CẦU 2 và 3**

3. Thêm tasks:
- Nhấn vào "Add new task..."
- Nhập title, description và chọn date và time
  + Nhấp X để xóa Date và Time
  + Ví dụ 1:
    * Nhập 
      * title: "sang"
      * descrition: "react native"
      * date: 6/11/2022
      * time: 10:20:00
    * Nhấn button "+"

  + Ví dụ 2:
    * Nhập 
      * title: "tran"
      * descrition: "flutter"
      * date: Bỏ trống
      * time: Bỏ trống
    * Nhấn button "+"

  + Danh sách sẽ được cập nhập

- => **YÊU CẦU 1**



4. Search:
- Nhấn và "Search" và gõ nội dung:
- Search sẽ tìm những ký tự có trong title và description
- Ví dụ:
  + Nhập "mmon"
  + Nhập "tough"
- Nhấn "X" để xóa nội dung vừa nhập

- => **YÊU CẦU 4**

5. Xóa tasks:
- Nhấn vào checkbox bên trái 1 task bất kỳ:
- Task sẽ biến mất
- Ví dụ:
  + Nhấn vào checkbox của Opela và Keylex
  
- => **YÊU CẦU 6**

6. Kiểm tra lưu trữ
- Thoát ứng dụng: 
- Vào lại lần nữa, 
  + Dữ liệu giống như lần cuối ta truy cập vào ứng dụng
  + Ví dụ:
    * Đã có "sang" và "tran"


- => **YÊU CẦU 7**

## Tổng kết:
- Hoàn thành: yêu cầu 1,2,3,4,6,7
- Chưa hoàn thành: yêu cầu 5 (Thông báo trước 10 phút)


## Tham khảo:
1. https://github.com/projectsforchannel/Todo-Project
- Lưu trữ dữ liệu
- Class TodoData

2. https://pub.dev/packages/flutter_datetime_picker/examplev
- Tạo Date picker
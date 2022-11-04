- Bài tập nhỏ 2: Các bạn hay xây dựng ứng dụng TODO List với danh sách các yêu cầu như sau:
- Cho người dùng tạo TODO có chọn thời gian TODO
- Trang chính cho chọn xem TODO theo All/Today/Upcoming
- Hiển thị danh sách TODO theo từng loại All/Today/Upcoming
- Search TODO list
- Thông báo notification trước khi TODO list xảy ra 10 phút (Sử dụng https://pub.dev/packages/flutter_local_notifications)
- Đánh dầu 1 TODO đã xong và remove khỏi danh sách TODO
- Yêu cầu sử dụng Local Storage để lưu trữ danh sách TODO, nếu ứng dụng tắt đi thì TODO vẫn còn lưu trư khi chạy lại.
- Bạn có thể tham khảo thêm các ứng dụng TODO LIST bất kì để hiểu rõ thêm về ứng dụng (https://apps.apple.com/vn/app/todoist-to-do-list-tasks/id572688855).
- Deadline: 23:55 Ngày 06/11/2022.
- Link nộp: https://courses.fit.hcmus.edu.vn/mod/assign/view.php?id=96056
- Dart packagesDart packages
- flutter_local_notifications | Flutter Package
- A cross platform plugin for displaying and scheduling local notifications for Flutter applications with the ability to customise for each platform.
- App StoreApp Store
- ‎Todoist: To-Do List & Planner
  ‎Trusted by 30+ million people and teams worldwide. Todoist is a delightfully simple yet powerful task manager and to-do list app. Finally, organize your work and life. - TechRadar - “...one of the best apps you can use to plan your personal and work schedules. The app has a lot of task management feat…

## Thiết kế UI:

- 1 Screen:
  - Chọn xem All, Today, Upcoming (ta sẽ làm Tab bottom cho cái những lựa chọn này)
    - All: Xem tất cả:
      - Mỗi TodoItem sẽ là có: title, description và time trên 1 column, bên trái có 1 cái checkbox để remove
    - Upcomming: thì nhiều list và mỗi list là 1 ngày, nếu đc thì Header ta show 1 cái scroll để lấy date (như ứng dụng TodoList mẫu)

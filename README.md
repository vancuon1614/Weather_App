# weather_app

Weather Flutter project.

## Getting Started

## THÀNH TỰU ĐẠT ĐƯỢC

Sau quá trình nghiên cứu và thực hiện Lab 4, em đã hoàn thành một ứng dụng Thời tiết (Weather App) hoàn chỉnh với các kết quả cụ thể sau:

# 1. Về mặt Kỹ thuật & Công nghệ:
- Kiến trúc phần mềm: Xây dựng ứng dụng theo mô hình phân lớp (Layered Architecture) rõ ràng gồm: Models, Providers (State Management), Services và Screens.
- Quản lý trạng thái: Sử dụng thành thạo thư viện Provider để quản lý trạng thái ứng dụng, tách biệt logic xử lý khỏi giao diện UI.
- Tích hợp API: Kết nối thành công với OpenWeatherMap API thông qua giao thức HTTP/RESTful để lấy dữ liệu thời gian thực.
- Xử lý bất đồng bộ: Áp dụng tốt kỹ thuật Future, async/await để xử lý các tác vụ mạng và định vị mà không làm treo giao diện.
- Bảo mật: Biết cách bảo vệ API Key bằng cách sử dụng file .env và thư viện flutter_dotenv, không hard-code key trực tiếp vào mã nguồn.

# 2. Các tính năng đã hoàn thiện:
- Thời tiết hiện tại: Hiển thị nhiệt độ, mô tả thời tiết, độ ẩm, sức gió, tầm nhìn theo vị trí thực tế.
- Định vị GPS: Tự động xác định vị trí người dùng để lấy dữ liệu thời tiết tương ứng.
- Dự báo 5 ngày: Hiển thị danh sách dự báo thời tiết cho các ngày tiếp theo.
- Tìm kiếm thông minh: Chức năng tìm kiếm thành phố với giao diện gợi ý (suggestion chips) giúp người dùng thao tác nhanh.
- Hỗ trợ đa ngôn ngữ: Ứng dụng đã được Việt hóa hoàn toàn (hiển thị ngày tháng, mô tả thời tiết bằng tiếng Việt).

# 3. Về mặt Giao diện (UI/UX):
- Thiết kế hiện đại: Áp dụng phong cách Glassmorphism (hiệu ứng kính mờ) kết hợp với hình nền Gradient tạo cảm giác sang trọng và chuyên nghiệp.
- Trải nghiệm người dùng: Tích hợp tính năng "Kéo để làm mới" (Pull-to-refresh) và hiển thị Loading Shimmer khi chờ dữ liệu.
- Xử lý lỗi: Hiển thị thông báo thân thiện khi mất kết nối mạng hoặc không tìm thấy thành phố.

# Giao diện màn hình chính
<img width="975" height="504" alt="image" src="https://github.com/user-attachments/assets/5ceed178-b597-4c63-9cd6-ad0eea6c0be3" />


# Dự báo theo giờ và Dự báo theo ngày
<img width="975" height="507" alt="image" src="https://github.com/user-attachments/assets/5e89a5d8-e778-4357-820d-1ccf8730ea17" />

# giao diện tìm kiếm thoi tiet cua thành phố khác
<img width="975" height="504" alt="image" src="https://github.com/user-attachments/assets/0d245bf1-2d18-47ab-84d7-2dd977f7ab6c" />

# ví dụ HN
<img width="975" height="502" alt="image" src="https://github.com/user-attachments/assets/0f522adf-d619-4967-864e-570746e59eab" />

# Thời tiết hiện theo giờ và theo ngày tại HN
<img width="975" height="504" alt="image" src="https://github.com/user-attachments/assets/b6b58973-54d2-4f9f-8659-acbefb234250" />





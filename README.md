# GitHub---QuanLyBanHangNoiThat_TimberTech_HDT

# 🖥️ Object-Oriented Analysis & Design: Hệ Thống Quản Lý Bán Hàng Nội Thất TimberTech

Dự án phân tích, thiết kế và xây dựng chương trình mẫu quản lý bán hàng nội thất TimberTech, nhằm giải quyết những hạn chế trong việc quản lý sản phẩm, khách hàng, đơn hàng, kho hàng và hóa đơn bằng các công cụ rời rạc. Dự án ứng dụng phương pháp phân tích thiết kế hướng đối tượng (OOAD), mô hình hóa UML, thiết kế cơ sở dữ liệu SQL Server và phát triển ứng dụng C# WinForms theo kiến trúc 3 tầng.

## 👩‍💻 Thông Tin Đồ Án

- **Sinh viên thực hiện:** Phan Thị Yến Ngọc (MSSV: 2321004044)
- **Giảng viên hướng dẫn:** ThS. Lê Thị Kim Thoa
- **Trường:** Đại học Tài chính – Marketing (Khoa Khoa học Dữ liệu)
- **Môn học:** Phân tích và Thiết kế hướng đối tượng
- **Thời gian:** 01/2026 – 04/2026

## 🛠️ Công Nghệ & Công Cụ Sử Dụng

- **Phân tích và thiết kế hệ thống:** Object-Oriented Analysis & Design (OOAD), UML.
- **Mô hình hóa UML:** Use Case, Activity, Sequence, Communication, Class, State, Package, Component và Deployment Diagram.
- **Ngôn ngữ lập trình:** C# .NET WinForms, lập trình hướng đối tượng (OOP).
- **Cơ sở dữ liệu:** Microsoft SQL Server, SQL, thiết kế mô hình dữ liệu quan hệ và ràng buộc toàn vẹn.
- **Kiến trúc phần mềm:** Mô hình 3 tầng (Presentation Layer, Business Logic Layer, Data Access Layer).
- **Công cụ hỗ trợ:** Visual Studio, SQL Server Management Studio (SSMS), Enterprise Architect và Draw.io.

## 🚀 Các Giai Đoạn Triển Khai Cốt Lõi

### 1. Phân Tích Bài Toán & Xác Định Yêu Cầu Hệ Thống

- Phân tích quy trình kinh doanh nội thất TimberTech, xác định các hạn chế trong quản lý sản phẩm, đơn hàng, tồn kho và tổng hợp báo cáo.
- Xác định các nhóm người dùng và phạm vi nghiệp vụ: Khách hàng, Nhân viên bán hàng, Nhân viên kho, Nhân viên kế toán, Ban quản lý và Quản trị viên.
- Xây dựng yêu cầu chức năng (FR) và phi chức năng (NFR), tập trung vào quản lý dữ liệu, phân quyền người dùng, tính chính xác và khả năng vận hành hệ thống.
- Đặc tả Use Case với luồng xử lý chính, luồng thay thế, điều kiện thực hiện và quy tắc nghiệp vụ.

### 2. Phân Tích & Mô Hình Hóa Hệ Thống (UML Analysis)

- Xây dựng sơ đồ Use Case tổng thể và chi tiết nhằm xác định chức năng, tác nhân và phạm vi tương tác với hệ thống.
- Thiết kế Activity Diagram để mô tả luồng xử lý nghiệp vụ, các điều kiện kiểm tra và những tình huống phát sinh.
- Sử dụng Sequence Diagram và Communication Diagram để thể hiện trình tự tương tác giữa các đối tượng trong quá trình thực hiện chức năng.
- Phân tích các lớp đối tượng, thuộc tính, phương thức và mối quan hệ; xây dựng Class Diagram và thẻ CRC.
- Thiết kế State Diagram mô tả sự thay đổi trạng thái của đơn hàng, hóa đơn và chứng từ nhập – xuất kho.

### 3. Thiết Kế Kiến Trúc & Cơ Sở Dữ Liệu (System Design)

- Phân chia hệ thống thành các nhóm chức năng thông qua Package Diagram, hỗ trợ tổ chức và quản lý các thành phần phần mềm.
- Thiết kế kiến trúc 3 tầng, phân tách giao diện người dùng, xử lý nghiệp vụ và truy cập dữ liệu.
- Chuyển đổi mô hình lớp đối tượng sang cơ sở dữ liệu quan hệ trên SQL Server.
- Xây dựng các bảng dữ liệu, thiết lập khóa chính (PK), khóa ngoại (FK) và các mối quan hệ giữa bảng.
- Xây dựng và kiểm thử các ràng buộc toàn vẹn dữ liệu bằng SQL Trigger, góp phần kiểm soát tính hợp lệ và nhất quán của dữ liệu.
- Thiết kế Component Diagram và Deployment Diagram nhằm mô tả cấu trúc thành phần và phương án triển khai hệ thống.

### 4. Xây Dựng Chương Trình Mẫu (C# WinForms & SQL Server)

Phát triển ứng dụng quản lý bán hàng nội thất bằng C# WinForms, kết nối SQL Server, với các chức năng tiêu biểu:

- **Đăng nhập & phân quyền:** Xác thực tài khoản và hỗ trợ truy cập chức năng theo vai trò người dùng.
- **Quản lý sản phẩm:** Thêm, sửa, xóa, tìm kiếm và cập nhật thông tin sản phẩm nội thất.
- **Quản lý khách hàng:** Lưu trữ, cập nhật và tra cứu thông tin khách hàng.
- **Quản lý đơn hàng:** Theo dõi, tìm kiếm và cập nhật trạng thái xử lý đơn hàng.
- **Quản lý kho:** Quản lý phiếu nhập kho, phiếu xuất kho và dữ liệu hàng hóa liên quan.
- **Quản lý hóa đơn:** Tra cứu, quản lý thông tin hóa đơn và hỗ trợ xuất báo cáo.
- **Báo cáo & thống kê:** Tổng hợp dữ liệu phục vụ theo dõi hoạt động bán hàng.

Chương trình mẫu tập trung hiện thực hóa các chức năng quản lý trọng tâm và kiểm tra khả năng kết nối, truy xuất, cập nhật dữ liệu giữa giao diện ứng dụng và SQL Server.

## 📌 Kết Quả Đạt Được

- Hoàn thiện tài liệu phân tích và thiết kế hướng đối tượng cho hệ thống quản lý bán hàng nội thất TimberTech.
- Xây dựng hệ thống sơ đồ UML, mô tả chức năng, quy trình xử lý, cấu trúc đối tượng và kiến trúc phần mềm.
- Thiết kế cơ sở dữ liệu SQL Server, xây dựng bảng dữ liệu, mối quan hệ và kiểm thử các ràng buộc toàn vẹn.
- Xây dựng chương trình mẫu C# WinForms với các chức năng quản lý bán hàng, khách hàng, kho, hóa đơn và báo cáo.
- Vận dụng kiến thức phân tích nghiệp vụ, thiết kế hệ thống, lập trình hướng đối tượng và xử lý dữ liệu vào một bài toán quản lý thực tế.
## 🔮 Hướng Phát Triển

- Hoàn thiện các chức năng chưa được triển khai đầy đủ trong chương trình mẫu.
- Mở rộng ứng dụng sang nền tảng web hoặc mobile.
- Nghiên cứu tích hợp thanh toán trực tuyến và quản lý vận chuyển.
- Phát triển chức năng quản lý nhiều kho, nhiều chi nhánh.
- Tiếp tục cải thiện giao diện, khả năng bảo mật và hiệu suất xử lý dữ liệu.

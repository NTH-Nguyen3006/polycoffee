# PHÂN TÍCH VÀ XÁC ĐỊNH PHẠM VI KIỂM THỬ
## Hệ thống: Quản lý bán đồ uống – PolyCoffee

| Thông tin | Chi tiết |
|---|---|
| **Dự án** | PolyCoffee – Hệ thống quản lý bán đồ uống |
| **Người lập** | QA Team |
| **Ngày lập** | 05/04/2026 |
| **Phiên bản tài liệu** | v1.0 |
| **Trạng thái** | Đã phê duyệt |

---

## 1. CÁC CHỨC NĂNG CẦN KIỂM THỬ (In-Scope)

Dựa trên yêu cầu nghiệp vụ và phạm vi dự án, các chức năng sau **nằm trong phạm vi kiểm thử** của đợt kiểm thử này:

### 1.1 Chức năng Đăng nhập (Authentication)
| STT | Chức năng con | Mô tả |
|-----|---------------|-------|
| 1.1.1 | Đăng nhập bằng tài khoản & mật khẩu | Kiểm thử luồng đăng nhập hợp lệ và không hợp lệ |
| 1.1.2 | Xác thực phiên đăng nhập (Session/Token) | Kiểm thử JWT token, hết hạn phiên |
| 1.1.3 | Đăng xuất | Kiểm thử xóa phiên, redirect về trang login |
| 1.1.4 | Phân quyền theo vai trò | Admin, nhân viên pha chế, thu ngân có quyền truy cập đúng |
| 1.1.5 | Giới hạn số lần đăng nhập sai | Khóa tài khoản sau N lần nhập sai |

### 1.2 Chức năng Quản lý đồ uống (Product Management)
| STT | Chức năng con | Mô tả |
|-----|---------------|-------|
| 1.2.1 | Thêm đồ uống mới | Kiểm thử nhập tên, giá, danh mục, hình ảnh |
| 1.2.2 | Sửa thông tin đồ uống | Cập nhật giá, tên, mô tả, trạng thái |
| 1.2.3 | Xóa / Ẩn đồ uống | Xóa mềm – kiểm thử không hiển thị trên menu |
| 1.2.4 | Tìm kiếm & lọc đồ uống | Lọc theo danh mục, giá, trạng thái |
| 1.2.5 | Quản lý tùy chọn sản phẩm | Size, topping, đá/đường |

### 1.3 Chức năng Quản lý hoá đơn (Invoice Management)
| STT | Chức năng con | Mô tả |
|-----|---------------|-------|
| 1.3.1 | Tạo hoá đơn mới | Thêm sản phẩm vào đơn hàng, chọn bàn |
| 1.3.2 | Cập nhật hoá đơn | Thêm/xóa sản phẩm, điều chỉnh số lượng |
| 1.3.3 | Tính tổng tiền | Kiểm thử tính đúng giá, áp dụng khuyến mãi |
| 1.3.4 | Thanh toán hoá đơn | Tiền mặt, chuyển khoản, quét QR |
| 1.3.5 | In hoá đơn | Xuất PDF, in nhiệt |
| 1.3.6 | Hủy hoá đơn | Kiểm thử quyền hủy, lý do hủy |
| 1.3.7 | Lịch sử hoá đơn | Tra cứu theo ngày, trạng thái, nhân viên |

### 1.4 Chức năng Quản lý nhân viên (Staff Management)
| STT | Chức năng con | Mô tả |
|-----|---------------|-------|
| 1.4.1 | Thêm nhân viên mới | Nhập thông tin cơ bản, gán vai trò |
| 1.4.2 | Sửa thông tin nhân viên | Cập nhật số điện thoại, chức vụ |
| 1.4.3 | Vô hiệu hóa tài khoản | Khóa nhân viên nghỉ việc |
| 1.4.4 | Phân quyền nhân viên | Gán/thu hồi quyền truy cập |

---

## 2. CÁC CHỨC NĂNG KHÔNG NẰM TRONG PHẠM VI KIỂM THỬ (Out-of-Scope)

Các chức năng sau **không thuộc phạm vi** đợt kiểm thử này do giới hạn thời gian, ngân sách, hoặc chưa hoàn thiện phát triển:

| STT | Chức năng | Lý do loại khỏi phạm vi |
|-----|-----------|-------------------------|
| 2.1 | Báo cáo thống kê doanh thu | Module đang trong giai đoạn phát triển, chưa ổn định |
| 2.2 | Tích hợp thanh toán bên thứ ba (VNPay, Momo) | Chưa có API key môi trường test, cần đợt kiểm thử riêng |
| 2.3 | Quản lý nhà cung cấp / nguyên liệu | Nằm ngoài yêu cầu nghiệp vụ đợt 1 |
| 2.4 | Ứng dụng di động (Mobile App) | Chỉ kiểm thử web version, mobile sẽ có sprint riêng |
| 2.5 | Chức năng đặt bàn trực tuyến | Tính năng dự kiến phát triển trong Phase 2 |
| 2.6 | Kiểm thử hiệu năng (Load/Stress Testing) | Sẽ được thực hiện trong giai đoạn UAT |
| 2.7 | Kiểm thử bảo mật (Penetration Testing) | Có kế hoạch kiểm thử riêng bởi Security Team |
| 2.8 | Tích hợp phần mềm kế toán | Phụ thuộc module bên thứ ba chưa sẵn sàng |

---

## 3. MỤC TIÊU KIỂM THỬ

### 3.1 Mục tiêu tổng quát
Đảm bảo hệ thống PolyCoffee hoạt động đúng theo yêu cầu nghiệp vụ, ổn định, và sẵn sàng ra mắt người dùng cuối trong môi trường thực tế tại các cơ sở kinh doanh đồ uống.

### 3.2 Mục tiêu cụ thể

| # | Mục tiêu | Mô tả chi tiết |
|---|----------|----------------|
| M1 | **Xác minh tính đúng đắn (Correctness)** | Tất cả chức năng hoạt động đúng theo đặc tả yêu cầu nghiệp vụ. Tính toán giá, tổng tiền, áp dụng khuyến mãi phải chính xác 100%. |
| M2 | **Đảm bảo tính toàn vẹn dữ liệu (Data Integrity)** | Dữ liệu hoá đơn, nhân viên, sản phẩm không bị mất, sai lệch sau khi tạo, sửa, xóa. |
| M3 | **Kiểm tra phân quyền (Authorization)** | Mỗi vai trò chỉ được phép thực hiện đúng các thao tác được cấp phép. Không có leo thang đặc quyền. |
| M4 | **Đảm bảo luồng nghiệp vụ (Business Flow)** | Luồng tạo đơn → xử lý → thanh toán → in hoá đơn hoạt động liền mạch, không bị gián đoạn. |
| M5 | **Kiểm thử trường hợp ngoại lệ (Exception Handling)** | Hệ thống xử lý đúng các trường hợp lỗi: dữ liệu rỗng, định dạng sai, mất kết nối. |
| M6 | **Phát hiện lỗi hồi quy (Regression)** | Các chức năng cũ không bị ảnh hưởng sau khi thêm tính năng mới. |

---

## 4. PHÂN TÍCH RỦI RO KIỂM THỬ

### Rủi ro 1: Dữ liệu kiểm thử không đủ thực tế
| Tiêu chí | Nội dung |
|----------|---------|
| **Mô tả rủi ro** | Môi trường kiểm thử sử dụng dữ liệu mẫu (mock data) không phản ánh đủ các tình huống thực tế tại quán (giờ cao điểm, nhiều đơn đồng thời, sản phẩm hết hàng). |
| **Khả năng xảy ra** | Cao (70%) |
| **Mức độ ảnh hưởng** | Cao – Có thể bỏ sót lỗi chỉ xuất hiện trên dữ liệu thực. |
| **Mức độ nghiêm trọng tổng hợp** | 🔴 **Critical** |
| **Biện pháp giảm thiểu** | Yêu cầu PO cung cấp dump dữ liệu thực (đã ẩn danh hóa) từ môi trường production cũ. Bổ sung kịch bản kiểm thử đa người dùng. |

### Rủi ro 2: Thay đổi yêu cầu giữa chừng (Requirement Instability)
| Tiêu chí | Nội dung |
|----------|---------|
| **Mô tả rủi ro** | Business Analyst / Product Owner thay đổi yêu cầu về luồng thanh toán hoặc cách tính giảm giá trong quá trình kiểm thử, dẫn đến test case cũ không còn phù hợp và phải viết lại. |
| **Khả năng xảy ra** | Trung bình (45%) |
| **Mức độ ảnh hưởng** | Cao – Mất thời gian viết lại test case, trễ tiến độ 2-3 ngày. |
| **Mức độ nghiêm trọng tổng hợp** | 🟠 **High** |
| **Biện pháp giảm thiểu** | Đóng băng (freeze) tài liệu yêu cầu trước khi bắt đầu kiểm thử. Thiết lập quy trình Change Request (CR) chính thức cho mọi thay đổi sau freeze. |

### Rủi ro 3: Môi trường kiểm thử không ổn định
| Tiêu chí | Nội dung |
|----------|---------|
| **Mô tả rủi ro** | Server kiểm thử bị downtime, database bị reset không có kế hoạch, hoặc cấu hình môi trường (API URL, cổng kết nối) khác với production dẫn đến kết quả kiểm thử không đáng tin cậy. |
| **Khả năng xảy ra** | Trung bình (40%) |
| **Mức độ ảnh hưởng** | Trung bình – Gián đoạn tiến độ, tester mất thời gian chờ hệ thống phục hồi. |
| **Mức độ nghiêm trọng tổng hợp** | 🟡 **Medium** |
| **Biện pháp giảm thiểu** | Thiết lập môi trường kiểm thử riêng biệt với production. Có quy trình backup/restore database test hàng ngày. Sử dụng Docker container để đảm bảo tính nhất quán môi trường. |

### Rủi ro 4: Thiếu nhân lực kiểm thử
| Tiêu chí | Nội dung |
|----------|---------|
| **Mô tả rủi ro** | Đội QA có ít thành viên, phải kiểm thử đồng thời nhiều module trong thời gian ngắn. |
| **Khả năng xảy ra** | Trung bình (50%) |
| **Mức độ ảnh hưởng** | Trung bình – Có thể bỏ sót test case, giảm độ phủ kiểm thử. |
| **Mức độ nghiêm trọng tổng hợp** | 🟡 **Medium** |
| **Biện pháp giảm thiểu** | Ưu tiên kiểm thử các chức năng core (đăng nhập, hoá đơn, thanh toán). Áp dụng Risk-Based Testing. Nhờ developer tham gia kiểm thử đơn vị (unit test) để giảm gánh nặng cho QA. |

### Ma trận rủi ro tổng hợp

```
                    MỨC ĐỘ ẢNH HƯỞNG
                  Thấp    Trung bình    Cao
                 +-------+-----------+------+
Cao              |       |           |  R1  |
                 +-------+-----------+------+
Trung bình       |       |  R3, R4   |  R2  |
                 +-------+-----------+------+
Thấp             |       |           |      |
                 +-------+-----------+------+
KHẢ NĂNG XẢY RA
```

---

*Tài liệu này được cập nhật lần cuối: 05/04/2026 | Phiên bản: 1.0*

# TEST PLAN – CHỨC NĂNG QUẢN LÝ HOÁ ĐƠN
## Dự án: PolyCoffee – Hệ thống quản lý bán đồ uống

---

## THÔNG TIN TÀI LIỆU

| Trường | Nội dung |
|--------|----------|
| **Tên tài liệu** | Test Plan – Quản lý Hoá đơn |
| **Mã tài liệu** | TP-POLYCOFFEE-INV-001 |
| **Phiên bản** | 1.0 |
| **Dự án** | PolyCoffee |
| **Module** | Quản lý Hoá đơn (Invoice Management) |
| **Người lập** | QA Lead – Nguyễn Thị H. |
| **Người phê duyệt** | Project Manager – Trần Văn A. |
| **Ngày lập** | 05/04/2026 |
| **Ngày phê duyệt** | 06/04/2026 |
| **Trạng thái** | Draft → Review → **Approved** |

---

## LỊCH SỬ THAY ĐỔI

| Phiên bản | Ngày | Người thực hiện | Mô tả thay đổi |
|-----------|------|-----------------|----------------|
| 0.1 | 01/04/2026 | Nguyễn Thị H. | Tạo draft ban đầu |
| 0.2 | 03/04/2026 | Nguyễn Thị H. | Bổ sung chiến lược kiểm thử |
| 1.0 | 05/04/2026 | Nguyễn Thị H. | Hoàn thiện, gửi phê duyệt |

---

## 1. GIỚI THIỆU

### 1.1 Mục đích
Test Plan này mô tả chiến lược, phạm vi, tài nguyên và lịch trình kiểm thử cho module **Quản lý Hoá đơn** của hệ thống PolyCoffee. Tài liệu được sử dụng bởi đội QA, Developer, và Project Manager để đảm bảo sự đồng thuận về cách thức thực hiện kiểm thử.

### 1.2 Đối tượng sử dụng tài liệu
- QA Engineer / Test Lead
- Developer (review để hiểu phạm vi test)
- Project Manager (theo dõi tiến độ)
- Business Analyst (xác nhận test coverage)

### 1.3 Tài liệu tham chiếu
| STT | Tài liệu | Phiên bản |
|-----|----------|-----------|
| 1 | Software Requirements Specification (SRS) | v2.1 |
| 2 | System Design Document | v1.3 |
| 3 | API Design Document – Invoice Module | v1.0 |
| 4 | DB Schema – polycoffee | Latest |
| 5 | PhanTich_PhamViKiemThu.md | v1.0 |

---

## 2. PHẠM VI KIỂM THỬ

### 2.1 Trong phạm vi (In-Scope)

| STT | Chức năng | Mô tả |
|-----|-----------|-------|
| 1 | **Tạo hoá đơn mới** | Tạo đơn hàng mới, thêm sản phẩm, chọn số lượng, ghi chú |
| 2 | **Cập nhật hoá đơn** | Sửa số lượng, thêm/xóa sản phẩm trong đơn chưa thanh toán |
| 3 | **Tính toán tổng tiền** | Giá cơ bản, số lượng, khuyến mãi, thuế (nếu có) |
| 4 | **Áp dụng khuyến mãi / mã giảm giá** | Validate mã giảm giá, tính số tiền được giảm |
| 5 | **Thanh toán hoá đơn** | Hỗ trợ tiền mặt, chuyển khoản; ghi nhận số tiền nhận và thối |
| 6 | **Hủy hoá đơn** | Hủy đơn chưa thanh toán, xác nhận lý do hủy |
| 7 | **In hoá đơn / xuất PDF** | Giao diện preview và in ra máy in nhiệt / xuất file |
| 8 | **Tra cứu lịch sử hoá đơn** | Lọc theo ngày, nhân viên, trạng thái, tổng tiền |
| 9 | **Phân quyền thao tác hoá đơn** | Nhân viên chỉ xem đơn của mình; admin xem tất cả |

### 2.2 Ngoài phạm vi (Out-of-Scope)

| STT | Chức năng | Lý do |
|-----|-----------|-------|
| 1 | Tích hợp VNPay / Momo | API bên thứ ba, kiểm thử trong sprint riêng |
| 2 | Kiểm thử hiệu năng hoá đơn | Thực hiện trong giai đoạn Performance Testing |
| 3 | Báo cáo doanh thu từ hoá đơn | Module báo cáo chưa hoàn thiện |
| 4 | Hoá đơn VAT điện tử (e-invoice) | Tính năng Phase 2 |

---

## 3. PHƯƠNG PHÁP TIẾP CẬN KIỂM THỬ

### 3.1 Kiểm thử thủ công (Manual Testing)
Áp dụng cho toàn bộ các chức năng trong phạm vi. Lý do:
- Module hoá đơn có nhiều luồng nghiệp vụ phức tạp cần kiểm tra thực tế qua UI
- Giai đoạn đầu dự án, yêu cầu có thể thay đổi – automation chưa ổn định
- Số lượng test case không quá lớn để áp dụng automation ngay

**Kỹ thuật kiểm thử thủ công áp dụng:**
- **Black-box Testing**: Kiểm thử từ góc nhìn người dùng, không quan tâm nội bộ code
- **Equivalence Partitioning (EP)**: Phân vùng tương đương cho dữ liệu đầu vào
- **Boundary Value Analysis (BVA)**: Kiểm thử các giá trị biên (số lượng = 0, 1, 999)
- **Error Guessing**: Đoán lỗi dựa trên kinh nghiệm (nhập ký tự đặc biệt, SQL injection cơ bản)

### 3.2 Kiểm thử tự động (Automation Testing) – *Dự kiến*
| Công cụ | Mục tiêu áp dụng | Thời gian áp dụng |
|---------|-----------------|-------------------|
| **Selenium WebDriver** | Automation regression test cho UI | Sprint 3 trở đi |
| **REST Assured / Postman** | API testing cho Invoice endpoints | Hiện tại (song song manual) |
| **JUnit 5 + Mockito** | Unit test bởi Developer | Trong quá trình phát triển |

---

## 4. CHIẾN LƯỢC KIỂM THỬ

### 4.1 Các cấp độ kiểm thử

```
┌─────────────────────────────────────┐
│         System Testing (QA)         │  ← Trọng tâm đợt này
├─────────────────────────────────────┤
│       Integration Testing (QA)      │
├─────────────────────────────────────┤
│        Unit Testing (Dev)           │
└─────────────────────────────────────┘
```

| Cấp độ | Người thực hiện | Công cụ | Trạng thái |
|--------|-----------------|---------|------------|
| Unit Testing | Developer | JUnit 5 | Hoàn thành trước khi giao QA |
| Integration Testing | QA + Dev | Postman, Swagger | Thực hiện song song |
| System Testing | QA | Manual, Postman | **Trọng tâm đợt này** |
| UAT | Product Owner | Manual | Sau khi System Test pass |

### 4.2 Ưu tiên kiểm thử (Risk-Based Testing)

| Mức ưu tiên | Chức năng | Lý do ưu tiên |
|-------------|-----------|---------------|
| 🔴 **P1 – Cao nhất** | Tạo hoá đơn, Thanh toán | Lõi nghiệp vụ, lỗi ảnh hưởng trực tiếp doanh thu |
| 🟠 **P2 – Cao** | Tính tổng tiền, Khuyến mãi | Ảnh hưởng tài chính, dễ gây sai số |
| 🟡 **P3 – Trung bình** | Hủy hoá đơn, In hoá đơn | Quan trọng nhưng ít critical hơn |
| 🟢 **P4 – Thấp** | Tra cứu lịch sử, Phân quyền | Chức năng hỗ trợ, ít rủi ro nghiệp vụ |

### 4.3 Chu trình kiểm thử

```
Nhận tài liệu yêu cầu
        ↓
Phân tích & viết Test Case
        ↓
Review Test Case (QA Lead duyệt)
        ↓
Chuẩn bị môi trường & dữ liệu
        ↓
Thực hiện kiểm thử
        ↓
Ghi nhận lỗi (Bug Report)
        ↓
Dev fix lỗi → Retest
        ↓
Kiểm thử hồi quy (Regression)
        ↓
Tổng kết & báo cáo
```

---

## 5. NGUỒN LỰC KIỂM THỬ

### 5.1 Nhân sự

| Vai trò | Tên | Trách nhiệm | Số lượng |
|---------|-----|-------------|---------|
| **QA Lead** | Nguyễn Thị H. | Lập kế hoạch, phân công, review bug, báo cáo tổng kết | 1 người |
| **QA Engineer** | Lê Văn B. | Viết & thực thi test case, log bug | 1 người |
| **QA Engineer** | Phạm Thị C. | Viết & thực thi test case, thực hiện retest | 1 người |
| **Developer (Support)** | Dev Team | Fix bug được báo cáo, hỗ trợ setup môi trường | 2 người |
| **Business Analyst** | Trần Văn D. | Clarify yêu cầu khi tester có thắc mắc | 1 người |

**Tổng thời gian kiểm thử ước tính:** 10 ngày làm việc (2 tuần)

### 5.2 Môi trường kiểm thử

| Hạng mục | Chi tiết |
|----------|---------|
| **Môi trường** | Staging Server (tách biệt hoàn toàn với Production) |
| **URL ứng dụng** | `https://staging.polycoffee.vn` |
| **Hệ điều hành Server** | Ubuntu 22.04 LTS |
| **Backend** | Java 17 + Spring Boot 3.x |
| **Frontend** | Vue.js 3 + Vite |
| **Database** | PostgreSQL 15 |
| **Trình duyệt kiểm thử** | Chrome 120+, Firefox 121+, Edge 120+ |
| **Độ phân giải màn hình** | 1920×1080, 1366×768 |
| **Database kiểm thử** | Bản sao database staging, seed data chuẩn bị sẵn |

### 5.3 Công cụ kiểm thử

| Công cụ | Mục đích | Ghi chú |
|---------|---------|---------|
| **Postman** | Kiểm thử API Invoice | Collection đã chuẩn bị sẵn |
| **Jira** | Quản lý test case, bug tracking | Dự án: POLYCOFFEE-QA |
| **Google Sheets / Excel** | Theo dõi tiến độ test | Daily test report |
| **Loom / OBS** | Ghi lại màn hình khi tái hiện bug | Đính kèm bug report |
| **DBeaver** | Kiểm tra dữ liệu trực tiếp trong DB | Để validate data integrity |

---

## 6. TIÊU CHÍ VÀO / RA KIỂM THỬ

### 6.1 Tiêu chí bắt đầu kiểm thử (Entry Criteria)

- [ ] Tài liệu yêu cầu (SRS) đã được phê duyệt và freeze
- [ ] Developer đã bàn giao build mới lên môi trường Staging
- [ ] Unit Test của Developer đạt tỷ lệ pass ≥ 90%
- [ ] Môi trường kiểm thử đã được cấu hình và hoạt động ổn định
- [ ] Dữ liệu kiểm thử (test data) đã được seed vào database
- [ ] Test Case đã được QA Lead phê duyệt
- [ ] Postman collection của API đã sẵn sàng

### 6.2 Tiêu chí kết thúc kiểm thử (Exit Criteria)

| Tiêu chí | Ngưỡng chấp nhận |
|----------|-----------------|
| Tỷ lệ test case đã thực thi | ≥ **95%** tổng số test case |
| Tỷ lệ test case PASS | ≥ **90%** số test case đã thực thi |
| Lỗi Severity **Critical** còn mở | **0** – Tất cả phải được fix và retest pass |
| Lỗi Severity **High** còn mở | ≤ **2** lỗi, có kế hoạch fix trong sprint tiếp theo |
| Lỗi Severity **Medium/Low** còn mở | Được phép tồn tại, có ghi nhận trong Known Issues |
| Kiểm thử hồi quy | Tất cả test case P1, P2 đã Retest pass sau fix |

### 6.3 Tiêu chí tạm dừng kiểm thử (Suspension Criteria)
Tạm dừng nếu:
- Môi trường Staging bị downtime > 4 giờ liên tục
- Phát hiện lỗi blocking (không thể vào màn hình chính) – cần Dev fix trước
- Fork yêu cầu lớn được PM chấp thuận thêm vào giữa sprint

---

## 7. LỊCH TRÌNH KIỂM THỬ

| Tuần | Công việc | Người thực hiện | Ngày bắt đầu | Ngày kết thúc |
|------|-----------|-----------------|-------------|----------------|
| Tuần 1 | Phân tích yêu cầu, viết Test Case | QA Team | 07/04/2026 | 09/04/2026 |
| Tuần 1 | Review & phê duyệt Test Case | QA Lead + BA | 09/04/2026 | 10/04/2026 |
| Tuần 1-2 | Thực thi kiểm thử (Round 1) | QA Engineer | 10/04/2026 | 16/04/2026 |
| Tuần 2 | Báo cáo lỗi, Dev fix bug | QA + Dev | 14/04/2026 | 17/04/2026 |
| Tuần 2 | Retest & Regression Testing | QA Team | 17/04/2026 | 18/04/2026 |
| Tuần 2 | Tổng kết, báo cáo Test Summary | QA Lead | 18/04/2026 | 18/04/2026 |

---

## 8. RỦI RO VÀ BIỆN PHÁP

| Rủi ro | Biện pháp |
|--------|-----------|
| Môi trường staging không ổn định | Có SLA với DevOps: uptime ≥ 95%, backup DB hàng ngày |
| Thay đổi yêu cầu sau khi freeze | Quy trình CR chính thức, tác động được đánh giá trước khi approve |
| Thiếu nguồn lực QA | Ưu tiên test P1, P2 trước; nhờ Dev tham gia smoke test |

---

## 9. PHÊ DUYỆT

| Vai trò | Họ tên | Chữ ký | Ngày |
|---------|--------|---------|------|
| QA Lead | Nguyễn Thị H. | .............. | 05/04/2026 |
| Project Manager | Trần Văn A. | .............. | 06/04/2026 |
| Business Analyst | Trần Văn D. | .............. | 06/04/2026 |

---

*Tài liệu này thuộc sở hữu của dự án PolyCoffee. Mọi thay đổi phải được QA Lead và PM phê duyệt.*

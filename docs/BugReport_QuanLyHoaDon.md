# BUG REPORT – CHỨC NĂNG TẠO VÀ XỬ LÝ HOÁ ĐƠN
## Dự án: PolyCoffee | Module: Invoice Management

---

## THÔNG TIN TÀI LIỆU

| Trường | Nội dung |
|--------|----------|
| **Mã tài liệu** | BR-POLYCOFFEE-INV-001 |
| **Phiên bản** | 1.0 |
| **Dự án** | PolyCoffee |
| **Người kiểm thử** | QA Engineer – Lê Văn B. |
| **Ngày kiểm thử** | 05/04/2026 |
| **Môi trường** | Staging – `https://staging.polycoffee.vn` |
| **Build version** | v1.2.3-staging |
| **Trình duyệt** | Chrome 120.0.6099.130 |
| **OS** | Ubuntu 22.04 LTS |

---

## 1. KẾT QUẢ THỰC HIỆN KIỂM THỬ

### 1.1 Tóm tắt thực thi

| Test Case ID | Tên Test Case | Kết quả | Ghi chú |
|-------------|---------------|---------|---------|
| TC-INV-001 | Tạo hoá đơn mới thành công | ✅ PASS | – |
| TC-INV-002 | Thêm sản phẩm vào đơn | ✅ PASS | – |
| TC-INV-003 | Thanh toán tiền mặt | ❌ **FAIL** | → Bug BUG-001 |
| TC-INV-004 | Áp dụng mã giảm giá hợp lệ | ❌ **FAIL** | → Bug BUG-002 |
| TC-INV-005 | Tạo đơn khi giỏ hàng trống | ✅ PASS | – |
| TC-INV-006 | Số lượng sản phẩm không hợp lệ | ✅ PASS | – |
| TC-INV-007 | Thanh toán thiếu tiền | ✅ PASS | – |
| TC-INV-008 | Mã giảm giá hết hạn | ✅ PASS | – |

**Tổng kết:** 6/8 PASS (75%) | 2/8 FAIL (25%) | 0 BLOCKED

---

## 2. CHI TIẾT BÁO CÁO LỖI

---

### BUG-001 – Tính tiền thối sai khi thanh toán tiền mặt

#### 2.1.1 Thông tin tổng quan

| Trường | Nội dung |
|--------|---------|
| **Bug ID** | BUG-POLYCOFFEE-INV-001 |
| **Tên lỗi** | Tiền thối tính sai – hiển thị âm khi khách đưa đúng tiền tròn |
| **Test Case liên quan** | TC-INV-003 |
| **Module** | Thanh toán hoá đơn – Payment Processing |
| **Phiên bản phát hiện** | v1.2.3-staging |
| **Người phát hiện** | Lê Văn B. |
| **Ngày phát hiện** | 05/04/2026 |
| **Trạng thái** | 🔴 **Open – Assigned** |
| **Mức độ nghiêm trọng (Severity)** | 🔴 **Critical** |
| **Mức độ ưu tiên (Priority)** | 🔴 **P1 – Immediate** |
| **Người được giao xử lý** | Developer – Phạm Văn E. |

#### 2.1.2 Mô tả lỗi

Khi nhân viên thu ngân nhập số tiền khách đưa **đúng bằng** tổng tiền hoá đơn (ví dụ: tổng tiền = 85,000 VNĐ, tiền nhận = 85,000 VNĐ), hệ thống tính tiền thối hiển thị **-0 VNĐ** hoặc **-1 VNĐ** thay vì **0 VNĐ**. Ngoài ra, trong một số trường hợp khi tổng tiền có số lẻ (vd: 84,500 VNĐ), phép tính thối ra số âm dù tiền nhận lớn hơn.

**Ảnh hưởng:** Lỗi gây mất niềm tin của nhân viên vào hệ thống, có thể dẫn đến thối tiền sai cho khách hàng, **ảnh hưởng trực tiếp đến doanh thu và nghiệp vụ kinh doanh**.

#### 2.1.3 Steps to Reproduce

| Bước | Hành động | Dữ liệu cụ thể |
|------|-----------|----------------|
| 1 | Đăng nhập với tài khoản thu ngân | `cashier01` / `Test@1234` |
| 2 | Tạo hoá đơn mới với: 2 Cà phê sữa đá (M, 29,000đ/cái) + 1 Trà đào cam sả (L, 27,000đ) | Tổng = 85,000đ |
| 3 | Nhấn **"Thanh toán"**, chọn "Tiền mặt" | – |
| 4 | Nhập số tiền khách đưa = **85,000** | `85000` |
| 5 | Quan sát phần hiển thị "Tiền thối" | – |
| 6 | Nhấn **"Xác nhận thanh toán"** | – |
| 7 | Kiểm tra dữ liệu trong DB bảng `payment` | Cột `change_amount` |

#### 2.1.4 Actual Result vs Expected Result

| | Kết quả |
|---|---------|
| **Expected Result** | Tiền thối hiển thị: **0 VNĐ** (hoặc "Không cần thối tiền"). Sau khi thanh toán, `change_amount` trong DB = `0`. |
| **Actual Result** | Tiền thối hiển thị: **-1 VNĐ** (hoặc **-0 VNĐ**). Khi xác nhận thanh toán, DB lưu `change_amount = -1`. Trạng thái hoá đơn vẫn chuyển thành `PAID` (lỗi không chặn thanh toán). |

#### 2.1.5 Bằng chứng (Evidence)

```
# Log API response khi gọi POST /api/v1/invoices/{id}/payment
{
  "invoiceId": "INV-20260405-001",
  "totalAmount": 85000,
  "receivedAmount": 85000,
  "changeAmount": -1,    ← GIÁ TRỊ SAI (phải là 0)
  "status": "PAID",
  "paymentMethod": "CASH"
}
```

#### 2.1.6 Phân loại mức độ nghiêm trọng (Severity Classification)

| Cấp độ | Mô tả |
|--------|-------|
| 🔴 **Critical** | Lỗi xảy ra trên luồng nghiệp vụ chính (core business flow). Dữ liệu lưu sai vào DB gây ảnh hưởng báo cáo tài chính. Có thể gây thối tiền sai cho khách. |

**Lý do chọn Critical:**
- Ảnh hưởng trực tiếp đến tài chính (dữ liệu `change_amount` âm trong report)
- Xảy ra 100% khi tiền nhận = tổng tiền (tình huống rất phổ biến)
- Không có workaround an toàn cho nhân viên

#### 2.1.7 Thông tin kỹ thuật bổ sung

**Phán đoán nguyên nhân (Root Cause Analysis – sơ bộ):**
Có thể do lỗi tính toán floating point trong JavaScript frontend:
```javascript
// Có thể lỗi tại đây:
const change = receivedAmount - totalAmount;
// Khi receivedAmount = 85000 và totalAmount = 85000.001 (lỗi làm tròn),
// change = -0.001, sau đó Math.round() → -1
```
Hoặc lỗi làm tròn ở tầng backend trước khi trả về response.

---

### BUG-002 – Mã giảm giá áp dụng đúng nhưng tổng tiền không được cập nhật trên UI

#### 2.2.1 Thông tin tổng quan

| Trường | Nội dung |
|--------|---------|
| **Bug ID** | BUG-POLYCOFFEE-INV-002 |
| **Tên lỗi** | UI không cập nhật tổng tiền sau khi áp dụng mã giảm giá thành công |
| **Test Case liên quan** | TC-INV-004 |
| **Module** | Áp dụng khuyến mãi – Promotion/Discount |
| **Phiên bản phát hiện** | v1.2.3-staging |
| **Người phát hiện** | Phạm Thị C. |
| **Ngày phát hiện** | 05/04/2026 |
| **Trạng thái** | 🟠 **Open – Assigned** |
| **Mức độ nghiêm trọng (Severity)** | 🟠 **High** |
| **Mức độ ưu tiên (Priority)** | 🟠 **P2 – Urgent** |
| **Người được giao xử lý** | Developer – Nguyễn Thị F. |

#### 2.2.1 Mô tả lỗi

Khi nhân viên nhập mã giảm giá hợp lệ (`SUMMER20`) và hệ thống trả về thông báo "Áp dụng thành công", **tổng tiền hiển thị trên màn hình hoá đơn không được cập nhật** – vẫn hiển thị giá gốc (120,000 VNĐ) thay vì giá sau giảm (96,000 VNĐ). Tuy nhiên, khi chuyển sang màn hình thanh toán, giá đúng (96,000 VNĐ) lại được hiển thị.

**Ảnh hưởng:** Nhân viên không biết mã giảm giá đã được áp dụng hay chưa, dẫn đến thao tác nhập mã lại nhiều lần, hoặc nhầm lẫn khi thông báo số tiền cần thanh toán với khách hàng.

#### 2.2.2 Steps to Reproduce

| Bước | Hành động | Dữ liệu cụ thể |
|------|-----------|----------------|
| 1 | Đăng nhập với tài khoản thu ngân | `cashier01` / `Test@1234` |
| 2 | Tạo hoá đơn: 3 Trà sữa trân châu Size M (40,000đ/cái) | Tổng = 120,000đ |
| 3 | Tại màn hình chi tiết đơn, nhấn **"Áp dụng mã giảm giá"** | – |
| 4 | Nhập mã `SUMMER20`, nhấn **"Kiểm tra mã"** | `SUMMER20` |
| 5 | Quan sát thông báo phản hồi | – |
| 6 | Quan sát tổng tiền hiển thị trên đơn hàng | – |
| 7 | Nhấn **"Thanh toán"** và quan sát tổng tiền màn hình thanh toán | – |

#### 2.2.3 Actual Result vs Expected Result

| | Kết quả |
|---|---------|
| **Expected Result** | Sau khi áp dụng mã: Màn hình đơn hàng hiển thị **"Giảm giá: -24,000 VNĐ"** và **"Tổng cộng: 96,000 VNĐ"** ngay lập tức, không cần reload trang. |
| **Actual Result** | Toast thông báo "Áp dụng mã giảm giá thành công!" nhưng tổng tiền trên màn hình **vẫn giữ nguyên 120,000 VNĐ**. Dòng giảm giá không xuất hiện. Chỉ khi nhấn sang màn hình "Thanh toán" mới hiển thị đúng 96,000 VNĐ. |

#### 2.2.4 Bằng chứng (Evidence)

```
# API GET /api/v1/invoices/{id} sau khi apply promotion → ĐÚNG:
{
  "invoiceId": "INV-20260405-002",
  "subtotal": 120000,
  "discountAmount": 24000,
  "totalAmount": 96000,           ← API trả đúng
  "appliedPromotion": "SUMMER20"
}

# Nhưng Vue component không re-render lại totalAmount
# Console log: totalAmount.value vẫn = 120000 (reactive state chưa được cập nhật)
```

**Nguyên nhân sơ bộ:** Frontend sử dụng Vue.js, có thể tồn tại lỗi reactive state – sau khi gọi API thành công, giá trị `totalAmount` trong store/composable không được cập nhật đúng cách khiến component hiển thị dữ liệu cũ.

#### 2.2.5 Phân loại mức độ nghiêm trọng (Severity Classification)

| Cấp độ | Mô tả |
|--------|-------|
| 🟠 **High** | Lỗi ảnh hưởng đến trải nghiệm người dùng và có thể gây nhầm lẫn trong nghiệp vụ. Tuy nhiên, dữ liệu trong DB đúng và thanh toán thực tế vẫn tính đúng số tiền. Có workaround (sang màn hình thanh toán để xem số tiền đúng). |

**Lý do chọn High (không phải Critical):**
- Dữ liệu backend / DB đúng – không gây sai sót tài chính thực tế
- Có workaround tạm thời
- Nhưng gây confusion nghiêm trọng cho nhân viên, cần fix trước khi release

---

## 3. VÒNG ĐỜI LỖI (BUG LIFECYCLE)

### 3.1 Mô tả vòng đời lỗi từ phát hiện đến đóng lỗi

```
 ┌──────────────┐
 │     NEW      │  ← QA phát hiện lỗi, tạo bug report
 └──────┬───────┘
        │ QA log bug, điền đầy đủ thông tin
        ▼
 ┌──────────────┐
 │   ASSIGNED   │  ← Team Lead / PM giao bug cho Developer phụ trách
 └──────┬───────┘
        │ Developer nhận bug, xác nhận có thể tái hiện
        ▼
 ┌──────────────────┐
 │   IN PROGRESS    │  ← Developer đang phân tích và sửa lỗi
 └──────┬───────────┘
        │
        ├─── Không tái hiện được lỗi ──→ ┌─────────────┐
        │                                 │  NEED INFO  │ ← Yêu cầu QA bổ sung
        │                                 └──────┬──────┘   thông tin
        │                                        │
        │                                 QA bổ sung steps,
        │                                 screenshot, log
        │                                        │
        │◄───────────────────────────────────────┘
        │
        │ Developer fix xong, push code lên staging
        ▼
 ┌──────────────┐
 │    FIXED     │  ← Developer cập nhật trạng thái, ghi commit ID
 └──────┬───────┘     "Fix: BUG-001 – Correct change amount calculation"
        │ QA nhận thông báo, tiến hành retest
        ▼
 ┌──────────────┐
 │   RETESTING  │  ← QA thực hiện lại các bước tái hiện lỗi
 └──────┬───────┘
        │
        ├─── Lỗi vẫn còn ──→ ┌──────────────┐
        │                     │   REOPENED   │ ← Trả về cho Developer
        │                     └──────┬───────┘
        │                            │
        │                     ← Quay lại IN PROGRESS
        │
        │ Lỗi đã được sửa, retest PASS
        ▼
 ┌──────────────┐
 │    CLOSED    │  ← QA xác nhận lỗi đã sửa, đóng bug report
 └──────────────┘
```

### 3.2 Chi tiết vòng đời từng trạng thái

| Trạng thái | Người thực hiện | Hành động | Điều kiện chuyển trạng thái |
|-----------|-----------------|-----------|---------------------------|
| **NEW** | QA Engineer | Phát hiện lỗi, tạo bug report đầy đủ trên Jira | Bug được PM/QA Lead xem xét |
| **ASSIGNED** | PM / QA Lead | Review bug, đánh giá severity, giao cho Dev | Dev xác nhận nhận task |
| **IN PROGRESS** | Developer | Phân tích root cause, viết code fix, unit test | Dev push code fix lên staging |
| **NEED INFO** | Developer → QA | Yêu cầu thêm thông tin từ QA nếu không tái hiện được | QA cung cấp đủ thông tin |
| **FIXED** | Developer | Cập nhật Jira: đã fix, kèm commit/PR ID | QA nhận để retest |
| **RETESTING** | QA Engineer | Thực hiện lại các bước tái hiện lỗi, kiểm tra kỹ | Lỗi pass hoặc vẫn fail |
| **REOPENED** | QA Engineer | Lỗi vẫn còn sau retest, trả về cho Dev | Dev tiếp tục fix |
| **CLOSED** | QA Lead | Xác nhận lỗi đã fix hoàn toàn, đóng bug | – |

### 3.3 Áp dụng vào BUG-001 và BUG-002

#### BUG-001 – Tiền thối tính sai
| Thời gian | Trạng thái | Người thực hiện | Ghi chú |
|-----------|-----------|-----------------|---------|
| 05/04/2026 14:30 | **NEW** | Lê Văn B. (QA) | Phát hiện khi thực thi TC-INV-003 |
| 05/04/2026 15:00 | **ASSIGNED** | QA Lead → Dev Phạm Văn E. | Severity: Critical, Priority: P1 |
| 06/04/2026 09:00 | **IN PROGRESS** | Phạm Văn E. (Dev) | Phát hiện lỗi làm tròn số thập phân |
| 07/04/2026 11:00 | **FIXED** | Phạm Văn E. (Dev) | Commit: `fix/inv-change-calculation #a3f2b1` |
| 07/04/2026 14:00 | **RETESTING** | Phạm Thị C. (QA) | Retest TC-INV-003 và các edge case |
| 07/04/2026 15:30 | **CLOSED** | QA Lead | Retest PASS, đóng bug |

**Tổng thời gian xử lý: 1 ngày 1 giờ 30 phút**

#### BUG-002 – UI không cập nhật tổng tiền
| Thời gian | Trạng thái | Người thực hiện | Ghi chú |
|-----------|-----------|-----------------|---------|
| 05/04/2026 16:00 | **NEW** | Phạm Thị C. (QA) | Phát hiện khi thực thi TC-INV-004 |
| 05/04/2026 16:30 | **ASSIGNED** | QA Lead → Dev Nguyễn Thị F. | Severity: High, Priority: P2 |
| 06/04/2026 10:00 | **IN PROGRESS** | Nguyễn Thị F. (Dev) | Tìm lỗi Vue reactive state |
| 06/04/2026 14:00 | **NEED INFO** | → QA | Hỏi thêm: "Lỗi có xảy ra cả khi reload page không?" |
| 06/04/2026 14:30 | **IN PROGRESS** | QA trả lời → Dev | Sau reload page thì hiển thị đúng |
| 07/04/2026 08:00 | **FIXED** | Nguyễn Thị F. (Dev) | Commit: `fix/inv-discount-ui-reactivity #b7d9c4` |
| 07/04/2026 10:00 | **RETESTING** | Lê Văn B. (QA) | Retest TC-INV-004 |
| 07/04/2026 10:30 | **REOPENED** | Lê Văn B. (QA) | Lỗi vẫn còn khi áp dụng lần 2 liên tiếp |
| 07/04/2026 14:00 | **FIXED** | Nguyễn Thị F. (Dev) | Fix bổ sung: `fix/inv-discount-ui-reactivity-v2 #c1e8a2` |
| 08/04/2026 09:00 | **RETESTING** | Lê Văn B. (QA) | Retest đầy đủ toàn bộ luồng giảm giá |
| 08/04/2026 10:00 | **CLOSED** | QA Lead | Retest PASS tất cả scenarios, đóng bug |

**Tổng thời gian xử lý: 2 ngày 18 giờ (có 1 lần Reopen)**

---

## 4. BÁO CÁO TỔNG KẾT KIỂM THỬ (Test Summary Report)

| Hạng mục | Số lượng / Tỷ lệ |
|----------|-----------------|
| Tổng số Test Case thực thi | 8 |
| Test Case PASS | 6 (75%) |
| Test Case FAIL | 2 (25%) |
| Tổng số Bug phát hiện | 2 |
| Bug Critical | 1 (BUG-001) |
| Bug High | 1 (BUG-002) |
| Bug đã đóng (Closed) | 2 (100% sau retest) |
| Tỷ lệ bug đã xử lý | 100% |

### Kết luận
> ✅ **Đủ điều kiện release** sau khi:
> - BUG-001 (Critical) đã được fix và retest PASS
> - BUG-002 (High) đã được fix và retest PASS (bao gồm cả regression test)
> - Không còn bug **Critical** hoặc **High** nào ở trạng thái **Open**

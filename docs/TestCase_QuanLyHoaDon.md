# TEST CASE – CHỨC NĂNG TẠO VÀ XỬ LÝ HOÁ ĐƠN
## Dự án: PolyCoffee | Module: Invoice Management

---

## THÔNG TIN TÀI LIỆU

| Trường | Nội dung |
|--------|----------|
| **Mã tài liệu** | TC-POLYCOFFEE-INV-001 |
| **Phiên bản** | 1.0 |
| **Module kiểm thử** | Tạo và xử lý hoá đơn |
| **Người viết** | QA Engineer – Lê Văn B. |
| **Người review** | QA Lead – Nguyễn Thị H. |
| **Ngày tạo** | 05/04/2026 |
| **Môi trường** | Staging – `https://staging.polycoffee.vn` |
| **Trình duyệt** | Chrome 120+ |

---

## TỔNG QUAN TEST CASE

| Tổng số TC | Happy Path | Invalid/Exception | Mức ưu tiên |
|-----------|-----------|-----------------|-------------|
| 8 | 4 | 4 | P1: 5 TC, P2: 3 TC |

---

## CHI TIẾT TEST CASE

---

### TC-INV-001 – Tạo hoá đơn mới thành công (Happy Path)

| Hạng mục | Nội dung |
|----------|---------|
| **Test Case ID** | TC-INV-001 |
| **Unit to Test** | Tạo hoá đơn mới – Màn hình "Tạo đơn hàng" |
| **Loại kiểm thử** | ✅ Happy Path |
| **Mức ưu tiên** | 🔴 P1 – Critical |
| **Điều kiện tiên quyết** | - Đã đăng nhập với tài khoản nhân viên thu ngân (role: CASHIER) <br> - Có ít nhất 2 sản phẩm đang hoạt động trong danh mục |

**Test Data:**

| Trường | Giá trị |
|--------|---------|
| Sản phẩm 1 | Cà phê sữa đá – Số lượng: 2 – Size: M |
| Sản phẩm 2 | Trà đào cam sả – Số lượng: 1 – Size: L |
| Ghi chú | "Ít đường, nhiều đá" |
| Bàn | Bàn số 5 |
| Phương thức thanh toán | Chưa áp dụng (chỉ tạo đơn) |

**Steps to Execute:**

| Bước | Hành động | Dữ liệu nhập |
|------|-----------|-------------|
| 1 | Đăng nhập hệ thống | Username: `cashier01`, Password: `Test@1234` |
| 2 | Vào menu **"Bán hàng" → "Tạo đơn hàng mới"** | – |
| 3 | Chọn **Bàn số 5** từ danh sách bàn | Bàn 5 |
| 4 | Tìm và thêm "Cà phê sữa đá" vào đơn | Nhập tên vào ô tìm kiếm |
| 5 | Chọn Size M, nhập số lượng = 2 | Size: M, SL: 2 |
| 6 | Thêm "Trà đào cam sả" vào đơn | Nhập tên vào ô tìm kiếm |
| 7 | Chọn Size L, nhập số lượng = 1 | Size: L, SL: 1 |
| 8 | Nhập ghi chú "Ít đường, nhiều đá" | Ghi chú đơn hàng |
| 9 | Nhấn nút **"Lưu đơn hàng"** | – |

**Expected Result:**

| # | Kết quả mong đợi |
|---|-----------------|
| 1 | Hệ thống tạo thành công hoá đơn mới với trạng thái **"Đang phục vụ"** |
| 2 | Mã hoá đơn được sinh tự động (vd: `INV-20260405-001`) |
| 3 | Danh sách sản phẩm trong đơn hiển thị đúng: 2 Cà phê sữa đá M + 1 Trà đào cam sả L |
| 4 | Tổng tiền tạm tính = (Giá CFSĐ × 2) + (Giá TĐCS × 1) |
| 5 | Ghi chú "Ít đường, nhiều đá" được lưu và hiển thị |
| 6 | Bàn số 5 chuyển sang trạng thái **"Đang có khách"** (màu đỏ/vàng) |
| 7 | Thông báo toast: "Tạo đơn hàng thành công!" xuất hiện |

**Post-condition:** Hoá đơn tồn tại trong DB, trạng thái = `ACTIVE`

---

### TC-INV-002 – Thêm đồ uống vào hoá đơn đã tồn tại (Happy Path)

| Hạng mục | Nội dung |
|----------|---------|
| **Test Case ID** | TC-INV-002 |
| **Unit to Test** | Cập nhật hoá đơn – Thêm sản phẩm vào đơn đang hoạt động |
| **Loại kiểm thử** | ✅ Happy Path |
| **Mức ưu tiên** | 🔴 P1 – Critical |
| **Điều kiện tiên quyết** | - Có hoá đơn `INV-20260405-001` đang ở trạng thái `ACTIVE` (từ TC-INV-001) <br> - Đang đăng nhập với tài khoản cashier01 |

**Test Data:**

| Trường | Giá trị |
|--------|---------|
| Hoá đơn cần cập nhật | INV-20260405-001 |
| Sản phẩm thêm mới | Matcha Latte – Số lượng: 1 – Size: S |

**Steps to Execute:**

| Bước | Hành động | Dữ liệu nhập |
|------|-----------|-------------|
| 1 | Vào danh sách đơn hàng, chọn `INV-20260405-001` | – |
| 2 | Nhấn **"Chỉnh sửa đơn"** | – |
| 3 | Tìm sản phẩm "Matcha Latte" | Nhập tên |
| 4 | Chọn Size S, số lượng = 1, nhấn **"Thêm vào đơn"** | Size: S, SL: 1 |
| 5 | Nhấn **"Lưu thay đổi"** | – |

**Expected Result:**

| # | Kết quả mong đợi |
|---|-----------------|
| 1 | Matcha Latte Size S × 1 xuất hiện trong danh sách sản phẩm của đơn |
| 2 | Tổng tiền được cập nhật tự động = tổng cũ + giá Matcha Latte S |
| 3 | Lịch sử chỉnh sửa đơn ghi nhận: "Thêm sản phẩm bởi cashier01 lúc [timestamp]" |
| 4 | Thông báo: "Cập nhật đơn hàng thành công!" |

---

### TC-INV-003 – Thanh toán hoá đơn bằng tiền mặt (Happy Path)

| Hạng mục | Nội dung |
|----------|---------|
| **Test Case ID** | TC-INV-003 |
| **Unit to Test** | Thanh toán hoá đơn – Phương thức tiền mặt |
| **Loại kiểm thử** | ✅ Happy Path |
| **Mức ưu tiên** | 🔴 P1 – Critical |
| **Điều kiện tiên quyết** | Hoá đơn `INV-20260405-001` đang ở trạng thái `ACTIVE`, tổng tiền = 85,000 VNĐ |

**Test Data:**

| Trường | Giá trị |
|--------|---------|
| Hoá đơn | INV-20260405-001 |
| Tổng tiền cần thanh toán | 85,000 VNĐ |
| Phương thức thanh toán | Tiền mặt |
| Số tiền khách đưa | 100,000 VNĐ |
| Tiền thối dự kiến | 15,000 VNĐ |

**Steps to Execute:**

| Bước | Hành động | Dữ liệu nhập |
|------|-----------|-------------|
| 1 | Mở đơn hàng `INV-20260405-001` | – |
| 2 | Nhấn nút **"Thanh toán"** | – |
| 3 | Chọn phương thức **"Tiền mặt"** | – |
| 4 | Nhập số tiền khách đưa = 100,000 | `100000` |
| 5 | Hệ thống tự tính tiền thối | Kiểm tra hiển thị |
| 6 | Nhấn **"Xác nhận thanh toán"** | – |

**Expected Result:**

| # | Kết quả mong đợi |
|---|-----------------|
| 1 | Màn hình hiển thị: Tổng tiền: **85,000 VNĐ** – Tiền nhận: **100,000 VNĐ** – Tiền thối: **15,000 VNĐ** |
| 2 | Sau khi xác nhận: Trạng thái hoá đơn chuyển thành **"Đã thanh toán"** |
| 3 | Bàn số 5 chuyển về trạng thái **"Trống"** (màu xanh) |
| 4 | Lịch sử thanh toán ghi nhận đúng thông tin |
| 5 | Màn hình hiện nút **"In hoá đơn"** |
| 6 | Toast: "Thanh toán thành công!" |

**Post-condition:** Hoá đơn trong DB có `status = PAID`, `payment_method = CASH`, `received_amount = 100000`, `change_amount = 15000`

---

### TC-INV-004 – Áp dụng mã giảm giá hợp lệ (Happy Path)

| Hạng mục | Nội dung |
|----------|---------|
| **Test Case ID** | TC-INV-004 |
| **Unit to Test** | Áp dụng khuyến mãi / mã giảm giá vào hoá đơn |
| **Loại kiểm thử** | ✅ Happy Path |
| **Mức ưu tiên** | 🟠 P2 – High |
| **Điều kiện tiên quyết** | Có mã giảm giá `SUMMER20` đang hoạt động (giảm 20%, tối đa 30,000 VNĐ), đơn hàng có tổng tiền = 120,000 VNĐ |

**Test Data:**

| Trường | Giá trị |
|--------|---------|
| Mã giảm giá | `SUMMER20` |
| Loại giảm giá | Phần trăm – 20% |
| Giảm tối đa | 30,000 VNĐ |
| Tổng tiền gốc | 120,000 VNĐ |
| Số tiền giảm dự kiến | 24,000 VNĐ (20% × 120,000 = 24,000 < 30,000) |
| Tổng tiền sau giảm | 96,000 VNĐ |

**Steps to Execute:**

| Bước | Hành động | Dữ liệu nhập |
|------|-----------|-------------|
| 1 | Mở đơn hàng đang active | – |
| 2 | Nhấn **"Áp dụng mã giảm giá"** | – |
| 3 | Nhập mã `SUMMER20` | `SUMMER20` |
| 4 | Nhấn **"Kiểm tra mã"** | – |
| 5 | Xác nhận áp dụng | Nhấn "Áp dụng" |

**Expected Result:**

| # | Kết quả mong đợi |
|---|-----------------|
| 1 | Hệ thống xác nhận mã hợp lệ: "Mã giảm giá SUMMER20 – Giảm 20%" |
| 2 | Số tiền giảm hiển thị: **-24,000 VNĐ** |
| 3 | Tổng tiền sau giảm giá: **96,000 VNĐ** |
| 4 | Mã giảm giá được gắn vào hoá đơn, hiển thị trong chi tiết đơn |

---

### TC-INV-005 – Tạo hoá đơn khi giỏ hàng trống (Invalid Case)

| Hạng mục | Nội dung |
|----------|---------|
| **Test Case ID** | TC-INV-005 |
| **Unit to Test** | Validation khi tạo hoá đơn không có sản phẩm |
| **Loại kiểm thử** | ❌ Invalid / Exception Case |
| **Mức ưu tiên** | 🔴 P1 – Critical |
| **Điều kiện tiên quyết** | Đã đăng nhập, đang ở màn hình tạo đơn hàng, chưa thêm sản phẩm nào |

**Test Data:**

| Trường | Giá trị |
|--------|---------|
| Sản phẩm trong đơn | Không có (giỏ hàng trống) |
| Bàn | Bàn số 3 |

**Steps to Execute:**

| Bước | Hành động | Dữ liệu nhập |
|------|-----------|-------------|
| 1 | Vào màn hình tạo đơn hàng mới | – |
| 2 | Chọn Bàn số 3 nhưng **không thêm sản phẩm nào** | – |
| 3 | Nhấn nút **"Lưu đơn hàng"** | – |

**Expected Result:**

| # | Kết quả mong đợi |
|---|-----------------|
| 1 | Hệ thống **không tạo** hoá đơn |
| 2 | Hiện thông báo lỗi: "Vui lòng thêm ít nhất 1 sản phẩm trước khi lưu đơn" |
| 3 | Người dùng vẫn ở lại màn hình tạo đơn (không redirect) |
| 4 | Không có record mới trong bảng `orders` trong database |

---

### TC-INV-006 – Nhập số lượng sản phẩm không hợp lệ (Invalid Case)

| Hạng mục | Nội dung |
|----------|---------|
| **Test Case ID** | TC-INV-006 |
| **Unit to Test** | Validation số lượng sản phẩm trong đơn hàng |
| **Loại kiểm thử** | ❌ Invalid / Exception Case |
| **Mức ưu tiên** | 🟠 P2 – High |
| **Điều kiện tiên quyết** | Đang ở màn hình tạo đơn, đã chọn sản phẩm |

**Test Data:**

| Trường hợp | Giá trị nhập | Kết quả mong đợi |
|-----------|-------------|-----------------|
| Số lượng = 0 | `0` | Lỗi: "Số lượng phải lớn hơn 0" |
| Số lượng âm | `-1` | Lỗi: "Số lượng không hợp lệ" |
| Số lượng = chữ | `abc` | Lỗi: "Vui lòng nhập số nguyên dương" |
| Số lượng quá lớn | `99999` | Lỗi: "Số lượng tối đa là 999" |

**Steps to Execute:**

| Bước | Hành động | Dữ liệu nhập |
|------|-----------|-------------|
| 1 | Thêm sản phẩm "Cà phê sữa đá" vào đơn | – |
| 2 | Xóa nội dung trường số lượng | – |
| 3 | Nhập lần lượt từng giá trị bất hợp lệ trong bảng Test Data | Xem bảng trên |
| 4 | Với mỗi giá trị: nhấn Tab hoặc nhấn "Thêm vào đơn" | – |

**Expected Result:** Với mỗi giá trị không hợp lệ, hệ thống hiển thị thông báo lỗi tương ứng, trường số lượng viền đỏ, không thêm sản phẩm vào đơn.

---

### TC-INV-007 – Thanh toán hoá đơn với số tiền nhận ít hơn tổng tiền (Invalid Case)

| Hạng mục | Nội dung |
|----------|---------|
| **Test Case ID** | TC-INV-007 |
| **Unit to Test** | Validation số tiền nhận khi thanh toán tiền mặt |
| **Loại kiểm thử** | ❌ Invalid / Exception Case |
| **Mức ưu tiên** | 🔴 P1 – Critical |
| **Điều kiện tiên quyết** | Có hoá đơn active, tổng tiền = 85,000 VNĐ |

**Test Data:**

| Trường | Giá trị |
|--------|---------|
| Tổng tiền cần thanh toán | 85,000 VNĐ |
| Phương thức thanh toán | Tiền mặt |
| Số tiền khách đưa (nhập sai) | 50,000 VNĐ |

**Steps to Execute:**

| Bước | Hành động | Dữ liệu nhập |
|------|-----------|-------------|
| 1 | Mở đơn hàng active, nhấn **"Thanh toán"** | – |
| 2 | Chọn phương thức **"Tiền mặt"** | – |
| 3 | Nhập số tiền khách đưa = **50,000** | `50000` |
| 4 | Nhấn **"Xác nhận thanh toán"** | – |

**Expected Result:**

| # | Kết quả mong đợi |
|---|-----------------|
| 1 | Hệ thống **không xử lý** thanh toán |
| 2 | Hiển thị cảnh báo: "Số tiền nhận (50,000 VNĐ) không đủ để thanh toán (85,000 VNĐ). Thiếu 35,000 VNĐ." |
| 3 | Trường nhập tiền viền đỏ |
| 4 | Hoá đơn vẫn giữ trạng thái `ACTIVE` |

---

### TC-INV-008 – Áp dụng mã giảm giá đã hết hạn (Invalid Case)

| Hạng mục | Nội dung |
|----------|---------|
| **Test Case ID** | TC-INV-008 |
| **Unit to Test** | Validation mã giảm giá hết hạn |
| **Loại kiểm thử** | ❌ Invalid / Exception Case |
| **Mức ưu tiên** | 🟡 P2 – Medium |
| **Điều kiện tiên quyết** | Có đơn hàng active. Trong DB có mã `EXPIRED10` với `expiry_date = 01/01/2025` (đã hết hạn) |

**Test Data:**

| Trường | Giá trị |
|--------|---------|
| Mã giảm giá | `EXPIRED10` |
| Ngày hết hạn của mã | 01/01/2025 |
| Ngày kiểm thử | 05/04/2026 |

**Steps to Execute:**

| Bước | Hành động | Dữ liệu nhập |
|------|-----------|-------------|
| 1 | Mở đơn hàng, nhấn **"Áp dụng mã giảm giá"** | – |
| 2 | Nhập mã `EXPIRED10` | `EXPIRED10` |
| 3 | Nhấn **"Kiểm tra mã"** | – |

**Expected Result:**

| # | Kết quả mong đợi |
|---|-----------------|
| 1 | Hệ thống **không áp dụng** mã giảm giá |
| 2 | Thông báo lỗi: "Mã giảm giá EXPIRED10 đã hết hạn sử dụng" |
| 3 | Tổng tiền **không thay đổi** |
| 4 | Không có record giảm giá nào được insert vào bảng `order_promotions` |

---

## TỔNG KẾT TEST CASE

| Test Case ID | Chức năng | Loại | Ưu tiên | Trạng thái |
|-------------|-----------|------|---------|------------|
| TC-INV-001 | Tạo hoá đơn mới | Happy Path | P1 | Chờ thực thi |
| TC-INV-002 | Thêm sản phẩm vào đơn | Happy Path | P1 | Chờ thực thi |
| TC-INV-003 | Thanh toán tiền mặt | Happy Path | P1 | Chờ thực thi |
| TC-INV-004 | Áp dụng mã giảm giá hợp lệ | Happy Path | P2 | Chờ thực thi |
| TC-INV-005 | Tạo đơn khi giỏ hàng trống | Invalid | P1 | Chờ thực thi |
| TC-INV-006 | Số lượng sản phẩm không hợp lệ | Invalid | P2 | Chờ thực thi |
| TC-INV-007 | Thanh toán thiếu tiền | Invalid | P1 | Chờ thực thi |
| TC-INV-008 | Mã giảm giá hết hạn | Invalid | P2 | Chờ thực thi |

---

*Tài liệu này thuộc dự án PolyCoffee. Phiên bản: 1.0 | Cập nhật: 05/04/2026*

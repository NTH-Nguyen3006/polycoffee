# Báo cáo Kiểm thử và Mô phỏng Lỗi (Bug Report)

## 1. Mô phỏng Kết quả Kiểm thử Hệ thống
Dựa vào 10 Test Case đã viết cho chức năng **Tạo và xử lý hoá đơn**, giả định sau khi chạy thực tế trên sản phẩm, chúng ta thu được kết quả sau:

- **Pass (Đạt - Không có lỗi):** TC_BILL_01, TC_BILL_02, TC_BILL_04, TC_BILL_06, TC_BILL_08, TC_BILL_09, TC_BILL_10.
- **Fail (Không Đạt - Phát hiện lỗi):** 
  - **TC_BILL_03:** Bắt lỗi khi thêm số lượng mua lớn hơn số lượng tồn kho.
  - **TC_BILL_05:** Báo lỗi khi tiền khách đưa nhỏ hơn tổng tiền.

---

## 2. Báo cáo Chi tiết Lỗi (Bug Report)
Dựa trên giả định phát hiện được 2 test case Fail ở trên, dưới đây là chi tiết mô tả lỗi.

### Bug 01: [Từ TC_BILL_03] Lỗi cho phép xuất bán vượt số lượng tồn kho
- **Mô tả lỗi (Bug Description):** Khi người dùng nhập số lượng sản phẩm cần mua lớn hơn số lượng tồn kho thực tế hiện có, hệ thống không có cảnh báo từ chối mà vẫn cho phép thêm vào hoá đơn, dẫn đến tồn kho bị sai lệch thành số âm.
- **Các bước tái hiện (Steps to Reproduce):**
  1. Vào màn hình Bán hàng/Tạo hoá đơn.
  2. Chọn sản phẩm đang sắp hết, ví dụ "Bánh ngọt" (tồn kho hiện tại đang là 2 chiếc).
  3. Tại ô số lượng mua, nhập vào số 5.
  4. Bấm "Thêm vào hoá đơn" (hoặc chờ hệ thống tự tự cập nhật giỏ hàng).
- **Kết quả chờ đợi (Expected Result):** Hệ thống không được phép thêm sản phẩm vào hoá đơn, đồng thời hiển thị thông báo rõ ràng "Số lượng vượt quá số dư tồn trong kho".
- **Kết quả thực tế (Actual Result):** Hệ thống vẫn thêm thành công 5 chiếc Bánh ngọt vào hoá đơn, tồn kho trên hệ thống bị trừ thành -3 (âm ba) chiếc.
- **Mức độ nghiêm trọng (Severity):** **High** (Nghiêm trọng - Lỗi logic quản lý kho có thể dẫn đến thất thoát hoặc sai lệch hàng hoá nặng nề).

### Bug 02: [Từ TC_BILL_05] Lỗi cho phép thanh toán khi số tiền khách đưa chưa đủ
- **Mô tả lỗi (Bug Description):** Tại màn hình thanh toán hoá đơn, nếu thu ngân bất cẩn hoặc cố tình nhập số tiền khách trả nhỏ hơn tổng thanh toán của hoá đơn, thì hệ thống không bắt lỗi mà vẫn ghi nhận đơn đó thanh toán thành công, hiển thị tiền thừa bị âm (nợ khoản tiền đó).
- **Các bước tái hiện (Steps to Reproduce):**
  1. Chọn hoá đơn đang ở trạng thái "Chờ thanh toán" có tổng tiền ví dụ là 55.000 VNĐ.
  2. Tại ô "Tiền khách đưa", thử nhập số tiền là 50.000 VNĐ.
  3. Bấm nhấn nút "Thanh toán".
- **Kết quả chờ đợi (Expected Result):** Nút Thanh toán bị vô hiệu hoá, hoặc hệ thống bật thông báo lỗi chặn quá trình ghi nhận thanh toán: "Số tiền khách đưa không đủ để thanh toán".
- **Kết quả thực tế (Actual Result):** Hệ thống xuất hoá đơn và xử lý thanh toán thành công, chuyển trạng thái bill sang "Đã thanh toán" và hiển thị thuộc tính Tiền thừa/Tiền thối là -5.000 VNĐ.
- **Mức độ nghiêm trọng (Severity):** **Critical** (Cực kỳ nghiêm trọng - Gây thất thoát doanh thu trực tiếp và sai kết toán thu ngân với cửa hàng).

---

## 3. Vòng đời của lỗi (Bug Life Cycle)
Để quản lý và khắc phục 2 Bug phát hiện ở phần trên, chúng sẽ đi qua vòng đời từ lúc phát hiện đến lúc đóng lỗi như sau:

1. **New (Mới phát hiện):** 
Tester/QA chạy test case TC_BILL_03 và TC_BILL_05, chứng kiến hệ thống đưa ra *Actual Result* không khớp với kế hoạch, tester ghi nhận và tạo log lỗi (ticket/bug report) lên hệ thống quản lý Jira/Trello..
2. **Assigned (Đã phân công):** 
Quản lý dự án hoặc Test Lead đánh giá Bug đúng là sự thật, sau đó Gán (Assign) cho Developer phụ trách làm Module Bán hàng (VD: Backend Coder).
3. **Open / In Progress (Đang xử lý):** 
Developer đọc chi tiết Bug, chọn nhận giải quyết và chuyển trạng thái ticket sang đang sửa. Developer review lại các hàm điều kiện `if/else` để vá lỗ hổng (Ví dụ: Thêm validate kiểm tra số tiền khách đưa `< totalBill`).
4. **Resolved / Fixed (Đã sửa):** 
Sau khi viết mã sửa chữa, Developer build lại code và cập nhật lên môi trường chạy Test chung, chuyển trạng thái bug về dạng Fixed/Đã Sửa.
5. **Retest (Kiểm thử lại khâu sửa):** 
Tester nhận thông báo, tiến hành mở lại hệ thống và thao tác y hệt quy trình "Steps to Reproduce" trong Bug 01 và 02.
  - Nếu kết quả vẫn ra số âm (Dev chưa sửa triệt để) -> Lỗi chuyển trạng thái thành **Re-Open (Mở lại)**, yêu cầu Dev xử lý tiếp.
  - Nếu hệ thống đã chặn thành công đúng như *Expected Result* mong muốn -> Chuyển bước cuối.
6. **Closed / Verified (Đóng lỗi / Xác nhận):** 
Tester xác nhận tính năng đã hoàn thiện, không phát sinh hiệu ứng ngược sang chức năng khác, kiểm thử kết thúc an toàn bằng động thái Closed (Đóng Bug). Vấn đề kết thúc.

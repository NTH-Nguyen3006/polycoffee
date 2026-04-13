package com.polycoffee.controller;

import com.polycoffee.dao.impl.OrdersDAO;
import com.polycoffee.dao.impl.PaymentDAOImpl;
import com.polycoffee.entity.Orders;
import com.polycoffee.entity.Payment;
import com.polycoffee.utils.VNPayUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Map;

/**
 * Xử lý Return URL từ VNPay sau khi khách hàng hoàn tất thanh toán.
 * VNPay redirect khách về: /payment/vnpay-return?vnp_ResponseCode=00&...
 *
 * LƯU Ý: Đây chỉ là trang hiển thị kết quả cho user.
 *         Logic nghiệp vụ quan trọng (cập nhật DB) nên đặt ở VNPayIPNController.
 */
@WebServlet("/payment/vnpay-return")
public class VNPayReturnController extends HttpServlet {

    private final OrdersDAO     ordersDAO  = new OrdersDAO();
    private final PaymentDAOImpl paymentDAO = new PaymentDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        Map<String, String[]> params = req.getParameterMap();

        // 1. Xác thực chữ ký
        boolean validSig = VNPayUtil.verifySignature(params);
        String responseCode = VNPayUtil.getParam(params, "vnp_ResponseCode");
        String txnRef       = VNPayUtil.getParam(params, "vnp_TxnRef");       // orderCode
        String transactionNo= VNPayUtil.getParam(params, "vnp_TransactionNo"); // mã GD VNPay
        String amountStr    = VNPayUtil.getParam(params, "vnp_Amount");        // *100
        String bankCode     = VNPayUtil.getParam(params, "vnp_BankCode");
        String payDate      = VNPayUtil.getParam(params, "vnp_PayDate");

        boolean success = validSig && "00".equals(responseCode);

        // 2. Cập nhật DB nếu chữ ký hợp lệ và chưa xử lý (idempotent)
        if (validSig) {
            Orders order = ordersDAO.findByCode(txnRef);
            if (order != null) {
                if (success && !"PAID".equals(order.getPaymentStatus())) {
                    // Cập nhật trạng thái thanh toán
                    ordersDAO.updatePaymentStatus(order.getId(), "PAID");
                    ordersDAO.updateStatus(order.getId(), "CONFIRMED");

                    // Lưu bản ghi thanh toán
                    long rawAmount = 0;
                    try { rawAmount = Long.parseLong(amountStr) / 100; } catch (Exception ignored) {}

                    Payment payment = Payment.builder()
                            .order(order)
                            .paymentMethod("VNPAY")
                            .transactionId(transactionNo)
                            .amount(BigDecimal.valueOf(rawAmount))
                            .paymentDate(LocalDateTime.now())
                            .vnpayBankCode(bankCode)
                            .vnpayResponseCode(responseCode)
                            .build();
                    paymentDAO.create(payment);

                } else if (!success && "PENDING".equals(order.getPaymentStatus())) {
                    ordersDAO.updatePaymentStatus(order.getId(), "FAILED");
                }
            }
        }

        // 3. Truyền data sang view
        req.setAttribute("success",       success);
        req.setAttribute("responseCode",  responseCode);
        req.setAttribute("txnRef",        txnRef);
        req.setAttribute("transactionNo", transactionNo);
        req.setAttribute("bankCode",      bankCode);
        req.setAttribute("payDate",       payDate);
        req.setAttribute("title",         success ? "Thanh Toán Thành Công" : "Thanh Toán Thất Bại");

        // Không dùng renderPage vì không cần layout admin
        req.getRequestDispatcher("/views/public/payment_result.jsp").forward(req, resp);
    }
}

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
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Map;

/**
 * VNPay IPN (Instant Payment Notification) Handler.
 *
 * VNPay gọi server-to-server đến endpoint này sau khi giao dịch hoàn tất.
 * Đây là nơi CHẮC CHẮN để cập nhật database vì không phụ thuộc vào browser user.
 *
 * Response phải trả về JSON: {"RspCode":"00","Message":"Confirm Success"}
 */
@WebServlet("/payment/vnpay-ipn")
public class VNPayIPNController extends HttpServlet {

    private final OrdersDAO      ordersDAO  = new OrdersDAO();
    private final PaymentDAOImpl paymentDAO = new PaymentDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        handleIPN(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        handleIPN(req, resp);
    }

    private void handleIPN(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        PrintWriter out = resp.getWriter();

        try {
            Map<String, String[]> params = req.getParameterMap();

            // 1. Xác thực chữ ký
            if (!VNPayUtil.verifySignature(params)) {
                out.print("{\"RspCode\":\"97\",\"Message\":\"Invalid Signature\"}");
                return;
            }

            String responseCode  = VNPayUtil.getParam(params, "vnp_ResponseCode");
            String txnRef        = VNPayUtil.getParam(params, "vnp_TxnRef");
            String transactionNo = VNPayUtil.getParam(params, "vnp_TransactionNo");
            String amountStr     = VNPayUtil.getParam(params, "vnp_Amount");
            String bankCode      = VNPayUtil.getParam(params, "vnp_BankCode");

            // 2. Tìm đơn hàng
            Orders order = ordersDAO.findByCode(txnRef);
            if (order == null) {
                out.print("{\"RspCode\":\"01\",\"Message\":\"Order Not Found\"}");
                return;
            }

            // 3. Kiểm tra idempotency (tránh xử lý 2 lần)
            if ("PAID".equals(order.getPaymentStatus())) {
                out.print("{\"RspCode\":\"02\",\"Message\":\"Order Already Confirmed\"}");
                return;
            }

            // 4. Kiểm tra số tiền
            long vnpAmount = Long.parseLong(amountStr) / 100;
            long orderAmount = order.getTotalAmount().longValue();
            if (vnpAmount != orderAmount) {
                out.print("{\"RspCode\":\"04\",\"Message\":\"Invalid Amount\"}");
                return;
            }

            // 5. Cập nhật DB theo kết quả thanh toán
            if ("00".equals(responseCode)) {
                ordersDAO.updatePaymentStatus(order.getId(), "PAID");
                ordersDAO.updateStatus(order.getId(), "CONFIRMED");

                Payment payment = Payment.builder()
                        .order(order)
                        .paymentMethod("VNPAY")
                        .transactionId(transactionNo)
                        .amount(BigDecimal.valueOf(vnpAmount))
                        .paymentDate(LocalDateTime.now())
                        .vnpayBankCode(bankCode)
                        .vnpayResponseCode(responseCode)
                        .build();
                paymentDAO.create(payment);
            } else {
                ordersDAO.updatePaymentStatus(order.getId(), "FAILED");
            }

            out.print("{\"RspCode\":\"00\",\"Message\":\"Confirm Success\"}");

        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"RspCode\":\"99\",\"Message\":\"Unknown Error\"}");
        }
    }
}

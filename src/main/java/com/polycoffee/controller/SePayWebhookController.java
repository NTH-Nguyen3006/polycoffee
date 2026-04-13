package com.polycoffee.controller;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.polycoffee.dao.impl.OrdersDAO;
import com.polycoffee.dao.impl.PaymentDAOImpl;
import com.polycoffee.entity.Orders;
import com.polycoffee.entity.Payment;
import com.polycoffee.utils.SePayConfig;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Endpoint nhận Webhook từ SePay khi có giao dịch thành công.
 * https://my.sepay.vn/webhooks
 */
@WebServlet("/api/sepay-webhook")
public class SePayWebhookController extends HttpServlet {

    private final OrdersDAO ordersDAO = new OrdersDAO();
    private final PaymentDAOImpl paymentDAO = new PaymentDAOImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // 1. Kiểm tra Authorization header nếu cần bảo mật
        // Bật tính năng tích hợp bằng header của Sepay để an toàn mã hoá
        /* String authHeader = req.getHeader("Authorization");
         if (authHeader == null || !authHeader.equals("Bearer " + SePayConfig.WEBHOOK_AUTHORIZATION)) {
             resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
             return;
         } */

        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json");

        // 2. Lấy nội dung Payload từ Request
        StringBuilder sb = new StringBuilder();
        try (var reader = req.getReader()) {
            String line;
            while ((line = reader.readLine()) != null) sb.append(line);
        }

        try {
            ObjectMapper mapper = new ObjectMapper();
            JsonNode payload = mapper.readTree(sb.toString());

            // Payload SePay thường có các key như: gateway, transactionDate, transferAmount, content, referenceCode
            double transferAmount = payload.path("transferAmount").asDouble(0);
            String content = payload.path("content").asText("");
            String referenceCode = payload.path("referenceCode").asText("");
            String gateway = payload.path("gateway").asText("");

            // 3. Sử dụng RegEx để trích xuất mã đơn hàng từ content
            // Mẫu content: "ND chuyen tien... DHPC168392131230"
            String prefix = SePayConfig.PREFIX.toUpperCase();
            Pattern pattern = Pattern.compile(prefix + "(PC\\d+)");
            Matcher matcher = pattern.matcher(content.toUpperCase());

            if (matcher.find()) {
                String orderCode = matcher.group(1); // VD: PC168392131230

                Orders order = ordersDAO.findByCode(orderCode);

                if (order != null && !"PAID".equals(order.getPaymentStatus())) {
                    
                    // So sánh số tiền thanh toán có bằng (hoặc lớn hơn) đơn hàng hay không
                    double orderAmount = order.getTotalAmount().doubleValue();
                    
                    if (transferAmount >= orderAmount) {
                        // Cập nhật DB
                        ordersDAO.updatePaymentStatus(order.getId(), "PAID");
                        ordersDAO.updateStatus(order.getId(), "CONFIRMED");

                        // Lưu log Payment
                        Payment payment = Payment.builder()
                                .order(order)
                                .paymentMethod("SEPAY")
                                .transactionId(referenceCode)
                                .amount(BigDecimal.valueOf(transferAmount))
                                .paymentDate(LocalDateTime.now())
                                .vnpayBankCode(gateway)
                                .vnpayResponseCode("SEPAY_SUCCESS")
                                .build();
                        
                        paymentDAO.create(payment);
                    }
                }
            }

            // Phản hồi cho SePay biết xử lý thành công (HTTP 200 OK)
            resp.getWriter().print("{\"success\":true}");

        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            resp.getWriter().print("{\"success\":false,\"error\":\"" + e.getMessage() + "\"}");
        }
    }
}

package com.polycoffee.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.polycoffee.dao.impl.OrdersDAO;
import com.polycoffee.entity.Orders;
import com.polycoffee.entity.OrderItem;
import com.polycoffee.entity.Users;
import com.polycoffee.utils.VNPayUtil;
import com.polycoffee.utils.GenerateID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.*;

/**
 * Nhận request checkout từ menu.jsp, tạo đơn hàng, rồi redirect sang VNPay.
 *
 * POST /payment/checkout
 * Body (JSON): { items: [{id, name, price, qty}], note: "...", paymentMethod: "VNPAY|COD" }
 */
@WebServlet("/payment/checkout")
public class CheckoutController extends HttpServlet {

    private final OrdersDAO ordersDAO = new OrdersDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);

        // ── Đọc JSON body ────────────────────────────────────────────────────
        StringBuilder sb = new StringBuilder();
        try (var reader = req.getReader()) {
            String line;
            while ((line = reader.readLine()) != null) sb.append(line);
        }

        Map<String, Object> body;
        try {
            body = new ObjectMapper().readValue(sb.toString(), Map.class);
        } catch (Exception e) {
            resp.setStatus(400);
            resp.getWriter().print("{\"error\":\"Invalid JSON\"}");
            return;
        }

        @SuppressWarnings("unchecked")
        List<Map<String, Object>> items = (List<Map<String, Object>>) body.get("items");
        String note           = (String) body.getOrDefault("note", "");
        String paymentMethod  = (String) body.getOrDefault("paymentMethod", "SEPAY");

        if (items == null || items.isEmpty()) {
            resp.setStatus(400);
            resp.getWriter().print("{\"error\":\"Giỏ hàng trống\"}");
            return;
        }

        // ── Tính tổng tiền ───────────────────────────────────────────────────
        long totalAmount = 0;
        List<OrderItem> orderItems = new ArrayList<>();
        for (Map<String, Object> item : items) {
            long price = ((Number) item.get("price")).longValue();
            int qty    = ((Number) item.get("qty")).intValue();
            totalAmount += price * qty;
        }

        // ── Tạo đơn hàng ────────────────────────────────────────────────────
        Users loggedUser = (session != null) ? (Users) session.getAttribute("user") : null;
        String orderCode = "PC" + System.currentTimeMillis(); // unique code

        Orders order = Orders.builder()
                .user(loggedUser)
                .orderCode(orderCode)
                .totalAmount(BigDecimal.valueOf(totalAmount))
                .status("PENDING")
                .paymentStatus("PENDING")
                .note(note)
                .build();

        ordersDAO.createWithItems(order, items);

        // ── COD: Không cần redirect ──────────────────────────────────────────
        if ("COD".equalsIgnoreCase(paymentMethod)) {
            ordersDAO.updateStatus(order.getId(), "CONFIRMED");
            ordersDAO.updatePaymentStatus(order.getId(), "COD");
            resp.getWriter().print("{\"success\":true,\"method\":\"COD\",\"orderCode\":\"" + orderCode + "\"}");
            return;
        }

        // ── SEPAY: Redirect sang trang hiển thị QR ─────────────────────────────
        String payUrl = req.getContextPath() + "/payment/sepay-qr?orderCode=" + orderCode + "&amount=" + totalAmount;

        resp.getWriter().print("{\"success\":true,\"payUrl\":\"" + payUrl + "\",\"orderCode\":\"" + orderCode + "\"}");
    }
}

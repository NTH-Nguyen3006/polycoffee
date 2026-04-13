package com.polycoffee.controller;

import com.polycoffee.utils.SePayConfig;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Hiển thị trang quét mã QR cho đơn hàng SEPAY.
 * Cấu trúc: /payment/sepay-qr?orderCode=PCxxx&amount=100000
 */
@WebServlet("/payment/sepay-qr")
public class SePayQRController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
            
        String orderCode = req.getParameter("orderCode");
        String amount = req.getParameter("amount");
        
        if (orderCode == null || amount == null) {
            resp.sendRedirect(req.getContextPath() + "/menu");
            return;
        }

        // Tạo nội dung chuyển khoản an toàn (mã đơn hàng)
        String description = SePayConfig.PREFIX + orderCode;
        
        // Tạo URL ảnh QR từ API SePay
        String qrImageUrl = String.format("https://qr.sepay.vn/img?acc=%s&bank=%s&amount=%s&des=%s", 
                SePayConfig.ACC, 
                SePayConfig.BANK, 
                amount, 
                description);
                
        req.setAttribute("orderCode", orderCode);
        req.setAttribute("amount", amount);
        req.setAttribute("description", description);
        req.setAttribute("qrImageUrl", qrImageUrl);
        req.setAttribute("title", "Thanh Toán Đơn Hàng");

        // Forward tới View hiển thị mã QR
        req.getRequestDispatcher("/views/public/sepay_qr.jsp").forward(req, resp);
    }
}

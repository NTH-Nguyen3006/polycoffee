package com.polycoffee.controller.manage;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.polycoffee.controller.LayoutController;

@WebServlet("/admin/promotion")
public class PromotionController extends LayoutController {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("title", "Quản Lý Khuyến Mãi");
        renderPage(req, resp, "/views/admin/promotion/index.jsp");
    }
}

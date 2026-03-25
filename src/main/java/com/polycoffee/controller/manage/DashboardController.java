package com.polycoffee.controller.manage;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.polycoffee.controller.LayoutController;

@WebServlet("/admin/dashboard")
public class DashboardController extends LayoutController {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("title", "Bảng Điều Khiển");
        renderPage(req, resp, "/views/admin/dashboard.jsp");
    }
}

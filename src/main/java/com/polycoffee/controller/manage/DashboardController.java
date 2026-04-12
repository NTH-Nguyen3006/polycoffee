package com.polycoffee.controller.manage;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.polycoffee.controller.LayoutController;
import com.polycoffee.dao.impl.OrdersDAO;
import com.polycoffee.dao.impl.ProductsDAOImpl;
import com.polycoffee.dao.impl.UserDAO;
import com.polycoffee.entity.Orders;

@WebServlet("/admin/dashboard")
public class DashboardController extends LayoutController {

    private final OrdersDAO    ordersDAO   = new OrdersDAO();
    private final ProductsDAOImpl productsDAO = new ProductsDAOImpl();
    private final UserDAO      userDAO     = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // ── KPI: hôm nay ──────────────────────────────────────────
        LocalDateTime todayStart = LocalDateTime.now().with(LocalTime.MIN);
        LocalDateTime todayEnd   = LocalDateTime.now().with(LocalTime.MAX);

        // ── KPI: tháng này ────────────────────────────────────────
        LocalDateTime monthStart = LocalDateTime.now().withDayOfMonth(1).with(LocalTime.MIN);
        LocalDateTime monthEnd   = LocalDateTime.now().with(LocalTime.MAX);

        // Doanh thu hôm nay + tháng này
        List<Object[]> todaySummary = ordersDAO.getRevenueSummary(todayStart, todayEnd);
        List<Object[]> monthSummary = ordersDAO.getRevenueSummary(monthStart, monthEnd);

        if (todaySummary != null && !todaySummary.isEmpty()) {
            Object[] t = todaySummary.get(0);
            req.setAttribute("todayRevenue",   t[0] != null ? t[0] : 0);
            req.setAttribute("todayOrders",    t[1] != null ? t[1] : 0);
        } else {
            req.setAttribute("todayRevenue",   0);
            req.setAttribute("todayOrders",    0);
        }

        if (monthSummary != null && !monthSummary.isEmpty()) {
            Object[] m = monthSummary.get(0);
            req.setAttribute("monthRevenue",   m[0] != null ? m[0] : 0);
            req.setAttribute("monthOrders",    m[1] != null ? m[1] : 0);
        } else {
            req.setAttribute("monthRevenue",   0);
            req.setAttribute("monthOrders",    0);
        }

        // Đơn hàng đang chờ xử lý
        long pendingOrders = ordersDAO.countAll("PENDING");
        req.setAttribute("pendingOrders", pendingOrders);

        // Tổng sản phẩm đang bán
        long totalProducts = productsDAO.countSearch(null, null, true);
        req.setAttribute("totalProducts", totalProducts);

        // Tổng người dùng
        long totalUsers = userDAO.countSearch(null, null, null);
        req.setAttribute("totalUsers", totalUsers);

        // 10 đơn hàng mới nhất
        List<Orders> recentOrders = ordersDAO.findAllPaginated(null, 1, 10);
        req.setAttribute("recentOrders", recentOrders);

        // Top 5 sản phẩm bán chạy (tháng này)
        List<Object[]> top5 = ordersDAO.findTop5BestSelling(monthStart, monthEnd);
        req.setAttribute("top5Month", top5);

        req.setAttribute("title", "Bảng Điều Khiển");
        renderPage(req, resp, "/views/admin/dashboard.jsp");
    }
}

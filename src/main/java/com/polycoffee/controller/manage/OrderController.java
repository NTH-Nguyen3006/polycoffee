package com.polycoffee.controller.manage;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.polycoffee.controller.LayoutController;
import com.polycoffee.dao.impl.OrdersDAO;
import com.polycoffee.entity.Orders;

@WebServlet({"/admin/order", "/admin/order/detail", "/admin/order/cancel"})
public class OrderController extends LayoutController {

    private final OrdersDAO ordersDAO = new OrdersDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String path = req.getServletPath();

        switch (path) {
            case "/admin/order/detail":
                handleDetail(req, resp);
                break;
            case "/admin/order/cancel":
                handleCancel(req, resp);
                break;
            default:
                handleList(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String path = req.getServletPath();
        if ("/admin/order/cancel".equals(path)) {
            handleCancel(req, resp);
        }
    }

    // ===================== Danh sách đơn hàng (có phân trang) =====================
    private void handleList(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String status = req.getParameter("status");
        String pageStr = req.getParameter("page");
        int page = (pageStr != null && !pageStr.isEmpty()) ? Integer.parseInt(pageStr) : 1;
        int pageSize = 10;

        List<Orders> orders = ordersDAO.findAllPaginated(status, page, pageSize);
        long totalItems = ordersDAO.countAll(status);
        int totalPages = (int) Math.ceil((double) totalItems / pageSize);

        req.setAttribute("orders", orders);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("totalItems", totalItems);
        req.setAttribute("filterStatus", status);
        req.setAttribute("title", "Quản Lý Đơn Hàng");
        renderPage(req, resp, "/views/admin/order/index.jsp");
    }

    // ===================== Chi tiết đơn hàng =====================
    private void handleDetail(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            Long id = Long.parseLong(req.getParameter("id"));
            Orders order = ordersDAO.findById(id);
            if (order == null) {
                resp.sendRedirect(req.getContextPath() + "/admin/order");
                return;
            }
            req.setAttribute("order", order);
            req.setAttribute("title", "Chi Tiết Đơn Hàng #" + order.getOrderCode());
            renderPage(req, resp, "/views/admin/order/detail.jsp");
        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/admin/order");
        }
    }

    // ===================== Huỷ đơn hàng =====================
    private void handleCancel(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            Long id = Long.parseLong(req.getParameter("id"));
            Orders order = ordersDAO.findById(id);
            if (order != null && !"CANCELLED".equals(order.getStatus())) {
                ordersDAO.updateStatus(id, "CANCELLED");
                req.getSession().setAttribute("message", "Đơn hàng đã được huỷ thành công.");
            } else {
                req.getSession().setAttribute("error", "Không thể huỷ đơn hàng này.");
            }
        } catch (Exception e) {
            req.getSession().setAttribute("error", "Lỗi khi huỷ đơn: " + e.getMessage());
        }
        String redirect = req.getParameter("from");
        if ("detail".equals(redirect)) {
            resp.sendRedirect(req.getContextPath() + "/admin/order/detail?id=" + req.getParameter("id"));
        } else {
            resp.sendRedirect(req.getContextPath() + "/admin/order");
        }
    }
}

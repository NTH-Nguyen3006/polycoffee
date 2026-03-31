package com.polycoffee.controller.manage;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.polycoffee.controller.LayoutController;
import com.polycoffee.dao.impl.PromotionDAOImpl;
import com.polycoffee.entity.Promotion;

@WebServlet({"/admin/promotion", "/admin/promotion/create", "/admin/promotion/edit", "/admin/promotion/delete"})
public class PromotionController extends LayoutController {

    private final PromotionDAOImpl promotionDAO = new PromotionDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        switch (path) {
            case "/admin/promotion/create":
                req.setAttribute("title", "Thêm Khuyến Mãi Mới");
                renderPage(req, resp, "/views/admin/promotion/form.jsp");
                break;
            case "/admin/promotion/edit":
                handleEdit(req, resp);
                break;
            case "/admin/promotion/delete":
                handleDelete(req, resp);
                break;
            case "/admin/promotion":
            default:
                handleList(req, resp);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String path = req.getServletPath();

        try {
            String code = req.getParameter("code");
            String discountType = req.getParameter("discountType");
            BigDecimal discountValue = new BigDecimal(req.getParameter("discountValue"));
            BigDecimal minOrderValue = new BigDecimal(req.getParameter("minOrderValue"));
            LocalDateTime startDate = LocalDateTime.parse(req.getParameter("startDate"));
            LocalDateTime endDate = LocalDateTime.parse(req.getParameter("endDate"));
            Integer usageLimit = Integer.parseInt(req.getParameter("usageLimit"));

            Promotion promotion = Promotion.builder()
                    .code(code)
                    .discountType(discountType)
                    .discountValue(discountValue)
                    .minOrderValue(minOrderValue)
                    .startDate(startDate)
                    .endDate(endDate)
                    .usageLimit(usageLimit)
                    .build();

            if ("/admin/promotion/create".equals(path)) {
                promotionDAO.create(promotion);
                req.getSession().setAttribute("message", "Đã tạo mã khuyến mãi thành công!");
            } else if ("/admin/promotion/edit".equals(path)) {
                Long id = Long.parseLong(req.getParameter("id"));
                promotion.setId(id);
                promotionDAO.update(promotion);
                req.getSession().setAttribute("message", "Đã cập nhật khuyến mãi thành công!");
            }
        } catch (Exception e) {
            req.getSession().setAttribute("error", "Lỗi: " + e.getMessage());
        }

        resp.sendRedirect(req.getContextPath() + "/admin/promotion");
    }

    private void handleList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Promotion> promotions = promotionDAO.findAll();
        req.setAttribute("promotions", promotions);
        req.setAttribute("title", "Quản Lý Khuyến Mãi");
        renderPage(req, resp, "/views/admin/promotion/index.jsp");
    }

    private void handleEdit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Long id = Long.parseLong(req.getParameter("id"));
            Promotion promotion = promotionDAO.findById(id);
            if (promotion != null) {
                req.setAttribute("promotion", promotion);
                req.setAttribute("title", "Chỉnh Sửa Khuyến Mãi");
                renderPage(req, resp, "/views/admin/promotion/form.jsp");
                return;
            }
        } catch (Exception e) {}
        resp.sendRedirect(req.getContextPath() + "/admin/promotion");
    }

    private void handleDelete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            Long id = Long.parseLong(req.getParameter("id"));
            promotionDAO.delete(id);
            req.getSession().setAttribute("message", "Đã xóa khuyến mãi thành công!");
        } catch (Exception e) {
            req.getSession().setAttribute("error", "Không thể xóa khuyến mãi: " + e.getMessage());
        }
        resp.sendRedirect(req.getContextPath() + "/admin/promotion");
    }
}

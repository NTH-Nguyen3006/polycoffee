package com.polycoffee.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.polycoffee.dao.impl.ProductsDAOImpl;
import com.polycoffee.entity.Products;

@WebServlet({ "", "/home", "/about", "/contact" })
public class HomeController extends LayoutController {

    private final ProductsDAOImpl productsDAO = new ProductsDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String path = req.getServletPath();

        switch (path) {
            case "/about":
                req.setAttribute("title", "Giới Thiệu");
                renderPage(req, resp, "/views/public/about.jsp");
                break;
            case "/contact":
                req.setAttribute("title", "Liên Hệ");
                renderPage(req, resp, "/views/public/contact.jsp");
                break;
            default:
            case "/home":
                req.setAttribute("title", "Trang Chủ");
                loadHomeData(req);
                renderPage(req, resp, "/views/public/home.jsp");
                break;
        }
    }

    /** Load dữ liệu cho trang chủ: sản phẩm nổi bật */
    private void loadHomeData(HttpServletRequest req) {
        try {
            // Lấy sản phẩm nổi bật (featured=true, available=true), tối đa 8 sản phẩm
            List<Products> featured = productsDAO.searchAndPaginate(null, null, true, 1, 8);
            // Nếu không đủ 8 sản phẩm nổi bật, lấy thêm sản phẩm đang bán bình thường
            if (featured == null || featured.size() < 4) {
                featured = productsDAO.searchAndPaginate(null, null, true, 1, 8);
                if (featured == null || featured.isEmpty()) {
                    // Fallback: lấy bất kỳ sản phẩm nào đang bán
                    featured = productsDAO.searchAndPaginate(null, null, null, 1, 8);
                }
            }
            req.setAttribute("featuredProducts", featured);
        } catch (Exception e) {
            // Nếu lỗi, để null — JSP sẽ hiển thị static cards
            req.setAttribute("featuredProducts", null);
        }
    }
}

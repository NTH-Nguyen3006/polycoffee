package com.polycoffee.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.polycoffee.dao.impl.CategoryDAO;
import com.polycoffee.dao.impl.ProductsDAOImpl;
import com.polycoffee.entity.Categories;
import com.polycoffee.entity.Products;

@WebServlet("/menu")
public class MenuController extends LayoutController {

    private final ProductsDAOImpl productDao   = new ProductsDAOImpl();
    private final CategoryDAO     categoryDAO  = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        // ── Filter params ──────────────────────────────
        String keywords   = req.getParameter("keywords");
        String catIdParam = req.getParameter("categoryId");

        Long categoryId = null;
        if (catIdParam != null && !catIdParam.isEmpty()) {
            try { categoryId = Long.parseLong(catIdParam); } catch (NumberFormatException ignored) {}
        }

        // ── Query products ─────────────────────────────
        List<Products> list;
        if ((keywords != null && !keywords.trim().isEmpty()) || categoryId != null) {
            list = productDao.searchAndPaginate(
                keywords != null ? keywords.trim() : null,
                categoryId,
                true,   // only available products
                1, 100  // no pagination on menu page
            );
        } else {
            list = productDao.searchAndPaginate(null, null, true, 1, 100);
        }

        // ── All categories for filter tabs ─────────────
        List<Categories> categories = categoryDAO.findAll();

        req.setAttribute("productList",  list);
        req.setAttribute("categories",   categories);
        req.setAttribute("selectedCat",  categoryId);
        req.setAttribute("keywords",     keywords);
        req.setAttribute("title",        "Thực Đơn — Polycoffee");

        renderPage(req, resp, "/views/public/menu.jsp");
    }
}
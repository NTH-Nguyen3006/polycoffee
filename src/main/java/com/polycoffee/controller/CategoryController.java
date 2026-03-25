package com.polycoffee.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.polycoffee.dto.CategoryDTO;
import com.polycoffee.service.CategoryService;

@WebServlet({ "/admin/category", "/admin/category/create", "/admin/category/edit", "/admin/category/delete" })
public class CategoryController extends LayoutController {

    private final CategoryService categoryService = new CategoryService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        System.out.println("Path: " + path);

        switch (path) {
            case "/admin/category/create":
                renderPage(req, resp, "/views/admin/category/form.jsp");
                break;
            case "/admin/category/edit":
                try {
                    Long id = Long.valueOf(req.getParameter("id"));
                    CategoryDTO category = categoryService.findById(id);
                    req.setAttribute("category", category);
                    renderPage(req, resp, "/views/admin/category/form.jsp");
                } catch (Exception e) {
                    resp.sendRedirect(req.getContextPath() + "/admin/category");
                }
                break;
            case "/admin/category/delete":
                try {
                    Long deleteId = Long.valueOf(req.getParameter("id"));
                    categoryService.delete(deleteId);
                } catch (Exception e) {
                }
                resp.sendRedirect(req.getContextPath() + "/admin/category");
                break;
            default:
            case "/admin/category":
                List<CategoryDTO> list = categoryService.findAll();
                req.setAttribute("categories", list);
                renderPage(req, resp, "/views/admin/category/index.jsp");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String path = req.getServletPath();

        if (path.equals("/admin/category/create")) {
            String name = req.getParameter("name");
            String description = req.getParameter("description");
            categoryService.create(new CategoryDTO(null, name, description));
            resp.sendRedirect(req.getContextPath() + "/admin/category");
        } else if (path.equals("/admin/category/edit")) {
            Long id = Long.valueOf(req.getParameter("id"));
            String name = req.getParameter("name");
            String description = req.getParameter("description");
            categoryService.update(new CategoryDTO(id, name, description));
            resp.sendRedirect(req.getContextPath() + "/admin/category");
        }
    }
}

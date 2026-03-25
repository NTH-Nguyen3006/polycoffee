package com.polycoffee.controller.manage;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.polycoffee.controller.LayoutController;
import com.polycoffee.dto.CategoryDTO;
import com.polycoffee.service.CategoryService;

@WebServlet({ "/admin/category", "/admin/category/create", "/admin/category/edit", "/admin/category/delete", "/admin/category/update" })
public class CategoryController extends LayoutController {

    private final CategoryService categoryService = new CategoryService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        switch (path) {
            case "/admin/category/create":
                req.setAttribute("title", "Thêm Danh Mục Mới");
                renderPage(req, resp, "/views/admin/category/form.jsp");
                break;
            case "/admin/category/edit":
                edit(req, resp);
                break;
            case "/admin/category/delete":
                delete(req, resp);
                break;
            case "/admin/category":
            default:
                list(req, resp);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String path = req.getServletPath();

        if (path.equals("/admin/category/create")) {
            create(req, resp);
        } else if (path.equals("/admin/category/update") || path.equals("/admin/category/edit")) {
            update(req, resp);
        }
    }

    private void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<CategoryDTO> list = categoryService.findAll();
        req.setAttribute("categories", list);
        req.setAttribute("title", "Quản Lý Danh Mục");
        renderPage(req, resp, "/views/admin/category/index.jsp");
    }

    private void edit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Long id = Long.valueOf(req.getParameter("id"));
            CategoryDTO category = categoryService.findById(id);
            if (category != null) {
                req.setAttribute("category", category);
                req.setAttribute("title", "Chỉnh Sửa Danh Mục");
                renderPage(req, resp, "/views/admin/category/form.jsp");
            } else {
                req.getSession().setAttribute("message", "Không tìm thấy danh mục!");
                resp.sendRedirect(req.getContextPath() + "/admin/category");
            }
        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/admin/category");
        }
    }

    private void create(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            String name = req.getParameter("name");
            String description = req.getParameter("description");
            
            if (name == null || name.trim().isEmpty()) {
                req.getSession().setAttribute("error", "Tên danh mục không được để trống!");
                resp.sendRedirect(req.getContextPath() + "/admin/category/create");
                return;
            }

            categoryService.create(new CategoryDTO(null, name, description));
            req.getSession().setAttribute("message", "Thêm danh mục thành công!");
            resp.sendRedirect(req.getContextPath() + "/admin/category");
        } catch (Exception e) {
            req.getSession().setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/admin/category/create");
        }
    }

    private void update(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            Long id = Long.valueOf(req.getParameter("id"));
            String name = req.getParameter("name");
            String description = req.getParameter("description");

            if (name == null || name.trim().isEmpty()) {
                req.getSession().setAttribute("error", "Tên danh mục không được để trống!");
                resp.sendRedirect(req.getContextPath() + "/admin/category/edit?id=" + id);
                return;
            }

            categoryService.update(new CategoryDTO(id, name, description));
            req.getSession().setAttribute("message", "Cập nhật danh mục thành công!");
            resp.sendRedirect(req.getContextPath() + "/admin/category");
        } catch (Exception e) {
            req.getSession().setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/admin/category");
        }
    }

    private void delete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            Long deleteId = Long.valueOf(req.getParameter("id"));
            categoryService.delete(deleteId);
            req.getSession().setAttribute("message", "Xóa danh mục thành công!");
        } catch (Exception e) {
            req.getSession().setAttribute("error", "Không thể xóa danh mục này!");
        }
        resp.sendRedirect(req.getContextPath() + "/admin/category");
    }
}

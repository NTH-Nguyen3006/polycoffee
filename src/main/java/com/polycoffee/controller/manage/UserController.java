package com.polycoffee.controller.manage;

import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.polycoffee.controller.LayoutController;
import com.polycoffee.dto.UserDTO;
import com.polycoffee.enums.UserRole;
import com.polycoffee.service.UserService;

@WebServlet({"/admin/user", "/admin/user/create", "/admin/user/edit", "/admin/user/delete"})
public class UserController extends LayoutController {

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        switch (path) {
            case "/admin/user/create":
                req.setAttribute("title", "Thêm Người Dùng Mới");
                renderPage(req, resp, "/views/admin/user/form.jsp");
                break;
            case "/admin/user/edit":
                try {
                    UUID id = UUID.fromString(req.getParameter("id"));
                    UserDTO user = userService.findById(id);
                    req.setAttribute("user", user);
                    req.setAttribute("title", "Chỉnh Sửa Người Dùng");
                    renderPage(req, resp, "/views/admin/user/form.jsp");
                } catch (Exception e) {
                    resp.sendRedirect(req.getContextPath() + "/admin/user");
                }
                break;
            case "/admin/user/delete":
                try {
                    UUID deleteId = UUID.fromString(req.getParameter("id"));
                    userService.delete(deleteId);
                } catch (Exception e) {}
                resp.sendRedirect(req.getContextPath() + "/admin/user");
                break;
            default:
            case "/admin/user":
                List<UserDTO> list = userService.findAll();
                req.setAttribute("users", list);
                req.setAttribute("title", "Quản Lý Người Dùng");
                renderPage(req, resp, "/views/admin/user/index.jsp");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String path = req.getServletPath();

        String username = req.getParameter("username");
        String fullname = req.getParameter("fullname");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        UserRole role = UserRole.valueOf(req.getParameter("role"));
        boolean active = req.getParameter("active") != null;

        if (path.equals("/admin/user/create")) {
            String password = req.getParameter("password");
            UserDTO dto = new UserDTO(null, username, fullname, email, phone, role, active, null);
            userService.create(dto, password);
            resp.sendRedirect(req.getContextPath() + "/admin/user");
        } else if (path.equals("/admin/user/edit")) {
            UUID id = UUID.fromString(req.getParameter("id"));
            UserDTO dto = new UserDTO(id, username, fullname, email, phone, role, active, null);
            userService.update(dto);
            resp.sendRedirect(req.getContextPath() + "/admin/user");
        }
    }
}

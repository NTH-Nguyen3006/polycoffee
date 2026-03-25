package com.polycoffee.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.polycoffee.dao.impl.UserDAO;
import com.polycoffee.entity.Users;
import com.polycoffee.enums.UserRole;

@WebServlet("/login")
public class LoginController extends LayoutController {
    UserDAO dao = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String errorMsg = request.getParameter("error");
        if (errorMsg != null) {
            request.setAttribute("message", errorMsg);
        }
        
        request.setAttribute("title", "Đăng nhập");
        renderPage(request, response, "/views/auth/login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userParam = request.getParameter("username");
        String passParam = request.getParameter("password");

        Users user = dao.findByUsername(userParam);

        if (user != null && user.getPassword().equals(passParam)) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            String redirectUrl = (String) session.getAttribute("redirectUrl");
            if (redirectUrl != null) {
                session.removeAttribute("redirectUrl");
                response.sendRedirect(redirectUrl);
                return;
            }

            UserRole role = user.getRole();

            if (role == UserRole.ADMIN || role == UserRole.EMPLOYEE) {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }
        } else {
            request.setAttribute("message", "Tài khoản hoặc mật khẩu không đúng!");
            request.setAttribute("title", "Đăng nhập");
            renderPage(request, response, "/views/auth/login.jsp");
        }
    }
}
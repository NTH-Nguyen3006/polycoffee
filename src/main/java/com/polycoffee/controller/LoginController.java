package com.polycoffee.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.polycoffee.dao.impl.UserDAO;
import com.polycoffee.entity.Users;
import com.polycoffee.enums.UserRole;

@WebServlet("/login")
public class LoginController extends HttpServlet {
    UserDAO dao = new UserDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/login.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userParam = request.getParameter("username");
        String passParam = request.getParameter("password");

        Users user = dao.findByUsername(userParam);

        if (user != null && user.getPassword().equals(passParam)) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            UserRole role = user.getRole();

            if (role == UserRole.ADMIN) {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            } else if (role == UserRole.EMPLOYEE) {
                response.sendRedirect(request.getContextPath() + "/employee/orders");
            } else {
                response.sendRedirect(request.getContextPath() + "/home/index");
            }
        } else {
            request.setAttribute("message", "Tài khoản hoặc mật khẩu không đúng!");
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
        }
    }
}
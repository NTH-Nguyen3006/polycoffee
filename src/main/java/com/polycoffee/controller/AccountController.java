package com.polycoffee.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.polycoffee.dao.IUserDAO;
import com.polycoffee.entity.Users;
import com.polycoffee.utils.MailerService;

@WebServlet({ "/forgot-password" })
public class AccountController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IUserDAO dao = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/auth/forgot-password.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");

        try {
            Users user = dao.findByEmail(email);

            if (user == null) {
                req.setAttribute("message", "Email này không tồn tại trong hệ thống!");
            } else {

                String newPass = Long.toHexString(Double.doubleToLongBits(Math.random())).substring(0, 6);

                user.setPassword(newPass);
                dao.update(user);

                String subject = "Khoi phuc mat khau - PolyCoffee";
                String body = "Xin chao " + user.getFullname() + ",\n\nMat khau moi cua ban la: " + newPass;

                MailerService.send(email, subject, body);

                req.setAttribute("message", "Mật khẩu mới đã được gửi vào Email của bạn.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("message", "Có lỗi xảy ra: " + e.getMessage());
        }

        req.getRequestDispatcher("/views/auth/forgot-password.jsp").forward(req, resp);
    }
}
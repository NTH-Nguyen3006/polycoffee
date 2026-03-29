package com.polycoffee.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.polycoffee.dao.IUserDAO;
import com.polycoffee.dao.impl.UserDAO;
import com.polycoffee.entity.Users;
import com.polycoffee.utils.MailerService;

@WebServlet({ "/forgot-password", "/reset-password", "/register" })
public class AccountController extends LayoutController {
    private static final long serialVersionUID = 1L;
    private IUserDAO dao = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        if (path.equals("/forgot-password")) {
            req.setAttribute("title", "Quên mật khẩu");
            renderPage(req, resp, "/views/auth/forgot-password.jsp");
        } else if (path.equals("/reset-password")) {
            String token = req.getParameter("token");
            Users user = dao.findByResetToken(token);
            if (user == null) {
                req.setAttribute("error", "Link đặt lại mật khẩu không hợp lệ hoặc đã hết hạn!");
                req.setAttribute("title", "Quên mật khẩu");
                renderPage(req, resp, "/views/auth/forgot-password.jsp");
            } else {
                req.setAttribute("token", token);
                req.setAttribute("title", "Đặt lại mật khẩu");
                renderPage(req, resp, "/views/auth/reset-password.jsp");
            }
        } else if (path.equals("/register")) {
            req.setAttribute("title", "Đăng ký thành viên");
            renderPage(req, resp, "/views/auth/register.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        if (path.equals("/forgot-password")) {
            handleForgotPassword(req, resp);
        } else if (path.equals("/reset-password")) {
            handleResetPassword(req, resp);
        } else if (path.equals("/register")) {
            handleRegister(req, resp);
        }
    }

    private void handleForgotPassword(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String email = req.getParameter("email");
        try {
            Users user = dao.findByEmail(email);
            if (user == null) {
                req.setAttribute("message", "Email này không tồn tại trong hệ thống!");
            } else {
                String token = java.util.UUID.randomUUID().toString();
                user.setResetToken(token);
                user.setResetTokenExpiry(java.time.LocalDateTime.now().plusMinutes(30));
                dao.update(user);

                String resetUrl = req.getRequestURL().toString().replace("forgot-password", "reset-password") + "?token="
                        + token;

                String subject = "Đặt lại mật khẩu - PolyCoffee";
                String body = "Xin chào " + user.getFullname() + ",\n\n"
                        + "Chúng tôi đã nhận được yêu cầu đặt lại mật khẩu cho tài khoản của bạn.\n"
                        + "Vui lòng click vào đường dẫn sau để đặt mật khẩu mới (có hiệu lực trong 30 phút):\n"
                        + resetUrl;

                MailerService.send(email, subject, body);
                req.setAttribute("message", "Đường dẫn đặt lại mật khẩu đã được gửi vào Email của bạn.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("message", "Có lỗi xảy ra: " + e.getMessage());
        }
        req.setAttribute("title", "Quên mật khẩu");
        renderPage(req, resp, "/views/auth/forgot-password.jsp");
    }

    private void handleResetPassword(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String token = req.getParameter("token");
        String newPass = req.getParameter("password");
        String confirmPass = req.getParameter("confirmPassword");

        if (newPass == null || !newPass.equals(confirmPass)) {
            req.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            req.setAttribute("token", token);
            req.setAttribute("title", "Đặt lại mật khẩu");
            renderPage(req, resp, "/views/auth/reset-password.jsp");
            return;
        }

        try {
            Users user = dao.findByResetToken(token);
            if (user == null) {
                req.setAttribute("error", "Link đã hết hạn hoặc không hợp lệ!");
                req.getRequestDispatcher("/views/auth/forgot-password.jsp").forward(req, resp);
            } else {
                user.setPassword(newPass);
                user.setResetToken(null);
                user.setResetTokenExpiry(null);
                dao.update(user);

                req.setAttribute("message", "Mật khẩu đã được cập nhật thành công. Vui lòng đăng nhập!");
                req.setAttribute("title", "Đăng nhập");
                renderPage(req, resp, "/views/auth/login.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Lỗi: " + e.getMessage());
            req.setAttribute("title", "Đặt lại mật khẩu");
            renderPage(req, resp, "/views/auth/reset-password.jsp");
        }
    }

    private void handleRegister(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String username = req.getParameter("username");
        String fullname = req.getParameter("fullname");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");

        if (password == null || !password.equals(confirmPassword)) {
            req.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            req.setAttribute("title", "Đăng ký thành viên");
            renderPage(req, resp, "/views/auth/register.jsp");
            return;
        }

        try {
            // Kiểm tra username tồn tại
            if (dao.findByUsername(username) != null) {
                req.setAttribute("error", "Tên đăng nhập đã được sử dụng!");
                req.setAttribute("title", "Đăng ký thành viên");
                renderPage(req, resp, "/views/auth/register.jsp");
                return;
            }

            // Kiểm tra email tồn tại
            if (dao.findByEmail(email) != null) {
                req.setAttribute("error", "Email đã được sử dụng!");
                req.setAttribute("title", "Đăng ký thành viên");
                renderPage(req, resp, "/views/auth/register.jsp");
                return;
            }

            // Tạo user mới
            Users user = Users.builder()
                    .username(username)
                    .fullname(fullname)
                    .email(email)
                    .phone(phone)
                    .password(password)
                    .role(com.polycoffee.enums.UserRole.USER)
                    .active(true)
                    .createdAt(java.time.LocalDateTime.now())
                    .build();

            dao.create(user);
            req.setAttribute("message", "Đăng ký thành công! Vui lòng đăng nhập.");
            req.setAttribute("title", "Đăng nhập");
            renderPage(req, resp, "/views/auth/login.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            req.setAttribute("title", "Đăng ký thành viên");
            renderPage(req, resp, "/views/auth/register.jsp");
        }
    }
}
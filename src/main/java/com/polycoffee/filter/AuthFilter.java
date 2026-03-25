package com.polycoffee.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.polycoffee.entity.Users;
import com.polycoffee.enums.UserRole;

@WebFilter(urlPatterns = { "/admin/*", "/employee/*", "/cart/*", "/profile/*", "/checkout/*" })
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");
        String uri = request.getRequestURI();

        if (user == null) {
            session.setAttribute("redirectUrl", uri);
            String message = java.net.URLEncoder.encode("Vui lòng đăng nhập để tiếp tục!", "UTF-8");
            response.sendRedirect(request.getContextPath() + "/login?error=" + message);
            return;
        }

        UserRole role = user.getRole();

        if (uri.startsWith(request.getContextPath() + "/admin")) {
            if (role == UserRole.ADMIN) {
                chain.doFilter(req, res);
            } else {
                String errorMsg = java.net.URLEncoder.encode("Bạn không có quyền truy cập trang quản trị!", "UTF-8");
                response.sendRedirect(request.getContextPath() + "/home?error=" + errorMsg);
            }
        } else if (uri.startsWith(request.getContextPath() + "/employee")) {
            if (role == UserRole.ADMIN || role == UserRole.EMPLOYEE) {
                chain.doFilter(req, res);
            } else {
                String errorMsg = java.net.URLEncoder.encode("Bạn không có quyền truy cập trang nhân viên!", "UTF-8");
                response.sendRedirect(request.getContextPath() + "/home?error=" + errorMsg);
            }
        } else {
            chain.doFilter(req, res);
        }
    }

}
package com.polycoffee.utils;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.polycoffee.entity.Users;
import com.polycoffee.enums.UserRole;

@WebFilter(urlPatterns = { "/admin/*", "/employee/*" })
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        Users user = (Users) request.getSession().getAttribute("user");
        String uri = request.getRequestURI();

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        UserRole role = user.getRole();

        if (uri.contains("/admin/")) {
            if (role == UserRole.ADMIN) {
                chain.doFilter(req, res);
            } else {
                response.sendRedirect(request.getContextPath() + "/home/index?error=denied");
            }
        } else if (uri.contains("/employee/")) {
            if (role == UserRole.ADMIN || role == UserRole.EMPLOYEE) {
                chain.doFilter(req, res);
            } else {
                response.sendRedirect(request.getContextPath() + "/home/index?error=denied");
            }
        } else {
            chain.doFilter(req, res);
        }
    }
}
package com.polycoffee.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet({ "/", "/home", "/menu", "/about", "/contact" })
public class HomeController extends LayoutController {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        switch (path) {
            case "/menu":
                req.setAttribute("title", "Thực đơn");
                renderPage(req, resp, "/views/public/menu.jsp");
                break;
            case "/about":
                req.setAttribute("title", "Giới thiệu");
                renderPage(req, resp, "/views/public/about.jsp");
                break;
            case "/contact":
                req.setAttribute("title", "Liên hệ");
                renderPage(req, resp, "/views/public/contact.jsp");
                break;
            default:
            case "/home":
                req.setAttribute("title", "Trang chủ");
                renderPage(req, resp, "/views/public/home.jsp");
                break;
        }
    }
}

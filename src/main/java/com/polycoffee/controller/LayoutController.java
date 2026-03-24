package com.polycoffee.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LayoutController extends HttpServlet {

    protected void renderPage(HttpServletRequest request, HttpServletResponse response, String viewPage)
            throws ServletException, IOException {
        request.setAttribute("view", viewPage);
        request.getRequestDispatcher("/views/layout.jsp").forward(request, response);
    }
}

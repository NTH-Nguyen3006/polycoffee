package com.polycoffee.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.polycoffee.dao.IProductsDao;
import com.polycoffee.dao.impl.ProductsDAOImpl;
import com.polycoffee.entity.Products;

@WebServlet("/menu")
public class MenuController extends LayoutController { // Đã đổi kế thừa
    
    private IProductsDao productDao = new ProductsDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
                req.setCharacterEncoding("UTF-8");
                resp.setCharacterEncoding("UTF-8");
        // 1. Lấy từ khóa từ ô tìm kiếm
        String keywords = req.getParameter("keywords");
        List<Products> list;

        // 2. Logic tìm kiếm
        if (keywords != null && !keywords.trim().isEmpty()) {
            list = productDao.findByName(keywords);
        } else {
            list = productDao.findAll();
        }

        // 3. Đẩy dữ liệu ra Request
        req.setAttribute("productList", list);
        req.setAttribute("title", "Thực đơn PolyCoffee");

        // 4. SỬ DỤNG RENDERPAGE (Thay vì getRequestDispatcher)
        // Hàm này sẽ tự động đẩy "/views/public/menu.jsp" vào biến ${view} trong layout.jsp
        renderPage(req, resp, "/views/public/menu.jsp");
    }
}
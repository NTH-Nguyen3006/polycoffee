package com.polycoffee.controller.manage;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.polycoffee.controller.LayoutController;
import com.polycoffee.dao.ICategoryDAO;
import com.polycoffee.dao.IProductsDao;
import com.polycoffee.dao.impl.CategoryDAO;
import com.polycoffee.dao.impl.ProductsDAOImpl;
import com.polycoffee.entity.Categories;
import com.polycoffee.entity.Products;

@WebServlet({ "/admin/product", "/admin/product/create", "/admin/product/edit", "/admin/product/delete" })
public class ProductController extends LayoutController {

    private IProductsDao dao = new ProductsDAOImpl();
    private ICategoryDAO categoryDao = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        switch (path) {
            case "/admin/product/create":
                req.setAttribute("categories", categoryDao.findAll());
                req.setAttribute("title", "Thêm Sản Phẩm Mới");
                renderPage(req, resp, "/views/admin/product/form.jsp");
                break;

            case "/admin/product/edit":
                try {
                    UUID id = UUID.fromString(req.getParameter("id"));
                    Products product = dao.findById(id);
                    if (product == null)
                        throw new Exception("Không tìm thấy sản phẩm.");
                    req.setAttribute("product", product);
                    req.setAttribute("categories", categoryDao.findAll());
                    req.setAttribute("title", "Chỉnh Sửa Sản Phẩm");
                    renderPage(req, resp, "/views/admin/product/form.jsp");
                } catch (Exception e) {
                    req.getSession().setAttribute("error", "Không tìm thấy sản phẩm.");
                    resp.sendRedirect(req.getContextPath() + "/admin/product");
                }
                break;

            case "/admin/product/delete":
                try {
                    UUID deleteId = UUID.fromString(req.getParameter("id"));
                    dao.delete(deleteId);
                    req.getSession().setAttribute("message", "Đã xóa sản phẩm thành công.");
                } catch (Exception e) {
                    req.getSession().setAttribute("error", "Lỗi khi xóa sản phẩm: " + e.getMessage());
                }
                resp.sendRedirect(req.getContextPath() + "/admin/product");
                break;

            default:
            case "/admin/product":
                String name = req.getParameter("name");
                String catIdStr = req.getParameter("categoryId");
                String availStr = req.getParameter("available");
                String pageStr = req.getParameter("page");

                long categoryId = (catIdStr != null && !catIdStr.isEmpty()) ? Long.parseLong(catIdStr) : null;
                boolean available = (availStr != null && !availStr.isEmpty()) ? Boolean.parseBoolean(availStr) : null;
                int page = (pageStr != null && !pageStr.isEmpty()) ? Integer.parseInt(pageStr) : 1;
                int pageSize = 10;

                List<Products> list = dao.searchAndPaginate(name, categoryId, available, page, pageSize);
                long totalItems = dao.countSearch(name, categoryId, available);
                int totalPages = (int) Math.ceil((double) totalItems / pageSize);

                req.setAttribute("products", list);
                req.setAttribute("categories", categoryDao.findAll());
                req.setAttribute("currentPage", page);
                req.setAttribute("totalPages", totalPages);
                req.setAttribute("totalItems", totalItems);
                req.setAttribute("name", name);
                req.setAttribute("categoryId", categoryId);
                req.setAttribute("available", available);
                req.setAttribute("title", "Quản Lý Sản Phẩm");
                renderPage(req, resp, "/views/admin/product/index.jsp");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String path = req.getServletPath();

        String name = req.getParameter("name");
        String description = req.getParameter("description");
        String thumbnailUrl = req.getParameter("thumbnailUrl");
        String basePriceStr = req.getParameter("basePrice");
        String categoryIdStr = req.getParameter("categoryId");
        boolean available = req.getParameter("available") != null;
        boolean featured = req.getParameter("featured") != null;

        BigDecimal basePrice = (basePriceStr != null && !basePriceStr.isEmpty())
                ? new BigDecimal(basePriceStr)
                : BigDecimal.ZERO;

        Categories category = null;
        if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
            category = categoryDao.findById(Long.parseLong(categoryIdStr));
        }

        try {
            if (path.equals("/admin/product/create")) {
                Products product = Products.builder()
                        .name(name)
                        .description(description)
                        .thumbnailUrl(thumbnailUrl)
                        .basePrice(basePrice)
                        .category(category)
                        .available(available)
                        .featured(featured)
                        .build();
                dao.create(product);
                req.getSession().setAttribute("message", "Thêm sản phẩm \"" + name + "\" thành công.");

            } else if (path.equals("/admin/product/edit")) {
                UUID id = UUID.fromString(req.getParameter("id"));
                Products product = dao.findById(id);
                if (product != null) {
                    product.setName(name);
                    product.setDescription(description);
                    product.setThumbnailUrl(thumbnailUrl);
                    product.setBasePrice(basePrice);
                    product.setCategory(category);
                    product.setAvailable(available);
                    product.setFeatured(featured);
                    dao.update(product);
                    req.getSession().setAttribute("message", "Cập nhật sản phẩm \"" + name + "\" thành công.");
                }
            }
        } catch (Exception e) {
            req.getSession().setAttribute("error", "Lỗi: " + e.getMessage());
        }

        resp.sendRedirect(req.getContextPath() + "/admin/product");
    }
}

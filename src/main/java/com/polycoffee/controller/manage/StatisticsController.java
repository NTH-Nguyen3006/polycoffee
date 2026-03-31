package com.polycoffee.controller.manage;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.polycoffee.controller.LayoutController;
import com.polycoffee.dao.impl.OrdersDAO;

@WebServlet("/admin/statistics")
public class StatisticsController extends LayoutController {

    private final OrdersDAO ordersDAO = new OrdersDAO();
    private static final DateTimeFormatter DATE_FMT = DateTimeFormatter.ofPattern("yyyy-MM-dd");

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String tab = req.getParameter("tab");
        if (tab == null || tab.isEmpty()) tab = "bestseller";

        // Lấy khoảng thời gian từ request
        String fromStr = req.getParameter("from");
        String toStr   = req.getParameter("to");

        // Mặc định: 30 ngày gần nhất
        LocalDateTime toDate   = (toStr != null && !toStr.isEmpty())
                ? LocalDateTime.parse(toStr + "T23:59:59")
                : LocalDateTime.now();
        LocalDateTime fromDate = (fromStr != null && !fromStr.isEmpty())
                ? LocalDateTime.parse(fromStr + "T00:00:00")
                : toDate.minusDays(29).with(LocalTime.MIN);

        req.setAttribute("fromDate", fromDate.format(DATE_FMT));
        req.setAttribute("toDate",   toDate.format(DATE_FMT));
        req.setAttribute("tab", tab);

        if ("revenue".equals(tab)) {
            loadRevenueData(req, fromDate, toDate);
        } else {
            loadBestSellerData(req, fromDate, toDate);
        }

        req.setAttribute("title", "Thống Kê");
        renderPage(req, resp, "/views/admin/statistics/index.jsp");
    }

    // ===================== BÀI 2: Top 5 thức uống bán chạy =====================
    private void loadBestSellerData(HttpServletRequest req,
                                    LocalDateTime from, LocalDateTime to) {
        List<Object[]> top5 = ordersDAO.findTop5BestSelling(from, to);
        req.setAttribute("top5", top5);
    }

    // ===================== BÀI 3: Thống kê doanh thu =====================
    private void loadRevenueData(HttpServletRequest req,
                                 LocalDateTime from, LocalDateTime to) {
        // Lấy kiểu nhóm: day hoặc month
        String groupBy = req.getParameter("groupBy");
        if (groupBy == null || groupBy.isEmpty()) groupBy = "day";
        req.setAttribute("groupBy", groupBy);

        // Dữ liệu biểu đồ
        List<Object[]> chartData;
        if ("month".equals(groupBy)) {
            chartData = ordersDAO.getRevenueByMonth(from, to);
        } else {
            chartData = ordersDAO.getRevenueByDay(from, to);
        }
        req.setAttribute("chartData", chartData);

        // Tổng hợp
        List<Object[]> summaryList = ordersDAO.getRevenueSummary(from, to);
        if (summaryList != null && !summaryList.isEmpty()) {
            Object[] summary = summaryList.get(0);
            req.setAttribute("totalRevenue",  summary[0]);
            req.setAttribute("totalOrders",   summary[1]);
            req.setAttribute("avgOrderValue", summary[2]);
        }

        // Doanh thu theo danh mục
        List<Object[]> revenueByCategory = ordersDAO.findRevenueByCategory(from, to);
        req.setAttribute("revenueByCategory", revenueByCategory);
    }
}

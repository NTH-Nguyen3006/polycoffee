<%@page pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container-fluid px-4">
    <!-- Page Header -->
    <div class="d-flex align-items-center justify-content-between my-4">
        <div>
            <h2 class="fw-bold text-dark mb-1"><i class="bi bi-cup-hot-fill text-warning me-2"></i>Thống Kê Cửa Hàng</h2>
            <p class="text-muted mb-0">Theo dõi hiệu suất kinh doanh và xu hướng sản phẩm</p>
        </div>
    </div>

    <!-- Tab Navigation -->
    <ul class="nav nav-pills mb-4 gap-2" id="statsTabs">
        <li class="nav-item">
            <a class="nav-link ${tab == 'bestseller' ? 'active' : ''} px-4 py-2 rounded-pill"
               style="${tab == 'bestseller' ? 'background-color: #6f4e37 !important;' : 'background-color: #f8f9fa; color: #6f4e37;'}"
               href="${pageContext.request.contextPath}/admin/statistics?tab=bestseller&from=${fromDate}&to=${toDate}">
                <i class="bi bi-trophy me-2"></i>Sản Phẩm Bán Chạy
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link ${tab == 'revenue' ? 'active' : ''} px-4 py-2 rounded-pill"
               style="${tab == 'revenue' ? 'background-color: #6f4e37 !important;' : 'background-color: #f8f9fa; color: #6f4e37;'}"
               href="${pageContext.request.contextPath}/admin/statistics?tab=revenue&from=${fromDate}&to=${toDate}">
                <i class="bi bi-graph-up-arrow me-2"></i>Doanh Thu
            </a>
        </li>
    </ul>

    <!-- Filter Form -->
    <div class="card border-0 shadow-sm mb-4 rounded-4">
        <div class="card-body p-4">
            <form action="${pageContext.request.contextPath}/admin/statistics" method="get" class="row g-3 align-items-end">
                <input type="hidden" name="tab" value="${tab}">
                
                <div class="col-md-3">
                    <label class="form-label small fw-bold text-uppercase text-muted">Từ ngày</label>
                    <input type="date" class="form-control rounded-3" name="from" value="${fromDate}">
                </div>
                <div class="col-md-3">
                    <label class="form-label small fw-bold text-uppercase text-muted">Đến ngày</label>
                    <input type="date" class="form-control rounded-3" name="to" value="${toDate}">
                </div>

                <c:if test="${tab == 'revenue'}">
                    <div class="col-md-2">
                        <label class="form-label small fw-bold text-uppercase text-muted">Nhóm theo</label>
                        <select class="form-select rounded-3" name="groupBy">
                            <option value="day" ${groupBy=='day' ? 'selected' : '' }>Ngày</option>
                            <option value="month" ${groupBy=='month' ? 'selected' : '' }>Tháng</option>
                        </select>
                    </div>
                </c:if>

                <div class="col-md-auto d-flex gap-2">
                    <button type="submit" class="btn text-white px-4 rounded-3" style="background-color: #6f4e37;">
                        <i class="bi bi-funnel me-1"></i>Lọc
                    </button>
                    <a href="${pageContext.request.contextPath}/admin/statistics?tab=${tab}" class="btn btn-light rounded-3">
                        <i class="bi bi-arrow-clockwise"></i>
                    </a>
                </div>
            </form>
        </div>
    </div>

    <!-- Content Area -->
    <div class="fade-in">
        <c:choose>
            <c:when test="${tab == 'bestseller'}">
                <jsp:include page="_bestseller.jsp" />
            </c:when>
            <c:when test="${tab == 'revenue'}">
                <jsp:include page="_revenue.jsp" />
            </c:when>
        </c:choose>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.3/dist/chart.umd.min.js"></script>
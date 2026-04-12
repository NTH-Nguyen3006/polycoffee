<%@page pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
/* ─── KPI Cards ─── */
.kpi-card {
    border-radius: 20px;
    border: none;
    overflow: hidden;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    position: relative;
}
.kpi-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 20px 40px rgba(0,0,0,0.12) !important;
}
.kpi-card .kpi-icon {
    width: 56px; height: 56px;
    border-radius: 16px;
    display: flex; align-items: center; justify-content: center;
    font-size: 1.5rem;
    flex-shrink: 0;
}
.kpi-card .kpi-value {
    font-size: 1.8rem; font-weight: 800; line-height: 1;
    color: #1a0a00;
}
.kpi-card .kpi-label {
    font-size: 0.82rem; color: #6c757d; font-weight: 500; margin-top: 4px;
}
.kpi-card .kpi-sub {
    font-size: 0.78rem; margin-top: 8px; font-weight: 600;
}

/* ─── Quick Nav Cards ─── */
.quick-card {
    border-radius: 18px; border: 1px solid #f0ebe4;
    background: #fff; transition: all 0.3s;
    text-decoration: none; display: block; padding: 24px 20px;
    text-align: center; height: 100%;
}
.quick-card:hover {
    transform: translateY(-6px);
    box-shadow: 0 20px 40px rgba(107,58,31,0.1);
    border-color: rgba(232,137,28,0.3);
    text-decoration: none;
}
.quick-card .quick-icon {
    width: 60px; height: 60px; border-radius: 18px;
    display: flex; align-items: center; justify-content: center;
    font-size: 1.6rem; margin: 0 auto 14px;
    transition: transform 0.3s;
}
.quick-card:hover .quick-icon { transform: scale(1.1) rotate(-5deg); }
.quick-card .quick-title { font-weight: 700; font-size: 0.95rem; color: #1a0a00; }
.quick-card .quick-desc  { font-size: 0.78rem; color: #888; margin-top: 4px; }

/* ─── Table ─── */
.dashboard-table thead th {
    background: linear-gradient(135deg, #1a0a00, #3d1f00);
    color: rgba(255,255,255,0.9);
    font-size: 0.82rem; font-weight: 600;
    padding: 12px 16px; border: none;
}
.dashboard-table tbody td {
    padding: 12px 16px; font-size: 0.88rem;
    vertical-align: middle; border-color: #f5f0eb;
}
.dashboard-table tbody tr:hover { background: rgba(232,137,28,0.04); }

/* ─── Status badges ─── */
.status-badge {
    padding: 4px 12px; border-radius: 20px;
    font-size: 11px; font-weight: 700;
    display: inline-flex; align-items: center; gap: 4px;
}
.status-pending    { background: rgba(255,193,7,0.15);  color: #856404; }
.status-processing { background: rgba(13,110,253,0.12); color: #084298; }
.status-completed  { background: rgba(25,135,84,0.12);  color: #0a3622; }
.status-cancelled  { background: rgba(220,53,69,0.12);  color: #842029; }

/* ─── Section headers ─── */
.section-header {
    display: flex; justify-content: space-between; align-items: center;
    margin-bottom: 16px;
}
.section-title-sm {
    font-size: 1rem; font-weight: 700; color: #1a0a00;
    display: flex; align-items: center; gap: 8px;
}
.section-title-sm .dot {
    width: 8px; height: 8px; border-radius: 50%;
    background: linear-gradient(135deg, #e8891c, #d4722a);
}

/* ─── Top item bar ─── */
.top-item { margin-bottom: 16px; }
.top-item .top-bar {
    height: 8px; border-radius: 4px; margin-top: 6px;
    background: linear-gradient(90deg, #e8891c, #f6c06e);
    transition: width 1s ease;
}

/* ─── Welcome banner ─── */
.welcome-banner {
    background: linear-gradient(135deg, #1a0a00 0%, #3d1f00 60%, #6b3a1f 100%);
    border-radius: 20px; padding: 28px 32px;
    position: relative; overflow: hidden;
    margin-bottom: 28px;
}
.welcome-banner::before {
    content: '☕';
    position: absolute; right: 24px; top: 50%; transform: translateY(-50%);
    font-size: 5rem; opacity: 0.12;
    pointer-events: none;
}
.welcome-banner h2 { color: #fff; font-weight: 800; margin: 0; }
.welcome-banner p  { color: rgba(255,255,255,0.65); margin: 6px 0 0; font-size: 0.9rem; }
</style>

<!-- ─── Welcome Banner ─── -->
<div class="welcome-banner">
    <h2>
        Xin chào, <span style="color:#f6c06e;">${sessionScope.user.fullname}</span> 👋
    </h2>
    <p>Hôm nay là ${pageContext.request.getSession().getAttribute("today") != null ? '' : ''}
        <fmt:formatDate value="${now}" pattern="EEEE, dd/MM/yyyy" var="today"/>
        Chào mừng trở lại bảng điều khiển Polycoffee.</p>
</div>

<!-- ─── KPI Cards ─── -->
<div class="row g-4 mb-4">
    <!-- Doanh thu hôm nay -->
    <div class="col-sm-6 col-xl-3">
        <div class="kpi-card card shadow-sm p-4">
            <div class="d-flex justify-content-between align-items-start gap-3">
                <div>
                    <div class="kpi-label">Doanh Thu Hôm Nay</div>
                    <div class="kpi-value mt-2">
                        <fmt:formatNumber value="${todayRevenue != null ? todayRevenue : 0}"
                                          type="number" groupingUsed="true"/>đ
                    </div>
                    <div class="kpi-sub text-success">
                        <i class="bi bi-receipt me-1"></i>${todayOrders != null ? todayOrders : 0} đơn hàng
                    </div>
                </div>
                <div class="kpi-icon" style="background:linear-gradient(135deg,rgba(25,135,84,0.12),rgba(25,135,84,0.06));">
                    <i class="bi bi-cash-stack" style="color:#198754;"></i>
                </div>
            </div>
        </div>
    </div>

    <!-- Doanh thu tháng -->
    <div class="col-sm-6 col-xl-3">
        <div class="kpi-card card shadow-sm p-4">
            <div class="d-flex justify-content-between align-items-start gap-3">
                <div>
                    <div class="kpi-label">Doanh Thu Tháng Này</div>
                    <div class="kpi-value mt-2">
                        <fmt:formatNumber value="${monthRevenue != null ? monthRevenue : 0}"
                                          type="number" groupingUsed="true"/>đ
                    </div>
                    <div class="kpi-sub text-primary">
                        <i class="bi bi-graph-up me-1"></i>${monthOrders != null ? monthOrders : 0} đơn tháng này
                    </div>
                </div>
                <div class="kpi-icon" style="background:linear-gradient(135deg,rgba(13,110,253,0.12),rgba(13,110,253,0.06));">
                    <i class="bi bi-bar-chart-line" style="color:#0d6efd;"></i>
                </div>
            </div>
        </div>
    </div>

    <!-- Chờ xử lý -->
    <div class="col-sm-6 col-xl-3">
        <div class="kpi-card card shadow-sm p-4">
            <div class="d-flex justify-content-between align-items-start gap-3">
                <div>
                    <div class="kpi-label">Đang Chờ Xử Lý</div>
                    <div class="kpi-value mt-2">${pendingOrders}</div>
                    <div class="kpi-sub text-warning">
                        <i class="bi bi-clock me-1"></i>Cần xử lý ngay
                    </div>
                </div>
                <div class="kpi-icon" style="background:linear-gradient(135deg,rgba(255,193,7,0.15),rgba(255,193,7,0.08));">
                    <i class="bi bi-hourglass-split" style="color:#e6a817;"></i>
                </div>
            </div>
            <c:if test="${pendingOrders > 0}">
                <a href="${pageContext.request.contextPath}/admin/order?status=PENDING"
                   class="btn btn-sm btn-warning rounded-pill mt-3 w-100 fw-semibold" style="font-size:12px;">
                    Xem ngay →
                </a>
            </c:if>
        </div>
    </div>

    <!-- Sản phẩm & người dùng -->
    <div class="col-sm-6 col-xl-3">
        <div class="kpi-card card shadow-sm p-4">
            <div class="d-flex justify-content-between align-items-start gap-3">
                <div>
                    <div class="kpi-label">Tổng Sản Phẩm / Khách</div>
                    <div class="kpi-value mt-2">${totalProducts} / ${totalUsers}</div>
                    <div class="kpi-sub" style="color:#6f42c1;">
                        <i class="bi bi-cup-hot me-1"></i>Hiện đang bán
                    </div>
                </div>
                <div class="kpi-icon" style="background:linear-gradient(135deg,rgba(111,66,193,0.12),rgba(111,66,193,0.06));">
                    <i class="bi bi-people-fill" style="color:#6f42c1;"></i>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- ─── Main Content Row ─── -->
<div class="row g-4 mb-4">

    <!-- Recent Orders Table -->
    <div class="col-lg-8">
        <div class="card border-0 shadow-sm h-100" style="border-radius:20px;overflow:hidden;">
            <div class="card-body p-0">
                <div class="p-4 pb-2">
                    <div class="section-header">
                        <div class="section-title-sm">
                            <span class="dot"></span>Đơn Hàng Mới Nhất
                        </div>
                        <a href="${pageContext.request.contextPath}/admin/order"
                           class="btn btn-sm btn-outline-warning rounded-pill fw-semibold" style="font-size:12px;">
                            Xem tất cả <i class="bi bi-arrow-right ms-1"></i>
                        </a>
                    </div>
                </div>
                <div class="table-responsive">
                    <table class="table mb-0 dashboard-table">
                        <thead>
                            <tr>
                                <th>Mã đơn</th>
                                <th>Nhân viên</th>
                                <th class="text-end">Tổng tiền</th>
                                <th class="text-center">Trạng thái</th>
                                <th>Ngày tạo</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty recentOrders}">
                                    <c:forEach var="o" items="${recentOrders}">
                                        <tr>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/admin/order/detail?id=${o.id}"
                                                   class="fw-bold text-decoration-none" style="color:#e8821c;">
                                                    #${o.orderCode}
                                                </a>
                                            </td>
                                            <td class="text-muted">
                                                <c:choose>
                                                    <c:when test="${not empty o.user}">${o.user.fullname}</c:when>
                                                    <c:otherwise><span class="text-muted">—</span></c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="text-end fw-semibold" style="color:#198754;">
                                                <fmt:formatNumber value="${o.totalAmount}" type="number" groupingUsed="true"/>đ
                                            </td>
                                            <td class="text-center">
                                                <c:choose>
                                                    <c:when test="${o.status == 'PENDING'}">
                                                        <span class="status-badge status-pending"><i class="bi bi-clock"></i>Chờ xử lý</span>
                                                    </c:when>
                                                    <c:when test="${o.status == 'PROCESSING'}">
                                                        <span class="status-badge status-processing"><i class="bi bi-gear"></i>Đang xử lý</span>
                                                    </c:when>
                                                    <c:when test="${o.status == 'COMPLETED'}">
                                                        <span class="status-badge status-completed"><i class="bi bi-check-circle"></i>Hoàn thành</span>
                                                    </c:when>
                                                    <c:when test="${o.status == 'CANCELLED'}">
                                                        <span class="status-badge status-cancelled"><i class="bi bi-x-circle"></i>Đã huỷ</span>
                                                    </c:when>
                                                </c:choose>
                                            </td>
                                            <td class="text-muted" style="font-size:0.82rem;">
                                                <c:if test="${not empty o.createdAt}">
                                                    ${o.createdAt.toString().replace('T',' ').substring(0,16)}
                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="5" class="text-center text-muted py-5">
                                            <i class="bi bi-inbox fs-1 d-block mb-2 opacity-25"></i>
                                            Chưa có đơn hàng nào.
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- Top 5 products this month -->
    <div class="col-lg-4">
        <div class="card border-0 shadow-sm h-100 p-4" style="border-radius:20px;">
            <div class="section-header mb-3">
                <div class="section-title-sm">
                    <span class="dot"></span>Top Bán Chạy Tháng Này
                </div>
            </div>
            <c:choose>
                <c:when test="${not empty top5Month}">
                    <c:set var="maxQty" value="${top5Month[0][1]}" />
                    <c:forEach var="item" items="${top5Month}" varStatus="loop">
                        <div class="top-item">
                            <div class="d-flex justify-content-between align-items-center">
                                <div class="d-flex align-items-center gap-2">
                                    <span class="fw-bold" style="font-size:0.78rem;color:#999;width:18px;">
                                        #${loop.index + 1}
                                    </span>
                                    <span class="fw-semibold" style="font-size:0.86rem;color:#1a0a00;
                                          max-width:150px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;"
                                          title="${item[0]}">${item[0]}</span>
                                </div>
                                <span class="badge rounded-pill"
                                      style="background:rgba(232,137,28,0.12);color:#e8821c;font-size:11px;">
                                    ${item[1]} ly
                                </span>
                            </div>
                            <div class="top-bar" style="width:${maxQty > 0 ? item[1] * 100 / maxQty : 0}%;"></div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="text-center text-muted py-4">
                        <i class="bi bi-trophy fs-1 d-block mb-2 opacity-25"></i>
                        Chưa có dữ liệu tháng này.
                    </div>
                </c:otherwise>
            </c:choose>
            <div class="mt-auto pt-2">
                <a href="${pageContext.request.contextPath}/admin/statistics?tab=bestseller"
                   class="btn btn-outline-warning rounded-pill w-100 fw-semibold" style="font-size:13px;">
                    <i class="bi bi-bar-chart me-1"></i>Xem thống kê đầy đủ
                </a>
            </div>
        </div>
    </div>
</div>

<!-- ─── Quick Access Cards ─── -->
<div class="mb-3">
    <div class="section-title-sm mb-3">
        <span class="dot"></span>Truy Cập Nhanh
    </div>
</div>
<div class="row g-3">
    <div class="col-6 col-md-4 col-lg-2">
        <a href="${pageContext.request.contextPath}/admin/category" class="quick-card">
            <div class="quick-icon" style="background:rgba(13,110,253,0.1);">
                <i class="bi bi-tags-fill" style="color:#0d6efd;"></i>
            </div>
            <div class="quick-title">Danh Mục</div>
            <div class="quick-desc">Quản lý loại đồ uống</div>
        </a>
    </div>
    <div class="col-6 col-md-4 col-lg-2">
        <a href="${pageContext.request.contextPath}/admin/product" class="quick-card">
            <div class="quick-icon" style="background:rgba(25,135,84,0.1);">
                <i class="bi bi-cup-hot-fill" style="color:#198754;"></i>
            </div>
            <div class="quick-title">Sản Phẩm</div>
            <div class="quick-desc">Thêm / chỉnh sửa món</div>
        </a>
    </div>
    <div class="col-6 col-md-4 col-lg-2">
        <a href="${pageContext.request.contextPath}/admin/order" class="quick-card">
            <div class="quick-icon" style="background:rgba(255,193,7,0.12);">
                <i class="bi bi-receipt-cutoff" style="color:#e6a817;"></i>
            </div>
            <div class="quick-title">Đơn Hàng</div>
            <div class="quick-desc">Xử lý đơn đặt hàng</div>
        </a>
    </div>
    <div class="col-6 col-md-4 col-lg-2">
        <a href="${pageContext.request.contextPath}/admin/promotion" class="quick-card">
            <div class="quick-icon" style="background:rgba(220,53,69,0.1);">
                <i class="bi bi-percent" style="color:#dc3545;"></i>
            </div>
            <div class="quick-title">Khuyến Mãi</div>
            <div class="quick-desc">Mã giảm giá & ưu đãi</div>
        </a>
    </div>
    <div class="col-6 col-md-4 col-lg-2">
        <a href="${pageContext.request.contextPath}/admin/user" class="quick-card">
            <div class="quick-icon" style="background:rgba(13,202,240,0.1);">
                <i class="bi bi-people-fill" style="color:#0dcaf0;"></i>
            </div>
            <div class="quick-title">Người Dùng</div>
            <div class="quick-desc">Tài khoản & phân quyền</div>
        </a>
    </div>
    <div class="col-6 col-md-4 col-lg-2">
        <a href="${pageContext.request.contextPath}/admin/statistics" class="quick-card">
            <div class="quick-icon" style="background:rgba(111,66,193,0.1);">
                <i class="bi bi-graph-up-arrow" style="color:#6f42c1;"></i>
            </div>
            <div class="quick-title">Thống Kê</div>
            <div class="quick-desc">Doanh thu & báo cáo</div>
        </a>
    </div>
</div>
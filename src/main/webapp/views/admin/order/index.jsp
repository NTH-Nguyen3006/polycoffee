<%@page pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- Flash messages --%>
<c:if test="${not empty sessionScope.message}">
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        <i class="bi bi-check-circle-fill me-2"></i>${sessionScope.message}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    <c:remove var="message" scope="session"/>
</c:if>
<c:if test="${not empty sessionScope.error}">
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        <i class="bi bi-exclamation-triangle-fill me-2"></i>${sessionScope.error}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    <c:remove var="error" scope="session"/>
</c:if>

<%-- Page Header --%>
<div class="d-flex justify-content-between align-items-center mb-4">
    <div>
        <h1 class="h3 fw-bold mb-1"><i class="bi bi-receipt-cutoff me-2 text-warning"></i>Quản Lý Đơn Hàng</h1>
        <p class="text-muted mb-0">Xem và xử lý tất cả đơn đặt hàng của hệ thống.</p>
    </div>
</div>

<%-- Filter by Status --%>
<div class="card border-0 shadow-sm mb-4">
    <div class="card-body py-2">
        <form action="${pageContext.request.contextPath}/admin/order" method="get" class="d-flex align-items-center gap-3 flex-wrap">
            <label class="fw-semibold text-muted small mb-0"><i class="bi bi-funnel me-1"></i>Lọc theo trạng thái:</label>
            <div class="d-flex gap-2 flex-wrap">
                <a href="${pageContext.request.contextPath}/admin/order"
                   class="btn btn-sm ${empty filterStatus ? 'btn-dark' : 'btn-outline-dark'}">
                    Tất cả <span class="badge bg-secondary ms-1">${totalItems}</span>
                </a>
                <c:forEach var="s" items="${['PENDING','PROCESSING','COMPLETED','CANCELLED']}">
                    <a href="${pageContext.request.contextPath}/admin/order?status=${s}"
                       class="btn btn-sm
                              ${s == 'PENDING'    ? (filterStatus == s ? 'btn-warning'  : 'btn-outline-warning')  : ''}
                              ${s == 'PROCESSING' ? (filterStatus == s ? 'btn-primary'  : 'btn-outline-primary')  : ''}
                              ${s == 'COMPLETED'  ? (filterStatus == s ? 'btn-success'  : 'btn-outline-success')  : ''}
                              ${s == 'CANCELLED'  ? (filterStatus == s ? 'btn-danger'   : 'btn-outline-danger')   : ''}">
                        <c:choose>
                            <c:when test="${s == 'PENDING'}">Chờ xử lý</c:when>
                            <c:when test="${s == 'PROCESSING'}">Đang xử lý</c:when>
                            <c:when test="${s == 'COMPLETED'}">Hoàn thành</c:when>
                            <c:when test="${s == 'CANCELLED'}">Đã huỷ</c:when>
                        </c:choose>
                    </a>
                </c:forEach>
            </div>
        </form>
    </div>
</div>

<%-- Orders Table --%>
<div class="card border-0 shadow-sm">
    <div class="card-header bg-warning text-dark d-flex justify-content-between align-items-center">
        <span><i class="bi bi-list-check me-2"></i><strong>Danh sách đơn hàng</strong>
            <span class="badge bg-dark ms-2">${totalItems} đơn</span>
        </span>
    </div>
    <div class="card-body p-0 table-responsive">
        <table class="table table-hover table-bordered mb-0 align-middle">
            <thead class="table-light">
                <tr>
                    <th style="width:50px">#</th>
                    <th>Mã đơn hàng</th>
                    <th>Nhân viên tạo</th>
                    <th class="text-end">Tổng tiền</th>
                    <th class="text-center">Trạng thái</th>
                    <th class="text-center">Thanh toán</th>
                    <th>Ngày tạo</th>
                    <th class="text-center" style="width:110px">Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty orders}">
                        <c:forEach var="o" items="${orders}" varStatus="loop">
                            <tr>
                                <td class="text-muted">${(currentPage - 1) * 10 + loop.index + 1}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/admin/order/detail?id=${o.id}"
                                       class="fw-semibold text-decoration-none">
                                        <i class="bi bi-hash"></i>${o.orderCode}
                                    </a>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty o.user}">
                                            <i class="bi bi-person-circle me-1 text-muted"></i>${o.user.fullname}
                                        </c:when>
                                        <c:otherwise><span class="text-muted">—</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-end fw-bold text-success">
                                    <fmt:formatNumber value="${o.totalAmount}" type="number" groupingUsed="true"/>đ
                                </td>
                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${o.status == 'PENDING'}">
                                            <span class="badge bg-warning text-dark"><i class="bi bi-clock me-1"></i>Chờ xử lý</span>
                                        </c:when>
                                        <c:when test="${o.status == 'PROCESSING'}">
                                            <span class="badge bg-primary"><i class="bi bi-gear me-1"></i>Đang xử lý</span>
                                        </c:when>
                                        <c:when test="${o.status == 'COMPLETED'}">
                                            <span class="badge bg-success"><i class="bi bi-check-circle me-1"></i>Hoàn thành</span>
                                        </c:when>
                                        <c:when test="${o.status == 'CANCELLED'}">
                                            <span class="badge bg-danger"><i class="bi bi-x-circle me-1"></i>Đã huỷ</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">${o.status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${o.paymentStatus == 'PAID'}">
                                            <span class="badge bg-success">Đã thanh toán</span>
                                        </c:when>
                                        <c:when test="${o.paymentStatus == 'UNPAID'}">
                                            <span class="badge bg-warning text-dark">Chưa TT</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">${not empty o.paymentStatus ? o.paymentStatus : '—'}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty o.createdAt}">
                                            ${o.createdAt.toString().replace('T',' ').substring(0,16)}
                                        </c:when>
                                        <c:otherwise>—</c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-center">
                                    <a href="${pageContext.request.contextPath}/admin/order/detail?id=${o.id}"
                                       class="btn btn-sm btn-outline-primary me-1" title="Xem chi tiết">
                                        <i class="bi bi-eye"></i>
                                    </a>
                                    <c:if test="${o.status != 'CANCELLED' && o.status != 'COMPLETED'}">
                                        <a href="${pageContext.request.contextPath}/admin/order/cancel?id=${o.id}"
                                           class="btn btn-sm btn-outline-danger"
                                           title="Huỷ đơn"
                                           onclick="return confirm('Huỷ đơn hàng #${o.orderCode}? Hành động này không thể hoàn tác!')">
                                            <i class="bi bi-x-lg"></i>
                                        </a>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="8" class="text-center text-muted py-5">
                                <i class="bi bi-inbox fs-1 d-block mb-2 opacity-50"></i>
                                Không có đơn hàng nào.
                            </td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>

    <%-- Pagination --%>
    <c:if test="${totalPages >= 1}">
        <div class="card-footer bg-white d-flex justify-content-between align-items-center flex-wrap gap-2">
            <small class="text-muted">
                Trang <strong>${currentPage}</strong> / <strong>${totalPages}</strong>
                &nbsp;·&nbsp; Tổng <strong>${totalItems}</strong> đơn hàng
            </small>
            <c:if test="${totalPages > 1}">
                <nav>
                    <ul class="pagination pagination-sm mb-0">
                        <li class="page-item ${currentPage <= 1 ? 'disabled' : ''}">
                            <a class="page-link"
                               href="${pageContext.request.contextPath}/admin/order?page=${currentPage - 1}&status=${filterStatus}">
                               <i class="bi bi-chevron-left"></i>
                            </a>
                        </li>

                        <c:set var="startPage" value="${currentPage - 2 < 1 ? 1 : currentPage - 2}"/>
                        <c:set var="endPage"   value="${currentPage + 2 > totalPages ? totalPages : currentPage + 2}"/>

                        <c:if test="${startPage > 1}">
                            <li class="page-item">
                                <a class="page-link" href="${pageContext.request.contextPath}/admin/order?page=1&status=${filterStatus}">1</a>
                            </li>
                            <c:if test="${startPage > 2}">
                                <li class="page-item disabled"><span class="page-link">…</span></li>
                            </c:if>
                        </c:if>

                        <c:forEach var="i" begin="${startPage}" end="${endPage}">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link"
                                   href="${pageContext.request.contextPath}/admin/order?page=${i}&status=${filterStatus}">${i}</a>
                            </li>
                        </c:forEach>

                        <c:if test="${endPage < totalPages}">
                            <c:if test="${endPage < totalPages - 1}">
                                <li class="page-item disabled"><span class="page-link">…</span></li>
                            </c:if>
                            <li class="page-item">
                                <a class="page-link" href="${pageContext.request.contextPath}/admin/order?page=${totalPages}&status=${filterStatus}">${totalPages}</a>
                            </li>
                        </c:if>

                        <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}">
                            <a class="page-link"
                               href="${pageContext.request.contextPath}/admin/order?page=${currentPage + 1}&status=${filterStatus}">
                               <i class="bi bi-chevron-right"></i>
                            </a>
                        </li>
                    </ul>
                </nav>
            </c:if>
        </div>
    </c:if>
</div>
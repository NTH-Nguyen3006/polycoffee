<%@page pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

<div class="d-flex justify-content-between align-items-center mb-4">
    <div>
        <h1 class="h3 fw-bold mb-1"><i class="bi bi-percent me-2 text-danger"></i>Quản Lý Khuyến Mãi</h1>
        <p class="text-muted mb-0">Thiết lập các chương trình ưu đãi cho khách hàng.</p>
    </div>
    <a href="${pageContext.request.contextPath}/admin/promotion/create" class="btn btn-primary">
        <i class="bi bi-plus-circle me-1"></i>Thêm Mới
    </a>
</div>

<div class="card border-0 shadow-sm">
    <div class="card-body p-0 table-responsive">
        <table class="table table-hover table-bordered mb-0 align-middle">
            <thead class="table-light">
                <tr>
                    <th style="width:50px">#</th>
                    <th>Mã giảm giá</th>
                    <th>Loại/Giá trị</th>
                    <th>ĐH Tối thiểu</th>
                    <th>Thời gian áp dụng</th>
                    <th class="text-center">Số lượng</th>
                    <th class="text-center" style="width:120px">Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty promotions}">
                        <c:forEach var="p" items="${promotions}" varStatus="loop">
                            <tr>
                                <td class="text-muted">${loop.index + 1}</td>
                                <td>
                                    <span class="badge bg-danger fs-6 fw-bold">${p.code}</span>
                                </td>
                                <td>
                                    <div class="fw-semibold">
                                        <c:choose>
                                            <c:when test="${p.discountType eq 'PERCENTAGE'}">
                                                Giảm ${p.discountValue}%
                                            </c:when>
                                            <c:otherwise>
                                                Giảm <fmt:formatNumber value="${p.discountValue}" type="number" groupingUsed="true"/>đ
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <small class="text-muted">${p.discountType}</small>
                                </td>
                                <td>
                                    <fmt:formatNumber value="${p.minOrderValue}" type="number" groupingUsed="true"/>đ
                                </td>
                                <td>
                                    <div class="small">Từ: ${p.startDate.toString().replace('T',' ').substring(0,16)}</div>
                                    <div class="small">Đến: ${p.endDate.toString().replace('T',' ').substring(0,16)}</div>
                                </td>
                                <td class="text-center">
                                    <span class="badge bg-primary">${p.usageLimit} lần</span>
                                </td>
                                <td class="text-center">
                                    <a href="${pageContext.request.contextPath}/admin/promotion/edit?id=${p.id}"
                                       class="btn btn-sm btn-outline-primary" title="Chỉnh sửa">
                                        <i class="bi bi-pencil"></i>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/promotion/delete?id=${p.id}"
                                       class="btn btn-sm btn-outline-danger"
                                       title="Xóa"
                                       onclick="return confirm('Xóa mã khuyến mãi ${p.code}?')">
                                        <i class="bi bi-trash"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="7" class="text-center text-muted py-5">
                                <i class="bi bi-percent fs-1 d-block mb-2 opacity-50"></i>
                                Chưa có chương trình khuyến mãi nào.
                            </td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</div>
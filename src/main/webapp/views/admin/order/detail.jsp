<%@page pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
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

<%-- Breadcrumb --%>
<nav aria-label="breadcrumb" class="mb-3">
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin">Dashboard</a></li>
        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/order">Đơn Hàng</a></li>
        <li class="breadcrumb-item active">Chi tiết #${order.orderCode}</li>
    </ol>
</nav>

<div class="row g-4">

    <%-- LEFT: Order Info + Items --%>
    <div class="col-lg-8">

        <%-- Order Header --%>
        <div class="card border-0 shadow-sm mb-4">
            <div class="card-header d-flex justify-content-between align-items-center
                        ${order.status == 'COMPLETED' ? 'bg-success text-white' :
                          order.status == 'CANCELLED' ? 'bg-danger text-white' :
                          order.status == 'PROCESSING' ? 'bg-primary text-white' :
                          'bg-warning text-dark'}">
                <span class="fw-bold fs-5">
                    <i class="bi bi-receipt me-2"></i>Đơn hàng #${order.orderCode}
                </span>
                <span class="badge bg-white
                             ${order.status == 'COMPLETED' ? 'text-success' :
                               order.status == 'CANCELLED' ? 'text-danger' :
                               order.status == 'PROCESSING' ? 'text-primary' :
                               'text-warning'}
                             fs-6">
                    <c:choose>
                        <c:when test="${order.status == 'PENDING'}"><i class="bi bi-clock me-1"></i>Chờ xử lý</c:when>
                        <c:when test="${order.status == 'PROCESSING'}"><i class="bi bi-gear me-1"></i>Đang xử lý</c:when>
                        <c:when test="${order.status == 'COMPLETED'}"><i class="bi bi-check-circle me-1"></i>Hoàn thành</c:when>
                        <c:when test="${order.status == 'CANCELLED'}"><i class="bi bi-x-circle me-1"></i>Đã huỷ</c:when>
                        <c:otherwise>${order.status}</c:otherwise>
                    </c:choose>
                </span>
            </div>
        </div>

        <%-- Product Items --%>
        <div class="card border-0 shadow-sm mb-4">
            <div class="card-header bg-light fw-semibold">
                <i class="bi bi-bag-check me-2"></i>Danh sách sản phẩm
            </div>
            <div class="card-body p-0">
                <table class="table table-hover mb-0 align-middle">
                    <thead class="table-light">
                        <tr>
                            <th style="width:40px">#</th>
                            <th>Tên sản phẩm</th>
                            <th>Tuỳ chọn</th>
                            <th class="text-center">Số lượng</th>
                            <th class="text-end">Đơn giá</th>
                            <th class="text-end">Thành tiền</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty order.orderItems}">
                                <c:forEach var="item" items="${order.orderItems}" varStatus="loop">
                                    <tr>
                                        <td class="text-muted">${loop.index + 1}</td>
                                        <td class="fw-semibold">
                                            <i class="bi bi-cup-hot me-2 text-warning"></i>${item.productName}
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty item.optionsSnapshot}">
                                                    <small class="text-muted">${item.optionsSnapshot}</small>
                                                </c:when>
                                                <c:otherwise><span class="text-muted">—</span></c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-center">
                                            <span class="badge bg-secondary">${item.quantity}</span>
                                        </td>
                                        <td class="text-end">
                                            <fmt:formatNumber value="${item.price}" type="number" groupingUsed="true"/>đ
                                        </td>
                                        <td class="text-end fw-bold text-success">
                                            <fmt:formatNumber value="${item.price * item.quantity}" type="number" groupingUsed="true"/>đ
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="6" class="text-center text-muted py-4">
                                        <i class="bi bi-bag fs-2 d-block mb-2 opacity-50"></i>
                                        Không có sản phẩm trong đơn hàng này.
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                    <c:if test="${not empty order.orderItems}">
                        <tfoot class="table-light">
                            <tr>
                                <td colspan="5" class="text-end fw-bold">Tổng cộng:</td>
                                <td class="text-end fw-bold text-success fs-5">
                                    <fmt:formatNumber value="${order.totalAmount}" type="number" groupingUsed="true"/>đ
                                </td>
                            </tr>
                        </tfoot>
                    </c:if>
                </table>
            </div>
        </div>

        <%-- Note --%>
        <c:if test="${not empty order.note}">
            <div class="card border-0 shadow-sm mb-4">
                <div class="card-header bg-light fw-semibold">
                    <i class="bi bi-pencil-square me-2"></i>Ghi chú
                </div>
                <div class="card-body text-muted">
                    ${order.note}
                </div>
            </div>
        </c:if>

    </div>

    <%-- RIGHT: Summary + Actions --%>
    <div class="col-lg-4">

        <%-- Order Summary --%>
        <div class="card border-0 shadow-sm mb-4">
            <div class="card-header bg-light fw-semibold">
                <i class="bi bi-info-circle me-2"></i>Thông tin đơn hàng
            </div>
            <div class="card-body">
                <dl class="row mb-0">
                    <dt class="col-5 text-muted small">Mã đơn:</dt>
                    <dd class="col-7 fw-semibold">${order.orderCode}</dd>

                    <dt class="col-5 text-muted small">Trạng thái:</dt>
                    <dd class="col-7">
                        <c:choose>
                            <c:when test="${order.status == 'PENDING'}"><span class="badge bg-warning text-dark">Chờ xử lý</span></c:when>
                            <c:when test="${order.status == 'PROCESSING'}"><span class="badge bg-primary">Đang xử lý</span></c:when>
                            <c:when test="${order.status == 'COMPLETED'}"><span class="badge bg-success">Hoàn thành</span></c:when>
                            <c:when test="${order.status == 'CANCELLED'}"><span class="badge bg-danger">Đã huỷ</span></c:when>
                            <c:otherwise><span class="badge bg-secondary">${order.status}</span></c:otherwise>
                        </c:choose>
                    </dd>

                    <dt class="col-5 text-muted small">Thanh toán:</dt>
                    <dd class="col-7">
                        <c:choose>
                            <c:when test="${order.paymentStatus == 'PAID'}"><span class="badge bg-success">Đã thanh toán</span></c:when>
                            <c:when test="${order.paymentStatus == 'UNPAID'}"><span class="badge bg-warning text-dark">Chưa thanh toán</span></c:when>
                            <c:otherwise><span class="badge bg-secondary">${not empty order.paymentStatus ? order.paymentStatus : '—'}</span></c:otherwise>
                        </c:choose>
                    </dd>

                    <dt class="col-5 text-muted small">Nhân viên:</dt>
                    <dd class="col-7">
                        <c:choose>
                            <c:when test="${not empty order.user}">
                                <i class="bi bi-person-circle me-1"></i>${order.user.fullname}
                                <br><small class="text-muted">@${order.user.username}</small>
                            </c:when>
                            <c:otherwise><span class="text-muted">—</span></c:otherwise>
                        </c:choose>
                    </dd>

                    <dt class="col-5 text-muted small">Ngày tạo:</dt>
                    <dd class="col-7">
                        <c:choose>
                            <c:when test="${not empty order.createdAt}">
                                ${order.createdAt.toString().replace('T',' ').substring(0,10)}
                                <br><small class="text-muted">${order.createdAt.toString().substring(11,19)}</small>
                            </c:when>
                            <c:otherwise>—</c:otherwise>
                        </c:choose>
                    </dd>

                    <c:if test="${not empty order.shippingAddress}">
                        <dt class="col-5 text-muted small">Địa chỉ:</dt>
                        <dd class="col-7">${order.shippingAddress}</dd>
                    </c:if>

                    <c:if test="${not empty order.promotion}">
                        <dt class="col-5 text-muted small">Khuyến mãi:</dt>
                        <dd class="col-7">
                            <span class="badge bg-danger">${order.promotion.code}</span>
                        </dd>
                    </c:if>
                </dl>
            </div>
        </div>

        <%-- Total Summary Box --%>
        <div class="card border-0 shadow-sm mb-4 bg-success text-white">
            <div class="card-body text-center py-4">
                <div class="fs-6 mb-1 opacity-75">Tổng tiền đơn hàng</div>
                <div class="display-6 fw-bold">
                    <fmt:formatNumber value="${order.totalAmount}" type="number" groupingUsed="true"/>đ
                </div>
            </div>
        </div>

        <%-- Actions --%>
        <div class="card border-0 shadow-sm">
            <div class="card-header bg-light fw-semibold">
                <i class="bi bi-lightning me-2"></i>Thao tác
            </div>
            <div class="card-body d-grid gap-2">
                <a href="${pageContext.request.contextPath}/admin/order"
                   class="btn btn-outline-secondary">
                    <i class="bi bi-arrow-left me-1"></i>Quay lại danh sách
                </a>
                <c:if test="${order.status != 'CANCELLED' && order.status != 'COMPLETED'}">
                    <a href="${pageContext.request.contextPath}/admin/order/cancel?id=${order.id}&from=detail"
                       class="btn btn-danger"
                       onclick="return confirm('Bạn có chắc muốn HUỶ đơn hàng #${order.orderCode}?\nHành động này không thể hoàn tác!')">
                        <i class="bi bi-x-circle me-1"></i>Huỷ Đơn Hàng
                    </a>
                </c:if>
            </div>
        </div>

    </div>
</div>

<%@page pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%-- Flash messages --%>
<c:if test="${not empty sessionScope.message}">
    <div class="alert alert-success alert-dismissible fade show mb-4 rounded-3 border-0 shadow-sm" role="alert">
        <i class="bi bi-check-circle-fill me-2"></i>${sessionScope.message}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    <c:remove var="message" scope="session"/>
</c:if>
<c:if test="${not empty sessionScope.error}">
    <div class="alert alert-danger alert-dismissible fade show mb-4 rounded-3 border-0 shadow-sm" role="alert">
        <i class="bi bi-exclamation-triangle-fill me-2"></i>${sessionScope.error}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    <c:remove var="error" scope="session"/>
</c:if>

<style>
.cat-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
    gap: 16px;
}
.cat-item {
    background: #fff;
    border: 1px solid #f0ebe4;
    border-radius: 20px;
    padding: 24px 20px;
    transition: all 0.3s;
    position: relative;
}
.cat-item:hover {
    border-color: rgba(232,130,28,0.35);
    box-shadow: 0 12px 30px rgba(107,58,31,0.09);
    transform: translateY(-4px);
}
.cat-icon {
    width: 52px; height: 52px;
    background: linear-gradient(135deg, rgba(232,137,28,0.15), rgba(212,113,42,0.08));
    border-radius: 16px;
    display: flex; align-items: center; justify-content: center;
    font-size: 1.5rem; margin-bottom: 14px;
    border: 1px solid rgba(232,130,28,0.2);
}
.cat-name { font-weight: 700; font-size: 1rem; color: #1a0a00; }
.cat-desc { font-size: 0.82rem; color: #999; margin-top: 4px; line-height: 1.5; }
.cat-actions { margin-top: 14px; display: flex; gap: 8px; }
.cat-id-badge {
    position: absolute; top: 14px; right: 14px;
    background: #f5f0eb; color: #999;
    font-size: 10px; font-weight: 700;
    padding: 3px 8px; border-radius: 20px;
}
</style>

<div class="d-flex justify-content-between align-items-center mb-4">
    <div>
        <h1 class="h3 fw-bold mb-1">
            <i class="bi bi-tags-fill me-2" style="color:#0d6efd;"></i>Quản Lý Danh Mục
        </h1>
        <p class="text-muted mb-0">Phân loại các món đồ uống trong thực đơn.</p>
    </div>
    <a href="${pageContext.request.contextPath}/admin/category/create"
       class="btn btn-primary rounded-pill px-4 fw-semibold">
        <i class="bi bi-plus-circle me-1"></i>Thêm Danh Mục
    </a>
</div>

<c:choose>
    <c:when test="${not empty categories}">
        <div class="cat-grid">
            <c:forEach var="item" items="${categories}" varStatus="loop">
                <div class="cat-item">
                    <span class="cat-id-badge">#${item.id}</span>
                    <div class="cat-icon">☕</div>
                    <div class="cat-name">${item.name}</div>
                    <div class="cat-desc">
                        <c:choose>
                            <c:when test="${not empty item.description}">${item.description}</c:when>
                            <c:otherwise><span style="color:#ccc;">Chưa có mô tả</span></c:otherwise>
                        </c:choose>
                    </div>
                    <div class="cat-actions">
                        <a href="${pageContext.request.contextPath}/admin/category/edit?id=${item.id}"
                           class="btn btn-sm btn-outline-primary rounded-pill px-3 fw-semibold">
                            <i class="bi bi-pencil me-1"></i>Sửa
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/category/delete?id=${item.id}"
                           class="btn btn-sm btn-outline-danger rounded-pill px-3 fw-semibold"
                           onclick="return confirm('Xóa danh mục «${item.name}»?\nCác sản phẩm thuộc danh mục này có thể bị ảnh hưởng.')">
                            <i class="bi bi-trash me-1"></i>Xóa
                        </a>
                    </div>
                </div>
            </c:forEach>
        </div>
        <div class="mt-4 text-muted small text-end">
            Tổng cộng <strong>${categories.size()}</strong> danh mục
        </div>
    </c:when>
    <c:otherwise>
        <div class="card border-0 shadow-sm" style="border-radius:20px;">
            <div class="card-body text-center py-5">
                <i class="bi bi-tags fs-1 d-block mb-3" style="color:#ddd;"></i>
                <h5 class="fw-bold" style="color:#999;">Chưa có danh mục nào</h5>
                <p class="text-muted small mb-3">Bắt đầu bằng cách thêm danh mục đầu tiên.</p>
                <a href="${pageContext.request.contextPath}/admin/category/create"
                   class="btn btn-primary rounded-pill px-4">
                    <i class="bi bi-plus-circle me-1"></i>Thêm Danh Mục
                </a>
            </div>
        </div>
    </c:otherwise>
</c:choose>
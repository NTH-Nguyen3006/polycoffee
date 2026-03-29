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

<%-- Search Card --%>
<div class="card mb-4 border-0 shadow-sm">
    <div class="card-header bg-primary text-white">
        <i class="bi bi-search me-2"></i><strong>Tìm kiếm sản phẩm</strong>
    </div>
    <div class="card-body bg-light">
        <form action="${pageContext.request.contextPath}/admin/product" method="get">
            <div class="row g-3 align-items-end">
                <div class="col-md-4">
                    <label class="form-label fw-semibold">
                        <i class="bi bi-cup-hot me-1"></i>Tên đồ uống
                    </label>
                    <input type="text" class="form-control" name="name"
                           value="${name}" placeholder="Nhập tên đồ uống...">
                </div>
                <div class="col-md-4">
                    <label class="form-label fw-semibold">
                        <i class="bi bi-tag me-1"></i>Loại đồ uống
                    </label>
                    <select class="form-select" name="categoryId">
                        <option value="">-- Tất cả loại --</option>
                        <c:forEach var="cat" items="${categories}">
                            <option value="${cat.id}"
                                <c:if test="${categoryId == cat.id}">selected</c:if>>
                                ${cat.name}
                            </option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-2">
                    <label class="form-label fw-semibold">
                        <i class="bi bi-toggle-on me-1"></i>Trạng thái
                    </label>
                    <select class="form-select" name="available">
                        <option value="">-- Tất cả --</option>
                        <option value="true"  <c:if test="${available == true}">selected</c:if>>Đang bán</option>
                        <option value="false" <c:if test="${available == false}">selected</c:if>>Ngừng bán</option>
                    </select>
                </div>
                <div class="col-md-2 d-flex gap-2">
                    <button type="submit" class="btn btn-primary w-100">
                        <i class="bi bi-search me-1"></i>Tìm
                    </button>
                    <a href="${pageContext.request.contextPath}/admin/product" class="btn btn-outline-secondary w-100">
                        <i class="bi bi-x-lg"></i>
                    </a>
                </div>
            </div>
        </form>
    </div>
</div>

<%-- Main Table Card --%>
<div class="card border-0 shadow-sm">
    <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
        <span>
            <i class="bi bi-cup-straw me-2"></i><strong>Danh sách đồ uống</strong>
            <span class="badge bg-light text-primary ms-2">${totalItems} sản phẩm</span>
        </span>
        <a href="${pageContext.request.contextPath}/admin/product/create" class="btn btn-light btn-sm">
            <i class="bi bi-plus-circle me-1"></i>Thêm mới
        </a>
    </div>

    <div class="card-body p-0 table-responsive">
        <table class="table table-hover table-bordered mb-0 align-middle">
            <thead class="table-light">
                <tr>
                    <th style="width:50px;">#</th>
                    <th style="width:65px;">Ảnh</th>
                    <th>Tên đồ uống</th>
                    <th>Loại</th>
                    <th>Giá cơ bản</th>
                    <th>Trạng thái</th>
                    <th>Nổi bật</th>
                    <th class="text-center" style="width:100px;">Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty products}">
                        <c:forEach var="item" items="${products}" varStatus="loop">
                            <tr>
                                <td class="text-muted">${(currentPage - 1) * 10 + loop.index + 1}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty item.thumbnailUrl}">
                                            <img src="${item.thumbnailUrl}" alt="${item.name}"
                                                 class="rounded" style="width:48px;height:48px;object-fit:cover;">
                                        </c:when>
                                        <c:otherwise>
                                            <div class="bg-light rounded d-flex align-items-center justify-content-center text-muted"
                                                 style="width:48px;height:48px;">
                                                <i class="bi bi-cup-hot"></i>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class="fw-semibold">${item.name}</div>
                                    <c:if test="${not empty item.description}">
                                        <small class="text-muted"
                                               style="display:block;max-width:220px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">
                                            ${item.description}
                                        </small>
                                    </c:if>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty item.category}">
                                            <span class="badge bg-secondary">${item.category.name}</span>
                                        </c:when>
                                        <c:otherwise><span class="text-muted">—</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="fw-semibold text-primary">
                                    <fmt:formatNumber value="${item.basePrice}" type="number" groupingUsed="true"/>đ
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${item.available}">
                                            <span class="badge bg-success">Đang bán</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-danger">Ngừng bán</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-center">
                                    <c:if test="${item.featured}">
                                        <i class="bi bi-star-fill text-warning"></i>
                                    </c:if>
                                    <c:if test="${!item.featured}">
                                        <i class="bi bi-star text-muted"></i>
                                    </c:if>
                                </td>
                                <td class="text-center">
                                    <a href="${pageContext.request.contextPath}/admin/product/edit?id=${item.id}"
                                       class="btn btn-sm btn-outline-primary me-1" title="Chỉnh sửa">
                                        <i class="bi bi-pencil"></i>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/product/delete?id=${item.id}"
                                       class="btn btn-sm btn-outline-danger"
                                       onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này?');"
                                       title="Xóa">
                                        <i class="bi bi-trash"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="8" class="text-center text-muted py-5">
                                <i class="bi bi-cup-hot fs-2 d-block mb-2"></i>
                                Không tìm thấy sản phẩm nào phù hợp.
                                <a href="${pageContext.request.contextPath}/admin/product"
                                   class="d-block mt-2 small">Xem tất cả</a>
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
                &nbsp;·&nbsp; Tổng <strong>${totalItems}</strong> sản phẩm
            </small>
            <c:if test="${totalPages > 1}">
                <nav>
                    <ul class="pagination pagination-sm mb-0">

                        <%-- Previous --%>
                        <li class="page-item ${currentPage <= 1 ? 'disabled' : ''}">
                            <a class="page-link"
                               href="${pageContext.request.contextPath}/admin/product?page=${currentPage - 1}&name=${name}&categoryId=${categoryId}&available=${available}">
                               <i class="bi bi-chevron-left"></i>
                            </a>
                        </li>

                        <%-- Page window --%>
                        <c:set var="startPage" value="${currentPage - 2 < 1 ? 1 : currentPage - 2}"/>
                        <c:set var="endPage"   value="${currentPage + 2 > totalPages ? totalPages : currentPage + 2}"/>

                        <c:if test="${startPage > 1}">
                            <li class="page-item">
                                <a class="page-link" href="${pageContext.request.contextPath}/admin/product?page=1&name=${name}&categoryId=${categoryId}&available=${available}">1</a>
                            </li>
                            <c:if test="${startPage > 2}">
                                <li class="page-item disabled"><span class="page-link">…</span></li>
                            </c:if>
                        </c:if>

                        <c:forEach var="i" begin="${startPage}" end="${endPage}">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link"
                                   href="${pageContext.request.contextPath}/admin/product?page=${i}&name=${name}&categoryId=${categoryId}&available=${available}">
                                   ${i}
                                </a>
                            </li>
                        </c:forEach>

                        <c:if test="${endPage < totalPages}">
                            <c:if test="${endPage < totalPages - 1}">
                                <li class="page-item disabled"><span class="page-link">…</span></li>
                            </c:if>
                            <li class="page-item">
                                <a class="page-link" href="${pageContext.request.contextPath}/admin/product?page=${totalPages}&name=${name}&categoryId=${categoryId}&available=${available}">${totalPages}</a>
                            </li>
                        </c:if>

                        <%-- Next --%>
                        <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}">
                            <a class="page-link"
                               href="${pageContext.request.contextPath}/admin/product?page=${currentPage + 1}&name=${name}&categoryId=${categoryId}&available=${available}">
                               <i class="bi bi-chevron-right"></i>
                            </a>
                        </li>

                    </ul>
                </nav>
            </c:if>
        </div>
    </c:if>
</div>
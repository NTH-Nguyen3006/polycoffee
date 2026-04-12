<%@page pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- Flash messages --%>
<c:if test="${not empty sessionScope.message}">
    <div class="alert alert-success alert-dismissible fade show rounded-4 border-0 shadow-sm mb-4" role="alert">
        <i class="bi bi-check-circle-fill me-2"></i>${sessionScope.message}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    <c:remove var="message" scope="session"/>
</c:if>
<c:if test="${not empty sessionScope.error}">
    <div class="alert alert-danger alert-dismissible fade show rounded-4 border-0 shadow-sm mb-4" role="alert">
        <i class="bi bi-exclamation-triangle-fill me-2"></i>${sessionScope.error}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    <c:remove var="error" scope="session"/>
</c:if>

<div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3 mb-4">
    <div>
        <h1 class="h3 fw-bold mb-1"><i class="bi bi-cup-hot-fill me-2" style="color:#198754;"></i>Quản Lý Sản Phẩm</h1>
        <p class="text-muted mb-0">Quản lý các loại đồ uống, thức ăn và cập nhật trạng thái bán.</p>
    </div>
    <a href="${pageContext.request.contextPath}/admin/product/create" class="btn fw-bold px-4 rounded-pill text-white shadow-sm" style="background:linear-gradient(135deg, #198754, #146c43); min-width: fit-content;">
        <i class="bi bi-plus-circle me-1"></i>Thêm Sản Phẩm
    </a>
</div>

<%-- Search Card --%>
<div class="card mb-4 border-0 shadow-sm rounded-4">
    <div class="card-body p-4 bg-white rounded-4">
        <form action="${pageContext.request.contextPath}/admin/product" method="get">
            <div class="row g-3 align-items-end">
                <div class="col-lg-4 col-md-6">
                    <label class="form-label small fw-bold text-uppercase text-muted">
                        <i class="bi bi-search me-1"></i>Tìm theo tên
                    </label>
                    <input type="text" class="form-control rounded-3" name="name"
                           value="${name}" placeholder="Nhập tên đồ uống...">
                </div>
                <div class="col-lg-3 col-md-6">
                    <label class="form-label small fw-bold text-uppercase text-muted">
                        <i class="bi bi-tag me-1"></i>Lọc theo nhóm
                    </label>
                    <select class="form-select rounded-3" name="categoryId">
                        <option value="">-- Tất cả danh mục --</option>
                        <c:forEach var="cat" items="${categories}">
                            <option value="${cat.id}"
                                <c:if test="${categoryId == cat.id}">selected</c:if>>
                                ${cat.name}
                            </option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-lg-3 col-md-6">
                    <label class="form-label small fw-bold text-uppercase text-muted">
                        <i class="bi bi-filter-circle me-1"></i>Trạng thái
                    </label>
                    <select class="form-select rounded-3" name="available">
                        <option value="">-- Tất cả --</option>
                        <option value="true"  <c:if test="${available == true}">selected</c:if>>Đang bán</option>
                        <option value="false" <c:if test="${available == false}">selected</c:if>>Ngừng bán</option>
                    </select>
                </div>
                <div class="col-lg-2 col-md-6 d-flex gap-2">
                    <button type="submit" class="btn text-white w-100 rounded-3" style="background-color: #6f4e37;">
                        <i class="bi bi-search me-1"></i>Lọc
                    </button>
                    <a href="${pageContext.request.contextPath}/admin/product" class="btn btn-light border rounded-3 px-3">
                        <i class="bi bi-arrow-clockwise"></i>
                    </a>
                </div>
            </div>
        </form>
    </div>
</div>

<%-- Main Table Card --%>
<div class="card border-0 shadow-sm rounded-4 overflow-hidden">
    <div class="card-header bg-white border-bottom py-3 px-4 d-flex justify-content-between align-items-center">
        <span class="fw-bold text-dark">
            <i class="bi bi-list-nested me-2 text-primary"></i>Danh sách sản phẩm
            <span class="badge bg-light text-primary border ms-2 rounded-pill">${totalItems} SP</span>
        </span>
    </div>

    <div class="card-body p-0 table-responsive">
        <table class="table table-hover mb-0 align-middle">
            <thead class="table-light">
                <tr>
                    <th class="ps-4" style="width:50px;">#</th>
                    <th style="width:70px;">Ảnh</th>
                    <th>Thông tin sản phẩm</th>
                    <th>Danh mục</th>
                    <th>Đơn giá</th>
                    <th class="text-center">Trạng thái</th>
                    <th class="text-center" style="width:130px; padding-right: 20px;">Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty products}">
                        <c:forEach var="item" items="${products}" varStatus="loop">
                            <tr>
                                <td class="ps-4 text-muted fw-semibold">${(currentPage - 1) * 10 + loop.index + 1}</td>
                                <td>
                                    <div class="rounded-3 overflow-hidden shadow-sm border border-light" style="width:52px;height:52px;background:#f8f9fa;">
                                        <c:choose>
                                            <c:when test="${not empty item.thumbnailUrl}">
                                                <img src="${pageContext.request.contextPath}/uploads/images/${item.thumbnailUrl}" alt="${item.name}"
                                                     onerror="this.src='https://images.unsplash.com/photo-1509042239860-f550ce710b93?q=80&w=150&h=150&auto=format&fit=crop'"
                                                     style="width:100%;height:100%;object-fit:cover;">
                                            </c:when>
                                            <c:otherwise>
                                                <div class="d-flex w-100 h-100 align-items-center justify-content-center text-muted">
                                                    <i class="bi bi-cup-hot" style="font-size:1.3rem;"></i>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </td>
                                <td>
                                    <div class="fw-bold text-dark d-flex align-items-center gap-2">
                                        ${item.name}
                                        <c:if test="${item.featured}">
                                            <i class="bi bi-star-fill text-warning shadow-sm" style="font-size: 11px;" title="Nổi bật"></i>
                                        </c:if>
                                    </div>
                                    <c:if test="${not empty item.description}">
                                        <div class="small text-muted fst-italic mt-1"
                                               style="display:block;max-width:260px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">
                                            ${item.description}
                                        </div>
                                    </c:if>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty item.category}">
                                            <span class="badge" style="background:rgba(13,110,253,0.1);color:#0d6efd;border:1px solid rgba(13,110,253,0.2);">
                                                ${item.category.name}
                                            </span>
                                        </c:when>
                                        <c:otherwise><span class="text-muted fst-italic">—</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="fw-bold text-success">
                                    <fmt:formatNumber value="${item.basePrice}" type="number" groupingUsed="true"/>đ
                                </td>
                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${item.available}">
                                            <span class="badge rounded-pill bg-success px-3 shadow-sm" style="font-weight: 600;">
                                                <i class="bi bi-check-circle me-1"></i>Đang bán
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge rounded-pill bg-danger px-3 shadow-sm" style="font-weight: 600;">
                                                <i class="bi bi-x-circle me-1"></i>Ngừng bán
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-center pe-4">
                                    <a href="${pageContext.request.contextPath}/admin/product/edit?id=${item.id}"
                                       class="btn btn-sm btn-outline-primary rounded-circle" style="width:32px;height:32px;padding:0;line-height:30px;" title="Chỉnh sửa">
                                        <i class="bi bi-pencil"></i>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/product/delete?id=${item.id}"
                                       class="btn btn-sm btn-outline-danger rounded-circle mx-1" style="width:32px;height:32px;padding:0;line-height:30px;"
                                       onclick="return confirm('Bạn có chắc muốn xóa sản phẩm ${item.name}?');"
                                       title="Xóa">
                                        <i class="bi bi-trash"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="7" class="text-center py-5">
                                <div style="width:80px;height:80px;border-radius:50%;background:#f8f9fa;display:flex;align-items:center;justify-content:center;margin:0 auto 16px;">
                                    <i class="bi bi-cup-straw fs-2 text-muted opacity-50"></i>
                                </div>
                                <h6 class="fw-bold text-muted">Không tìm thấy sản phẩm</h6>
                                <p class="text-muted small mb-3">Có vẻ từ khóa tìm kiếm không khớp với món nào.</p>
                                <a href="${pageContext.request.contextPath}/admin/product"
                                   class="btn btn-outline-secondary btn-sm rounded-pill px-3">Xóa bộ lọc</a>
                            </td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>

    <%-- Pagination --%>
    <c:if test="${totalPages >= 1}">
        <div class="card-footer bg-white border-top py-3 px-4 d-flex justify-content-between align-items-center flex-wrap gap-2">
            <small class="text-muted fw-semibold">
                Hiển thị trang <span class="badge bg-light text-dark border mx-1">${currentPage} / ${totalPages}</span>
            </small>
            <c:if test="${totalPages > 1}">
                <nav>
                    <ul class="pagination pagination-sm mb-0">
                        <li class="page-item ${currentPage <= 1 ? 'disabled' : ''}">
                            <a class="page-link shadow-sm text-dark" href="${pageContext.request.contextPath}/admin/product?page=${currentPage - 1}&name=${name}&categoryId=${categoryId}&available=${available}">
                               <i class="bi bi-chevron-left"></i>
                            </a>
                        </li>
                        <c:set var="startPage" value="${currentPage - 2 < 1 ? 1 : currentPage - 2}"/>
                        <c:set var="endPage"   value="${currentPage + 2 > totalPages ? totalPages : currentPage + 2}"/>
                        <c:forEach var="i" begin="${startPage}" end="${endPage}">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link shadow-sm ${i == currentPage ? 'bg-primary text-white border-primary' : 'text-dark'}"
                                   href="${pageContext.request.contextPath}/admin/product?page=${i}&name=${name}&categoryId=${categoryId}&available=${available}">
                                   ${i}
                                </a>
                            </li>
                        </c:forEach>
                        <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}">
                            <a class="page-link shadow-sm text-dark" href="${pageContext.request.contextPath}/admin/product?page=${currentPage + 1}&name=${name}&categoryId=${categoryId}&available=${available}">
                               <i class="bi bi-chevron-right"></i>
                            </a>
                        </li>
                    </ul>
                </nav>
            </c:if>
        </div>
    </c:if>
</div>
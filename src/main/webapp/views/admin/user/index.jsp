<%@page pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
        <i class="bi bi-search me-2"></i><strong>Tìm kiếm nhân viên</strong>
    </div>
    <div class="card-body bg-light">
        <form action="${pageContext.request.contextPath}/admin/user" method="get">
            <div class="row g-3 align-items-end">
                <div class="col-md-4">
                    <label class="form-label fw-semibold">
                        <i class="bi bi-person me-1"></i>Tên nhân viên
                    </label>
                    <input type="text" class="form-control" name="name"
                           value="${name}" placeholder="Nhập tên nhân viên...">
                </div>
                <div class="col-md-4">
                    <label class="form-label fw-semibold">
                        <i class="bi bi-envelope me-1"></i>Email
                    </label>
                    <input type="text" class="form-control" name="email"
                           value="${email}" placeholder="Nhập địa chỉ email...">
                </div>
                <div class="col-md-2">
                    <label class="form-label fw-semibold">
                        <i class="bi bi-toggle-on me-1"></i>Trạng thái
                    </label>
                    <select class="form-select" name="active">
                        <option value="">-- Tất cả --</option>
                        <option value="true"  <c:if test="${active == true}">selected</c:if>>Đang hoạt động</option>
                        <option value="false" <c:if test="${active == false}">selected</c:if>>Ngừng hoạt động</option>
                    </select>
                </div>
                <div class="col-md-2 d-flex gap-2">
                    <button type="submit" class="btn btn-primary w-100">
                        <i class="bi bi-search me-1"></i>Tìm
                    </button>
                    <a href="${pageContext.request.contextPath}/admin/user" class="btn btn-outline-secondary w-100">
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
            <i class="bi bi-people me-2"></i><strong>Danh sách nhân viên</strong>
            <span class="badge bg-light text-primary ms-2">${totalItems} người</span>
        </span>
        <a href="${pageContext.request.contextPath}/admin/user/create" class="btn btn-light btn-sm">
            <i class="bi bi-person-plus me-1"></i>Thêm mới
        </a>
    </div>

    <div class="card-body p-0 table-responsive">
        <table class="table table-hover table-bordered mb-0 align-middle">
            <thead class="table-light">
                <tr>
                    <th style="width:50px;">#</th>
                    <th>Họ tên</th>
                    <th>Tên đăng nhập</th>
                    <th>Email</th>
                    <th>Số điện thoại</th>
                    <th>Vai trò</th>
                    <th>Trạng thái</th>
                    <th class="text-center" style="width:130px;">Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty users}">
                        <c:forEach var="item" items="${users}" varStatus="loop">
                            <tr>
                                <td class="text-muted">${(currentPage - 1) * 10 + loop.index + 1}</td>
                                <td class="fw-semibold">${item.fullname}</td>
                                <td class="text-muted">@${item.username}</td>
                                <td>${item.email}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty item.phone}">${item.phone}</c:when>
                                        <c:otherwise><span class="text-muted">—</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${item.role == 'ADMIN'}">
                                            <span class="badge bg-danger">Admin</span>
                                        </c:when>
                                        <c:when test="${item.role == 'EMPLOYEE'}">
                                            <span class="badge bg-info text-dark">Nhân viên</span>
                                        </c:when>
                                        <c:when test="${item.role == 'USER'}">
                                            <span class="badge bg-success">Khách hàng</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">${item.role}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${item.active}">
                                            <span class="badge bg-success">Hoạt động</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">Ngừng HĐ</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-center">
                                    <a href="${pageContext.request.contextPath}/admin/user/edit?id=${item.id}"
                                       class="btn btn-sm btn-outline-primary me-1" title="Chỉnh sửa">
                                        <i class="bi bi-pencil"></i>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/user/reset-password?id=${item.id}"
                                       class="btn btn-sm btn-outline-warning me-1"
                                       onclick="return confirm('Cấp lại mật khẩu cho ${item.fullname}?\nMật khẩu mới sẽ được gửi qua email.');"
                                       title="Cấp lại mật khẩu">
                                        <i class="bi bi-key"></i>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/user/delete?id=${item.id}"
                                       class="btn btn-sm btn-outline-danger"
                                       onclick="return confirm('Bạn có chắc muốn xóa nhân viên ${item.fullname}?');"
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
                                <i class="bi bi-people fs-2 d-block mb-2"></i>
                                Không tìm thấy nhân viên nào phù hợp.
                                <a href="${pageContext.request.contextPath}/admin/user"
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
                &nbsp;·&nbsp; Tổng <strong>${totalItems}</strong> nhân viên
            </small>
            <c:if test="${totalPages > 1}">
                <nav>
                    <ul class="pagination pagination-sm mb-0">

                        <%-- Previous --%>
                        <li class="page-item ${currentPage <= 1 ? 'disabled' : ''}">
                            <a class="page-link"
                               href="${pageContext.request.contextPath}/admin/user?page=${currentPage - 1}&name=${name}&email=${email}&active=${active}">
                               <i class="bi bi-chevron-left"></i>
                            </a>
                        </li>

                        <%-- Page window ±2 --%>
                        <c:set var="startPage" value="${currentPage - 2 < 1 ? 1 : currentPage - 2}"/>
                        <c:set var="endPage"   value="${currentPage + 2 > totalPages ? totalPages : currentPage + 2}"/>

                        <c:if test="${startPage > 1}">
                            <li class="page-item">
                                <a class="page-link" href="${pageContext.request.contextPath}/admin/user?page=1&name=${name}&email=${email}&active=${active}">1</a>
                            </li>
                            <c:if test="${startPage > 2}">
                                <li class="page-item disabled"><span class="page-link">…</span></li>
                            </c:if>
                        </c:if>

                        <c:forEach var="i" begin="${startPage}" end="${endPage}">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link"
                                   href="${pageContext.request.contextPath}/admin/user?page=${i}&name=${name}&email=${email}&active=${active}">
                                   ${i}
                                </a>
                            </li>
                        </c:forEach>

                        <c:if test="${endPage < totalPages}">
                            <c:if test="${endPage < totalPages - 1}">
                                <li class="page-item disabled"><span class="page-link">…</span></li>
                            </c:if>
                            <li class="page-item">
                                <a class="page-link" href="${pageContext.request.contextPath}/admin/user?page=${totalPages}&name=${name}&email=${email}&active=${active}">${totalPages}</a>
                            </li>
                        </c:if>

                        <%-- Next --%>
                        <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}">
                            <a class="page-link"
                               href="${pageContext.request.contextPath}/admin/user?page=${currentPage + 1}&name=${name}&email=${email}&active=${active}">
                               <i class="bi bi-chevron-right"></i>
                            </a>
                        </li>

                    </ul>
                </nav>
            </c:if>
        </div>
    </c:if>
</div>
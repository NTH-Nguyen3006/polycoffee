<%@page pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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

<div class="d-flex justify-content-between align-items-center mb-4">
    <div>
        <h1 class="h3 fw-bold mb-1"><i class="bi bi-people-fill me-2" style="color:#0dcaf0;"></i>Quản Lý Người Dùng</h1>
        <p class="text-muted mb-0">Quản lý tài khoản, phân quyền và trạng thái hoạt động.</p>
    </div>
    <a href="${pageContext.request.contextPath}/admin/user/create" class="btn fw-bold px-4 rounded-pill text-white" style="background:linear-gradient(135deg, #e8891c, #d4722a);">
        <i class="bi bi-person-plus-fill me-1"></i>Thêm Mới
    </a>
</div>

<%-- Search Card --%>
<div class="card mb-4 border-0 shadow-sm rounded-4">
    <div class="card-body p-4 bg-white rounded-4">
        <form action="${pageContext.request.contextPath}/admin/user" method="get">
            <div class="row g-3 align-items-end">
                <div class="col-md-4">
                    <label class="form-label small fw-bold text-uppercase text-muted">
                        <i class="bi bi-person me-1"></i>Tên nhân viên
                    </label>
                    <input type="text" class="form-control rounded-3" name="name"
                           value="${name}" placeholder="Nhập tên người dùng...">
                </div>
                <div class="col-md-4">
                    <label class="form-label small fw-bold text-uppercase text-muted">
                        <i class="bi bi-envelope me-1"></i>Email
                    </label>
                    <input type="text" class="form-control rounded-3" name="email"
                           value="${email}" placeholder="Địa chỉ email...">
                </div>
                <div class="col-md-2">
                    <label class="form-label small fw-bold text-uppercase text-muted">
                        <i class="bi bi-toggle-on me-1"></i>Trạng thái
                    </label>
                    <select class="form-select rounded-3" name="active">
                        <option value="">-- Tất cả --</option>
                        <option value="true"  <c:if test="${active == true}">selected</c:if>>Đang HĐ</option>
                        <option value="false" <c:if test="${active == false}">selected</c:if>>Ngừng HĐ</option>
                    </select>
                </div>
                <div class="col-md-2 d-flex gap-2">
                    <button type="submit" class="btn text-white w-100 rounded-3" style="background-color: #6f4e37;">
                        <i class="bi bi-search me-1"></i>Tìm
                    </button>
                    <a href="${pageContext.request.contextPath}/admin/user" class="btn btn-light rounded-3 px-3">
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
            <i class="bi bi-list-ul me-2 text-primary"></i>Danh sách người dùng
            <span class="badge bg-light text-primary border ms-2 rounded-pill">${totalItems} TK</span>
        </span>
    </div>

    <div class="card-body p-0 table-responsive">
        <table class="table table-hover mb-0 align-middle">
            <thead class="table-light">
                <tr>
                    <th class="ps-4" style="width:50px;">#</th>
                    <th>Người dùng</th>
                    <th>Liên hệ</th>
                    <th>Vai trò</th>
                    <th>Trạng thái</th>
                    <th class="text-center" style="width:130px; padding-right: 20px;">Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty users}">
                        <c:forEach var="item" items="${users}" varStatus="loop">
                            <tr>
                                <td class="ps-4 text-muted fw-semibold">${(currentPage - 1) * 10 + loop.index + 1}</td>
                                <td>
                                    <div class="d-flex align-items-center gap-3">
                                        <div style="width:40px;height:40px;border-radius:12px;background:linear-gradient(135deg,rgba(13,202,240,0.2),rgba(13,202,240,0.1));display:flex;align-items:center;justify-content:center;color:#0dcaf0;font-weight:bold;font-size:1.1rem;">
                                            ${fn:substring(item.fullname, 0, 1)}
                                        </div>
                                        <div>
                                            <div class="fw-bold text-dark">${item.fullname}</div>
                                            <div class="small text-muted">@${item.username}</div>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <div class="small text-dark"><i class="bi bi-envelope text-muted me-1"></i>${item.email}</div>
                                    <div class="small text-dark mt-1"><i class="bi bi-telephone text-muted me-1"></i>
                                        <c:choose>
                                            <c:when test="${not empty item.phone}">${item.phone}</c:when>
                                            <c:otherwise><span class="text-muted fst-italic">Trống</span></c:otherwise>
                                        </c:choose>
                                    </div>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${item.role == 'ADMIN'}">
                                            <span class="badge" style="background:rgba(220,53,69,0.1);color:#dc3545;border:1px solid rgba(220,53,69,0.2);">Quản trị viên</span>
                                        </c:when>
                                        <c:when test="${item.role == 'EMPLOYEE'}">
                                            <span class="badge" style="background:rgba(13,202,240,0.1);color:#0dcaf0;border:1px solid rgba(13,202,240,0.2);">Nhân viên</span>
                                        </c:when>
                                        <c:when test="${item.role == 'USER'}">
                                            <span class="badge" style="background:rgba(25,135,84,0.1);color:#198754;border:1px solid rgba(25,135,84,0.2);">Khách hàng</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">${item.role}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${item.active}">
                                            <div class="d-flex align-items-center gap-1 text-success small fw-semibold">
                                                <i class="bi bi-circle-fill" style="font-size:8px;"></i> Hoạt động
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="d-flex align-items-center gap-1 text-muted small fw-semibold">
                                                <i class="bi bi-circle-fill" style="font-size:8px;"></i> Tạm khóa
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-center pe-4">
                                    <a href="${pageContext.request.contextPath}/admin/user/edit?id=${item.id}"
                                       class="btn btn-sm btn-outline-primary rounded-circle" style="width:32px;height:32px;padding:0;line-height:30px;" title="Chỉnh sửa">
                                        <i class="bi bi-pencil"></i>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/user/reset-password?id=${item.id}"
                                       class="btn btn-sm btn-outline-warning rounded-circle mx-1" style="width:32px;height:32px;padding:0;line-height:30px;"
                                       onclick="return confirm('Cấp lại mật khẩu cho ${item.fullname}?\nMật khẩu mới sẽ được gửi qua email.');"
                                       title="Cấp lại mật khẩu">
                                        <i class="bi bi-key"></i>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/user/delete?id=${item.id}"
                                       class="btn btn-sm btn-outline-danger rounded-circle" style="width:32px;height:32px;padding:0;line-height:30px;"
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
                            <td colspan="6" class="text-center py-5">
                                <div style="width:80px;height:80px;border-radius:50%;background:#f8f9fa;display:flex;align-items:center;justify-content:center;margin:0 auto 16px;">
                                    <i class="bi bi-people fs-2 text-muted opacity-50"></i>
                                </div>
                                <h6 class="fw-bold text-muted">Không tìm thấy người dùng</h6>
                                <p class="text-muted small mb-3">Thử thay đổi bộ lọc tìm kiếm.</p>
                                <a href="${pageContext.request.contextPath}/admin/user"
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
                            <a class="page-link shadow-sm text-dark" href="${pageContext.request.contextPath}/admin/user?page=${currentPage - 1}&name=${name}&email=${email}&active=${active}">
                               <i class="bi bi-chevron-left"></i>
                            </a>
                        </li>
                        <c:set var="startPage" value="${currentPage - 2 < 1 ? 1 : currentPage - 2}"/>
                        <c:set var="endPage"   value="${currentPage + 2 > totalPages ? totalPages : currentPage + 2}"/>
                        <c:forEach var="i" begin="${startPage}" end="${endPage}">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link shadow-sm ${i == currentPage ? 'bg-primary text-white border-primary' : 'text-dark'}"
                                   href="${pageContext.request.contextPath}/admin/user?page=${i}&name=${name}&email=${email}&active=${active}">
                                   ${i}
                                </a>
                            </li>
                        </c:forEach>
                        <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}">
                            <a class="page-link shadow-sm text-dark" href="${pageContext.request.contextPath}/admin/user?page=${currentPage + 1}&name=${name}&email=${email}&active=${active}">
                               <i class="bi bi-chevron-right"></i>
                            </a>
                        </li>
                    </ul>
                </nav>
            </c:if>
        </div>
    </c:if>
</div>
<%@page pageEncoding="utf-8" isELIgnored="false" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <div class="card shadow-sm">
            <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
                <h5 class="mb-0">Quản Lý Danh Mục</h5>
                <a href="${pageContext.request.contextPath}/admin/category/create" class="btn btn-light btn-sm"><i
                        class="bi bi-plus-circle"></i> Thêm Danh Mục Mới</a>
            </div>
            <div class="card-body p-0">
                <c:if test="${not empty sessionScope.message}">
                    <div class="alert alert-success alert-dismissible fade show m-3" role="alert">
                        ${sessionScope.message}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <c:remove var="message" scope="session"/>
                </c:if>
                <c:if test="${not empty sessionScope.error}">
                    <div class="alert alert-danger alert-dismissible fade show m-3" role="alert">
                        ${sessionScope.error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <c:remove var="error" scope="session"/>
                </c:if>

                <table class="table table-hover table-bordered mb-0">
                    <thead class="table-light">
                        <tr>
                            <th>Mã</th>
                            <th>Tên Danh Mục</th>
                            <th>Mô Tả</th>
                            <th class="text-center" style="width: 15%;">Hành Động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${categories}">
                            <tr>
                                <td>${item.id}</td>
                                <td>${item.name}</td>
                                <td>${item.description}</td>
                                <td class="text-center">
                                    <a href="${pageContext.request.contextPath}/admin/category/edit?id=${item.id}"
                                        class="btn btn-sm btn-outline-primary"><i class="bi bi-pencil"></i></a>
                                    <a href="${pageContext.request.contextPath}/admin/category/delete?id=${item.id}"
                                        class="btn btn-sm btn-outline-danger"
                                        onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục này?');"><i
                                            class="bi bi-trash"></i></a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty categories}">
                            <tr>
                                <td colspan="4" class="text-center text-muted py-4">Không tìm thấy danh mục nào.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
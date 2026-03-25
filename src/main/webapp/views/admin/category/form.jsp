<%@page pageEncoding="utf-8" isELIgnored="false" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card shadow-sm">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0">${empty category ? 'Thêm Danh Mục Mới' : 'Chỉnh Sửa Danh Mục'}</h5>
                    </div>
                    <div class="card-body">
                        <c:if test="${not empty sessionScope.error}">
                            <div class="alert alert-danger alert-dismissible fade show mb-3" role="alert">
                                ${sessionScope.error}
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                            <c:remove var="error" scope="session"/>
                        </c:if>
                        <form
                            action="${pageContext.request.contextPath}/admin/category/${empty category ? 'create' : 'edit'}"
                            method="post">
                            <c:if test="${not empty category}">
                                <input type="hidden" name="id" value="${category.id}">
                            </c:if>

                            <div class="mb-3">
                                <label for="categoryName" class="form-label">Tên Danh Mục</label>
                                <input type="text" class="form-control" id="categoryName" name="name"
                                    value="${category.name}" required>
                            </div>

                            <div class="mb-4">
                                <label for="categoryDescription" class="form-label">Mô Tả</label>
                                <textarea class="form-control" id="categoryDescription" name="description"
                                    rows="4">${category.description}</textarea>
                            </div>

                            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                <a href="${pageContext.request.contextPath}/admin/category"
                                    class="btn btn-secondary">Hủy Bỏ</a>
                                <button type="submit" class="btn btn-primary"><i class="bi bi-save"></i>
                                    Lưu Lại</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
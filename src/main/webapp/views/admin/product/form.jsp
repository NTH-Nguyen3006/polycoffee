<%@page pageEncoding="utf-8" isELIgnored="false" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <div class="row justify-content-center">
                <div class="col-lg-8">

                    <%-- Breadcrumb --%>
                        <nav aria-label="breadcrumb" class="mb-3">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item">
                                    <a href="${pageContext.request.contextPath}/admin/product">Quản lý sản phẩm</a>
                                </li>
                                <li class="breadcrumb-item active">
                                    ${empty product ? 'Thêm mới' : 'Chỉnh sửa'}
                                </li>
                            </ol>
                        </nav>

                        <div class="card border-0 shadow-sm">
                            <div class="card-header bg-primary text-white">
                                <h5 class="mb-0">
                                    <i class="bi bi-${empty product ? 'plus-circle' : 'pencil-square'} me-2"></i>
                                    ${empty product ? 'Thêm sản phẩm mới' : 'Chỉnh sửa sản phẩm'}
                                </h5>
                            </div>
                            <div class="card-body">
                                <form
                                    action="${pageContext.request.contextPath}/admin/product/${empty product ? 'create' : 'edit'}"
                                    method="post">

                                    <c:if test="${not empty product}">
                                        <input type="hidden" name="id" value="${product.id}">
                                    </c:if>

                                    <%-- Tên & Loại --%>
                                        <div class="row mb-3">
                                            <div class="col-md-8">
                                                <label class="form-label fw-semibold">
                                                    <i class="bi bi-cup-hot me-1"></i>Tên đồ uống <span
                                                        class="text-danger">*</span>
                                                </label>
                                                <input type="text" class="form-control" name="name"
                                                    value="${product.name}" placeholder="VD: Cà phê sữa đá" required>
                                            </div>
                                            <div class="col-md-4">
                                                <label class="form-label fw-semibold">
                                                    <i class="bi bi-tag me-1"></i>Loại đồ uống
                                                </label>
                                                <select class="form-select" name="categoryId">
                                                    <option value="">-- Chọn loại --</option>
                                                    <c:forEach var="cat" items="${categories}">
                                                        <option value="${cat.id}" <c:if
                                                            test="${product.category.id == cat.id}">selected</c:if>>
                                                            ${cat.name}
                                                        </option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>

                                        <%-- Giá & URL ảnh --%>
                                            <div class="row mb-3">
                                                <div class="col-md-5">
                                                    <label class="form-label fw-semibold">
                                                        <i class="bi bi-currency-exchange me-1"></i>Giá cơ bản (VNĐ)
                                                        <span class="text-danger">*</span>
                                                    </label>
                                                    <input type="number" class="form-control" name="basePrice"
                                                        value="${product.basePrice}" min="0" step="1000"
                                                        placeholder="VD: 35000" required>
                                                </div>
                                                <div class="col-md-7">
                                                    <label class="form-label fw-semibold">
                                                        <i class="bi bi-image me-1"></i>URL ảnh sản phẩm
                                                    </label>
                                                    <input type="url" class="form-control" name="thumbnailUrl"
                                                        id="thumbnailUrlInput" value="${product.thumbnailUrl}"
                                                        placeholder="https://example.com/image.jpg"
                                                        oninput="previewImage(this.value)">
                                                </div>
                                            </div>

                                            <%-- Preview ảnh --%>
                                                <div class="mb-3" id="previewBox"
                                                    style="${empty product.thumbnailUrl ? 'display:none;' : ''}">
                                                    <label class="form-label fw-semibold">Xem trước ảnh</label>
                                                    <div>
                                                        <img id="previewImg" src="${product.thumbnailUrl}" alt="Preview"
                                                            class="img-thumbnail"
                                                            style="max-height:160px;object-fit:cover;">
                                                    </div>
                                                </div>

                                                <%-- Mô tả --%>
                                                    <div class="mb-3">
                                                        <label class="form-label fw-semibold">
                                                            <i class="bi bi-card-text me-1"></i>Mô tả
                                                        </label>
                                                        <textarea class="form-control" name="description" rows="3"
                                                            placeholder="Nhập mô tả sản phẩm...">${product.description}</textarea>
                                                    </div>

                                                    <%-- Trạng thái & Nổi bật --%>
                                                        <div class="row mb-4">
                                                            <div class="col-md-6">
                                                                <div class="form-check form-switch mt-2">
                                                                    <input class="form-check-input" type="checkbox"
                                                                        role="switch" name="available"
                                                                        id="availableCheck" ${empty product ||
                                                                        product.available ? 'checked' : '' }>
                                                                    <label class="form-check-label fw-semibold"
                                                                        for="availableCheck">
                                                                        <i class="bi bi-shop me-1"></i>Đang bán
                                                                    </label>
                                                                    <div class="form-text">Bỏ chọn nếu sản phẩm tạm
                                                                        ngừng kinh doanh.</div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-6">
                                                                <div class="form-check form-switch mt-2">
                                                                    <input class="form-check-input" type="checkbox"
                                                                        role="switch" name="featured" id="featuredCheck"
                                                                        ${product.featured ? 'checked' : '' }>
                                                                    <label class="form-check-label fw-semibold"
                                                                        for="featuredCheck">
                                                                        <i class="bi bi-star me-1"></i>Sản phẩm nổi bật
                                                                    </label>
                                                                    <div class="form-text">Sẽ hiển thị ưu tiên trên
                                                                        trang chủ.</div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <%-- Buttons --%>
                                                            <div
                                                                class="d-flex gap-2 justify-content-end border-top pt-3">
                                                                <a href="${pageContext.request.contextPath}/admin/product"
                                                                    class="btn btn-outline-secondary">
                                                                    <i class="bi bi-arrow-left me-1"></i>Hủy
                                                                </a>
                                                                <button type="submit" class="btn btn-primary">
                                                                    <i class="bi bi-save me-1"></i>
                                                                    ${empty product ? 'Thêm sản phẩm' : 'Lưu thay đổi'}
                                                                </button>
                                                            </div>

                                </form>
                            </div>
                        </div>

                </div>
            </div>

            <script>
                function previewImage(url) {
                    const box = document.getElementById('previewBox');
                    const img = document.getElementById('previewImg');
                    if (url && url.trim() !== '') {
                        img.src = url;
                        box.style.display = '';
                        img.onerror = () => { box.style.display = 'none'; };
                    } else {
                        box.style.display = 'none';
                    }
                }
            </script>
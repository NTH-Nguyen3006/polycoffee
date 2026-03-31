<%@page pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="row justify-content-center">
    <div class="col-lg-8">
        <nav aria-label="breadcrumb" class="mb-3">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/promotion">Khuyến Mãi</a></li>
                <li class="breadcrumb-item active">${empty promotion ? 'Thêm mới' : 'Chỉnh sửa'}</li>
            </ol>
        </nav>

        <div class="card border-0 shadow-sm overflow-hidden">
            <div class="card-header bg-primary text-white py-3">
                <h5 class="mb-0 fw-bold">
                    <i class="bi bi-pencil-square me-2"></i>
                    ${empty promotion ? 'Thiết lập chương trình mới' : 'Cập nhật khuyến mãi #'}${promotion.code}
                </h5>
            </div>
            <div class="card-body p-4 bg-light">
                <form action="${pageContext.request.contextPath}/admin/promotion/${empty promotion ? 'create' : 'edit'}" method="post">
                    <c:if test="${not empty promotion}">
                        <input type="hidden" name="id" value="${promotion.id}">
                    </c:if>

                    <div class="row g-3">
                        <!-- Code và Loại -->
                        <div class="col-md-6">
                            <label class="form-label fw-semibold"><i class="bi bi-hash me-1"></i>Mã khuyến mãi</label>
                            <input type="text" class="form-control fw-bold text-uppercase" name="code"
                                   required placeholder="VD: SUMMER2024" value="${promotion.code}">
                        </div>

                        <div class="col-md-6">
                            <label class="form-label fw-semibold"><i class="bi bi-list-check me-1"></i>Loại giảm giá</label>
                            <select class="form-select" name="discountType" required>
                                <option value="PERCENTAGE" ${promotion.discountType eq 'PERCENTAGE' ? 'selected' : ''}>Phần trăm (%)</option>
                                <option value="FIXED_AMOUNT" ${promotion.discountType eq 'FIXED_AMOUNT' ? 'selected' : ''}>Số tiền cố định (đ)</option>
                            </select>
                        </div>

                        <!-- Giá trị và Tối thiểu -->
                        <div class="col-md-6">
                            <label class="form-label fw-semibold"><i class="bi bi-currency-dollar me-1"></i>Giá trị giảm</label>
                            <input type="number" class="form-control" name="discountValue"
                                   required min="0" placeholder="0" value="${promotion.discountValue}">
                        </div>

                        <div class="col-md-6">
                            <label class="form-label fw-semibold"><i class="bi bi-shield-check me-1"></i>Đơn tối thiểu (đ)</label>
                            <input type="number" class="form-control" name="minOrderValue"
                                   required min="0" placeholder="0" value="${promotion.minOrderValue}">
                        </div>

                        <!-- Ngày bắt đầu và kết thúc -->
                        <div class="col-md-6">
                            <label class="form-label fw-semibold"><i class="bi bi-calendar-event me-1"></i>Ngày bắt đầu</label>
                            <input type="datetime-local" class="form-control" name="startDate"
                                   required value="${not empty promotion.startDate ? fn:substring(promotion.startDate, 0, 16) : ''}">
                        </div>

                        <div class="col-md-6">
                            <label class="form-label fw-semibold"><i class="bi bi-calendar-check me-1"></i>Ngày kết thúc</label>
                            <input type="datetime-local" class="form-control" name="endDate"
                                   required value="${not empty promotion.endDate ? fn:substring(promotion.endDate, 0, 16) : ''}">
                        </div>

                        <div class="col-md-6">
                            <label class="form-label fw-semibold"><i class="bi bi-pin-angle me-1"></i>Giới hạn sử dụng (lần)</label>
                            <input type="number" class="form-control" name="usageLimit"
                                   required min="1" placeholder="999" value="${promotion.usageLimit}">
                        </div>

                        <!-- Actions -->
                        <div class="col-12 mt-4 d-flex gap-2">
                            <button type="submit" class="btn btn-primary px-4 py-2 fw-bold">
                                <i class="bi bi-save me-2"></i>Lưu chương trình
                            </button>
                            <a href="${pageContext.request.contextPath}/admin/promotion" class="btn btn-outline-secondary px-4">
                                <i class="bi bi-x-lg me-2"></i>Hủy
                            </a>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

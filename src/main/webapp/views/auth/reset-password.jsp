<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

        <div class="container d-flex align-items-center justify-content-center"
            style="min-height: calc(100vh - 120px);">
            <div class="card p-4 shadow-lg border-0 rounded-4" style="width: 100%; max-width: 450px;">
                <div class="text-center mb-4">
                    <div class="d-inline-flex align-items-center justify-content-center bg-light text-primary rounded-circle shadow-sm mb-3"
                        style="width: 70px; height: 70px;">
                        <i class="bi bi-shield-lock-fill fs-2"></i>
                    </div>
                    <h3 class="fw-bold text-dark mb-1">Poly<span class="text-primary">coffee</span></h3>
                    <h5 class="text-dark">Đặt mật khẩu mới</h5>
                    <p class="text-muted small">Nhập mật khẩu mới của bạn dưới đây.</p>
                </div>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger d-flex align-items-center mb-4 py-2 border-0 shadow-sm" role="alert">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i>
                        <div class="small fw-medium">${error}</div>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/reset-password" method="post">
                    <input type="hidden" name="token" value="${token}">

                    <div class="form-floating mb-3">
                        <input type="password" name="password" class="form-control shadow-none bg-light border-0"
                            id="password" placeholder="********" required>
                        <label for="password" class="text-muted"><i class="bi bi-lock-fill me-2"></i>Mật khẩu
                            mới</label>
                    </div>

                    <div class="form-floating mb-4">
                        <input type="password" name="confirmPassword" class="form-control shadow-none bg-light border-0"
                            id="confirmPassword" placeholder="**********" required>
                        <label for="confirmPassword" class="text-muted"><i class="bi bi-shield-lock-fill me-2"></i>Xác
                            nhận mật khẩu</label>
                    </div>

                    <button type="submit"
                        class="btn btn-primary w-100 py-3 rounded-3 shadow text-uppercase fw-bold mb-4">
                        Cập Nhật Mật Khẩu
                    </button>

                    <div class="text-center">
                        <a href="${pageContext.request.contextPath}/login"
                            class="text-decoration-none small fw-bold text-primary">
                            <i class="bi bi-arrow-left me-1"></i> Quay lại đăng nhập
                        </a>
                    </div>
                </form>
            </div>
        </div>
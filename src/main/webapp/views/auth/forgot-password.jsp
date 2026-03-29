<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container d-flex align-items-center justify-content-center" style="min-height: calc(100vh - 120px);">
    <div class="card p-4 shadow-lg border-0 rounded-4" style="width: 100%; max-width: 450px;">
        <div class="text-center mb-4">
            <div class="d-inline-flex align-items-center justify-content-center bg-light text-primary rounded-circle shadow-sm mb-3" style="width: 70px; height: 70px;">
                <i class="bi bi-key-fill fs-2"></i>
            </div>
            <h3 class="fw-bold text-dark mb-1">Poly<span class="text-primary">coffee</span></h3>
            <h5 class="text-dark">Quên mật khẩu?</h5>
            <p class="text-muted small">Nhập email của bạn để nhận link đặt lại mật khẩu.</p>
        </div>

        <c:if test="${not empty message}">
            <div class="alert alert-info d-flex align-items-center mb-4 py-2 border-0 shadow-sm" role="alert">
                <i class="bi bi-info-circle-fill me-2"></i>
                <div class="small fw-medium">${message}</div>
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger d-flex align-items-center mb-4 py-2 border-0 shadow-sm" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-2"></i>
                <div class="small fw-medium">${error}</div>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/forgot-password" method="post">
            <div class="form-floating mb-4">
                <input type="email" name="email" class="form-control shadow-none bg-light border-0" id="email" placeholder="example@gmail.com" required>
                <label for="email" class="text-muted"><i class="bi bi-envelope-fill me-2"></i>Địa chỉ Email</label>
            </div>
            
            <button type="submit" class="btn btn-primary w-100 py-3 rounded-3 shadow text-uppercase fw-bold mb-4">
                Gửi Link Yêu Cầu
            </button>
            <div class="text-center">
                <a href="${pageContext.request.contextPath}/login" class="text-decoration-none small fw-bold text-primary">
                    <i class="bi bi-arrow-left me-1"></i> Quay lại đăng nhập
                </a>
            </div>
        </form>
    </div>
</div>
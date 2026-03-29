<%@page pageEncoding="utf-8" isELIgnored="false" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container d-flex align-items-center justify-content-center" style="min-height: calc(100vh - 120px);">
    <div class="card shadow-lg border-0 rounded-4 w-100" style="max-width: 900px; overflow: hidden;">
        <div class="row g-0">
            <!-- Cột hình ảnh (Ẩn trên màn hình nhỏ, hiện trên md trở lên) -->
            <div class="col-md-5 d-none d-md-block">
                <img src="https://images.unsplash.com/photo-1497935586351-b67a49e012bf?q=80&w=800&auto=format&fit=crop" 
                     alt="Polycoffee" class="img-fluid h-100 object-fit-cover w-100">
            </div>
            
            <!-- Cột Form đăng nhập -->
            <div class="col-md-7 p-4 p-md-5 d-flex flex-column justify-content-center bg-white">
                <div class="text-center mb-4">
                    <div class="d-inline-flex align-items-center justify-content-center bg-light text-primary rounded-circle shadow-sm mb-3" style="width: 70px; height: 70px;">
                        <i class="bi bi-cup-hot-fill fs-2"></i>
                    </div>
                    <h3 class="fw-bold text-dark mb-1">Poly<span class="text-primary">coffee</span></h3>
                    <p class="text-muted small">Chào mừng trở lại, vui lòng đăng nhập</p>
                </div>

                <c:if test="${not empty message}">
                    <div class="alert alert-danger d-flex align-items-center mb-4 py-2 border-0 shadow-sm" role="alert">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i>
                        <div class="small fw-medium">${message}</div>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/login" method="post">
                    <div class="form-floating mb-3">
                        <input type="text" class="form-control shadow-none bg-light border-0" id="username" name="username" placeholder="Username" required autofocus>
                        <label for="username" class="text-muted"><i class="bi bi-person-fill me-2"></i>Tên đăng nhập</label>
                    </div>
                    
                    <div class="form-floating mb-3">
                        <input type="password" class="form-control shadow-none bg-light border-0" id="password" name="password" placeholder="Password" required>
                        <label for="password" class="text-muted"><i class="bi bi-lock-fill me-2"></i>Mật khẩu</label>
                    </div>

                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div class="form-check">
                            <input class="form-check-input shadow-none cursor-pointer" type="checkbox" id="remember" checked>
                            <label class="form-check-label small text-muted user-select-none" for="remember" style="cursor: pointer;">
                                Ghi nhớ tôi
                            </label>
                        </div>
                        <a href="${pageContext.request.contextPath}/forgot-password" class="text-decoration-none small fw-medium text-primary">Quên mật khẩu?</a>
                    </div>

                    <button type="submit" class="btn btn-primary w-100 py-3 rounded-3 shadow text-uppercase fw-bold mb-4">
                        Đăng nhập ngay
                    </button>

                        Chưa có tài khoản? <a href="${pageContext.request.contextPath}/register" class="text-decoration-none fw-bold text-primary ms-1">Đăng ký thành viên</a>
                </form>
            </div>
        </div>
    </div>
</div>

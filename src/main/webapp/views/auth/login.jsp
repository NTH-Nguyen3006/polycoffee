<%@page pageEncoding="utf-8" isELIgnored="false" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
.auth-wrapper {
    min-height: calc(100vh - 0px);
    display: flex; align-items: center; justify-content: center;
    background: linear-gradient(135deg, #1a0a00 0%, #3d1f00 40%, #6b3a1f 100%);
    position: relative; overflow: hidden;
    padding: 40px 16px;
}
.auth-wrapper::before {
    content: '';
    position: absolute; inset: 0;
    background: url('https://images.unsplash.com/photo-1497935586351-b67a49e012bf?q=80&w=1920&auto=format&fit=crop') center/cover;
    opacity: 0.12;
}
.auth-wrapper::after {
    content: '';
    position: absolute; inset: 0;
    background: radial-gradient(ellipse at 30% 50%, rgba(232,137,28,0.15), transparent 60%);
}

.auth-card {
    position: relative; z-index: 2;
    width: 100%; max-width: 960px;
    background: #fff;
    border-radius: 28px;
    overflow: hidden;
    box-shadow: 0 40px 80px rgba(0,0,0,0.35);
    display: flex;
}

.auth-banner {
    flex: 1; min-width: 0;
    background: linear-gradient(160deg, #2d1200 0%, #5a2c00 60%, #7a3d12 100%);
    padding: 48px 40px;
    display: flex; flex-direction: column; justify-content: space-between;
    position: relative; overflow: hidden;
}
.auth-banner::before {
    content: '';
    position: absolute; inset: 0;
    background: url('https://images.unsplash.com/photo-1509042239860-f550ce710b93?q=80&w=800&auto=format&fit=crop') center/cover;
    opacity: 0.18;
}
.auth-banner-content { position: relative; z-index: 1; }
.auth-banner-quote {
    position: relative; z-index: 1;
    border-left: 3px solid rgba(246,192,110,0.6);
    padding-left: 16px;
}

.auth-form-wrap {
    width: 400px; flex-shrink: 0;
    padding: 48px 44px;
    display: flex; flex-direction: column; justify-content: center;
}
@media (max-width: 768px) {
    .auth-card { flex-direction: column; }
    .auth-banner { display: none; }
    .auth-form-wrap { width: 100%; padding: 36px 28px; }
}

.auth-logo {
    width: 60px; height: 60px;
    background: linear-gradient(135deg, #e8891c, #d4722a);
    border-radius: 18px;
    display: flex; align-items: center; justify-content: center;
    font-size: 1.6rem;
    box-shadow: 0 8px 20px rgba(232,137,28,0.4);
    margin-bottom: 20px;
}

.form-group-custom { margin-bottom: 18px; }
.form-label-custom {
    font-size: 0.82rem; font-weight: 700;
    color: #3d1f00; display: block; margin-bottom: 7px;
    text-transform: uppercase; letter-spacing: 0.5px;
}
.form-control-custom {
    width: 100%; padding: 13px 16px 13px 44px;
    border: 2px solid #f0ebe4;
    border-radius: 14px; font-size: 0.92rem;
    background: #faf8f5; font-family: inherit;
    outline: none; transition: all 0.3s;
    color: #1a0a00;
}
.form-control-custom:focus {
    border-color: #e8821c;
    background: #fff;
    box-shadow: 0 0 0 4px rgba(232,130,28,0.1);
}
.input-icon-wrap { position: relative; }
.input-icon {
    position: absolute; left: 14px; top: 50%;
    transform: translateY(-50%);
    color: #bbb; font-size: 1rem; pointer-events: none;
    transition: 0.3s;
}
.input-icon-wrap:focus-within .input-icon { color: #e8821c; }

.btn-auth {
    width: 100%; padding: 14px;
    background: linear-gradient(135deg, #e8891c, #d4722a);
    color: #fff; border: none;
    border-radius: 14px; font-weight: 800;
    font-size: 1rem; font-family: inherit;
    cursor: pointer; transition: all 0.3s;
    box-shadow: 0 6px 20px rgba(232,137,28,0.35);
    margin-bottom: 16px;
}
.btn-auth:hover {
    transform: translateY(-2px);
    box-shadow: 0 12px 30px rgba(232,137,28,0.45);
}

.divider-text {
    text-align: center; position: relative;
    color: #ccc; font-size: 0.8rem; margin: 16px 0;
}
.divider-text::before, .divider-text::after {
    content: '';
    position: absolute; top: 50%; width: 40%;
    height: 1px; background: #f0ebe4;
}
.divider-text::before { left: 0; }
.divider-text::after  { right: 0; }

.link-primary-custom {
    color: #e8821c; font-weight: 700; text-decoration: none;
}
.link-primary-custom:hover { color: #c06a10; text-decoration: underline; }
</style>

<div class="auth-wrapper">
    <div class="auth-card">
        <!-- Left banner -->
        <div class="auth-banner">
            <div class="auth-banner-content">
                <div style="display:flex;align-items:center;gap:12px;margin-bottom:32px;">
                    <div style="width:46px;height:46px;background:linear-gradient(135deg,#e8891c,#d4722a);
                                border-radius:14px;display:flex;align-items:center;justify-content:center;">
                        <i class="bi bi-cup-hot-fill text-white" style="font-size:1.2rem;"></i>
                    </div>
                    <span style="font-size:1.5rem;font-weight:800;color:#fff;">Poly<span style="color:#f6c06e;">coffee</span></span>
                </div>
                <h2 style="color:#fff;font-weight:800;font-size:2rem;line-height:1.2;margin-bottom:16px;">
                    Hương Cà Phê<br>
                    <span style="background:linear-gradient(135deg,#f6c06e,#e8821c);-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;">
                        Đích Thực
                    </span>
                </h2>
                <p style="color:rgba(255,255,255,0.65);font-size:0.95rem;line-height:1.7;">
                    Chào mừng trở lại! Đăng nhập để khám phá thực đơn và đặt hàng của bạn.
                </p>
            </div>
            <div class="auth-banner-quote">
                <p style="color:rgba(255,255,255,0.8);font-size:0.9rem;margin:0;font-style:italic;">
                    "Một tách cà phê ngon có thể thay đổi cả một buổi sáng."
                </p>
                <small style="color:rgba(255,255,255,0.45);">— Polycoffee Barista</small>
            </div>
        </div>

        <!-- Right form -->
        <div class="auth-form-wrap">
            <div class="auth-logo">
                <i class="bi bi-cup-hot-fill text-white"></i>
            </div>

            <h3 class="fw-bold mb-1" style="color:#1a0a00;font-size:1.5rem;">Đăng Nhập</h3>
            <p class="mb-4" style="color:#999;font-size:0.88rem;">Nhập thông tin tài khoản của bạn</p>

            <c:if test="${not empty message}">
                <div class="mb-4 p-3 rounded-3 d-flex align-items-center gap-2"
                     style="background:rgba(220,53,69,0.08);border:1px solid rgba(220,53,69,0.2);color:#842029;font-size:0.88rem;">
                    <i class="bi bi-exclamation-triangle-fill flex-shrink-0"></i>
                    <span>${message}</span>
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/login" method="post">
                <div class="form-group-custom">
                    <label class="form-label-custom">Tên đăng nhập</label>
                    <div class="input-icon-wrap">
                        <i class="bi bi-person-fill input-icon"></i>
                        <input type="text" class="form-control-custom" name="username"
                               placeholder="Nhập tên đăng nhập" required autofocus>
                    </div>
                </div>

                <div class="form-group-custom">
                    <label class="form-label-custom">Mật khẩu</label>
                    <div class="input-icon-wrap">
                        <i class="bi bi-lock-fill input-icon"></i>
                        <input type="password" class="form-control-custom" name="password"
                               placeholder="Nhập mật khẩu" required id="pwdInput">
                    </div>
                </div>

                <div class="d-flex justify-content-between align-items-center mb-4">
                    <label style="display:flex;align-items:center;gap:8px;cursor:pointer;font-size:0.85rem;color:#666;">
                        <input type="checkbox" checked style="accent-color:#e8821c;"> Ghi nhớ tôi
                    </label>
                    <a href="${pageContext.request.contextPath}/forgot-password"
                       class="link-primary-custom" style="font-size:0.85rem;">Quên mật khẩu?</a>
                </div>

                <button type="submit" class="btn-auth">
                    <i class="bi bi-box-arrow-in-right me-2"></i>Đăng Nhập Ngay
                </button>
            </form>

            <div class="divider-text">hoặc</div>

            <p class="text-center mb-0" style="font-size:0.88rem;color:#888;">
                Chưa có tài khoản?
                <a href="${pageContext.request.contextPath}/register" class="link-primary-custom ms-1">
                    Đăng ký ngay
                </a>
            </p>
        </div>
    </div>
</div>

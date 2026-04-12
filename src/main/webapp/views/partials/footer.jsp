<%@page pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="cp" value="${pageContext.request.contextPath}" />
<c:set var="isAdmin" value="${fn:contains(view, '/admin/')}" />

<c:if test="${!isAdmin}">
<footer style="background: linear-gradient(135deg, #1a0a00 0%, #2d1200 60%, #3d1f00 100%); color: rgba(255,255,255,0.8);">
    <!-- Main Footer -->
    <div class="container" style="padding: 64px 0 40px;">
        <div class="row g-5">
            <!-- Brand -->
            <div class="col-lg-4">
                <a href="${cp}/home" class="d-flex align-items-center gap-3 text-decoration-none mb-4">
                    <div style="width:52px;height:52px;background:linear-gradient(135deg,#e8891c,#d4722a);
                                border-radius:16px;display:flex;align-items:center;justify-content:center;
                                box-shadow:0 8px 20px rgba(232,137,28,0.4);">
                        <i class="bi bi-cup-hot-fill text-white" style="font-size:1.4rem;"></i>
                    </div>
                    <span style="font-size:1.8rem;font-weight:800;color:#fff;">Poly<span style="color:#f6c06e;">coffee</span></span>
                </a>
                <p style="font-size:0.92rem;line-height:1.8;color:rgba(255,255,255,0.6);max-width:280px;">
                    Nơi hương cà phê đích thực gặp gỡ những tâm hồn yêu café. 
                    Mỗi ly là một hành trình hương vị tuyệt vời.
                </p>
                <div class="d-flex gap-3 mt-4">
                    <a href="#" style="width:40px;height:40px;background:rgba(255,255,255,0.08);border:1px solid rgba(255,255,255,0.15);
                                      border-radius:12px;display:flex;align-items:center;justify-content:center;
                                      color:rgba(255,255,255,0.7);text-decoration:none;font-size:1rem;
                                      transition:all 0.3s;"
                       onmouseover="this.style.background='#1877f2';this.style.color='#fff';this.style.borderColor='#1877f2';"
                       onmouseout="this.style.background='rgba(255,255,255,0.08)';this.style.color='rgba(255,255,255,0.7)';this.style.borderColor='rgba(255,255,255,0.15)';">
                        <i class="bi bi-facebook"></i>
                    </a>
                    <a href="#" style="width:40px;height:40px;background:rgba(255,255,255,0.08);border:1px solid rgba(255,255,255,0.15);
                                      border-radius:12px;display:flex;align-items:center;justify-content:center;
                                      color:rgba(255,255,255,0.7);text-decoration:none;font-size:1rem;
                                      transition:all 0.3s;"
                       onmouseover="this.style.background='#e1306c';this.style.color='#fff';this.style.borderColor='#e1306c';"
                       onmouseout="this.style.background='rgba(255,255,255,0.08)';this.style.color='rgba(255,255,255,0.7)';this.style.borderColor='rgba(255,255,255,0.15)';">
                        <i class="bi bi-instagram"></i>
                    </a>
                    <a href="#" style="width:40px;height:40px;background:rgba(255,255,255,0.08);border:1px solid rgba(255,255,255,0.15);
                                      border-radius:12px;display:flex;align-items:center;justify-content:center;
                                      color:rgba(255,255,255,0.7);text-decoration:none;font-size:1rem;
                                      transition:all 0.3s;"
                       onmouseover="this.style.background='#25d366';this.style.color='#fff';this.style.borderColor='#25d366';"
                       onmouseout="this.style.background='rgba(255,255,255,0.08)';this.style.color='rgba(255,255,255,0.7)';this.style.borderColor='rgba(255,255,255,0.15)';">
                        <i class="bi bi-whatsapp"></i>
                    </a>
                </div>
            </div>

            <!-- Navigation -->
            <div class="col-sm-6 col-lg-2 offset-lg-1">
                <h6 style="color:#fff;font-weight:700;font-size:0.85rem;letter-spacing:1.5px;text-transform:uppercase;margin-bottom:20px;">
                    Điều Hướng
                </h6>
                <ul style="list-style:none;padding:0;margin:0;">
                    <li style="margin-bottom:12px;">
                        <a href="${cp}/home" style="color:rgba(255,255,255,0.6);text-decoration:none;font-size:0.92rem;transition:0.2s;"
                           onmouseover="this.style.color='#f6c06e';this.style.paddingLeft='6px';"
                           onmouseout="this.style.color='rgba(255,255,255,0.6)';this.style.paddingLeft='0';">
                            Trang Chủ
                        </a>
                    </li>
                    <li style="margin-bottom:12px;">
                        <a href="${cp}/menu" style="color:rgba(255,255,255,0.6);text-decoration:none;font-size:0.92rem;transition:0.2s;"
                           onmouseover="this.style.color='#f6c06e';this.style.paddingLeft='6px';"
                           onmouseout="this.style.color='rgba(255,255,255,0.6)';this.style.paddingLeft='0';">
                            Thực Đơn
                        </a>
                    </li>
                    <li style="margin-bottom:12px;">
                        <a href="${cp}/about" style="color:rgba(255,255,255,0.6);text-decoration:none;font-size:0.92rem;transition:0.2s;"
                           onmouseover="this.style.color='#f6c06e';this.style.paddingLeft='6px';"
                           onmouseout="this.style.color='rgba(255,255,255,0.6)';this.style.paddingLeft='0';">
                            Giới Thiệu
                        </a>
                    </li>
                    <li style="margin-bottom:12px;">
                        <a href="${cp}/contact" style="color:rgba(255,255,255,0.6);text-decoration:none;font-size:0.92rem;transition:0.2s;"
                           onmouseover="this.style.color='#f6c06e';this.style.paddingLeft='6px';"
                           onmouseout="this.style.color='rgba(255,255,255,0.6)';this.style.paddingLeft='0';">
                            Liên Hệ
                        </a>
                    </li>
                </ul>
            </div>

            <!-- Info -->
            <div class="col-sm-6 col-lg-2">
                <h6 style="color:#fff;font-weight:700;font-size:0.85rem;letter-spacing:1.5px;text-transform:uppercase;margin-bottom:20px;">
                    Thông Tin
                </h6>
                <ul style="list-style:none;padding:0;margin:0;">
                    <li class="d-flex gap-2 align-items-start mb-3">
                        <i class="bi bi-geo-alt-fill" style="color:#f6c06e;margin-top:2px;flex-shrink:0;"></i>
                        <span style="color:rgba(255,255,255,0.6);font-size:0.88rem;">FPT Polytechnic, thành phố HCM</span>
                    </li>
                    <li class="d-flex gap-2 align-items-center mb-3">
                        <i class="bi bi-telephone-fill" style="color:#f6c06e;flex-shrink:0;"></i>
                        <a href="tel:02812345678" style="color:rgba(255,255,255,0.6);text-decoration:none;font-size:0.88rem;">028 1234 5678</a>
                    </li>
                    <li class="d-flex gap-2 align-items-center mb-3">
                        <i class="bi bi-envelope-fill" style="color:#f6c06e;flex-shrink:0;"></i>
                        <a href="mailto:hello@polycoffee.vn" style="color:rgba(255,255,255,0.6);text-decoration:none;font-size:0.88rem;">hello@polycoffee.vn</a>
                    </li>
                    <li class="d-flex gap-2 align-items-center">
                        <i class="bi bi-clock-fill" style="color:#f6c06e;flex-shrink:0;"></i>
                        <span style="color:rgba(255,255,255,0.6);font-size:0.88rem;">07:00 – 22:00 mỗi ngày</span>
                    </li>
                </ul>
            </div>

            <!-- Newsletter -->
            <div class="col-lg-3">
                <h6 style="color:#fff;font-weight:700;font-size:0.85rem;letter-spacing:1.5px;text-transform:uppercase;margin-bottom:20px;">
                    Đăng Ký Nhận Ưu Đãi
                </h6>
                <p style="color:rgba(255,255,255,0.55);font-size:0.88rem;margin-bottom:16px;">
                    Nhận thông tin khuyến mãi và menu mới nhất từ Polycoffee.
                </p>
                <div class="d-flex gap-2">
                    <input type="email" placeholder="Email của bạn..."
                           style="flex:1;background:rgba(255,255,255,0.08);border:1px solid rgba(255,255,255,0.15);
                                  color:#fff;border-radius:12px;padding:11px 16px;font-size:0.88rem;outline:none;
                                  font-family:inherit;"
                           onfocus="this.style.borderColor='#f6c06e';this.style.background='rgba(255,255,255,0.12)';"
                           onblur="this.style.borderColor='rgba(255,255,255,0.15)';this.style.background='rgba(255,255,255,0.08)';">
                    <button style="background:linear-gradient(135deg,#e8891c,#d4722a);border:none;
                                   border-radius:12px;padding:11px 18px;color:#fff;font-size:0.9rem;
                                   transition:0.3s;cursor:pointer;"
                            onmouseover="this.style.transform='scale(1.05)';"
                            onmouseout="this.style.transform='scale(1)';">
                        <i class="bi bi-send-fill"></i>
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Divider -->
    <div style="border-top:1px solid rgba(255,255,255,0.08);">
        <div class="container" style="padding:20px 0;">
            <div class="d-flex justify-content-between align-items-center flex-wrap gap-3">
                <p style="margin:0;font-size:0.85rem;color:rgba(255,255,255,0.4);">
                    &copy; 2026 <span style="color:#f6c06e;font-weight:600;">Polycoffee</span>. 
                    Thực hiện bởi Nhóm 8 — SD20308 · FPT Polytechnic.
                </p>
                <div class="d-flex gap-1">
                    <span style="display:inline-flex;align-items:center;gap:5px;background:rgba(255,255,255,0.06);
                                 border-radius:8px;padding:5px 12px;font-size:0.78rem;color:rgba(255,255,255,0.4);">
                        <i class="bi bi-shield-check" style="color:#f6c06e;"></i> Secure
                    </span>
                    <span style="display:inline-flex;align-items:center;gap:5px;background:rgba(255,255,255,0.06);
                                 border-radius:8px;padding:5px 12px;font-size:0.78rem;color:rgba(255,255,255,0.4);">
                        <i class="bi bi-heart-fill" style="color:#f6c06e;"></i> Made with love
                    </span>
                </div>
            </div>
        </div>
    </div>
</footer>
</c:if>

<c:if test="${isAdmin}">
<footer class="mt-auto" style="background:#f8f9fa;border-top:1px solid #e9ecef;padding:16px 0;">
    <div class="container">
        <p class="mb-0 text-muted small text-center">
            &copy; 2026 <strong>Polycoffee</strong> Admin Panel &middot; Nhóm 8 — SD20308
        </p>
    </div>
</footer>
</c:if>
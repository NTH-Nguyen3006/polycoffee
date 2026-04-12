<%@page pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
.contact-hero {
    background: linear-gradient(135deg, #1a0a00 0%, #3d1f00 50%, #6b3a1f 100%);
    padding: 90px 0 70px; position: relative; overflow: hidden;
}
.contact-hero::before {
    content: ''; position: absolute; inset: 0;
    background: url('https://images.unsplash.com/photo-1521017432531-fbd92d768814?q=80&w=1920&auto=format&fit=crop') center/cover;
    opacity: 0.1;
}
.contact-hero-content { position: relative; z-index: 2; }

.contact-info-card {
    background: #fff; border-radius: 24px; padding: 32px;
    border: 1px solid #f0ebe4;
    box-shadow: 0 4px 20px rgba(107,58,31,0.06);
    height: 100%;
}
.contact-icon-box {
    width: 56px; height: 56px; border-radius: 16px;
    display: flex; align-items: center; justify-content: center;
    font-size: 1.4rem; flex-shrink: 0;
}

.contact-form-card {
    background: #fff; border-radius: 24px; padding: 48px;
    border: 1px solid #f0ebe4;
    box-shadow: 0 8px 40px rgba(107,58,31,0.08);
}
.form-control-custom {
    border: 2px solid #f0ebe4; border-radius: 14px;
    padding: 14px 18px; font-size: 0.95rem;
    transition: all 0.3s; background: #faf8f5;
    font-family: inherit;
}
.form-control-custom:focus {
    border-color: #e8821c;
    background: #fff;
    box-shadow: 0 0 0 4px rgba(232,130,28,0.1);
    outline: none;
}
.form-label-custom {
    font-weight: 600; font-size: 0.88rem;
    color: #3d1f00; margin-bottom: 8px;
}

.btn-submit {
    background: linear-gradient(135deg, #e8891c, #d4722a);
    color: #fff; border: none;
    padding: 15px 40px; border-radius: 50px;
    font-weight: 700; font-size: 1rem;
    transition: all 0.3s;
    box-shadow: 0 8px 25px rgba(232,137,28,0.35);
    width: 100%;
}
.btn-submit:hover {
    transform: translateY(-2px);
    box-shadow: 0 15px 35px rgba(232,137,28,0.45);
}

.map-container {
    border-radius: 24px; overflow: hidden;
    border: 1px solid #f0ebe4;
    box-shadow: 0 8px 30px rgba(107,58,31,0.08);
}

.hours-row {
    display: flex; justify-content: space-between;
    padding: 12px 0;
    border-bottom: 1px solid #f0ebe4;
    font-size: 0.9rem;
}
.hours-row:last-child { border-bottom: none; }
.hours-day { color: #3d1f00; font-weight: 600; }
.hours-time { color: #e8821c; font-weight: 700; }
.hours-closed { color: #dc3545; font-weight: 600; }

.section-badge {
    display: inline-block;
    background: linear-gradient(135deg, rgba(232,137,28,0.1), rgba(212,135,55,0.2));
    color: #c06a10; border: 1px solid rgba(232,137,28,0.3);
    padding: 5px 16px; border-radius: 50px;
    font-size: 12px; font-weight: 700; letter-spacing: 1.5px;
    text-transform: uppercase; margin-bottom: 12px;
}
.section-title {
    font-size: clamp(1.8rem, 3.5vw, 2.5rem); font-weight: 800;
    color: #1a0a00; line-height: 1.2;
}
.accent { color: #e8821c; }
</style>

<!-- HERO -->
<section class="contact-hero">
    <div class="container contact-hero-content text-center text-white">
        <div style="display:inline-block;background:rgba(246,192,110,0.15);border:1px solid rgba(246,192,110,0.4);
                    color:#f6c06e;padding:6px 18px;border-radius:50px;font-size:12px;font-weight:700;
                    letter-spacing:1.5px;text-transform:uppercase;" class="mb-4">
            Liên Hệ
        </div>
        <h1 class="fw-bold mb-3" style="font-size:clamp(2.5rem,5vw,3.8rem);line-height:1.1;">
            Chúng Tôi Luôn<br>
            <span style="background:linear-gradient(135deg,#f6c06e,#e8821c);-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;">
                Sẵn Sàng Lắng Nghe
            </span>
        </h1>
        <p style="color:rgba(255,255,255,0.75);font-size:1.1rem;max-width:550px;margin:0 auto;">
            Có câu hỏi, góp ý hoặc muốn đặt chỗ? Hãy liên hệ với chúng tôi!
        </p>
    </div>
</section>

<!-- CONTACT GRID -->
<section style="padding:80px 0; background:#faf8f5;">
    <div class="container">
        <div class="row g-4 mb-5">
            <div class="col-md-4">
                <div class="contact-info-card text-center">
                    <div class="contact-icon-box mx-auto mb-3"
                         style="background:linear-gradient(135deg,rgba(232,137,28,0.15),rgba(212,113,42,0.1));width:64px;height:64px;border-radius:20px;">
                        <i class="bi bi-geo-alt-fill" style="font-size:1.6rem;color:#e8821c;"></i>
                    </div>
                    <h5 class="fw-bold mb-2" style="color:#1a0a00;">Địa Chỉ</h5>
                    <p class="text-muted mb-0" style="font-size:0.95rem;">
                        Trường FPT Polytechnic<br>
                        Số 1, Hòa Lạc, Hà Nội
                    </p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="contact-info-card text-center">
                    <div class="contact-icon-box mx-auto mb-3"
                         style="background:linear-gradient(135deg,rgba(13,110,253,0.12),rgba(13,110,253,0.08));width:64px;height:64px;border-radius:20px;">
                        <i class="bi bi-telephone-fill" style="font-size:1.5rem;color:#0d6efd;"></i>
                    </div>
                    <h5 class="fw-bold mb-2" style="color:#1a0a00;">Điện Thoại</h5>
                    <p class="text-muted mb-1" style="font-size:0.95rem;">
                        <a href="tel:02812345678" class="text-decoration-none text-muted fw-semibold">
                            028 1234 5678
                        </a>
                    </p>
                    <p class="text-muted mb-0" style="font-size:0.85rem;">Hỗ trợ: 7:00 – 22:00 hàng ngày</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="contact-info-card text-center">
                    <div class="contact-icon-box mx-auto mb-3"
                         style="background:linear-gradient(135deg,rgba(25,135,84,0.12),rgba(25,135,84,0.08));width:64px;height:64px;border-radius:20px;">
                        <i class="bi bi-envelope-fill" style="font-size:1.5rem;color:#198754;"></i>
                    </div>
                    <h5 class="fw-bold mb-2" style="color:#1a0a00;">Email</h5>
                    <p class="text-muted mb-1" style="font-size:0.95rem;">
                        <a href="mailto:hello@polycoffee.vn" class="text-decoration-none text-muted fw-semibold">
                            hello@polycoffee.vn
                        </a>
                    </p>
                    <p class="text-muted mb-0" style="font-size:0.85rem;">Phản hồi trong 24 giờ</p>
                </div>
            </div>
        </div>

        <!-- FORM + MAP -->
        <div class="row g-4">
            <!-- Form liên hệ -->
            <div class="col-lg-7">
                <div class="contact-form-card">
                    <div class="mb-4">
                        <div class="section-badge">Gửi Tin Nhắn</div>
                        <h3 class="fw-bold" style="color:#1a0a00;">Hãy Nhắn Cho Chúng Tôi</h3>
                        <p class="text-muted mb-0">Chúng tôi sẽ phản hồi sớm nhất có thể.</p>
                    </div>

                    <c:if test="${not empty sessionScope.contactSuccess}">
                        <div class="alert alert-success border-0 rounded-3 mb-4"
                             style="background:rgba(25,135,84,0.08);color:#0f5132;">
                            <i class="bi bi-check-circle-fill me-2"></i>
                            <strong>Gửi thành công!</strong> Chúng tôi sẽ liên hệ với bạn sớm nhất có thể.
                        </div>
                        <c:remove var="contactSuccess" scope="session"/>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/contact" method="post" id="contactForm">
                        <div class="row g-3 mb-3">
                            <div class="col-sm-6">
                                <label class="form-label-custom">Họ và tên <span class="text-danger">*</span></label>
                                <input type="text" class="form-control form-control-custom w-100"
                                       name="name" placeholder="Nguyễn Văn A" required>
                            </div>
                            <div class="col-sm-6">
                                <label class="form-label-custom">Số điện thoại</label>
                                <input type="tel" class="form-control form-control-custom w-100"
                                       name="phone" placeholder="0912 345 678">
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label-custom">Email <span class="text-danger">*</span></label>
                            <input type="email" class="form-control form-control-custom w-100"
                                   name="email" placeholder="email@example.com" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label-custom">Chủ đề</label>
                            <select class="form-control form-control-custom w-100" name="subject"
                                    style="appearance:auto;">
                                <option value="">-- Chọn chủ đề --</option>
                                <option value="order">Hỏi về đơn hàng</option>
                                <option value="menu">Hỏi về thực đơn</option>
                                <option value="feedback">Góp ý dịch vụ</option>
                                <option value="partner">Hợp tác kinh doanh</option>
                                <option value="other">Khác</option>
                            </select>
                        </div>
                        <div class="mb-4">
                            <label class="form-label-custom">Nội dung <span class="text-danger">*</span></label>
                            <textarea class="form-control form-control-custom w-100" name="message"
                                      rows="5" placeholder="Nhập nội dung tin nhắn của bạn..." required
                                      style="resize:vertical;"></textarea>
                        </div>
                        <button type="submit" class="btn-submit">
                            <i class="bi bi-send-fill me-2"></i>Gửi Tin Nhắn
                        </button>
                    </form>
                </div>
            </div>

            <!-- Sidebar: Hours + Map -->
            <div class="col-lg-5">
                <!-- Giờ hoạt động -->
                <div class="contact-info-card mb-4">
                    <div class="d-flex align-items-center gap-3 mb-4">
                        <div style="width:44px;height:44px;background:linear-gradient(135deg,#e8891c,#d4722a);
                                    border-radius:14px;display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                            <i class="bi bi-clock-fill text-white fs-5"></i>
                        </div>
                        <h5 class="fw-bold mb-0" style="color:#1a0a00;">Giờ Mở Cửa</h5>
                    </div>
                    <div class="hours-row"><span class="hours-day">Thứ Hai – Thứ Sáu</span><span class="hours-time">07:00 – 22:00</span></div>
                    <div class="hours-row"><span class="hours-day">Thứ Bảy</span><span class="hours-time">07:30 – 23:00</span></div>
                    <div class="hours-row"><span class="hours-day">Chủ Nhật</span><span class="hours-time">08:00 – 21:00</span></div>
                    <div class="hours-row"><span class="hours-day">Ngày Lễ</span><span class="hours-closed">Tùy theo lịch</span></div>
                    <div class="mt-3 p-3 rounded-3" style="background:rgba(232,137,28,0.08);border:1px dashed rgba(232,137,28,0.4);">
                        <small class="text-muted"><i class="bi bi-info-circle text-warning me-1"></i>
                        Chúng tôi phục vụ liên tục — không nghỉ trưa!</small>
                    </div>
                </div>

                <!-- Map placeholder -->
                <div class="map-container" style="height:240px;background:linear-gradient(135deg,#1a0a00,#3d1f00);
                                                  display:flex;align-items:center;justify-content:center;flex-direction:column;
                                                  color:rgba(255,255,255,0.6);">
                    <i class="bi bi-geo-alt-fill" style="font-size:3rem;color:#e8821c;margin-bottom:12px;"></i>
                    <div class="fw-semibold text-white">FPT Polytechnic</div>
                    <small style="opacity:0.7;">Số 1, Hòa Lạc, Hà Nội</small>
                    <a href="https://maps.google.com/?q=FPT+Polytechnic+Hoa+Lac" target="_blank"
                       class="mt-3 btn btn-sm btn-warning rounded-pill px-4 fw-semibold">
                        <i class="bi bi-map me-1"></i>Xem bản đồ
                    </a>
                </div>

                <!-- Social -->
                <div class="contact-info-card mt-4">
                    <h6 class="fw-bold mb-3" style="color:#1a0a00;">Kết Nối Với Chúng Tôi</h6>
                    <div class="d-flex gap-3">
                        <a href="#" class="d-flex align-items-center justify-content-center rounded-circle"
                           style="width:44px;height:44px;background:#1877f2;color:#fff;font-size:1.1rem;text-decoration:none;transition:0.2s;"
                           onmouseover="this.style.transform='scale(1.1)'" onmouseout="this.style.transform='scale(1)'">
                            <i class="bi bi-facebook"></i>
                        </a>
                        <a href="#" class="d-flex align-items-center justify-content-center rounded-circle"
                           style="width:44px;height:44px;background:linear-gradient(135deg,#f09433,#e6683c,#dc2743,#cc2366,#bc1888);color:#fff;font-size:1.1rem;text-decoration:none;transition:0.2s;"
                           onmouseover="this.style.transform='scale(1.1)'" onmouseout="this.style.transform='scale(1)'">
                            <i class="bi bi-instagram"></i>
                        </a>
                        <a href="#" class="d-flex align-items-center justify-content-center rounded-circle"
                           style="width:44px;height:44px;background:#25d366;color:#fff;font-size:1.1rem;text-decoration:none;transition:0.2s;"
                           onmouseover="this.style.transform='scale(1.1)'" onmouseout="this.style.transform='scale(1)'">
                            <i class="bi bi-whatsapp"></i>
                        </a>
                        <a href="mailto:hello@polycoffee.vn" class="d-flex align-items-center justify-content-center rounded-circle"
                           style="width:44px;height:44px;background:#0d6efd;color:#fff;font-size:1.1rem;text-decoration:none;transition:0.2s;"
                           onmouseover="this.style.transform='scale(1.1)'" onmouseout="this.style.transform='scale(1)'">
                            <i class="bi bi-envelope-fill"></i>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<script>
document.getElementById('contactForm').addEventListener('submit', function(e) {
    e.preventDefault();
    const btn = this.querySelector('.btn-submit');
    const originalText = btn.innerHTML;
    btn.innerHTML = '<i class="bi bi-hourglass-split me-2"></i>Đang gửi...';
    btn.disabled = true;
    
    // Simulate send (since no backend for contact)
    setTimeout(() => {
        btn.innerHTML = '<i class="bi bi-check-circle-fill me-2"></i>Đã gửi thành công!';
        btn.style.background = 'linear-gradient(135deg, #198754, #0f5132)';
        this.reset();
        setTimeout(() => {
            btn.innerHTML = originalText;
            btn.style.background = '';
            btn.disabled = false;
        }, 3000);
    }, 1500);
});
</script>
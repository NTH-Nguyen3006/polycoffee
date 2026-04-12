<%@page pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
.about-hero {
    background: linear-gradient(135deg, #1a0a00 0%, #3d1f00 50%, #6b3a1f 100%);
    padding: 100px 0 80px;
    position: relative; overflow: hidden;
}
.about-hero::before {
    content: ''; position: absolute; inset: 0;
    background: url('https://images.unsplash.com/photo-1442512595331-e89e73853f31?q=80&w=1920&auto=format&fit=crop') center/cover;
    opacity: 0.12;
}
.about-hero-content { position: relative; z-index: 2; }
.about-badge {
    display: inline-block;
    background: rgba(246,192,110,0.15); border: 1px solid rgba(246,192,110,0.4);
    color: #f6c06e; padding: 6px 18px; border-radius: 50px;
    font-size: 12px; font-weight: 700; letter-spacing: 1.5px; text-transform: uppercase;
}

.timeline { position: relative; padding: 0; }
.timeline::before {
    content: ''; position: absolute; left: 50%; top: 0; bottom: 0; width: 2px;
    background: linear-gradient(180deg, #e8821c, #f6c06e, transparent);
    transform: translateX(-50%);
}
.timeline-item { display: flex; gap: 40px; margin-bottom: 60px; }
.timeline-item:nth-child(odd) { flex-direction: row; }
.timeline-item:nth-child(even) { flex-direction: row-reverse; }
.timeline-content {
    flex: 1;
    background: #fff;
    border-radius: 20px;
    padding: 32px;
    border: 1px solid #f0ebe4;
    box-shadow: 0 4px 20px rgba(107,58,31,0.06);
    transition: all 0.3s;
    position: relative;
}
.timeline-content:hover {
    box-shadow: 0 15px 40px rgba(107,58,31,0.12);
    transform: translateY(-4px);
}
.timeline-dot {
    position: absolute; left: 50%; top: 30px;
    width: 44px; height: 44px;
    background: linear-gradient(135deg, #e8891c, #d4722a);
    border-radius: 50%; border: 4px solid #fff;
    transform: translateX(-50%);
    display: flex; align-items: center; justify-content: center;
    box-shadow: 0 6px 20px rgba(232,137,28,0.4);
    z-index: 1;
    font-size: 16px; color: #fff;
}
.timeline-year {
    display: inline-block;
    background: linear-gradient(135deg, #e8891c, #d4722a);
    color: #fff; font-weight: 800; font-size: 13px;
    padding: 4px 12px; border-radius: 50px; margin-bottom: 10px;
}
.timeline-spacer { flex: 1; }

.stat-grid .stat-item {
    text-align: center; padding: 40px 20px;
    background: #fff; border-radius: 24px;
    border: 1px solid #f0ebe4;
    transition: all 0.3s;
}
.stat-grid .stat-item:hover {
    transform: translateY(-6px);
    box-shadow: 0 20px 40px rgba(107,58,31,0.1);
    border-color: rgba(232,137,28,0.3);
}
.stat-number {
    font-size: 3rem; font-weight: 900;
    background: linear-gradient(135deg, #e8821c, #d4562a);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
    line-height: 1;
}

.team-card {
    border-radius: 24px; overflow: hidden;
    border: 1px solid #f0ebe4;
    background: #fff;
    transition: all 0.3s;
    text-align: center;
}
.team-card:hover {
    transform: translateY(-8px);
    box-shadow: 0 25px 50px rgba(107,58,31,0.12);
}
.team-img-wrap {
    height: 220px; overflow: hidden; position: relative;
    background: linear-gradient(135deg, #fdf0e0, #fde8c9);
}
.team-img-wrap img { width: 100%; height: 100%; object-fit: cover; }
.team-role {
    display: inline-block;
    background: linear-gradient(135deg, rgba(232,137,28,0.12), rgba(212,113,42,0.1));
    color: #c06a10; font-size: 11px; font-weight: 700;
    padding: 4px 12px; border-radius: 20px;
    border: 1px solid rgba(232,137,28,0.25);
}

.value-card {
    padding: 40px 32px; border-radius: 24px;
    border: 1px solid #f0ebe4;
    background: linear-gradient(135deg, #fff 0%, #fdf8f3 100%);
    transition: all 0.3s; height: 100%;
}
.value-card:hover {
    border-color: rgba(232,137,28,0.3);
    box-shadow: 0 20px 40px rgba(107,58,31,0.1);
    transform: translateY(-6px);
}

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
.section-title .accent { color: #e8821c; }

.fade-up { opacity: 0; transform: translateY(30px); transition: all 0.7s ease; }
.fade-up.visible { opacity: 1; transform: translateY(0); }

@media (max-width: 768px) {
    .timeline::before { left: 20px; }
    .timeline-item, .timeline-item:nth-child(even) { flex-direction: column; }
    .timeline-dot { left: 20px; top: 10px; }
    .timeline-spacer { display: none; }
}
</style>

<!-- ===== HERO ===== -->
<section class="about-hero">
    <div class="container about-hero-content text-center text-white">
        <div class="about-badge mb-4">Về Chúng Tôi</div>
        <h1 class="fw-bold mb-4" style="font-size:clamp(2.5rem,5vw,4rem);line-height:1.1;">
            Câu Chuyện Của<br>
            <span style="background:linear-gradient(135deg,#f6c06e,#e8821c);-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;">
                Polycoffee
            </span>
        </h1>
        <p style="color:rgba(255,255,255,0.75);font-size:1.15rem;max-width:600px;margin:0 auto;line-height:1.8;">
            Hành trình từ một quán nhỏ với tình yêu cà phê, chúng tôi đã trở thành điểm đến 
            yêu thích của hàng nghìn tín đồ café tại FPT Polytechnic.
        </p>
    </div>
</section>

<!-- ===== STATS ===== -->
<section style="padding:80px 0; background:#faf8f5;" class="fade-up">
    <div class="container">
        <div class="row g-4 stat-grid">
            <div class="col-6 col-md-3">
                <div class="stat-item">
                    <div class="stat-number">5+</div>
                    <div class="fw-bold mt-2" style="color:#3d1f00;">Năm Hoạt Động</div>
                    <div class="text-muted small mt-1">Kinh nghiệm và tâm huyết</div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="stat-item">
                    <div class="stat-number">50+</div>
                    <div class="fw-bold mt-2" style="color:#3d1f00;">Loại Đồ Uống</div>
                    <div class="text-muted small mt-1">Phong phú, đa dạng</div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="stat-item">
                    <div class="stat-number">5K+</div>
                    <div class="fw-bold mt-2" style="color:#3d1f00;">Khách Hàng</div>
                    <div class="text-muted small mt-1">Tin tưởng & yêu mến</div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="stat-item">
                    <div class="stat-number">4.9</div>
                    <div class="fw-bold mt-2" style="color:#3d1f00;">Đánh Giá ★</div>
                    <div class="text-muted small mt-1">Trên tất cả nền tảng</div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ===== OUR STORY / TIMELINE ===== -->
<section style="padding:96px 0; background:#fff;">
    <div class="container">
        <div class="text-center mb-5 fade-up">
            <div class="section-badge">Hành Trình</div>
            <h2 class="section-title">Chúng Tôi Đã Đi Đến <span class="accent">Đây Như Thế Nào</span></h2>
        </div>
        <div class="timeline fade-up">
            <div class="timeline-item">
                <div class="timeline-content">
                    <span class="timeline-year">2018</span>
                    <h5 class="fw-bold" style="color:#1a0a00;">Khởi Đầu Từ Căn Bếp Nhỏ</h5>
                    <p class="text-muted mb-0">Polycoffee bắt đầu từ một căn bếp nhỏ với niềm đam mê cà phê. 
                    Chúng tôi bắt đầu phục vụ sinh viên và giảng viên tại khuôn viên FPT Polytechnic.</p>
                </div>
                <div class="timeline-dot">☕</div>
                <div class="timeline-spacer"></div>
            </div>
            <div class="timeline-item">
                <div class="timeline-spacer"></div>
                <div class="timeline-dot">🏪</div>
                <div class="timeline-content">
                    <span class="timeline-year">2020</span>
                    <h5 class="fw-bold" style="color:#1a0a00;">Mở Rộng & Phát Triển</h5>
                    <p class="text-muted mb-0">Sau 2 năm, chúng tôi chính thức mở quán với không gian 
                    hiện đại, ấm cúng. Thực đơn được mở rộng với hơn 30 loại đồ uống đặc sắc.</p>
                </div>
            </div>
            <div class="timeline-item">
                <div class="timeline-content">
                    <span class="timeline-year">2022</span>
                    <h5 class="fw-bold" style="color:#1a0a00;">Công Nghệ Gặp Café</h5>
                    <p class="text-muted mb-0">Polycoffee ra mắt hệ thống đặt hàng online, giúp 
                    khách hàng dễ dàng đặt món và theo dõi đơn hàng trong thời gian thực.</p>
                </div>
                <div class="timeline-dot">💻</div>
                <div class="timeline-spacer"></div>
            </div>
            <div class="timeline-item">
                <div class="timeline-spacer"></div>
                <div class="timeline-dot">⭐</div>
                <div class="timeline-content">
                    <span class="timeline-year">2024</span>
                    <h5 class="fw-bold" style="color:#1a0a00;">Điểm Đến Yêu Thích</h5>
                    <p class="text-muted mb-0">Với hơn 5.000 khách hàng thân thiết và đánh giá 4.9/5, 
                    Polycoffee trở thành điểm đến không thể thiếu tại FPT Polytechnic.</p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ===== VALUES ===== -->
<section style="padding:96px 0; background:#faf8f5;">
    <div class="container">
        <div class="text-center mb-5 fade-up">
            <div class="section-badge">Giá Trị Cốt Lõi</div>
            <h2 class="section-title">Điều Khiến Chúng Tôi <span class="accent">Khác Biệt</span></h2>
        </div>
        <div class="row g-4 fade-up">
            <div class="col-md-6 col-lg-3">
                <div class="value-card text-center">
                    <div class="fs-1 mb-3">🫘</div>
                    <h5 class="fw-bold mb-2" style="color:#1a0a00;">Chất Lượng</h5>
                    <p class="text-muted small mb-0">Chỉ sử dụng nguyên liệu tươi ngon, hạt cà phê thượng hạng từ Đà Lạt và Buôn Ma Thuột.</p>
                </div>
            </div>
            <div class="col-md-6 col-lg-3">
                <div class="value-card text-center">
                    <div class="fs-1 mb-3">💚</div>
                    <h5 class="fw-bold mb-2" style="color:#1a0a00;">Bền Vững</h5>
                    <p class="text-muted small mb-0">Cam kết sử dụng bao bì thân thiện môi trường, ủng hộ nông dân địa phương.</p>
                </div>
            </div>
            <div class="col-md-6 col-lg-3">
                <div class="value-card text-center">
                    <div class="fs-1 mb-3">🤝</div>
                    <h5 class="fw-bold mb-2" style="color:#1a0a00;">Cộng Đồng</h5>
                    <p class="text-muted small mb-0">Polycoffee là nơi kết nối — không chỉ là quán cà phê, mà là không gian sáng tạo.</p>
                </div>
            </div>
            <div class="col-md-6 col-lg-3">
                <div class="value-card text-center">
                    <div class="fs-1 mb-3">✨</div>
                    <h5 class="fw-bold mb-2" style="color:#1a0a00;">Sáng Tạo</h5>
                    <p class="text-muted small mb-0">Liên tục cải tiến và sáng tạo menu, mang đến những trải nghiệm hương vị mới mẻ.</p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ===== TEAM ===== -->
<section style="padding:96px 0; background:#fff;">
    <div class="container">
        <div class="text-center mb-5 fade-up">
            <div class="section-badge">Đội Ngũ</div>
            <h2 class="section-title">Những Người <span class="accent">Đứng Sau Hương Vị</span></h2>
            <p class="text-muted mt-3" style="max-width:500px;margin:0 auto;">
                Đội ngũ barista tài năng, nhiệt huyết — những người tạo nên từng ly café hoàn hảo.
            </p>
        </div>
        <div class="row g-4 fade-up">
            <div class="col-md-4 col-lg-3">
                <div class="team-card">
                    <div class="team-img-wrap">
                        <img src="https://i.pravatar.cc/300?img=11" alt="Trưởng Barista">
                    </div>
                    <div class="p-4">
                        <h6 class="fw-bold mb-1" style="color:#1a0a00;">Nguyễn Hoài Nam</h6>
                        <span class="team-role">Head Barista</span>
                        <p class="text-muted small mt-3 mb-0">5 năm kinh nghiệm, chuyên gia pha chế cà phê specialty.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4 col-lg-3">
                <div class="team-card">
                    <div class="team-img-wrap">
                        <img src="https://i.pravatar.cc/300?img=5" alt="Barista">
                    </div>
                    <div class="p-4">
                        <h6 class="fw-bold mb-1" style="color:#1a0a00;">Lê Thị Mai</h6>
                        <span class="team-role">Senior Barista</span>
                        <p class="text-muted small mt-3 mb-0">Chuyên gia về latte art, 3 năm kinh nghiệm pha chế.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4 col-lg-3">
                <div class="team-card">
                    <div class="team-img-wrap">
                        <img src="https://i.pravatar.cc/300?img=7" alt="Manager">
                    </div>
                    <div class="p-4">
                        <h6 class="fw-bold mb-1" style="color:#1a0a00;">Trần Văn Bình</h6>
                        <span class="team-role">Quản Lý</span>
                        <p class="text-muted small mt-3 mb-0">Đảm bảo mỗi khách hàng có trải nghiệm tuyệt vời nhất.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4 col-lg-3">
                <div class="team-card">
                    <div class="team-img-wrap">
                        <img src="https://i.pravatar.cc/300?img=9" alt="Barista">
                    </div>
                    <div class="p-4">
                        <h6 class="fw-bold mb-1" style="color:#1a0a00;">Phạm Thùy Linh</h6>
                        <span class="team-role">Barista</span>
                        <p class="text-muted small mt-3 mb-0">Nhiệt huyết, sáng tạo — chuyên về các món trà sữa đặc biệt.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ===== CTA ===== -->
<section style="background:linear-gradient(135deg,#e8891c,#d4562a);padding:80px 0;">
    <div class="container text-center text-white">
        <h2 class="fw-bold mb-3" style="font-size:2.2rem;">Hãy Đến Và Trải Nghiệm Ngay!</h2>
        <p class="mb-4" style="opacity:0.85;font-size:1.05rem;">Chúng tôi luôn chào đón bạn với nụ cười và tách cafe nóng hổi.</p>
        <a href="${pageContext.request.contextPath}/menu"
           class="btn btn-light btn-lg rounded-pill px-5 fw-bold me-3" style="color:#e8821c;">
            <i class="bi bi-cup-hot me-2"></i>Xem Thực Đơn
        </a>
        <a href="${pageContext.request.contextPath}/contact"
           class="btn btn-outline-light btn-lg rounded-pill px-5 fw-bold">
            <i class="bi bi-telephone me-2"></i>Liên Hệ
        </a>
    </div>
</section>

<script>
const observer2 = new IntersectionObserver((entries) => {
    entries.forEach(e => { if (e.isIntersecting) e.target.classList.add('visible'); });
}, { threshold: 0.1 });
document.querySelectorAll('.fade-up').forEach(el => observer2.observe(el));
</script>
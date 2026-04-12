<%@page pageEncoding="utf-8" isELIgnored="false" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <style>
                .hero-section {
                    min-height: 92vh;
                    background: linear-gradient(135deg, #1a0a00 0%, #3d1f00 40%, #6b3a1f 100%);
                    position: relative;
                    overflow: hidden;
                    display: flex;
                    align-items: center;
                }

                @media (max-width: 991.98px) {
                    .hero-section {
                        min-height: auto;
                        padding-top: 100px;
                        padding-bottom: 60px;
                    }
                }

                .hero-section::before {
                    content: '';
                    position: absolute;
                    inset: 0;
                    background: url('https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?q=80&w=1920&auto=format&fit=crop') center/cover no-repeat;
                    opacity: 0.18;
                }

                .hero-section::after {
                    content: '';
                    position: absolute;
                    inset: 0;
                    background: radial-gradient(ellipse at 60% 50%, rgba(212, 135, 55, 0.15) 0%, transparent 70%);
                }

                .hero-content {
                    position: relative;
                    z-index: 2;
                }

                .hero-badge {
                    display: inline-flex;
                    align-items: center;
                    gap: 8px;
                    background: rgba(212, 135, 55, 0.2);
                    border: 1px solid rgba(212, 135, 55, 0.5);
                    color: #f6c06e;
                    border-radius: 50px;
                    padding: 6px 18px;
                    font-size: 13px;
                    font-weight: 600;
                    letter-spacing: 1px;
                    backdrop-filter: blur(10px);
                    animation: fadeInDown 0.8s ease both;
                    max-width: 100%;
                    text-align: center;
                }

                @media (max-width: 575.98px) {
                    .hero-badge {
                        font-size: 11px;
                        padding: 5px 14px;
                        line-height: 1.4;
                    }
                }

                .hero-title {
                    font-size: clamp(2.4rem, 8vw, 5rem);
                    font-weight: 800;
                    line-height: 1.1;
                    color: #fff;
                    animation: fadeInUp 0.9s ease 0.2s both;
                    word-wrap: break-word;
                }

                .hero-title .highlight {
                    background: linear-gradient(135deg, #f6c06e, #e8821c);
                    -webkit-background-clip: text;
                    -webkit-text-fill-color: transparent;
                    background-clip: text;
                }

                .hero-desc {
                    color: rgba(255, 255, 255, 0.75);
                    font-size: 1.15rem;
                    line-height: 1.8;
                    animation: fadeInUp 1s ease 0.35s both;
                }

                .hero-cta {
                    animation: fadeInUp 1.1s ease 0.5s both;
                }

                .btn-gold {
                    background: linear-gradient(135deg, #e8891c, #d4722a);
                    color: #fff;
                    border: none;
                    padding: 14px 36px;
                    border-radius: 50px;
                    font-weight: 700;
                    font-size: 1rem;
                    box-shadow: 0 8px 25px rgba(232, 137, 28, 0.4);
                    transition: all 0.3s ease;
                    text-decoration: none;
                    display: inline-flex;
                    align-items: center;
                    gap: 10px;
                }

                .btn-gold:hover {
                    transform: translateY(-3px);
                    box-shadow: 0 15px 35px rgba(232, 137, 28, 0.5);
                    color: #fff;
                }

                .btn-outline-white {
                    background: transparent;
                    color: #fff;
                    border: 2px solid rgba(255, 255, 255, 0.5);
                    padding: 12px 32px;
                    border-radius: 50px;
                    font-weight: 600;
                    font-size: 1rem;
                    transition: all 0.3s ease;
                    text-decoration: none;
                    display: inline-flex;
                    align-items: center;
                    gap: 8px;
                    backdrop-filter: blur(10px);
                }

                .btn-outline-white:hover {
                    background: rgba(255, 255, 255, 0.15);
                    border-color: #fff;
                    color: #fff;
                    transform: translateY(-2px);
                }

                .hero-stats {
                    animation: fadeInUp 1.2s ease 0.65s both;
                }

                .hero-stat-item {
                    text-align: center;
                    padding: 16px 24px;
                    background: rgba(255, 255, 255, 0.07);
                    border-radius: 16px;
                    border: 1px solid rgba(255, 255, 255, 0.1);
                    backdrop-filter: blur(10px);
                }

                .hero-stat-num {
                    font-size: 2rem;
                    font-weight: 800;
                    background: linear-gradient(135deg, #f6c06e, #e8821c);
                    -webkit-background-clip: text;
                    -webkit-text-fill-color: transparent;
                    background-clip: text;
                }

                .hero-stat-label {
                    color: rgba(255, 255, 255, 0.6);
                    font-size: 0.8rem;
                }

                .hero-image-wrap {
                    position: relative;
                    z-index: 2;
                    animation: floatUp 1s ease 0.3s both;
                }

                .hero-image-wrap img {
                    border-radius: 30px;
                    box-shadow: 0 40px 80px rgba(0, 0, 0, 0.5);
                    width: 100%;
                    max-height: 560px;
                    object-fit: cover;
                }

                /* Hero Float Cards */
                .hero-float-card {
                    position: absolute;
                    background: rgba(255, 255, 255, 0.95);
                    backdrop-filter: blur(20px);
                    border-radius: 18px;
                    padding: 16px 20px;
                    box-shadow: 0 15px 40px rgba(0, 0, 0, 0.2);
                    animation: float 3s ease-in-out infinite;
                    z-index: 3;
                }

                .hero-float-card-1 {
                    bottom: 40px;
                    left: -30px;
                }

                .hero-float-card-2 {
                    top: 30px;
                    right: -20px;
                }

                @media (max-width: 991.98px) {
                    .hero-float-card-1 {
                        left: 10px;
                        bottom: 20px;
                        padding: 10px 14px;
                    }
                    .hero-float-card-2 {
                        right: 10px;
                        top: 20px;
                        padding: 10px 14px;
                    }
                    .hero-float-card i { font-size: 1.2rem !important; }
                    .hero-float-card .fw-bold { font-size: 13px !important; }
                    .hero-float-card div[style*="font-size:12px"] { font-size: 11px !important; }
                }

                .scroll-hint {
                    position: absolute;
                    bottom: 30px;
                    left: 50%;
                    transform: translateX(-50%);
                    z-index: 2;
                    text-align: center;
                    color: rgba(255, 255, 255, 0.5);
                    font-size: 12px;
                    letter-spacing: 2px;
                    animation: bounce 2s infinite;
                }

                /* ========== SECTION STYLES ========== */
                .section-badge {
                    display: inline-block;
                    background: linear-gradient(135deg, rgba(232, 137, 28, 0.1), rgba(212, 135, 55, 0.2));
                    color: #c06a10;
                    border: 1px solid rgba(232, 137, 28, 0.3);
                    padding: 5px 16px;
                    border-radius: 50px;
                    font-size: 12px;
                    font-weight: 700;
                    letter-spacing: 1.5px;
                    text-transform: uppercase;
                    margin-bottom: 12px;
                }

                .section-title {
                    font-size: clamp(2rem, 4vw, 2.8rem);
                    font-weight: 800;
                    color: #1a0a00;
                    line-height: 1.2;
                }

                @media (max-width: 767.98px) {
                    .py-6 {
                        padding-top: 60px !important;
                        padding-bottom: 60px !important;
                    }

                    .hero-content {
                        text-align: center;
                    }

                    .hero-badge {
                        margin-left: auto;
                        margin-right: auto;
                    }

                    .hero-cta {
                        justify-content: center;
                    }

                    .hero-stats {
                        justify-content: center;
                        gap: 12px !important;
                        display: grid !important;
                        grid-template-columns: repeat(3, 1fr);
                    }

                    @media (max-width: 480px) {
                        .hero-stats {
                            grid-template-columns: repeat(2, 1fr);
                        }
                    }

                    .hero-stat-item {
                        padding: 12px 10px;
                        width: 100%;
                    }
                    .hero-stat-num { font-size: 1.4rem; }
                    .hero-stat-label { font-size: 0.65rem; }
                }

                .section-title .accent {
                    color: #e8821c;
                }

                /* ========== FEATURES ========== */
                .features-section {
                    background: #faf8f5;
                }

                .feature-card {
                    background: #fff;
                    border-radius: 24px;
                    padding: 40px 32px;
                    border: 1px solid #f0ebe4;
                    transition: all 0.35s ease;
                    height: 100%;
                }

                .feature-card:hover {
                    transform: translateY(-8px);
                    box-shadow: 0 25px 50px rgba(107, 58, 31, 0.1);
                    border-color: rgba(232, 137, 28, 0.3);
                }

                .feature-icon-wrap {
                    width: 70px;
                    height: 70px;
                    border-radius: 20px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-size: 2rem;
                    margin-bottom: 20px;
                }

                /* ========== PRODUCTS ========== */
                .products-section {
                    background: #fff;
                }

                .product-card-home {
                    border-radius: 24px;
                    overflow: hidden;
                    border: 1px solid #f0ebe4;
                    transition: all 0.3s ease;
                    height: 100%;
                    background: #fff;
                }

                .product-card-home:hover {
                    transform: translateY(-8px);
                    box-shadow: 0 20px 50px rgba(107, 58, 31, 0.12);
                }

                .product-card-home .product-img-wrap {
                    height: 220px;
                    overflow: hidden;
                    background: linear-gradient(135deg, #fdf0e0, #fde8c9);
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    position: relative;
                }

                .product-card-home .product-img-wrap img {
                    width: 100%;
                    height: 100%;
                    object-fit: cover;
                    transition: transform 0.4s ease;
                }

                .product-card-home:hover .product-img-wrap img {
                    transform: scale(1.08);
                }

                .product-badge {
                    position: absolute;
                    top: 12px;
                    left: 12px;
                    background: linear-gradient(135deg, #e8891c, #d4722a);
                    color: #fff;
                    font-size: 11px;
                    font-weight: 700;
                    padding: 4px 10px;
                    border-radius: 50px;
                }

                .product-price {
                    font-size: 1.3rem;
                    font-weight: 800;
                    color: #e8821c;
                }

                .btn-add-cart {
                    width: 42px;
                    height: 42px;
                    border-radius: 12px;
                    background: linear-gradient(135deg, #e8891c, #d4722a);
                    color: #fff;
                    border: none;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-size: 1.1rem;
                    transition: all 0.25s;
                    cursor: pointer;
                    flex-shrink: 0;
                }

                .btn-add-cart:hover {
                    transform: scale(1.1);
                    box-shadow: 0 6px 15px rgba(232, 137, 28, 0.5);
                }

                /* ========== TESTIMONIALS ========== */
                .testimonials-section {
                    background: linear-gradient(135deg, #1a0a00 0%, #3d1f00 100%);
                    position: relative;
                    overflow: hidden;
                }

                .testimonials-section::before {
                    content: '';
                    position: absolute;
                    inset: 0;
                    background: url('https://images.unsplash.com/photo-1442512595331-e89e73853f31?q=80&w=1920&auto=format&fit=crop') center/cover;
                    opacity: 0.06;
                }

                .testimonial-card {
                    background: rgba(255, 255, 255, 0.07);
                    border: 1px solid rgba(255, 255, 255, 0.12);
                    backdrop-filter: blur(15px);
                    border-radius: 24px;
                    padding: 32px;
                    transition: all 0.3s;
                }

                .testimonial-card:hover {
                    background: rgba(255, 255, 255, 0.12);
                    transform: translateY(-4px);
                }

                .testimonial-stars {
                    color: #f6c06e;
                    font-size: 1rem;
                }

                .testimonial-text {
                    color: rgba(255, 255, 255, 0.85);
                    font-size: 0.95rem;
                    line-height: 1.8;
                }

                .testimonial-avatar {
                    width: 48px;
                    height: 48px;
                    border-radius: 50%;
                    object-fit: cover;
                    border: 2px solid rgba(246, 192, 110, 0.5);
                }

                /* ========== CTA SECTION ========== */
                .cta-section {
                    background: linear-gradient(135deg, #e8891c 0%, #d4562a 100%);
                    position: relative;
                    overflow: hidden;
                }

                .cta-section::before {
                    content: '';
                    position: absolute;
                    inset: 0;
                    background: radial-gradient(ellipse at 80% 50%, rgba(255, 255, 255, 0.1), transparent);
                }

                /* ========== ANIMATIONS ========== */
                @keyframes fadeInDown {
                    from {
                        opacity: 0;
                        transform: translateY(-20px);
                    }

                    to {
                        opacity: 1;
                        transform: translateY(0);
                    }
                }

                @keyframes fadeInUp {
                    from {
                        opacity: 0;
                        transform: translateY(30px);
                    }

                    to {
                        opacity: 1;
                        transform: translateY(0);
                    }
                }

                @keyframes floatUp {
                    from {
                        opacity: 0;
                        transform: translateY(50px);
                    }

                    to {
                        opacity: 1;
                        transform: translateY(0);
                    }
                }

                @keyframes float {

                    0%,
                    100% {
                        transform: translateY(0);
                    }

                    50% {
                        transform: translateY(-10px);
                    }
                }

                @keyframes bounce {

                    0%,
                    100% {
                        transform: translateX(-50%) translateY(0);
                    }

                    50% {
                        transform: translateX(-50%) translateY(-10px);
                    }
                }

                .fade-in-section {
                    opacity: 0;
                    transform: translateY(40px);
                    transition: all 0.7s ease;
                }

                .fade-in-section.visible {
                    opacity: 1;
                    transform: translateY(0);
                }
            </style>

            <!-- ========== HERO SECTION ========== -->
            <section class="hero-section">
                <div class="container py-5">
                    <div class="row align-items-center g-5">
                        <div class="col-lg-6 hero-content">
                            <div class="hero-badge mb-4">
                                <i class="bi bi-cup-hot-fill"></i>
                                POLYCOFFEE — Nơi Hương Cà Phê Đích Thực
                            </div>
                            <h1 class="hero-title mb-4">
                                Thưởng thức<br>
                                <span class="highlight">Hương Vị</span><br>
                                Cà Phê Tuyệt Vời
                            </h1>
                            <p class="hero-desc mb-5">
                                Mỗi tách cà phê là một hành trình khám phá hương vị. Từ hạt cà phê thượng hạng
                                đến tay nghề pha chế tỉ mỉ — chúng tôi mang đến trải nghiệm café đích thực.
                            </p>
                            <div class="hero-cta d-flex flex-wrap gap-3 mb-5">
                                <a href="${pageContext.request.contextPath}/menu" class="btn-gold">
                                    <i class="bi bi-cup-hot"></i> Xem Thực Đơn
                                </a>
                                <a href="${pageContext.request.contextPath}/about" class="btn-outline-white">
                                    <i class="bi bi-play-circle"></i> Về Chúng Tôi
                                </a>
                            </div>
                            <div class="hero-stats d-flex flex-wrap gap-3">
                                <div class="hero-stat-item">
                                    <div class="hero-stat-num">50+</div>
                                    <div class="hero-stat-label">Món uống</div>
                                </div>
                                <div class="hero-stat-item">
                                    <div class="hero-stat-num">5K+</div>
                                    <div class="hero-stat-label">Khách hàng</div>
                                </div>
                                <div class="hero-stat-item">
                                    <div class="hero-stat-num">4.9★</div>
                                    <div class="hero-stat-label">Đánh giá</div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6 d-lg-block text-center mt-lg-0 mt-5">
                            <div class="hero-image-wrap mx-auto" style="max-width: 500px;">
                                <img src="https://images.unsplash.com/photo-1509042239860-f550ce710b93?q=80&w=800&auto=format&fit=crop"
                                    alt="Polycoffee Premium Coffee">
                                <div class="hero-float-card hero-float-card-1">
                                    <div class="d-flex align-items-center gap-3">
                                        <div class="bg-warning bg-opacity-10 rounded-circle d-flex align-items-center justify-content-center"
                                            style="width:46px;height:46px;">
                                            <i class="bi bi-award-fill text-warning fs-5"></i>
                                        </div>
                                        <div>
                                            <div class="fw-bold" style="font-size:14px;color:#1a0a00;">Đảm Bảo Chất
                                                Lượng</div>
                                            <div style="font-size:12px;color:#888;">100% nguyên liệu tươi</div>
                                        </div>
                                    </div>
                                </div>
                                <div class="hero-float-card hero-float-card-2">
                                    <div class="d-flex align-items-center gap-2">
                                        <div style="font-size:22px;">☕</div>
                                        <div>
                                            <div class="fw-bold" style="font-size:14px;color:#1a0a00;">Phục Vụ Nhanh
                                            </div>
                                            <div style="font-size:12px;color:#888;">≤ 5 phút</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="scroll-hint">
                    <div>CUỘN XUỐNG</div>
                    <i class="bi bi-chevron-down d-block mt-1"></i>
                </div>
            </section>

            <!-- ========== FEATURES SECTION ========== -->
            <section class="features-section py-6 fade-in-section" style="padding:96px 0;">
                <div class="container">
                    <div class="text-center mb-5">
                        <div class="section-badge">Tại Sao Chọn Chúng Tôi</div>
                        <h2 class="section-title">Trải Nghiệm <span class="accent">Khác Biệt</span><br>Tại Polycoffee
                        </h2>
                    </div>
                    <div class="row g-4">
                        <div class="col-md-4">
                            <div class="feature-card text-center fade-in-section">
                                <div class="feature-icon-wrap bg-warning bg-opacity-10 mx-auto">
                                    <i class="bi bi-cup-hot-fill text-warning" style="font-size:2rem;"></i>
                                </div>
                                <h4 class="fw-bold mb-3" style="color:#1a0a00;">Cà Phê Nguyên Chất</h4>
                                <p class="text-muted mb-0">
                                    Chúng tôi chọn lựa kỹ càng từng hạt cà phê từ các vùng trồng nổi tiếng Đà Lạt,
                                    Buôn Ma Thuột, đảm bảo hương vị thuần khiết nhất.
                                </p>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="feature-card text-center fade-in-section">
                                <div class="feature-icon-wrap mx-auto" style="background:rgba(220,53,69,0.1);">
                                    <i class="bi bi-heart-fill" style="font-size:2rem;color:#dc3545;"></i>
                                </div>
                                <h4 class="fw-bold mb-3" style="color:#1a0a00;">Pha Chế Với Tâm Huyết</h4>
                                <p class="text-muted mb-0">
                                    Mỗi ly đồ uống được các Barista tài năng pha chế tỉ mỉ với kỹ thuật chuyên nghiệp,
                                    mang lại hương vị hoàn hảo cho bạn.
                                </p>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="feature-card text-center fade-in-section">
                                <div class="feature-icon-wrap mx-auto" style="background:rgba(13,110,253,0.1);">
                                    <i class="bi bi-shop-window" style="font-size:2rem;color:#0d6efd;"></i>
                                </div>
                                <h4 class="fw-bold mb-3" style="color:#1a0a00;">Không Gian Ấm Cúng</h4>
                                <p class="text-muted mb-0">
                                    Không gian thiết kế hiện đại, ấm áp, là nơi lý tưởng để làm việc, gặp gỡ bạn bè
                                    hay đơn giản là thưởng thức một ly cà phê trong yên bình.
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- ========== FEATURED PRODUCTS ========== -->
            <section class="products-section py-6 fade-in-section" style="padding:96px 0;">
                <div class="container">
                    <div class="d-flex justify-content-between align-items-end mb-5 flex-wrap gap-3">
                        <div>
                            <div class="section-badge">Thực Đơn Nổi Bật</div>
                            <h2 class="section-title mb-0">Món Uống <span class="accent">Được Yêu Thích</span></h2>
                        </div>
                        <a href="${pageContext.request.contextPath}/menu"
                            class="btn btn-outline-warning rounded-pill px-4 fw-semibold">
                            Xem tất cả <i class="bi bi-arrow-right ms-1"></i>
                        </a>
                    </div>

                    <div class="row g-4">
                        <c:choose>
                            <c:when test="${not empty featuredProducts}">
                                <c:forEach var="p" items="${featuredProducts}">
                                    <div class="col-xl-3 col-lg-4 col-sm-6">
                                        <div class="product-card-home">
                                            <div class="product-img-wrap">
                                                <c:choose>
                                                    <c:when test="${not empty p.thumbnailUrl}">
                                                        <img src="${pageContext.request.contextPath}/uploads/images/${p.thumbnailUrl}"
                                                            alt="${p.name}"
                                                            onerror="this.src='https://images.unsplash.com/photo-1461023058943-07fcbe16d735?q=80&w=400&h=400&auto=format&fit=crop'">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img src="https://images.unsplash.com/photo-1461023058943-07fcbe16d735?q=80&w=400&h=400&auto=format&fit=crop"
                                                            alt="${p.name}">
                                                    </c:otherwise>
                                                </c:choose>
                                                <c:if test="${p.featured}">
                                                    <span class="product-badge"><i class="bi bi-star-fill me-1"></i>Nổi
                                                        Bật</span>
                                                </c:if>
                                            </div>
                                            <div class="p-4">
                                                <c:if test="${not empty p.category}">
                                                    <small class="text-muted text-uppercase fw-semibold"
                                                        style="font-size:10px;letter-spacing:1px;">
                                                        ${p.category.name}
                                                    </small>
                                                </c:if>
                                                <h6 class="fw-bold mt-1 mb-2" style="color:#1a0a00;">${p.name}</h6>
                                                <c:if test="${not empty p.description}">
                                                    <p class="text-muted small mb-3"
                                                        style="display:-webkit-box;-webkit-line-clamp:2;-webkit-box-orient:vertical;overflow:hidden;">
                                                        ${p.description}
                                                    </p>
                                                </c:if>
                                                <div class="d-flex justify-content-between align-items-center">
                                                    <span class="product-price">
                                                        <fmt:formatNumber value="${p.basePrice}" type="number"
                                                            groupingUsed="true" />đ
                                                    </span>
                                                    <a href="${pageContext.request.contextPath}/menu"
                                                        class="btn-add-cart" title="Xem thực đơn">
                                                        <i class="bi bi-plus-lg"></i>
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <%-- Fallback static cards khi chưa có data --%>
                                    <c:forEach begin="1" end="4" varStatus="i">
                                        <div class="col-xl-3 col-lg-4 col-sm-6">
                                            <div class="product-card-home">
                                                <div class="product-img-wrap">
                                                    <img src="https://images.unsplash.com/photo-1509042239860-f550ce710b93?q=80&w=400&h=400&auto=format&fit=crop"
                                                        alt="Cà phê">
                                                    <span class="product-badge"><i class="bi bi-star-fill me-1"></i>Nổi
                                                        Bật</span>
                                                </div>
                                                <div class="p-4">
                                                    <small class="text-muted text-uppercase fw-semibold"
                                                        style="font-size:10px;letter-spacing:1px;">Cà Phê</small>
                                                    <h6 class="fw-bold mt-1 mb-2" style="color:#1a0a00;">Cà Phê Đặc Biệt
                                                        #${i.index+1}</h6>
                                                    <p class="text-muted small mb-3">Hương vị cà phê nguyên chất, thơm
                                                        ngon đặc trưng.</p>
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <span class="product-price">35.000đ</span>
                                                        <a href="${pageContext.request.contextPath}/menu"
                                                            class="btn-add-cart">
                                                            <i class="bi bi-plus-lg"></i>
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </section>

            <!-- ========== TESTIMONIALS ========== -->
            <section class="testimonials-section py-6 fade-in-section" style="padding:96px 0;">
                <div class="container" style="position:relative;z-index:2;">
                    <div class="text-center mb-5">
                        <div class="section-badge"
                            style="color:#f6c06e;border-color:rgba(246,192,110,0.4);background:rgba(246,192,110,0.1);">
                            Khách Hàng Nói Gì
                        </div>
                        <h2 class="section-title" style="color:#fff;">Hàng Nghìn Khách Hàng<br>
                            <span style="color:#f6c06e;">Tin Tưởng Chúng Tôi</span>
                        </h2>
                    </div>
                    <div class="row g-4">
                        <div class="col-md-4">
                            <div class="testimonial-card">
                                <div class="testimonial-stars mb-3">★★★★★</div>
                                <p class="testimonial-text mb-4">"Cà phê ở đây thực sự tuyệt vời! Hương vị đậm đà, thơm
                                    ngon.
                                    Nhân viên phục vụ nhiệt tình và thân thiện. Tôi sẽ quay lại thường xuyên."</p>
                                <div class="d-flex align-items-center gap-3">
                                    <img src="https://i.pravatar.cc/150?img=1" alt="Nguyễn Văn A"
                                        class="testimonial-avatar">
                                    <div>
                                        <div class="fw-bold text-white" style="font-size:14px;">Nguyễn Văn An</div>
                                        <div style="color:rgba(255,255,255,0.5);font-size:12px;">Khách hàng thân thiết
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="testimonial-card">
                                <div class="testimonial-stars mb-3">★★★★★</div>
                                <p class="testimonial-text mb-4">"Không gian quán rất đẹp và ấm cúng. Menu đa dạng, phù
                                    hợp
                                    với mọi khẩu vị. Đặc biệt yêu thích ly Bạc Xỉu ở đây, không đâu ngon bằng!"</p>
                                <div class="d-flex align-items-center gap-3">
                                    <img src="https://i.pravatar.cc/150?img=5" alt="Trần Thị B"
                                        class="testimonial-avatar">
                                    <div>
                                        <div class="fw-bold text-white" style="font-size:14px;">Trần Thị Bảo</div>
                                        <div style="color:rgba(255,255,255,0.5);font-size:12px;">Học sinh FPT
                                            Polytechnic</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="testimonial-card">
                                <div class="testimonial-stars mb-3">★★★★★</div>
                                <p class="testimonial-text mb-4">"Polycoffee là nơi tôi thường xuyên đến làm việc.
                                    Wifi nhanh, đồ uống ngon, giá cả hợp lý. Barista ở đây tay nghề rất giỏi!"</p>
                                <div class="d-flex align-items-center gap-3">
                                    <img src="https://i.pravatar.cc/150?img=8" alt="Lê Minh C"
                                        class="testimonial-avatar">
                                    <div>
                                        <div class="fw-bold text-white" style="font-size:14px;">Lê Minh Cường</div>
                                        <div style="color:rgba(255,255,255,0.5);font-size:12px;">Khách hàng VIP</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- ========== CTA SECTION ========== -->
            <section class="cta-section py-6 fade-in-section" style="padding:80px 0;">
                <div class="container text-center" style="position:relative;z-index:2;">
                    <h2 class="fw-bold text-white mb-3" style="font-size:clamp(2rem,4vw,2.8rem);">
                        Sẵn Sàng Thưởng Thức<br>Ly Café Hoàn Hảo?
                    </h2>
                    <p class="text-white mb-5"
                        style="opacity:0.85;font-size:1.1rem;max-width:500px;margin:0 auto 2rem;">
                        Ghé thăm Polycoffee ngay hôm nay hoặc xem thực đơn để lựa chọn món yêu thích.
                    </p>
                    <div class="d-flex gap-3 justify-content-center flex-wrap">
                        <a href="${pageContext.request.contextPath}/menu"
                            class="btn btn-light btn-lg rounded-pill px-5 fw-bold shadow-sm" style="color:#e8821c;">
                            <i class="bi bi-cup-hot me-2"></i>Xem Thực Đơn
                        </a>
                        <a href="${pageContext.request.contextPath}/contact"
                            class="btn btn-outline-light btn-lg rounded-pill px-5 fw-bold">
                            <i class="bi bi-geo-alt me-2"></i>Tìm Chúng Tôi
                        </a>
                    </div>
                </div>
            </section>

            <script>
                // Scroll animation
                const observer = new IntersectionObserver((entries) => {
                    entries.forEach(entry => {
                        if (entry.isIntersecting) {
                            entry.target.classList.add('visible');
                        }
                    });
                }, { threshold: 0.1 });

                document.querySelectorAll('.fade-in-section').forEach(el => observer.observe(el));

                // Counter animation for hero stats
                function animateCounter(el, target, suffix = '') {
                    let current = 0;
                    const step = target / 60;
                    const timer = setInterval(() => {
                        current += step;
                        if (current >= target) {
                            current = target;
                            clearInterval(timer);
                        }
                        el.textContent = Math.floor(current) + suffix;
                    }, 20);
                }
            </script>
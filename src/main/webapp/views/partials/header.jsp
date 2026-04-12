<%@page pageEncoding="utf-8" isELIgnored="false" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
            <c:set var="currentPath" value="${pageContext.request.servletPath}" />
            <c:set var="contextPath" value="${pageContext.request.contextPath}" />
            <c:set var="isAdmin" value="${fn:startsWith(currentPath, '/admin')}" />

            <style>
                /* ===== NAVBAR BASE ===== */
                .pc-navbar {
                    transition: all 0.4s ease;
                    padding: 12px 0;
                }

                /* Public Navbar */
                .pc-navbar.public-nav {
                    background: transparent;
                    position: fixed;
                    width: 100%;
                    top: 0;
                    z-index: 1050;
                }

                .pc-navbar.public-nav.scrolled,
                body:not(.path-home) .pc-navbar.public-nav {
                    background: rgba(26, 10, 0, 0.95) !important;
                    backdrop-filter: blur(20px);
                    -webkit-backdrop-filter: blur(20px);
                    box-shadow: 0 4px 30px rgba(0, 0, 0, 0.2);
                    padding: 8px 0;
                }

                .pc-navbar.public-nav.scrolled .nav-link {
                    color: #ffffff;
                    font-weight: 600;
                    padding: 8px 16px;
                    border-radius: 10px;
                    transition: all 0.25s;
                    font-size: 0.95rem;
                }

                .pc-navbar.public-nav .nav-link {
                    color: #3d1f00;
                    font-weight: 600;
                    padding: 8px 16px;
                    border-radius: 10px;
                    transition: all 0.25s;
                    font-size: 0.95rem;
                }

                .pc-navbar.public-nav .nav-link:hover,
                .pc-navbar.public-nav .nav-link.active {
                    color: #f6c06e !important;
                    background: rgba(246, 192, 110, 0.1);
                }

                .pc-navbar.public-nav .navbar-brand span {
                    color: #fff;
                }

                .pc-navbar.public-nav .navbar-brand span .brand-accent {
                    color: #f6c06e;
                }

                /* Admin Navbar */
                .pc-navbar.admin-nav {
                    background: linear-gradient(135deg, #1a0a00, #3d1f00);
                    box-shadow: 0 2px 20px rgba(0, 0, 0, 0.15);
                    position: sticky;
                    top: 0;
                    z-index: 1030;
                }

                .pc-navbar.admin-nav .nav-link {
                    color: rgba(255, 255, 255, 0.8) !important;
                    font-size: 0.9rem;
                    padding: 7px 14px;
                    border-radius: 8px;
                    transition: all 0.25s;
                    font-weight: 500;
                }

                .pc-navbar.admin-nav .nav-link:hover,
                .pc-navbar.admin-nav .nav-link.active {
                    background: rgba(246, 192, 110, 0.15);
                    color: #f6c06e !important;
                }

                /* Logo */
                .pc-logo-icon {
                    width: 42px;
                    height: 42px;
                    border-radius: 14px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-size: 1.2rem;
                    transition: transform 0.3s;
                }

                .pc-logo-icon:hover {
                    transform: rotate(-10deg) scale(1.05);
                }

                /* Login btn public */
                .btn-login-public {
                    background: linear-gradient(135deg, #e8891c, #d4722a);
                    color: #fff !important;
                    border: none;
                    padding: 9px 24px;
                    border-radius: 50px;
                    font-weight: 700;
                    font-size: 0.88rem;
                    text-decoration: none;
                    transition: all 0.3s;
                    display: inline-flex;
                    align-items: center;
                    gap: 6px;
                    box-shadow: 0 4px 15px rgba(232, 137, 28, 0.35);
                }

                .btn-login-public:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 8px 25px rgba(232, 137, 28, 0.5);
                    color: #fff !important;
                }

                /* Dropdown */
                .pc-dropdown-menu {
                    border: none;
                    border-radius: 16px;
                    box-shadow: 0 20px 50px rgba(0, 0, 0, 0.15);
                    padding: 8px;
                    min-width: 220px;
                    margin-top: 12px !important;
                }

                .pc-dropdown-item {
                    border-radius: 10px;
                    padding: 10px 16px;
                    font-size: 0.9rem;
                    transition: all 0.2s;
                }

                .pc-dropdown-item:hover {
                    background: linear-gradient(135deg, rgba(232, 137, 28, 0.1), rgba(212, 113, 42, 0.08));
                    color: #e8821c;
                }

                /* Mobile toggle */
                .pc-toggler {
                    border: 1px solid rgba(255, 255, 255, 0.25);
                    border-radius: 10px;
                    padding: 6px 10px;
                    background: rgba(255, 255, 255, 0.08);
                    transition: all 0.3s;
                }

                .pc-toggler:hover, .pc-toggler:focus {
                    background: rgba(255, 255, 255, 0.15);
                    border-color: rgba(255, 255, 255, 0.4);
                }

                .pc-toggler .navbar-toggler-icon {
                    filter: brightness(0) invert(1);
                    width: 20px;
                    height: 20px;
                }

                /* Responsive Adjustments */
                @media (max-width: 991.98px) {
                    .pc-navbar.public-nav {
                        background: #1a0a00 !important; /* Force background on mobile menu */
                        padding: 10px 0;
                    }
                    
                    .pc-navbar.public-nav .navbar-collapse {
                        margin-top: 15px;
                        padding: 15px;
                        background: rgba(255, 255, 255, 0.03);
                        border-radius: 20px;
                        border: 1px solid rgba(255, 255, 255, 0.05);
                    }

                    .pc-navbar.public-nav .nav-link {
                        color: rgba(255, 255, 255, 0.85) !important;
                        padding: 12px 16px;
                    }

                    .pc-navbar.public-nav .nav-link:hover,
                    .pc-navbar.public-nav .nav-link.active {
                        background: rgba(246, 192, 110, 0.1);
                        color: #f6c06e !important;
                    }

                    .pc-navbar.admin-nav .navbar-collapse {
                        margin-top: 15px;
                        padding: 15px;
                        background: rgba(0, 0, 0, 0.2);
                        border-radius: 20px;
                    }

                    .pc-navbar .navbar-nav {
                        margin-bottom: 20px;
                    }

                    .btn-login-public {
                        width: 100%;
                        justify-content: center;
                        padding: 12px;
                    }
                }

                /* Main padding for fixed nav */
                body.has-fixed-nav main {
                    padding-top: 72px !important;
                }

                @media (min-width: 992px) {
                    body.has-fixed-nav main {
                        padding-top: 80px !important;
                    }
                }
            </style>

            <nav class="pc-navbar navbar navbar-expand-lg ${isAdmin ? 'admin-nav' : 'public-nav'} ${currentPath eq '/home' || currentPath eq '/' ? '' : 'scrolled'}" id="mainNavbar">
                <div class="container">
                    <!-- Logo -->
                    <a class="navbar-brand d-flex align-items-center gap-2 text-decoration-none"
                        href="${contextPath}/home">
                        <div class="pc-logo-icon"
                            style="background: linear-gradient(135deg, #e8891c, #d4722a); box-shadow: 0 4px 15px rgba(232,137,28,0.4);">
                            <i class="bi bi-cup-hot-fill text-white"></i>
                        </div>
                        <span class="fw-bold" style="font-size:1.4rem;color:#fff;letter-spacing:-0.5px;">
                            Poly<span class="brand-accent" style="color:#f6c06e;">coffee</span>
                        </span>
                    </a>

                    <!-- Toggler -->
                    <button class="navbar-toggler pc-toggler border-0 shadow-none" type="button"
                        data-bs-toggle="collapse" data-bs-target="#pcNavContent">
                        <span class="navbar-toggler-icon"></span>
                    </button>

                    <!-- Nav Content -->
                    <div class="collapse navbar-collapse" id="pcNavContent">
                        <c:choose>
                            <c:when test="${!isAdmin}">
                                <!-- PUBLIC NAV LINKS -->
                                <ul class="navbar-nav mx-auto gap-1">
                                    <li class="nav-item">
                                        <a class="nav-link ${currentPath eq '/home' ? 'active' : ''}"
                                            href="${contextPath}/home">
                                            Trang Chủ
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link ${currentPath eq '/menu' ? 'active' : ''}"
                                            href="${contextPath}/menu">
                                            Thực Đơn
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link ${currentPath eq '/about' ? 'active' : ''}"
                                            href="${contextPath}/about">
                                            Giới Thiệu
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link ${currentPath eq '/contact' ? 'active' : ''}"
                                            href="${contextPath}/contact">
                                            Liên Hệ
                                        </a>
                                    </li>
                                    <c:if
                                        test="${sessionScope.user.role == 'ADMIN' or sessionScope.user.role == 'EMPLOYEE'}">
                                        <li class="nav-item">
                                            <a class="nav-link ${fn:startsWith(currentPath, '/admin') ? 'active' : ''}"
                                                href="${contextPath}/admin/dashboard">
                                                <i class="bi bi-speedometer2 me-1"></i>Quản Trị
                                            </a>
                                        </li>
                                    </c:if>
                                </ul>

                                <!-- USER ACTIONS -->
                                <div class="d-flex align-items-center gap-2">
                                    <c:choose>
                                        <c:when test="${not empty sessionScope.user}">
                                            <div class="dropdown">
                                                <button class="btn d-flex align-items-center gap-2 dropdown-toggle"
                                                    type="button" id="userDrop" data-bs-toggle="dropdown"
                                                    style="background:rgba(255,255,255,0.1);border:1px solid rgba(255,255,255,0.2);
                                                       color:#fff;border-radius:50px;padding:8px 18px;font-size:0.9rem;font-weight:600;">
                                                    <i class="bi bi-person-circle"></i>
                                                    ${sessionScope.user.fullname}
                                                </button>
                                                <ul class="dropdown-menu pc-dropdown-menu dropdown-menu-end"
                                                    aria-labelledby="userDrop">
                                                    <c:if
                                                        test="${sessionScope.user.role == 'ADMIN' or sessionScope.user.role == 'EMPLOYEE'}">
                                                        <li><a class="dropdown-item pc-dropdown-item"
                                                                href="${contextPath}/admin/dashboard">
                                                                <i class="bi bi-speedometer2 me-2 text-warning"></i>Quản
                                                                trị
                                                            </a></li>
                                                        <li>
                                                            <hr class="dropdown-divider mx-3 my-1">
                                                        </li>
                                                    </c:if>
                                                    <li><a class="dropdown-item pc-dropdown-item"
                                                            href="${contextPath}/profile">
                                                            <i class="bi bi-person me-2" style="color:#0d6efd;"></i>Hồ
                                                            sơ
                                                        </a></li>
                                                    <li><a class="dropdown-item pc-dropdown-item text-danger"
                                                            href="${contextPath}/logout">
                                                            <i class="bi bi-box-arrow-right me-2"></i>Đăng xuất
                                                        </a></li>
                                                </ul>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${contextPath}/login" class="btn-login-public">
                                                <i class="bi bi-box-arrow-in-right"></i>Đăng Nhập
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </c:when>

                            <c:otherwise>
                                <!-- ADMIN NAV LINKS -->
                                <ul class="navbar-nav mx-auto gap-1">
                                    <li class="nav-item">
                                        <a class="nav-link ${currentPath eq '/admin/dashboard' ? 'active' : ''}"
                                            href="${contextPath}/admin/dashboard">
                                            <i class="bi bi-speedometer2 me-1"></i>Dashboard
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link ${currentPath eq '/admin/product' ? 'active' : ''}"
                                            href="${contextPath}/admin/product">
                                            <i class="bi bi-cup-hot me-1"></i>Sản Phẩm
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link ${currentPath eq '/admin/order' ? 'active' : ''}"
                                            href="${contextPath}/admin/order">
                                            <i class="bi bi-receipt me-1"></i>Đơn Hàng
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link ${currentPath eq '/admin/category' ? 'active' : ''}"
                                            href="${contextPath}/admin/category">
                                            <i class="bi bi-tags me-1"></i>Danh Mục
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link ${currentPath eq '/admin/promotion' ? 'active' : ''}"
                                            href="${contextPath}/admin/promotion">
                                            <i class="bi bi-percent me-1"></i>Khuyến Mãi
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link ${currentPath eq '/admin/user' ? 'active' : ''}"
                                            href="${contextPath}/admin/user">
                                            <i class="bi bi-people me-1"></i>Người Dùng
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link ${currentPath eq '/admin/statistics' ? 'active' : ''}"
                                            href="${contextPath}/admin/statistics">
                                            <i class="bi bi-bar-chart-line me-1"></i>Thống Kê
                                        </a>
                                    </li>
                                </ul>
                                <div class="d-flex align-items-center gap-2">
                                    <a href="${contextPath}/home" style="color:rgba(255,255,255,0.6);text-decoration:none;font-size:0.85rem;padding:6px 14px;
                                           border:1px solid rgba(255,255,255,0.2);border-radius:20px;transition:0.2s;"
                                        onmouseover="this.style.color='#f6c06e';this.style.borderColor='rgba(246,192,110,0.5)';"
                                        onmouseout="this.style.color='rgba(255,255,255,0.6)';this.style.borderColor='rgba(255,255,255,0.2)';">
                                        <i class="bi bi-house me-1"></i>Trang chủ
                                    </a>
                                    <c:if test="${not empty sessionScope.user}">
                                        <div class="dropdown">
                                            <button class="btn dropdown-toggle d-flex align-items-center gap-2"
                                                type="button" data-bs-toggle="dropdown"
                                                style="background:rgba(246,192,110,0.15);border:1px solid rgba(246,192,110,0.3);
                                                   color:#f6c06e;border-radius:20px;padding:6px 16px;font-size:0.88rem;font-weight:600;">
                                                <i class="bi bi-person-circle"></i>
                                                ${sessionScope.user.fullname}
                                            </button>
                                            <ul class="dropdown-menu pc-dropdown-menu dropdown-menu-end">
                                                <li><a class="dropdown-item pc-dropdown-item text-danger"
                                                        href="${contextPath}/logout">
                                                        <i class="bi bi-box-arrow-right me-2"></i>Đăng xuất
                                                    </a></li>
                                            </ul>
                                        </div>
                                    </c:if>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </nav>

            <c:if test="${!isAdmin}">
                <script>
                    // Sticky scroll effect for public navbar
                    (function () {
                        const nav = document.getElementById('mainNavbar');
                        if (!nav || !nav.classList.contains('public-nav')) return;
                        
                        // Add path class to body for specific page styling
                        const path = '${currentPath}';
                        if (path === '/home' || path === '/') {
                            document.body.classList.add('path-home');
                        }

                        window.addEventListener('scroll', function () {
                            if (window.scrollY > 60) {
                                nav.classList.add('scrolled');
                            } else {
                                nav.classList.remove('scrolled');
                            }
                        }, { passive: true });
                    })();
                </script>
            </c:if>
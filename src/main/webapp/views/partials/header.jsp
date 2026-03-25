<%@page pageEncoding="utf-8" isELIgnored="false" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <c:set var="currentPath" value="${pageContext.request.servletPath}" />
        <c:set var="contextPath" value="${pageContext.request.contextPath}" />

        <nav
            class="navbar navbar-expand-lg border-bottom shadow-sm py-3 ${currentPath.startsWith('/admin') ? 'navbar-dark bg-primary' : 'navbar-light bg-white'}">
            <div class="container">
                <!-- Logo -->
                <a class="navbar-brand d-flex align-items-center fw-bold" href="${contextPath}/home">
                    <div class="bg-warning text-dark rounded-circle d-flex align-items-center justify-content-center me-2"
                        style="width: 40px; height: 40px;">
                        <i class="bi bi-cup-hot-fill fs-5"></i>
                    </div>
                    <span
                        class="fs-4 tracking-tight ${currentPath.startsWith('/admin') ? 'text-white' : 'text-dark'}">Polycoffee</span>
                </a>

                <!-- Toggler -->
                <button class="navbar-toggler border-0 shadow-none" type="button" data-bs-toggle="collapse"
                    data-bs-target="#mainNavbar">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <!-- Navbar Content -->
                <div class="collapse navbar-collapse" id="mainNavbar">
                    <ul class="navbar-nav mx-auto">
                        <li class="nav-item">
                            <a class="nav-link px-3 fw-medium ${currentPath eq '/home' ? 'active text-primary' : ''}"
                                href="${contextPath}/home">Trang Chủ</a>
                        </li>
                        <li class="nav-item border-start d-none d-lg-block my-auto" style="height: 15px;"></li>
                        <li class="nav-item">
                            <a class="nav-link px-3 fw-medium ${currentPath eq '/menu' ? 'active text-primary' : ''}"
                                href="${contextPath}/menu">Thực Đơn</a>
                        </li>
                        <li class="nav-item border-start d-none d-lg-block my-auto" style="height: 15px;"></li>
                        <li class="nav-item">
                            <a class="nav-link px-3 fw-medium ${currentPath eq '/about' ? 'active text-primary' : ''}"
                                href="${contextPath}/about">Giới Thiệu</a>
                        </li>
                        <li class="nav-item border-start d-none d-lg-block my-auto" style="height: 15px;"></li>
                        <li class="nav-item">
                            <a class="nav-link px-3 fw-medium ${currentPath eq '/contact' ? 'active text-primary' : ''}"
                                href="${contextPath}/contact">Liên Hệ</a>
                        </li>
                        <c:if test="${sessionScope.user.role == 'ADMIN' or sessionScope.user.role == 'EMPLOYEE'}">
                            <li class="nav-item border-start d-none d-lg-block my-auto" style="height: 15px;"></li>
                            <li class="nav-item">
                                <a class="nav-link px-3 fw-medium ${currentPath.startsWith('/admin') ? 'active text-primary' : ''}"
                                    href="${contextPath}/admin/dashboard">Quản Trị</a>
                            </li>
                        </c:if>
                    </ul>

                    <div class="d-flex align-items-center gap-2">
                        <c:choose>
                            <c:when test="${not empty sessionScope.user}">
                                <div class="dropdown">
                                    <button class="btn btn-light rounded-pill px-4 btn-sm dropdown-toggle shadow-sm border"
                                        type="button" id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                        <i class="bi bi-person-circle me-1"></i> ${sessionScope.user.fullname}
                                    </button>
                                    <ul class="dropdown-menu dropdown-menu-end shadow border-0 mt-2 py-2" aria-labelledby="userDropdown">
                                        <c:if test="${sessionScope.user.role == 'ADMIN' or sessionScope.user.role == 'EMPLOYEE'}">
                                            <li><a class="dropdown-item py-2" href="${contextPath}/admin/dashboard"><i class="bi bi-speedometer2 me-2"></i> Quản trị</a></li>
                                            <li><hr class="dropdown-divider"></li>
                                        </c:if>
                                        <li><a class="dropdown-item py-2" href="${contextPath}/profile"><i class="bi bi-person me-2"></i> Hồ sơ</a></li>
                                        <li><a class="dropdown-item py-2 text-danger" href="${contextPath}/logout"><i class="bi bi-box-arrow-right me-2"></i> Đăng xuất</a></li>
                                    </ul>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <a href="${contextPath}/login"
                                    class="btn btn-primary rounded-pill px-4 btn-sm shadow-sm">
                                    Đăng Nhập
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </div>

                </div>
            </div>
        </nav>

        <style>
            .nav-link {
                transition: color 0.2s ease-in-out;
            }

            .nav-link:hover {
                color: var(--bs-primary) !important;
            }

            .active.text-primary {
                color: var(--bs-primary) !important;
            }

            .navbar-dark .nav-link {
                color: rgba(255, 255, 255, 0.85) !important;
            }

            .navbar-dark .nav-link:hover {
                color: #fff !important;
            }
        </style>
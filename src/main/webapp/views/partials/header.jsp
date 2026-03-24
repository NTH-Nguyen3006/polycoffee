<%@page pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="currentPath" value="${pageContext.request.servletPath}" />
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/admin/category"><i
                    class="bi bi-cup-hot-fill text-warning"></i> Polycoffee</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link ${currentPath.startsWith('/admin/category') ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/category"><i
                                class="bi bi-tags"></i> Categories</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${currentPath.startsWith('/admin/product') ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/product"><i
                                class="bi bi-box-seam"></i> Products</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${currentPath.startsWith('/admin/order') ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/order"><i
                                class="bi bi-cart3"></i> Orders</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${currentPath.startsWith('/admin/promotion') ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/promotion"><i
                                class="bi bi-percent"></i> Promotions</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${currentPath.startsWith('/admin/user') ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/user"><i
                                class="bi bi-people"></i> Users</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${currentPath.startsWith('/admin/payment') ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/payment"><i
                                class="bi bi-credit-card"></i> Payments</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
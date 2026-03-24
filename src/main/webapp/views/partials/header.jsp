<%@page pageEncoding="utf-8" isELIgnored="false" %>
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
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/category"><i
                                class="bi bi-tags"></i> Categories</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/user"><i
                                class="bi bi-people"></i> Users</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
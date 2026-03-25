<%@page pageEncoding="utf-8" isELIgnored="false" %>
    <div class="container mt-4">
        <div class="row mb-4">
            <div class="col">
                <h1 class="display-4 fw-bold text-dark"><i class="bi bi-speedometer2"></i> Admin Dashboard</h1>
                <p class="text-muted">Quản lý các hoạt động của cửa hàng Polycoffee.</p>
            </div>
        </div>

        <div class="row g-4">
            <!-- Categories -->
            <div class="col-md-4">
                <div class="card h-100 border-0 shadow-sm hover-shadow transition">
                    <div class="card-body text-center p-4">
                        <div class="bg-primary bg-opacity-10 text-primary rounded-circle d-inline-flex align-items-center justify-content-center mb-3"
                            style="width: 64px; height: 64px;">
                            <i class="bi bi-tags fs-2"></i>
                        </div>
                        <h3 class="card-title h5 mb-3">Danh Mục</h3>
                        <p class="card-text text-muted small">Quản lý các loại món ăn, thức uống.</p>
                        <a href="${pageContext.request.contextPath}/admin/category"
                            class="btn btn-outline-primary stretched-link mt-auto">Truy cập</a>
                    </div>
                </div>
            </div>

            <!-- Products -->
            <div class="col-md-4">
                <div class="card h-100 border-0 shadow-sm hover-shadow transition">
                    <div class="card-body text-center p-4">
                        <div class="bg-success bg-opacity-10 text-success rounded-circle d-inline-flex align-items-center justify-content-center mb-3"
                            style="width: 64px; height: 64px;">
                            <i class="bi bi-cup-hot fs-2"></i>
                        </div>
                        <h3 class="card-title h5 mb-3">Sản Phẩm</h3>
                        <p class="card-text text-muted small">Quản lý thông tin thức uống & món ăn.</p>
                        <a href="${pageContext.request.contextPath}/admin/product"
                            class="btn btn-outline-success stretched-link mt-auto">Truy cập</a>
                    </div>
                </div>
            </div>

            <!-- Orders -->
            <div class="col-md-4">
                <div class="card h-100 border-0 shadow-sm hover-shadow transition">
                    <div class="card-body text-center p-4">
                        <div class="bg-warning bg-opacity-10 text-warning rounded-circle d-inline-flex align-items-center justify-content-center mb-3"
                            style="width: 64px; height: 64px;">
                            <i class="bi bi-cart-check fs-2"></i>
                        </div>
                        <h3 class="card-title h5 mb-3">Đơn Hàng</h3>
                        <p class="card-text text-muted small">Xem và xử lý các đơn đặt hàng.</p>
                        <a href="${pageContext.request.contextPath}/admin/order"
                            class="btn btn-outline-warning stretched-link mt-auto">Truy cập</a>
                    </div>
                </div>
            </div>

            <!-- Promotions -->
            <div class="col-md-4">
                <div class="card h-100 border-0 shadow-sm hover-shadow transition">
                    <div class="card-body text-center p-4">
                        <div class="bg-danger bg-opacity-10 text-danger rounded-circle d-inline-flex align-items-center justify-content-center mb-3"
                            style="width: 64px; height: 64px;">
                            <i class="bi bi-percent fs-2"></i>
                        </div>
                        <h3 class="card-title h5 mb-3">Khuyến Mãi</h3>
                        <p class="card-text text-muted small">Quản lý các chương trình ưu đãi.</p>
                        <a href="${pageContext.request.contextPath}/admin/promotion"
                            class="btn btn-outline-danger stretched-link mt-auto">Truy cập</a>
                    </div>
                </div>
            </div>

            <!-- Users -->
            <div class="col-md-4">
                <div class="card h-100 border-0 shadow-sm hover-shadow transition">
                    <div class="card-body text-center p-4">
                        <div class="bg-info bg-opacity-10 text-info rounded-circle d-inline-flex align-items-center justify-content-center mb-3"
                            style="width: 64px; height: 64px;">
                            <i class="bi bi-people fs-2"></i>
                        </div>
                        <h3 class="card-title h5 mb-3">Người Dùng</h3>
                        <p class="card-text text-muted small">Quản lý tài khoản khách hàng & nhân viên.</p>
                        <a href="${pageContext.request.contextPath}/admin/user"
                            class="btn btn-outline-info stretched-link mt-auto">Truy cập</a>
                    </div>
                </div>
            </div>

            <!-- Payments -->
            <div class="col-md-4">
                <div class="card h-100 border-0 shadow-sm hover-shadow transition">
                    <div class="card-body text-center p-4">
                        <div class="bg-dark bg-opacity-10 text-dark rounded-circle d-inline-flex align-items-center justify-content-center mb-3"
                            style="width: 64px; height: 64px;">
                            <i class="bi bi-credit-card-2-front fs-2"></i>
                        </div>
                        <h3 class="card-title h5 mb-3">Thanh Toán</h3>
                        <p class="card-text text-muted small">Theo dõi giao dịch & hóa đơn.</p>
                        <a href="${pageContext.request.contextPath}/admin/payment"
                            class="btn btn-outline-dark stretched-link mt-auto">Truy cập</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <style>
        .hover-shadow {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .hover-shadow:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1) !important;
        }
    </style>
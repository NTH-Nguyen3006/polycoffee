<%@page pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
.payment-coming-soon {
    min-height: 60vh;
    display: flex; flex-direction: column;
    align-items: center; justify-content: center;
    text-align: center;
}
.payment-icon-wrap {
    width: 100px; height: 100px;
    background: linear-gradient(135deg, rgba(13,110,253,0.1), rgba(13,110,253,0.06));
    border-radius: 30px;
    display: flex; align-items: center; justify-content: center;
    font-size: 3.5rem; margin: 0 auto 24px;
    border: 1px solid rgba(13,110,253,0.15);
}
.feature-pill {
    display: inline-flex; align-items: center; gap: 8px;
    background: #fff; border: 1px solid #f0ebe4;
    padding: 12px 20px; border-radius: 50px;
    font-size: 0.88rem; font-weight: 600; color: #3d1f00;
    transition: all 0.3s;
}
.feature-pill:hover {
    border-color: rgba(232,130,28,0.4);
    box-shadow: 0 4px 12px rgba(232,130,28,0.12);
    transform: translateY(-2px);
}
.feature-pill i { color: #e8821c; }
</style>

<div class="d-flex justify-content-between align-items-center mb-4">
    <div>
        <h1 class="h3 fw-bold mb-1">
            <i class="bi bi-credit-card-2-front me-2" style="color:#0d6efd;"></i>Thanh Toán
        </h1>
        <p class="text-muted mb-0">Theo dõi giao dịch và hóa đơn của hệ thống.</p>
    </div>
    <a href="${pageContext.request.contextPath}/admin/order"
       class="btn btn-outline-primary rounded-pill px-4">
        <i class="bi bi-receipt me-1"></i>Xem Đơn Hàng
    </a>
</div>

<div class="card border-0 shadow-sm" style="border-radius:24px;overflow:hidden;">
    <div class="card-body">
        <div class="payment-coming-soon">
            <div class="payment-icon-wrap">
                <i class="bi bi-credit-card-2-front" style="color:#0d6efd;"></i>
            </div>
            <h4 class="fw-bold mb-2" style="color:#1a0a00;">Module Thanh Toán</h4>
            <p class="text-muted mb-4" style="max-width:460px;font-size:0.95rem;line-height:1.7;">
                Tính năng quản lý thanh toán chi tiết đang được phát triển. 
                Hiện tại bạn có thể theo dõi trạng thái thanh toán trong 
                <strong>Quản Lý Đơn Hàng</strong>.
            </p>

            <div class="d-flex flex-wrap gap-3 justify-content-center mb-5">
                <div class="feature-pill">
                    <i class="bi bi-check-circle-fill"></i>
                    Xem trạng thái PAID / UNPAID qua đơn hàng
                </div>
                <div class="feature-pill">
                    <i class="bi bi-bar-chart-fill"></i>
                    Doanh thu theo ngày / tháng trong Thống Kê
                </div>
                <div class="feature-pill">
                    <i class="bi bi-clock-history"></i>
                    Lịch sử đơn hoàn thành có thể tra cứu
                </div>
            </div>

            <div class="d-flex gap-3 flex-wrap justify-content-center">
                <a href="${pageContext.request.contextPath}/admin/order?status=COMPLETED"
                   class="btn btn-primary rounded-pill px-4 fw-semibold">
                    <i class="bi bi-receipt-cutoff me-1"></i>Đơn Đã Hoàn Thành
                </a>
                <a href="${pageContext.request.contextPath}/admin/statistics?tab=revenue"
                   class="btn btn-outline-warning rounded-pill px-4 fw-semibold">
                    <i class="bi bi-graph-up-arrow me-1"></i>Xem Thống Kê Doanh Thu
                </a>
            </div>
        </div>
    </div>
</div>
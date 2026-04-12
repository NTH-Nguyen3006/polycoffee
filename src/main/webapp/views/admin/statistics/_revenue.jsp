<%@page pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set value="${pageContext.request.contextPath}" var="path" />

<style>
/* ─── Revenue specific ─── */
.kpi-card-rev {
    border-radius: 20px; border: none; overflow: hidden;
    position: relative; color: #fff; padding: 24px;
    transition: transform 0.3s, box-shadow 0.3s;
}
.kpi-card-rev:hover { transform: translateY(-4px); box-shadow: 0 16px 32px rgba(0,0,0,0.15); }
.kpi-card-rev .icon-bg {
    position: absolute; right: -10px; bottom: -20px;
    font-size: 8rem; opacity: 0.15; transform: rotate(-15deg);
}

.table-rev thead th {
    background: #fdfaf6; color: #6f4e37; border-bottom: 2px solid #e8821c;
    font-size: 0.85rem; text-transform: uppercase; letter-spacing: 0.5px;
}
.table-rev tbody td { padding: 16px 12px; vertical-align: middle; border-color: #f5f0eb; }
</style>

<!-- ── Summary KPI ── -->
<div class="row g-4 mb-4">
    <!-- Tổng doanh thu -->
    <div class="col-md-4">
        <div class="kpi-card-rev shadow-sm" style="background: linear-gradient(135deg, #198754, #146c43);">
            <i class="bi bi-cash-stack icon-bg"></i>
            <div class="d-flex flex-column h-100 position-relative z-1">
                <div class="small fw-semibold text-white-50 mb-1 text-uppercase tracking-wider">Tổng Doanh Thu</div>
                <div class="fs-2 fw-bold mb-2">
                    <fmt:formatNumber value="${totalRevenue != null ? totalRevenue : 0}" type="number" groupingUsed="true"/>đ
                </div>
                <div class="mt-auto small bg-white bg-opacity-25 rounded-pill px-3 py-1 d-inline-table">
                    <i class="bi bi-graph-up me-1"></i>Doanh thu thực tế
                </div>
            </div>
        </div>
    </div>
    <!-- Tổng đơn hàng -->
    <div class="col-md-4">
        <div class="kpi-card-rev shadow-sm" style="background: linear-gradient(135deg, #e8821c, #d4722a);">
            <i class="bi bi-receipt icon-bg"></i>
            <div class="d-flex flex-column h-100 position-relative z-1">
                <div class="small fw-semibold text-white-50 mb-1 text-uppercase tracking-wider">Tổng Đơn Hàng</div>
                <div class="fs-2 fw-bold mb-2">
                    <fmt:formatNumber value="${totalOrders != null ? totalOrders : 0}" type="number" groupingUsed="true"/> đơn
                </div>
                <div class="mt-auto small bg-white bg-opacity-25 rounded-pill px-3 py-1 d-inline-table">
                    <i class="bi bi-cart-check me-1"></i>Đơn hoàn thành
                </div>
            </div>
        </div>
    </div>
    <!-- TB / Đơn -->
    <div class="col-md-4">
        <div class="kpi-card-rev shadow-sm" style="background: linear-gradient(135deg, #0dcaf0, #0bacbe);">
            <i class="bi bi-calculator icon-bg"></i>
            <div class="d-flex flex-column h-100 position-relative z-1">
                <div class="small fw-semibold text-white-50 mb-1 text-uppercase tracking-wider">Giá Trị TB / Đơn</div>
                <div class="fs-2 fw-bold mb-2">
                    <fmt:formatNumber value="${avgOrderValue != null ? avgOrderValue : 0}" type="number" groupingUsed="true"/>đ
                </div>
                <div class="mt-auto small bg-white bg-opacity-25 rounded-pill px-3 py-1 d-inline-table">
                    <i class="bi bi-pie-chart me-1"></i>Mức chi tiêu / khách
                </div>
            </div>
        </div>
    </div>
</div>

<!-- ── Charts ── -->
<div class="row g-4 mb-4">
    <!-- Main line chart (Revenue over time) -->
    <div class="col-lg-8">
        <div class="card border-0 shadow-sm h-100 rounded-4">
            <div class="card-header bg-white border-0 pt-4 px-4 d-flex justify-content-between align-items-center">
                <h5 class="fw-bold mb-0 text-dark">
                    <i class="bi bi-graph-up-arrow me-2" style="color:#e8821c;"></i>Xu Hướng Doanh Thu
                </h5>
                <div class="btn-group shadow-sm rounded-pill overflow-hidden" role="group">
                    <a href="${path}/admin/statistics?tab=revenue&from=${fromDate}&to=${toDate}&groupBy=day"
                       class="btn btn-sm ${groupBy == 'day' ? 'btn-warning fw-bold text-dark' : 'btn-light text-muted'} px-3">
                       Theo Ngày
                    </a>
                    <a href="${path}/admin/statistics?tab=revenue&from=${fromDate}&to=${toDate}&groupBy=month"
                       class="btn btn-sm ${groupBy == 'month' ? 'btn-warning fw-bold text-dark' : 'btn-light text-muted'} px-3">
                       Theo Tháng
                    </a>
                </div>
            </div>
            <div class="card-body p-4 pt-2">
                <c:choose>
                    <c:when test="${not empty chartData}">
                        <div style="height:350px;"><canvas id="revenueChart"></canvas></div>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center py-5">
                            <i class="bi bi-graph-up fs-1 d-block mb-3 opacity-25"></i>
                            <p class="text-muted">Không có dữ liệu trong khoảng thời gian này.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <!-- Category Pie -->
    <div class="col-lg-4">
        <div class="card border-0 shadow-sm h-100 rounded-4">
            <div class="card-header bg-white border-0 pt-4 px-4">
                <h5 class="fw-bold mb-0 text-dark">
                    <i class="bi bi-pie-chart-fill me-2" style="color:#198754;"></i>Tỷ Trọng Danh Mục
                </h5>
            </div>
            <div class="card-body p-4 d-flex flex-column align-items-center justify-content-center">
                <c:choose>
                    <c:when test="${not empty revenueByCategory}">
                        <div style="height:260px;width:100%;"><canvas id="categoryChart"></canvas></div>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center py-5">
                            <i class="bi bi-pie-chart fs-1 d-block mb-3 opacity-25"></i>
                            <p class="text-muted">Chưa có dữ liệu phân bổ.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<!-- ── Tables ── -->
<div class="row g-4">
    <!-- Data table -->
    <div class="col-lg-8">
        <div class="card border-0 shadow-sm rounded-4 overflow-hidden h-100">
            <div class="card-header bg-white border-bottom py-3 px-4">
                <h6 class="fw-bold mb-0"><i class="bi bi-table me-2" style="color:#6f4e37;"></i>Bảng Dữ Liệu Chi Tiết</h6>
            </div>
            <div class="card-body p-0 table-responsive">
                <table class="table table-hover table-rev mb-0">
                    <thead>
                        <tr>
                            <th class="ps-4">Thứ tự</th>
                            <th>Khoảng Thời Gian</th>
                            <th class="text-center">Số Lượng Đơn</th>
                            <th class="text-end pe-4">Tổng Doanh Thu</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty chartData}">
                                <c:forEach var="row" items="${chartData}" varStatus="loop">
                                    <tr>
                                        <td class="ps-4 text-muted fw-semibold">#${loop.index + 1}</td>
                                        <td class="fw-bold text-dark">
                                            <i class="bi bi-calendar2-check text-warning me-2"></i>
                                            <c:choose>
                                                <c:when test="${groupBy == 'month'}">Tháng ${row[1]} / ${row[0]}</c:when>
                                                <c:otherwise><fmt:formatDate value="${row[0]}" pattern="dd/MM/yyyy"/></c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-center">
                                            <span class="badge bg-light text-dark border px-3 py-2 rounded-pill">
                                                <i class="bi bi-box-seam me-1"></i>
                                                <c:choose>
                                                    <c:when test="${groupBy == 'month'}">${row[3]}</c:when>
                                                    <c:otherwise>${row[2]}</c:otherwise>
                                                </c:choose>
                                            </span>
                                        </td>
                                        <td class="text-end pe-4 fw-bold text-success fs-6">
                                            <c:choose>
                                                <c:when test="${groupBy == 'month'}">
                                                    <fmt:formatNumber value="${row[2]}" type="number" groupingUsed="true"/>đ
                                                </c:when>
                                                <c:otherwise>
                                                    <fmt:formatNumber value="${row[1]}" type="number" groupingUsed="true"/>đ
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="4" class="text-center text-muted py-4">Trống.</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    
    <!-- Category table -->
    <div class="col-lg-4">
        <div class="card border-0 shadow-sm rounded-4 overflow-hidden h-100">
            <div class="card-header bg-white border-bottom py-3 px-4">
                <h6 class="fw-bold mb-0"><i class="bi bi-list-nested me-2" style="color:#6f4e37;"></i>Doanh Thu Nhóm</h6>
            </div>
            <div class="card-body p-0">
                <c:choose>
                    <c:when test="${not empty revenueByCategory}">
                        <c:forEach var="catRow" items="${revenueByCategory}" varStatus="loop">
                            <div class="d-flex justify-content-between align-items-center p-3 px-4 border-bottom ${loop.index % 2 == 0 ? 'bg-light' : 'bg-white'}">
                                <div class="fw-semibold text-dark d-flex align-items-center gap-2">
                                    <div style="width:10px;height:10px;border-radius:50%;background-color:${loop.index==0?'#e8821c':loop.index==1?'#198754':loop.index==2?'#0dcaf0':loop.index==3?'#dc3545':'#6f4e37'};"></div>
                                    ${catRow[0]}
                                </div>
                                <div class="fw-bold text-dark">
                                    <fmt:formatNumber value="${catRow[1]}" type="number" groupingUsed="true"/>đ
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center text-muted py-4">Trống.</div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<!-- ── Scripts ── -->
<c:if test="${not empty chartData}">
<script>
    (function () {
        const groupBy = '${groupBy}';
        const labels = [<c:forEach var="row" items="${chartData}" varStatus="s">
            <c:choose>
                <c:when test="${groupBy == 'month'}">'T${row[1]}/${row[0]}'</c:when>
                <c:otherwise>'<fmt:formatDate value="${row[0]}" pattern="dd/MM/yyyy"/>'</c:otherwise>
            </c:choose>${!s.last ? ',' : ''}
        </c:forEach>];
        const revenues = [<c:forEach var="row" items="${chartData}" varStatus="s">
            <c:choose>
                <c:when test="${groupBy == 'month'}">${row[2] != null ? row[2] : 0}</c:when>
                <c:otherwise>${row[1] != null ? row[1] : 0}</c:otherwise>
            </c:choose>${!s.last ? ',' : ''}
        </c:forEach>];
        const orders = [<c:forEach var="row" items="${chartData}" varStatus="s">
            <c:choose>
                <c:when test="${groupBy == 'month'}">${row[3] != null ? row[3] : 0}</c:when>
                <c:otherwise>${row[2] != null ? row[2] : 0}</c:otherwise>
            </c:choose>${!s.last ? ',' : ''}
        </c:forEach>];

        const ctx = document.getElementById('revenueChart');
        if (ctx) {
            new Chart(ctx, {
                data: {
                    labels: labels,
                    datasets: [
                        {
                            type: 'line',
                            label: 'Doanh thu (VNĐ)',
                            data: revenues,
                            borderColor: '#e8821c',
                            backgroundColor: 'rgba(232, 130, 28, 0.1)',
                            borderWidth: 3,
                            pointBackgroundColor: '#fff',
                            pointBorderColor: '#e8821c',
                            pointBorderWidth: 2,
                            pointRadius: 4,
                            pointHoverRadius: 6,
                            fill: true,
                            tension: 0.4,
                            yAxisID: 'y'
                        },
                        {
                            type: 'bar',
                            label: 'Số lượng đơn',
                            data: orders,
                            backgroundColor: 'rgba(25, 135, 84, 0.2)',
                            borderColor: 'rgba(25, 135, 84, 0.6)',
                            borderWidth: 1,
                            borderRadius: 6,
                            yAxisID: 'y1'
                        }
                    ]
                },
                options: {
                    responsive: true, maintainAspectRatio: false,
                    interaction: { mode: 'index', intersect: false },
                    plugins: {
                        legend: { position: 'top', labels: { usePointStyle: true, font: {family: 'Plus Jakarta Sans', weight:'600'} } },
                        tooltip: {
                            backgroundColor: 'rgba(26, 10, 0, 0.9)',
                            titleFont: {family: 'Plus Jakarta Sans', size: 13},
                            bodyFont: {family: 'Plus Jakarta Sans', size: 14, weight:'bold'},
                            padding: 12, cornerRadius: 8,
                            callbacks: {
                                label: function(ctx) {
                                    if(ctx.dataset.yAxisID === 'y') return ' Doanh thu: ' + ctx.parsed.y.toLocaleString('vi-VN') + 'đ';
                                    return ' Số đơn: ' + ctx.parsed.y;
                                }
                            }
                        }
                    },
                    scales: {
                        y: {
                            type: 'linear', position: 'left',
                            grid: { color: 'rgba(0,0,0,0.05)' },
                            border: { dash: [4, 4] },
                            ticks: { callback: v => (v >= 1000000 ? (v/1000000)+'M' : v >= 1000 ? (v/1000)+'K' : v) }
                        },
                        y1: {
                            type: 'linear', position: 'right',
                            grid: { drawOnChartArea: false },
                            ticks: { precision: 0 }
                        },
                        x: { grid: { display: false } }
                    }
                }
            });
        }
    })();
</script>
</c:if>

<c:if test="${not empty revenueByCategory}">
<script>
    (function () {
        const labels = [<c:forEach var="catRow" items="${revenueByCategory}" varStatus="s">'${catRow[0]}'${!s.last ? ',' : ''}</c:forEach>];
        const data = [<c:forEach var="catRow" items="${revenueByCategory}" varStatus="s">${catRow[1]}${!s.last ? ',' : ''}</c:forEach>];
        const colors = ['#e8821c', '#198754', '#0dcaf0', '#dc3545', '#6f4e37', '#ffc107', '#6610f2'];

        const ctx = document.getElementById('categoryChart');
        if (ctx) {
            new Chart(ctx, {
                type: 'doughnut',
                data: {
                    labels: labels,
                    datasets: [{
                        data: data,
                        backgroundColor: colors,
                        borderWidth: 2,
                        borderColor: '#fff',
                        hoverOffset: 8
                    }]
                },
                options: {
                    responsive: true, maintainAspectRatio: false,
                    cutout: '70%',
                    plugins: {
                        legend: { position: 'bottom', labels: { padding: 16, usePointStyle: true, font: {family: 'Plus Jakarta Sans'} } },
                        tooltip: {
                            callbacks: { label: ctx => ' ' + ctx.label + ': ' + ctx.parsed.toLocaleString('vi-VN') + 'đ' }
                        }
                    }
                }
            });
        }
    })();
</script>
</c:if>
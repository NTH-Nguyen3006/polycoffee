<%@page pageEncoding="utf-8" isELIgnored="false" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <c:set value="${pageContext.request.contextPath}" var="path" />

            <!-- TAB: Revenue (BÀI 3) -->
            <!-- Summary Cards -->
            <div class="row g-3 mb-4">
                <div class="col-md-4">
                    <div class="card border-0 shadow-sm bg-gradient"
                        style="background: linear-gradient(135deg, #11998e, #38ef7d);">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <div class="small opacity-75 mb-1">Tổng Doanh Thu</div>
                                    <div class="fs-4 fw-bold">
                                        <fmt:formatNumber value="${totalRevenue != null ? totalRevenue : 0}"
                                            type="number" groupingUsed="true" />đ
                                    </div>
                                </div>
                                <div class="opacity-50">
                                    <i class="bi bi-cash-stack" style="font-size: 2.5rem;"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card border-0 shadow-sm" style="background: linear-gradient(135deg, #4facfe, #00f2fe);">
                        <div class="card-body text-white">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <div class="small opacity-75 mb-1">Tổng Đơn Hàng</div>
                                    <div class="fs-4 fw-bold">${totalOrders != null ? totalOrders : 0} đơn</div>
                                </div>
                                <div class="opacity-50">
                                    <i class="bi bi-receipt" style="font-size: 2.5rem;"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card border-0 shadow-sm" style="background: linear-gradient(135deg, #f093fb, #f5576c);">
                        <div class="card-body text-white">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <div class="small opacity-75 mb-1">Trung Bình / Đơn</div>
                                    <div class="fs-4 fw-bold">
                                        <fmt:formatNumber value="${avgOrderValue != null ? avgOrderValue : 0}"
                                            type="number" groupingUsed="true" />đ
                                    </div>
                                </div>
                                <div class="opacity-50">
                                    <i class="bi bi-calculator" style="font-size: 2.5rem;"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Revenue Charts Row -->
            <div class="row g-4 mb-4">
                <!-- Main Revenue Chart -->
                <div class="col-lg-8">
                    <div class="card border-0 shadow-sm h-100">
                        <div
                            class="card-header d-flex justify-content-between align-items-center bg-primary text-white">
                            <span class="fw-semibold">
                                <i class="bi bi-graph-up-arrow me-2"></i>
                                Biểu đồ doanh thu theo ${groupBy == 'month' ? 'tháng' : 'ngày'}
                            </span>
                            <div class="d-flex gap-2">
                                <a href="${path}/admin/statistics?tab=revenue&from=${fromDate}&to=${toDate}&groupBy=day"
                                    class="btn btn-sm ${groupBy == 'day' ? 'btn-light' : 'btn-outline-light'}">Ngày</a>
                                <a href="${path}/admin/statistics?tab=revenue&from=${fromDate}&to=${toDate}&groupBy=month"
                                    class="btn btn-sm ${groupBy == 'month' ? 'btn-light' : 'btn-outline-light'}">Tháng</a>
                            </div>
                        </div>
                        <div class="card-body">
                            <c:choose>
                                <c:when test="${not empty chartData}">
                                    <canvas id="revenueChart" style="max-height: 380px;"></canvas>
                                </c:when>
                                <c:otherwise>
                                    <div class="text-center text-muted py-5">
                                        <i class="bi bi-graph-up fs-1 d-block mb-2 opacity-25"></i>
                                        Không có dữ liệu doanh thu trong khoảng thời gian này.
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>

                <!-- Category Distribution Chart -->
                <div class="col-lg-4">
                    <div class="card border-0 shadow-sm h-100">
                        <div class="card-header bg-info text-white fw-semibold">
                            <i class="bi bi-pie-chart-fill me-2"></i>Doanh Thu Theo Nhóm
                        </div>
                        <div class="card-body d-flex flex-column align-items-center justify-content-center">
                            <c:choose>
                                <c:when test="${not empty revenueByCategory}">
                                    <canvas id="categoryChart" style="max-width: 300px; max-height: 300px;"></canvas>
                                    <div class="mt-3 small text-muted">Phân bổ doanh thu theo danh
                                        mục</div>
                                </c:when>
                                <c:otherwise>
                                    <div class="text-center text-muted py-5">
                                        <i class="bi bi-pie-chart fs-1 d-block mb-2 opacity-25"></i>
                                        Chưa có dữ liệu nhóm.
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Data Tables Row -->
            <div class="row g-4">
                <!-- Revenue Data Table -->
                <div class="col-lg-8">
                    <c:if test="${not empty chartData}">
                        <div class="card border-0 shadow-sm h-100">
                            <div class="card-header bg-light fw-semibold">
                                <i class="bi bi-table me-2"></i>Chi tiết doanh thu chi tiết
                            </div>
                            <div class="card-body p-0 table-responsive">
                                <table class="table table-hover table-sm mb-0 align-middle">
                                    <thead class="table-light sticky-top">
                                        <tr>
                                            <th>#</th>
                                            <th>Thời gian</th>
                                            <th class="text-center">Số đơn</th>
                                            <th class="text-end">Doanh thu</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="row" items="${chartData}" varStatus="loop">
                                            <tr>
                                                <td class="text-muted">${loop.index + 1}</td>
                                                <td class="fw-semibold">
                                                    <c:choose>
                                                        <c:when test="${groupBy == 'month'}">
                                                            Tháng ${row[1]}/${row[0]}
                                                        </c:when>
                                                        <c:otherwise>
                                                            <fmt:formatDate value="${row[0]}" pattern="dd/MM/yyyy" />
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td class="text-center">
                                                    <span class="badge bg-primary">
                                                        <c:choose>
                                                            <c:when test="${groupBy == 'month'}">
                                                                ${row[3]}
                                                            </c:when>
                                                            <c:otherwise>
                                                                ${row[2]}
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </span>
                                                </td>
                                                <td class="text-end fw-bold text-success">
                                                    <c:choose>
                                                        <c:when test="${groupBy == 'month'}">
                                                            <fmt:formatNumber value="${row[2]}" type="number"
                                                                groupingUsed="true" />
                                                            đ
                                                        </c:when>
                                                        <c:otherwise>
                                                            <fmt:formatNumber value="${row[1]}" type="number"
                                                                groupingUsed="true" />
                                                            đ
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </c:if>
                </div>

                <!-- Category Revenue Table -->
                <div class="col-lg-4">
                    <c:if test="${not empty revenueByCategory}">
                        <div class="card border-0 shadow-sm h-100">
                            <div class="card-header bg-light fw-semibold">
                                <i class="bi bi-list-stars me-2"></i>Top Doanh Thu Danh Mục
                            </div>
                            <div class="card-body p-0">
                                <table class="table table-hover table-sm mb-0">
                                    <thead class="table-light">
                                        <tr>
                                            <th>Danh mục</th>
                                            <th class="text-end">Doanh thu</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="catRow" items="${revenueByCategory}">
                                            <tr>
                                                <td class="fw-medium">${catRow[0]}</td>
                                                <td class="text-end fw-bold text-info">
                                                    <fmt:formatNumber value="${catRow[1]}" type="number"
                                                        groupingUsed="true" /> đ
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>

            <c:if test="${not empty chartData}">
                <script>
                    (function () {
                        const groupBy = '${groupBy}';
                        const labels = [<c:forEach var="row" items="${chartData}" varStatus="s">
                            <c:choose>
                                <c:when test="${groupBy == 'month'}">'T${row[1]}/${row[0]}'</c:when>
                                <c:otherwise>
                                    '<fmt:formatDate value="${row[0]}" pattern="dd/MM/yyyy" />'
                                </c:otherwise>
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

                        new Chart(document.getElementById('revenueChart'), {
                            type: 'bar',
                            data: {
                                labels: labels,
                                datasets: [
                                    {
                                        label: 'Doanh thu (đ)',
                                        data: revenues,
                                        backgroundColor: 'rgba(13, 110, 253, 0.75)',
                                        borderColor: 'rgba(13, 110, 253, 1)',
                                        borderWidth: 1,
                                        borderRadius: 6,
                                        yAxisID: 'y',
                                        order: 1
                                    },
                                    {
                                        label: 'Số đơn hàng',
                                        data: orders,
                                        type: 'line',
                                        borderColor: '#f6c90e',
                                        backgroundColor: 'rgba(246,201,14,0.15)',
                                        borderWidth: 2,
                                        pointBackgroundColor: '#f6c90e',
                                        pointRadius: 4,
                                        tension: 0.4,
                                        yAxisID: 'y1',
                                        order: 0
                                    }
                                ]
                            },
                            options: {
                                responsive: true,
                                interaction: { mode: 'index', intersect: false },
                                plugins: {
                                    legend: { position: 'top' },
                                    tooltip: {
                                        callbacks: {
                                            label: function (ctx) {
                                                if (ctx.dataset.yAxisID === 'y') {
                                                    return ' Doanh thu: ' + ctx.parsed.y.toLocaleString('vi-VN') + 'đ';
                                                }
                                                return ' Đơn hàng: ' + ctx.parsed.y;
                                            }
                                        }
                                    }
                                },
                                scales: {
                                    y: {
                                        type: 'linear',
                                        position: 'left',
                                        title: { display: true, text: 'Doanh thu (đ)' },
                                        ticks: { callback: v => v.toLocaleString('vi-VN') + 'đ' }
                                    },
                                    y1: {
                                        type: 'linear',
                                        position: 'right',
                                        title: { display: true, text: 'Số đơn' },
                                        grid: { drawOnChartArea: false }
                                    }
                                },
                                animation: { duration: 1000 }
                            }
                        });
                    })();
                </script>
            </c:if>

            <c:if test="${not empty revenueByCategory}">
                <script>
                    (function () {
                        const labels = [<c:forEach var="catRow" items="${revenueByCategory}" varStatus="s">'${catRow[0]}'${!s.last ? ',' : ''}</c:forEach>];
                        const data = [<c:forEach var="catRow" items="${revenueByCategory}" varStatus="s">${catRow[1]}${!s.last ? ',' : ''}</c:forEach>];
                        const colors = ['#4facfe', '#00f2fe', '#f093fb', '#f5576c', '#11998e', '#38ef7d'];

                        new Chart(document.getElementById('categoryChart'), {
                            type: 'doughnut',
                            data: {
                                labels: labels,
                                datasets: [{
                                    data: data,
                                    backgroundColor: colors,
                                    borderWidth: 1,
                                    borderColor: '#fff'
                                }]
                            },
                            options: {
                                responsive: true,
                                maintainAspectRatio: false,
                                plugins: {
                                    legend: { position: 'bottom', labels: { boxWidth: 12, font: { size: 10 } } },
                                    tooltip: {
                                        callbacks: {
                                            label: function (ctx) {
                                                return ' ' + ctx.label + ': ' + ctx.parsed.toLocaleString('vi-VN') + 'đ';
                                            }
                                        }
                                    }
                                },
                                cutout: '60%'
                            }
                        });
                    })();
                </script>
            </c:if>
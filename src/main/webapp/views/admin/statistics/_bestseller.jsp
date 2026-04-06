<%@page pageEncoding="utf-8" isELIgnored="false" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!-- TAB: BestSeller (BÀI 2) -->
            <div class="row g-4">
                <div class="col-lg-7">
                    <div class="card border-0 shadow-sm h-100">
                        <div class="card-header bg-warning text-dark fw-semibold">
                            <i class="bi bi-trophy-fill me-2"></i>Top 5 Thức Uống Bán Chạy
                        </div>
                        <div class="card-body p-0">
                            <table class="table table-hover mb-0 align-middle">
                                <thead class="table-light">
                                    <tr>
                                        <th style="width:50px" class="text-center">Hạng</th>
                                        <th>Tên sản phẩm</th>
                                        <th class="text-center">Tổng số lượng</th>
                                        <th class="text-end">Doanh thu</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${not empty top5}">
                                            <c:forEach var="item" items="${top5}" varStatus="loop">
                                                <tr class="${loop.index == 0 ? 'table-warning' : ''}">
                                                    <td class="text-center">
                                                        <span class="text-muted fw-bold">${loop.index + 1}</span>
                                                    </td>
                                                    <td class="fw-semibold">
                                                        <i class="bi bi-cup-hot me-2 text-warning"></i>${item[0]}
                                                    </td>
                                                    <td class="text-center">
                                                        <span class="badge bg-primary">${item[1]} ly</span>
                                                    </td>
                                                    <td class="text-end fw-bold text-success">
                                                        <fmt:formatNumber value="${item[2]}" type="number"
                                                            groupingUsed="true" /> đ
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="4" class="text-center text-muted py-5">
                                                    <i class="bi bi-trophy fs-1 d-block mb-2 opacity-25"></i>
                                                    Không có dữ liệu trong khoảng thời gian này.
                                                </td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <div class="col-lg-5">
                    <div class="card border-0 shadow-sm h-100">
                        <div class="card-header bg-primary text-white fw-semibold">
                            <i class="bi bi-pie-chart-fill me-2"></i>Biểu đồ Top 5
                        </div>
                        <div class="card-body d-flex align-items-center justify-content-center">
                            <canvas id="bestsellerChart" width="400" height="350"></canvas>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Progress bars -->
            <c:if test="${not empty top5}">
                <div class="card border-0 shadow-sm mt-4">
                    <div class="card-header bg-light fw-semibold">
                        <i class="bi bi-bar-chart-steps me-2"></i>So sánh số lượng bán
                    </div>
                    <div class="card-body">
                        <c:set var="maxQty" value="${top5[0][1]}" />
                        <c:forEach var="item" items="${top5}" varStatus="loop">
                            <div class="mb-3">
                                <div class="d-flex justify-content-between align-items-center mb-1">
                                    <span class="fw-semibold small">${item[0]}</span>
                                    <span class="text-muted small">${item[1]} ly</span>
                                </div>
                                <div class="progress" style="height: 22px; border-radius: 10px;">
                                    <div class="progress-bar ${loop.index == 0 ? 'bg-warning' : loop.index == 1 ? 'bg-primary' : loop.index == 2 ? 'bg-danger' : loop.index == 3 ? 'bg-info' : 'bg-secondary'}"
                                        style="width: ${maxQty > 0 ? item[1] * 100 / maxQty : 0}%; border-radius: 10px; transition: width 1s ease;">
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </c:if>

            <c:if test="${not empty top5}">
                <script>
                    (function () {
                        const labels = [<c:forEach var="item" items="${top5}" varStatus="s">'${item[0]}'${!s.last ? ',' : ''}</c:forEach>];

                        const qtys = [<c:forEach var="item" items="${top5}" varStatus="s">${item[1]}${!s.last ? ',' : ''}</c:forEach>];

                        const colors = ['#f6c90e', '#0d6efd', '#dc3545', '#0dcaf0', '#6c757d'];

                        new Chart(document.getElementById('bestsellerChart'), {
                            type: 'doughnut',
                            data: {
                                labels: labels,
                                datasets: [{
                                    data: qtys,
                                    backgroundColor: colors,
                                    borderWidth: 2,
                                    borderColor: '#fff',
                                    hoverOffset: 12
                                }]
                            },
                            options: {
                                responsive: true,
                                plugins: {
                                    legend: { position: 'bottom', labels: { padding: 15, font: { size: 12 } } },
                                    tooltip: {
                                        callbacks: {
                                            label: function (ctx) {
                                                return ' ' + ctx.label + ': ' + ctx.parsed + ' ly';
                                            }
                                        }
                                    }
                                },
                                animation: { animateScale: true, duration: 1200 }
                            }
                        });
                    })();
                </script>
            </c:if>
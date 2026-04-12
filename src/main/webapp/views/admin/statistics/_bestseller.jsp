<%@page pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
/* ─── Rank badges ─── */
.rank-badge {
    width: 34px; height: 34px;
    border-radius: 10px;
    display: flex; align-items: center; justify-content: center;
    font-size: 0.85rem; font-weight: 800; flex-shrink: 0;
}
.rank-1 { background: linear-gradient(135deg, #f6c90e, #e6a000); color: #fff;
           box-shadow: 0 4px 12px rgba(230,160,0,0.4); }
.rank-2 { background: linear-gradient(135deg, #dee2e6, #adb5bd); color: #fff;
           box-shadow: 0 4px 10px rgba(0,0,0,0.15); }
.rank-3 { background: linear-gradient(135deg, #cd7f32, #a0522d); color: #fff;
           box-shadow: 0 4px 10px rgba(160,82,45,0.3); }
.rank-n { background: #f5f0eb; color: #999; }

/* ─── Product rows ─── */
.best-row {
    display: flex; align-items: center; gap: 14px;
    padding: 16px 0;
    border-bottom: 1px solid #f5f0eb;
    transition: background 0.2s;
}
.best-row:last-child { border-bottom: none; }
.best-row:hover { background: rgba(232,130,28,0.04); margin: 0 -20px; padding: 16px 20px; }

.best-info { flex: 1; min-width: 0; }
.best-name {
    font-weight: 700; font-size: 0.95rem; color: #1a0a00;
    white-space: nowrap; overflow: hidden; text-overflow: ellipsis;
}
.best-qty  { font-size: 0.78rem; color: #999; margin-top: 2px; }
.best-rev  {
    font-weight: 800; font-size: 1rem; color: #198754;
    flex-shrink: 0; text-align: right;
}
.best-bar-wrap { width: 100%; height: 6px; background: #f0ebe4; border-radius: 3px; margin-top: 8px; overflow: hidden; }
.best-bar {
    height: 6px; border-radius: 3px;
    transition: width 1.2s ease;
}

/* ─── Chart wrapper ─── */
.chart-card {
    background: #fff; border-radius: 20px;
    padding: 24px; border: 1px solid #f0ebe4;
    height: 100%;
    display: flex; flex-direction: column;
}
.chart-card canvas { flex: 1; }

/* ─── Summary cards ─── */
.summary-mini {
    background: #fff; border-radius: 16px;
    padding: 20px; border: 1px solid #f0ebe4;
    transition: all 0.3s; text-align: center;
}
.summary-mini:hover {
    border-color: rgba(232,130,28,0.3);
    box-shadow: 0 8px 24px rgba(107,58,31,0.08);
    transform: translateY(-3px);
}
.summary-mini .val { font-size: 1.6rem; font-weight: 800; line-height: 1; }
.summary-mini .lbl { font-size: 0.75rem; color: #999; margin-top: 4px; }
</style>

<!-- ── Summary mini cards ── -->
<c:if test="${not empty top5}">
    <div class="row g-3 mb-4">
        <div class="col-6 col-md-3">
            <div class="summary-mini">
                <div class="val" style="color:#e8821c;">
                    <c:set var="totalQty" value="0"/>
                    <c:forEach var="item" items="${top5}">
                        <c:set var="totalQty" value="${totalQty + item[1]}"/>
                    </c:forEach>
                    ${totalQty}
                </div>
                <div class="lbl">Tổng ly bán (Top 5)</div>
            </div>
        </div>
        <div class="col-6 col-md-3">
            <div class="summary-mini">
                <div class="val" style="color:#198754;font-size:1.2rem;">
                    <c:set var="totalRev" value="0"/>
                    <c:forEach var="item" items="${top5}">
                        <c:set var="totalRev" value="${totalRev + item[2]}"/>
                    </c:forEach>
                    <fmt:formatNumber value="${totalRev}" type="number" groupingUsed="true"/>đ
                </div>
                <div class="lbl">Doanh thu (Top 5)</div>
            </div>
        </div>
        <div class="col-6 col-md-3">
            <div class="summary-mini">
                <div class="val" style="color:#0d6efd;">${top5[0][0]}</div>
                <div class="lbl">🥇 Bán chạy #1</div>
            </div>
        </div>
        <div class="col-6 col-md-3">
            <div class="summary-mini">
                <div class="val" style="color:#e8821c;">${top5[0][1]} ly</div>
                <div class="lbl">Số lượng cao nhất</div>
            </div>
        </div>
    </div>
</c:if>

<!-- ── Main content ── -->
<div class="row g-4">
    <!-- Product list -->
    <div class="col-lg-7">
        <div class="card border-0 shadow-sm" style="border-radius:20px;overflow:hidden;">
            <div class="card-body p-0">
                <div class="p-4 pb-0 d-flex align-items-center gap-2 mb-1">
                    <div style="width:36px;height:36px;background:linear-gradient(135deg,#f6c90e,#e6a000);
                                border-radius:12px;display:flex;align-items:center;justify-content:center;">
                        <i class="bi bi-trophy-fill text-white" style="font-size:0.95rem;"></i>
                    </div>
                    <h5 class="fw-bold mb-0" style="color:#1a0a00;">Top 5 Thức Uống Bán Chạy</h5>
                </div>
                <div class="px-4 pb-4">
                    <c:choose>
                        <c:when test="${not empty top5}">
                            <c:set var="maxQty" value="${top5[0][1]}"/>
                            <c:forEach var="item" items="${top5}" varStatus="loop">
                                <div class="best-row">
                                    <!-- Rank -->
                                    <div class="rank-badge rank-${loop.index + 1 <= 3 ? loop.index + 1 : 'n'}">
                                        <c:choose>
                                            <c:when test="${loop.index == 0}">🥇</c:when>
                                            <c:when test="${loop.index == 1}">🥈</c:when>
                                            <c:when test="${loop.index == 2}">🥉</c:when>
                                            <c:otherwise>${loop.index + 1}</c:otherwise>
                                        </c:choose>
                                    </div>

                                    <!-- Info + bar -->
                                    <div class="best-info">
                                        <div class="best-name" title="${item[0]}">${item[0]}</div>
                                        <div class="best-qty">${item[1]} ly đã bán</div>
                                        <div class="best-bar-wrap">
                                            <div class="best-bar"
                                                 style="width:${maxQty > 0 ? item[1] * 100 / maxQty : 0}%;
                                                 background: ${loop.index == 0 ? 'linear-gradient(90deg,#f6c90e,#e6a000)' :
                                                               loop.index == 1 ? 'linear-gradient(90deg,#dee2e6,#adb5bd)' :
                                                               loop.index == 2 ? 'linear-gradient(90deg,#cd7f32,#a0522d)' :
                                                               'linear-gradient(90deg,#e8891c,#d4722a)'};">
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Revenue -->
                                    <div class="best-rev" style="font-size:0.88rem;">
                                        <fmt:formatNumber value="${item[2]}" type="number" groupingUsed="true"/>đ
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="text-center py-5">
                                <i class="bi bi-trophy fs-1 d-block mb-2 opacity-25"></i>
                                <p class="text-muted mb-0">Không có dữ liệu trong khoảng thời gian này.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>

    <!-- Doughnut chart -->
    <div class="col-lg-5">
        <div class="chart-card shadow-sm h-100">
            <div class="d-flex align-items-center gap-2 mb-3">
                <div style="width:36px;height:36px;background:linear-gradient(135deg,#e8891c,#d4722a);
                            border-radius:12px;display:flex;align-items:center;justify-content:center;">
                    <i class="bi bi-pie-chart-fill text-white" style="font-size:0.9rem;"></i>
                </div>
                <h6 class="fw-bold mb-0" style="color:#1a0a00;">Tỷ Lệ Bán Hàng</h6>
            </div>
            <c:choose>
                <c:when test="${not empty top5}">
                    <canvas id="bestsellerChart"></canvas>
                </c:when>
                <c:otherwise>
                    <div class="d-flex flex-column align-items-center justify-content-center" style="flex:1;">
                        <i class="bi bi-pie-chart fs-1 opacity-25 mb-2"></i>
                        <p class="text-muted small mb-0">Chưa có dữ liệu</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<c:if test="${not empty top5}">
<script>
(function () {
    const labels  = [<c:forEach var="item" items="${top5}" varStatus="s">'${item[0]}'${!s.last ? ',' : ''}</c:forEach>];
    const qtys    = [<c:forEach var="item" items="${top5}" varStatus="s">${item[1]}${!s.last ? ',' : ''}</c:forEach>];
    const colors  = ['#e8891c', '#f6c06e', '#3d1f00', '#d4722a', '#a05e1e'];
    const borders = ['#fff','#fff','#fff','#fff','#fff'];

    if (typeof Chart === 'undefined') {
        const script = document.createElement('script');
        script.src = 'https://cdn.jsdelivr.net/npm/chart.js@4.4/dist/chart.umd.min.js';
        script.onload = renderChart;
        document.head.appendChild(script);
    } else {
        renderChart();
    }

    function renderChart() {
        const ctx = document.getElementById('bestsellerChart');
        if (!ctx) return;
        new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: labels,
                datasets: [{
                    data: qtys,
                    backgroundColor: colors,
                    borderColor: borders,
                    borderWidth: 3,
                    hoverOffset: 14
                }]
            },
            options: {
                responsive: true,
                cutout: '62%',
                plugins: {
                    legend: {
                        position: 'bottom',
                        labels: {
                            padding: 16,
                            font: { size: 12, weight: '600', family: 'Plus Jakarta Sans' },
                            color: '#3d1f00'
                        }
                    },
                    tooltip: {
                        callbacks: {
                            label: (ctx) => ' ' + ctx.label + ': ' + ctx.parsed + ' ly'
                        }
                    }
                },
                animation: { animateScale: true, duration: 1200, easing: 'easeOutQuart' }
            }
        });
    }
})();
</script>
</c:if>
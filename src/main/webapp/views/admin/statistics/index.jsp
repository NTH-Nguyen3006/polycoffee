<%@page pageEncoding="utf-8" isELIgnored="false" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!-- Page Header -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h1 class="h3 fw-bold mb-1"><i class="bi bi-bar-chart-line me-2 text-primary"></i>Thống Kê</h1>
                    <p class="text-muted mb-0">Phân tích doanh thu và sản phẩm bán chạy theo khoảng thời gian.</p>
                </div>
            </div>

            <!-- Tab Navigation -->
            <ul class="nav nav-tabs nav-pills-custom mb-4" id="statsTabs">
                <li class="nav-item">
                    <a class="nav-link ${tab == 'bestseller' ? 'active' : ''} fw-semibold"
                        href="${pageContext.request.contextPath}/admin/statistics?tab=bestseller&from=${fromDate}&to=${toDate}">
                        <i class="bi bi-trophy me-2"></i>Top 5 Bán Chạy
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${tab == 'revenue' ? 'active' : ''} fw-semibold"
                        href="${pageContext.request.contextPath}/admin/statistics?tab=revenue&from=${fromDate}&to=${toDate}">
                        <i class="bi bi-graph-up-arrow me-2"></i>Doanh Thu
                    </a>
                </li>
            </ul>

            <!-- Date Range Filter -->
            <div class="card border-0 shadow-sm mb-4">
                <div class="card-body py-3">
                    <form action="${pageContext.request.contextPath}/admin/statistics" method="get"
                        class="row g-3 align-items-end">
                        <input type="hidden" name="tab" value="${tab}">
                        <c:if test="${tab == 'revenue'}">
                            <input type="hidden" name="groupBy" value="${groupBy}">
                        </c:if>

                        <div class="col-md-4">
                            <label class="form-label fw-semibold small text-muted">
                                <i class="bi bi-calendar-event me-1"></i>Từ ngày
                            </label>
                            <input type="date" class="form-control" name="from" value="${fromDate}" id="fromDate">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-semibold small text-muted">
                                <i class="bi bi-calendar-check me-1"></i>Đến ngày
                            </label>
                            <input type="date" class="form-control" name="to" value="${toDate}" id="toDate">
                        </div>

                        <c:if test="${tab == 'revenue'}">
                            <div class="col-md-2">
                                <label class="form-label fw-semibold small text-muted">
                                    <i class="bi bi-grid-1x2 me-1"></i>Nhóm theo
                                </label>
                                <select class="form-select" name="groupBy">
                                    <option value="day" ${groupBy=='day' ? 'selected' : '' }>Ngày</option>
                                    <option value="month" ${groupBy=='month' ? 'selected' : '' }>Tháng
                                    </option>
                                </select>
                            </div>
                        </c:if>

                        <div class="col-md-2 d-flex gap-2">
                            <button type="submit" class="btn btn-primary w-100">
                                <i class="bi bi-search me-1"></i>Xem
                            </button>
                            <a href="${pageContext.request.contextPath}/admin/statistics?tab=${tab}"
                                class="btn btn-outline-secondary">
                                <i class="bi bi-x-lg"></i>
                            </a>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Date range display badge -->
            <div class="mb-3">
                <span class="badge bg-light text-dark border">
                    <i class="bi bi-calendar3 me-1"></i>
                    ${fromDate} → ${toDate}
                </span>
            </div>

            <!-- Chart.js -->
            <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.3/dist/chart.umd.min.js"></script>

            <c:choose>
                <c:when test="${tab == 'bestseller'}">
                    <jsp:include page="_bestseller.jsp" />
                </c:when>
                <c:when test="${tab == 'revenue'}">
                    <jsp:include page="_revenue.jsp" />
                </c:when>
            </c:choose>

            <style>
                .nav-pills-custom .nav-link {
                    border-radius: 8px 8px 0 0;
                    padding: 10px 20px;
                    color: #495057;
                    border: 1px solid transparent;
                    border-bottom: none;
                    transition: all 0.2s;
                }

                .nav-pills-custom .nav-link:hover {
                    background: rgba(13, 110, 253, 0.08);
                    color: #0d6efd;
                }

                .nav-pills-custom .nav-link.active {
                    background: #fff;
                    color: #0d6efd;
                    border-color: #dee2e6 #dee2e6 #fff;
                    font-weight: 600;
                }
            </style>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${title} - PolyCoffee</title>
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background: #faf8f5;
            color: #1a0a00;
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            margin: 0;
            padding: 20px;
        }
        .result-card {
            background: #fff;
            border-radius: 24px;
            padding: 40px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.08);
            max-width: 500px;
            width: 100%;
            text-align: center;
            border: 1px solid #f0ebe4;
        }
        .icon-wrapper {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 24px;
            font-size: 36px;
        }
        .success-icon {
            background: #d1e7dd;
            color: #0f5132;
        }
        .error-icon {
            background: #f8d7da;
            color: #842029;
        }
        .title {
            font-weight: 800;
            font-size: 1.5rem;
            margin-bottom: 12px;
        }
        .message {
            color: #666;
            margin-bottom: 30px;
            font-size: 0.95rem;
        }
        .details-box {
            background: #faf8f5;
            border-radius: 12px;
            padding: 20px;
            text-align: left;
            margin-bottom: 30px;
        }
        .detail-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 12px;
            font-size: 0.9rem;
        }
        .detail-item:last-child {
            margin-bottom: 0;
        }
        .detail-label {
            color: #666;
        }
        .detail-value {
            font-weight: 700;
            color: #1a0a00;
        }
        .btn-home {
            background: linear-gradient(135deg, #e8891c, #d4722a);
            color: #fff;
            border: none;
            padding: 12px 30px;
            border-radius: 50px;
            font-weight: 700;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s;
        }
        .btn-home:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(232,137,28,0.3);
            color: #fff;
        }
    </style>
</head>
<body>

<div class="result-card">
    <c:choose>
        <c:when test="${success}">
            <div class="icon-wrapper success-icon">
                <i class="bi bi-check-lg"></i>
            </div>
            <h2 class="title">Thanh Toán Thành Công!</h2>
            <p class="message">Đơn hàng của bạn đã được xác nhận và đang được chuẩn bị.</p>
        </c:when>
        <c:otherwise>
            <div class="icon-wrapper error-icon">
                <i class="bi bi-x-lg"></i>
            </div>
            <h2 class="title text-danger">Thanh Toán Thất Bại</h2>
            <p class="message">Rất tiếc, giao dịch của bạn không thể hoàn tất hoặc đã bị hủy.</p>
        </c:otherwise>
    </c:choose>

    <div class="details-box">
        <div class="detail-item">
            <span class="detail-label">Mã đơn hàng:</span>
            <span class="detail-value">${txnRef}</span>
        </div>
        <c:if test="${not empty transactionNo && transactionNo != '0'}">
            <div class="detail-item">
                <span class="detail-label">Mã giao dịch VNPay:</span>
                <span class="detail-value">${transactionNo}</span>
            </div>
        </c:if>
        <c:if test="${not empty bankCode}">
            <div class="detail-item">
                <span class="detail-label">Ngân hàng:</span>
                <span class="detail-value">${bankCode}</span>
            </div>
        </c:if>
        <div class="detail-item">
            <span class="detail-label">Mã phản hồi:</span>
            <span class="detail-value">${responseCode}</span>
        </div>
    </div>

    <a href="${pageContext.request.contextPath}/menu" class="btn-home">
        <i class="bi bi-arrow-left me-2"></i>Tiếp tục mua hàng
    </a>
</div>

</body>
</html>

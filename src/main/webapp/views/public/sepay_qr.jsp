<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${title} - PolyCoffee</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', sans-serif; background: #faf8f5; padding-top: 50px; }
        .qr-card { max-width: 480px; margin: 0 auto; background: #fff; border-radius: 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.05); padding: 40px; text-align: center; border: 1px solid #f0ebe4; }
        .qr-img { width: 100%; max-width: 300px; border-radius: 12px; margin-bottom: 20px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); border: 4px solid #fff; }
        .amount { font-size: 2rem; font-weight: 800; color: #e8821c; margin-bottom: 10px; }
        .instruction { color: #666; font-size: 0.95rem; line-height: 1.5; margin-bottom: 20px; }
        .info-box { background: #faf8f5; border-radius: 12px; padding: 15px; margin-bottom: 20px; text-align: left; }
        .info-row { display: flex; justify-content: space-between; margin-bottom: 8px; font-size: 0.9rem; }
        .info-row:last-child { margin-bottom: 0; }
        .info-label { color: #777; font-weight: 500; }
        .info-value { color: #1a0a00; font-weight: 700; user-select: text; }
        .copy-btn { color: #0d6efd; cursor: pointer; border: none; background: none; font-size: 0.85rem; padding: 0; margin-left: 8px; font-weight: 600; }
        .btn-home { background: #1a0a00; color: #fff; padding: 12px 24px; border-radius: 50px; font-weight: 600; text-decoration: none; display: inline-block; width: 100%; transition: all 0.2s; }
        .btn-home:hover { background: #333; color: white; transform: translateY(-2px); }
        .poll-loader { font-size: 0.85rem; color: #888; margin-top: 20px; display: flex; align-items: center; justify-content: center; gap: 8px; }
    </style>
</head>
<body>

<div class="container">
    <div class="qr-card">
        <h4 class="fw-bold mb-3">Quét Mã QR Để Thanh Toán</h4>
        <p class="instruction">Vui lòng sử dụng ứng dụng ngân hàng của bạn và quét mã QR bên dưới.</p>
        
        <img src="${qrImageUrl}" alt="QR Code" class="qr-img" />

        <div class="amount"><fmt:formatNumber value="${amount}" type="number" groupingUsed="true"/>đ</div>

        <div class="info-box">
             <div class="info-row">
                 <span class="info-label">Ngân hàng:</span>
                 <span class="info-value">Vietcombank</span>
             </div>
             <div class="info-row">
                 <span class="info-label">Số tài khoản:</span>
                 <span class="info-value">1234567890</span>
             </div>
             <div class="info-row align-items-center">
                 <span class="info-label">Nội dung CK:</span>
                 <span class="info-value text-primary fs-6">
                    ${description}
                    <button class="copy-btn" onclick="copyText('${description}')"><i class="bi bi-copy"></i> Copy</button>
                 </span>
             </div>
        </div>

        <p class="text-danger fw-semibold" style="font-size: 0.9rem;">
            * Vui lòng giữ nguyên nội dung chuyển khoản để hệ thống tự động xác nhận đơn hàng!
        </p>
        
        <div class="poll-loader">
            <div class="spinner-border spinner-border-sm" role="status"></div>
            Đang chờ trạng thái thanh toán...
        </div>

        <div class="mt-4">
            <a href="${pageContext.request.contextPath}/menu" class="btn-home">Quay Lại Cửa Hàng</a>
        </div>
    </div>
</div>

<!-- Lấy thư viện Toastify -->
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/toastify-js"></script>

<script>
function copyText(text) {
    navigator.clipboard.writeText(text).then(() => {
        Toastify({ text: "Đã copy nội dung!", duration: 2000, gravity: "top", position: "center" }).showToast();
    });
}
</script>

</body>
</html>

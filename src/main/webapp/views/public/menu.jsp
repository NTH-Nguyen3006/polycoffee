<%@ page pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<style>
    /* --- CSS CHO SẢN PHẨM --- */
    .product-card {
        border: none; border-radius: 20px; transition: all 0.3s ease;
        background: #fff; height: 100%; display: flex; flex-direction: column;
        overflow: hidden;
    }
    .product-card:hover { 
        transform: translateY(-8px); 
        box-shadow: 0 15px 30px rgba(0,0,0,0.08); 
    }
    .product-img { 
        height: 200px; /* Tăng nhẹ để ảnh 800x800 hiển thị rõ hơn */
        width: 100%; 
        object-fit: contain; /* Giữ nguyên tỷ lệ ảnh 800x800 */
        padding: 15px; 
        background: #fdfdfd;
    }
    
    /* --- SỬA LẠI NÚT TÌM KIẾM --- */
    .search-container { width: 400px; }
    .search-box { 
        border-radius: 25px 0 0 25px !important; 
        border: 2px solid #eee;
        padding-left: 20px;
        transition: 0.3s;
    }
    .search-box:focus { 
        border-color: #0d6efd; 
        box-shadow: none; 
    }
    .btn-search { 
        border-radius: 0 25px 25px 0 !important; 
        padding: 0 25px;
        font-weight: 600;
        border: 2px solid #0d6efd;
    }

    /* --- NÚT THÊM (+) --- */
    .btn-add { 
        border-radius: 12px; width: 42px; height: 42px; 
        display: flex; align-items: center; justify-content: center;
        transition: 0.2s;
    }
    .btn-add:active { transform: scale(0.9); }
    
    .cart-sidebar {
        background: #fff; height: 100vh; position: fixed; right: 0; top: 0;
        border-left: 1px solid #eee; padding: 25px; display: flex; flex-direction: column;
        z-index: 1030;
    }
    .main-content { margin-right: 25%; }
    
    @media (max-width: 992px) {
        .main-content { margin-right: 0; }
        .cart-sidebar { display: none; }
        .search-container { width: 100%; }
    }
</style>

<div class="row">
    <div class="col-md-9 p-4 main-content">
        
        <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 gap-3">
            <h3 class="fw-bold m-0 text-dark">Thực đơn đồ uống</h3>
            
            <form action="${pageContext.request.contextPath}/menu" method="GET" class="search-container">
                <div class="input-group">
                    <input type="text" name="keywords" class="form-control search-box" 
                           placeholder="Tìm cà phê, trà sữa..." value="${param.keywords}">
                    <button class="btn btn-primary btn-search" type="submit">
                        <i class="fas fa-search me-2"></i>Tìm
                    </button>
                </div>
            </form>
        </div>

        <div class="row g-4">
            <c:forEach var="p" items="${productList}">
                <div class="col-xl-3 col-lg-4 col-sm-6">
                    <div class="product-card shadow-sm">
                        <div class="text-center">
                            <img src="${pageContext.request.contextPath}/uploads/${p.thumbnailUrl}" 
                                 class="product-img" alt="${p.name}"
                                 onerror="this.src='https://placehold.co/800x800?text=PolyCoffee'">
                        </div>
                        
                        <div class="p-3 flex-grow-1 d-flex flex-column">
                            <small class="text-muted mb-1" style="font-size: 10px;">
                                Mã: ${p.id.toString().length() > 8 ? p.id.toString().substring(0,8) : p.id}
                            </small>
                            <h6 class="fw-bold text-dark text-truncate" title="${p.name}">${p.name}</h6>
                            
                            <div class="d-flex justify-content-between align-items-center mt-auto pt-3">
                                <span class="text-primary fw-bold fs-5">
                                    <fmt:formatNumber value="${p.basePrice}" type="number"/>đ
                                </span>
                                <button class="btn btn-primary btn-add shadow-sm" 
                                        onclick="addToCart('${p.name}')">
                                    <i class="fas fa-plus"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <div class="col-md-3 cart-sidebar shadow-sm d-none d-lg-flex">
        <h5 class="fw-bold mb-4 mt-5"><i class="fas fa-shopping-basket me-2 text-primary"></i>Đơn hàng</h5>
        <div class="cart-content flex-grow-1 overflow-auto text-center py-5">
             <i class="fas fa-coffee fa-3x text-light mb-3"></i>
             <p class="text-muted small">Chưa có món nào được chọn.</p>
        </div>
        <div class="cart-footer pt-3 border-top mt-auto">
            <div class="d-flex justify-content-between mb-3">
                <span class="fw-bold">Tổng cộng</span>
                <span class="fw-bold text-primary fs-4">0đ</span>
            </div>
            <button class="btn btn-primary w-100 py-3 fw-bold shadow-sm" style="border-radius: 15px;">
                THANH TOÁN
            </button>
        </div>
    </div>
</div>

<script>
    function addToCart(productName) {
        // Hiển thị thông báo Toastify
        Toastify({
            text: " Đã thêm " + productName + " vào đơn hàng!",
            duration: 3000,
            gravity: "top", 
            position: "right", 
            stopOnFocus: true, 
            style: {
                background: "linear-gradient(to right, #00b09b, #96c93d)",
                borderRadius: "10px",
                fontWeight: "bold"
            },
            onClick: function(){} 
        }).showToast();
        
        // Chỗ này Bảo có thể thêm logic AJAX để lưu vào Session giỏ hàng sau nhé
    }
</script>
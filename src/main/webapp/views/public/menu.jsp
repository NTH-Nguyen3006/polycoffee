<%@ page pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"      prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"       prefix="fmt" %>

<style>
/* ─── Layout ─── */
.menu-layout { display: flex; gap: 0; min-height: calc(100vh - 80px); }
.menu-left   { flex: 1; padding: 32px 28px; overflow-y: auto; }
.cart-sidebar {
    width: 340px; flex-shrink: 0;
    background: #fff;
    border-left: 1px solid #f0ebe4;
    position: sticky; top: 80px;
    height: calc(100vh - 80px);
    display: flex; flex-direction: column;
    overflow: hidden;
}
@media (max-width: 991px) {
    .cart-sidebar { display: none; }
    .menu-left { padding: 20px; }
}

/* ─── Page title ─── */
.menu-title {
    font-size: 1.8rem; font-weight: 800; color: #1a0a00;
    display: flex; align-items: center; gap: 10px;
}

/* ─── Search ─── */
.search-wrap {
    position: relative; max-width: 380px;
}
.search-input {
    width: 100%; padding: 12px 20px 12px 46px;
    border: 2px solid #f0ebe4; border-radius: 50px;
    font-size: 0.9rem; outline: none; transition: 0.3s;
    background: #faf8f5; font-family: inherit; color: #1a0a00;
}
.search-input:focus {
    border-color: #e8821c;
    background: #fff;
    box-shadow: 0 0 0 4px rgba(232,130,28,0.1);
}
.search-icon {
    position: absolute; left: 16px; top: 50%;
    transform: translateY(-50%); color: #999; font-size: 1rem;
}

/* ─── Category tabs ─── */
.cat-tabs { display: flex; flex-wrap: wrap; gap: 8px; margin-bottom: 24px; }
.cat-tab {
    padding: 8px 18px; border-radius: 50px;
    border: 2px solid #f0ebe4;
    background: #fff; color: #666;
    font-size: 0.85rem; font-weight: 600;
    cursor: pointer; text-decoration: none;
    transition: all 0.25s;
    display: inline-flex; align-items: center; gap: 6px;
}
.cat-tab:hover {
    border-color: #e8821c; color: #e8821c; background: rgba(232,130,28,0.05);
}
.cat-tab.active {
    background: linear-gradient(135deg, #e8891c, #d4722a);
    border-color: transparent; color: #fff;
    box-shadow: 0 4px 12px rgba(232,137,28,0.35);
}

/* ─── Product Cards ─── */
.product-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(200px, 1fr)); gap: 18px; }
.product-card {
    background: #fff; border-radius: 20px;
    border: 1px solid #f0ebe4; overflow: hidden;
    transition: all 0.3s; cursor: pointer;
}
.product-card:hover {
    transform: translateY(-6px);
    box-shadow: 0 20px 40px rgba(107,58,31,0.1);
    border-color: rgba(232,137,28,0.3);
}
.product-img {
    width: 100%; height: 180px; object-fit: cover;
    background: linear-gradient(135deg, #fdf0e0, #fde8c9);
    transition: transform 0.4s;
}
.product-card:hover .product-img { transform: scale(1.05); }
.product-img-wrap { overflow: hidden; height: 180px; position: relative; }
.product-badge {
    position: absolute; top: 10px; right: 10px;
    background: linear-gradient(135deg, #e8891c, #d4722a);
    color: #fff; font-size: 10px; font-weight: 700;
    padding: 3px 9px; border-radius: 50px;
}
.product-info { padding: 14px 16px 16px; }
.product-cat   { font-size: 10px; color: #aaa; font-weight: 700; text-transform: uppercase; letter-spacing: 1px; }
.product-name  { font-size: 0.92rem; font-weight: 700; color: #1a0a00; margin: 4px 0; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
.product-price { font-size: 1.1rem; font-weight: 800; color: #e8821c; }
.btn-add-to-cart {
    width: 36px; height: 36px; border-radius: 10px;
    background: linear-gradient(135deg, #e8891c, #d4722a);
    color: #fff; border: none; font-size: 1rem;
    display: flex; align-items: center; justify-content: center;
    cursor: pointer; flex-shrink: 0; transition: all 0.2s;
}
.btn-add-to-cart:hover { transform: scale(1.1); box-shadow: 0 6px 16px rgba(232,137,28,0.45); }
.btn-add-to-cart:active { transform: scale(0.95); }

/* ─── Empty state ─── */
.empty-state { text-align: center; padding: 60px 20px; }
.empty-state i { font-size: 4rem; color: #ddd; display: block; margin-bottom: 16px; }

/* ─── Cart Sidebar ─── */
.cart-header {
    padding: 20px 24px 14px;
    border-bottom: 1px solid #f0ebe4;
    flex-shrink: 0;
}
.cart-header h5 { font-weight: 800; color: #1a0a00; font-size: 1.1rem; }
.cart-body { flex: 1; overflow-y: auto; padding: 16px 20px; }
.cart-empty {
    height: 100%; display: flex; flex-direction: column;
    align-items: center; justify-content: center;
    text-align: center; color: #ccc;
}
.cart-item {
    display: flex; gap: 12px; align-items: center;
    padding: 12px 0; border-bottom: 1px solid #f5f0eb;
    animation: slideIn 0.3s ease;
}
.cart-item-img {
    width: 54px; height: 54px; border-radius: 12px;
    object-fit: cover; flex-shrink: 0;
    background: #fdf0e0;
}
.cart-item-name  { font-size: 0.85rem; font-weight: 700; color: #1a0a00; line-height: 1.3; }
.cart-item-price { font-size: 0.82rem; color: #e8821c; font-weight: 700; margin-top: 2px; }
.qty-ctrl {
    display: flex; align-items: center; gap: 6px; margin-top: 6px;
}
.qty-btn {
    width: 26px; height: 26px; border-radius: 8px; border: none;
    background: #f0ebe4; color: #1a0a00; font-size: 1rem;
    display: flex; align-items: center; justify-content: center;
    cursor: pointer; transition: 0.2s; font-weight: 700; line-height: 1;
}
.qty-btn:hover { background: #e8821c; color: #fff; }
.qty-num { font-weight: 700; font-size: 0.9rem; min-width: 20px; text-align: center; color: #1a0a00; }
.delete-item {
    margin-left: auto; background: none; border: none;
    color: #ccc; font-size: 0.9rem; cursor: pointer;
    flex-shrink: 0; padding: 4px; transition: 0.2s;
}
.delete-item:hover { color: #dc3545; }

.cart-footer {
    padding: 16px 20px;
    border-top: 1px solid #f0ebe4;
    background: #faf8f5;
    flex-shrink: 0;
}
.cart-total-label { font-size: 0.82rem; color: #999; }
.cart-total-value { font-size: 1.5rem; font-weight: 900; color: #e8821c; line-height: 1; }
.btn-checkout {
    width: 100%; padding: 14px;
    background: linear-gradient(135deg, #e8891c, #d4722a);
    color: #fff; border: none; border-radius: 16px;
    font-weight: 800; font-size: 1rem;
    cursor: pointer; transition: all 0.3s;
    box-shadow: 0 6px 20px rgba(232,137,28,0.35);
    margin-top: 12px;
}
.btn-checkout:hover {
    transform: translateY(-2px);
    box-shadow: 0 12px 30px rgba(232,137,28,0.45);
}
.btn-checkout:disabled {
    opacity: 0.5; transform: none; cursor: not-allowed;
}

/* ─── Floating cart btn (mobile) ─── */
.float-cart-btn {
    position: fixed; bottom: 24px; right: 24px;
    width: 60px; height: 60px; border-radius: 50%;
    background: linear-gradient(135deg, #e8891c, #d4722a);
    color: #fff; border: none; font-size: 1.4rem;
    box-shadow: 0 8px 25px rgba(232,137,28,0.5);
    cursor: pointer; display: none;
    align-items: center; justify-content: center;
    z-index: 1000; transition: all 0.3s;
}
.float-cart-btn:hover { transform: scale(1.1); }
.cart-badge {
    position: absolute; top: -4px; right: -4px;
    background: #dc3545; color: #fff;
    width: 22px; height: 22px; border-radius: 50%;
    font-size: 11px; font-weight: 800;
    display: flex; align-items: center; justify-content: center;
    border: 2px solid #fff;
}

@media (max-width: 991px) {
    .float-cart-btn { display: flex; }
}

/* ─── Animations ─── */
@keyframes slideIn {
    from { opacity: 0; transform: translateX(10px); }
    to   { opacity: 1; transform: translateX(0); }
}
@keyframes pop {
    0%   { transform: scale(1); }
    50%  { transform: scale(1.3); }
    100% { transform: scale(1); }
}
.pop { animation: pop 0.3s ease; }

/* ─── Results count ─── */
.results-count {
    font-size: 0.85rem; color: #888; font-weight: 500;
    margin-bottom: 16px;
}
</style>

<div class="menu-layout">
    <!-- ═══════════ LEFT: Products ═══════════ -->
    <div class="menu-left">

        <!-- Header -->
        <div class="d-flex justify-content-between align-items-center flex-wrap gap-3 mb-4">
            <div class="menu-title">
                <i class="bi bi-cup-hot-fill" style="color:#e8821c;"></i>
                Thực Đơn
            </div>
            <div class="search-wrap">
                <i class="bi bi-search search-icon"></i>
                <input type="text" class="search-input" id="searchInput"
                       placeholder="Tìm đồ uống..." value="${keywords}"
                       autocomplete="off">
            </div>
        </div>

        <!-- Category Tabs -->
        <div class="cat-tabs" id="catTabs">
            <a href="${pageContext.request.contextPath}/menu"
               class="cat-tab ${empty selectedCat and empty keywords ? 'active' : ''}">
                <i class="bi bi-grid-3x3-gap-fill"></i>Tất cả
            </a>
            <c:forEach var="cat" items="${categories}">
                <a href="${pageContext.request.contextPath}/menu?categoryId=${cat.id}"
                   class="cat-tab ${selectedCat == cat.id ? 'active' : ''}">
                    ${cat.name}
                </a>
            </c:forEach>
        </div>

        <!-- Results count -->
        <div class="results-count" id="resultCount">
            <c:choose>
                <c:when test="${not empty productList}">
                    Hiển thị <strong>${productList.size()}</strong> sản phẩm
                    <c:if test="${not empty keywords}"> cho "<strong>${keywords}</strong>"</c:if>
                </c:when>
                <c:otherwise>Không tìm thấy sản phẩm</c:otherwise>
            </c:choose>
        </div>

        <!-- Product Grid -->
        <div class="product-grid" id="productGrid">
            <c:choose>
                <c:when test="${not empty productList}">
                    <c:forEach var="p" items="${productList}">
                        <div class="product-card"
                             data-id="${p.id}"
                             data-name="${p.name}"
                             data-price="${p.basePrice}"
                             data-img="${p.thumbnailUrl}"
                             data-cat="${not empty p.category ? p.category.name : ''}"
                             onclick="addToCart(this)">
                            <div class="product-img-wrap">
                                <c:choose>
                                    <c:when test="${not empty p.thumbnailUrl}">
                                        <img class="product-img"
                                             src="${pageContext.request.contextPath}/uploads/${p.thumbnailUrl}"
                                             alt="${p.name}"
                                             onerror="this.src='https://images.unsplash.com/photo-1509042239860-f550ce710b93?q=80&w=400&h=300&auto=format&fit=crop'">
                                    </c:when>
                                    <c:otherwise>
                                        <img class="product-img"
                                             src="https://images.unsplash.com/photo-1509042239860-f550ce710b93?q=80&w=400&h=300&auto=format&fit=crop"
                                             alt="${p.name}">
                                    </c:otherwise>
                                </c:choose>
                                <c:if test="${p.featured}">
                                    <span class="product-badge">★ Nổi bật</span>
                                </c:if>
                            </div>
                            <div class="product-info">
                                <div class="product-cat">${not empty p.category ? p.category.name : 'Đồ uống'}</div>
                                <div class="product-name" title="${p.name}">${p.name}</div>
                                <div class="d-flex justify-content-between align-items-center mt-2">
                                    <span class="product-price">
                                        <fmt:formatNumber value="${p.basePrice}" type="number" groupingUsed="true"/>đ
                                    </span>
                                    <button class="btn-add-to-cart" onclick="event.stopPropagation();addToCart(this.closest('.product-card'))">
                                        <i class="bi bi-plus-lg"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="empty-state" style="grid-column:1/-1;">
                        <i class="bi bi-search"></i>
                        <h5 style="color:#999;">Không tìm thấy sản phẩm</h5>
                        <p class="text-muted small">Thử tìm kiếm với từ khóa khác hoặc chọn danh mục khác.</p>
                        <a href="${pageContext.request.contextPath}/menu"
                           class="btn btn-outline-warning rounded-pill mt-2">
                            Xem tất cả sản phẩm
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- ═══════════ RIGHT: Cart Sidebar ═══════════ -->
    <div class="cart-sidebar" id="cartSidebar">
        <div class="cart-header">
            <h5><i class="bi bi-bag-heart-fill me-2" style="color:#e8821c;"></i>Đơn Của Bạn</h5>
            <small class="text-muted" id="cartItemCount">Giỏ trống</small>
        </div>

        <div class="cart-body" id="cartBody">
            <div class="cart-empty" id="cartEmpty">
                <i class="bi bi-cup fa-3x" style="font-size:3.5rem;margin-bottom:12px;"></i>
                <p class="mb-0" style="font-size:0.88rem;">Chưa có món nào.<br>Chọn thức uống để bắt đầu!</p>
            </div>
            <div id="cartItems"></div>
        </div>

        <div class="cart-footer">
            <div class="d-flex justify-content-between align-items-end mb-2">
                <div>
                    <div class="cart-total-label">Tổng cộng</div>
                    <div class="cart-total-value" id="cartTotal">0đ</div>
                </div>
                <button class="btn btn-sm btn-outline-secondary rounded-pill"
                        onclick="clearCart()"
                        style="font-size:11px;" id="clearBtn">
                    <i class="bi bi-trash me-1"></i>Xoá tất cả
                </button>
            </div>
            <button class="btn-checkout" id="checkoutBtn" disabled onclick="checkout()">
                <i class="bi bi-bag-check-fill me-2"></i>Đặt Hàng Ngay
            </button>
        </div>
    </div>
</div>

<!-- MOBILE FLOAT CART BUTTON -->
<button class="float-cart-btn" id="floatCartBtn" onclick="toggleMobileCart()">
    <i class="bi bi-bag-heart-fill"></i>
    <span class="cart-badge" id="floatBadge" style="display:none;">0</span>
</button>

<!-- CHECKOUT MODAL -->
<div class="modal fade" id="checkoutModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content" style="border-radius:24px;border:none;overflow:hidden;">
            <div class="modal-header border-0 p-4"
                 style="background:linear-gradient(135deg,#1a0a00,#3d1f00);">
                <h5 class="modal-title text-white fw-bold">
                    <i class="bi bi-bag-check-fill me-2" style="color:#f6c06e;"></i>Xác Nhận Đặt Hàng
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body p-4">
                <div id="modalOrderSummary" class="mb-3"></div>
                <div class="p-3 rounded-3 mb-3" style="background:#faf8f5;">
                    <div class="d-flex justify-content-between">
                        <span class="fw-bold">Tổng tiền:</span>
                        <span class="fw-bold fs-5" style="color:#e8821c;" id="modalTotal"></span>
                    </div>
                </div>
                <div>
                    <label class="fw-semibold mb-2" style="font-size:0.88rem;">Ghi chú (tuỳ chọn)</label>
                    <textarea class="form-control" id="orderNote" rows="3"
                              placeholder="VD: ít đường, nhiều đá, không sữa..."
                              style="border-radius:12px;border-color:#f0ebe4;font-size:0.88rem;"></textarea>
                </div>
            </div>
            <div class="modal-footer border-0 p-4 pt-0">
                <button type="button" class="btn btn-outline-secondary rounded-pill px-4"
                        data-bs-dismiss="modal">Hủy</button>
                <button type="button" class="btn rounded-pill px-5 fw-bold"
                        style="background:linear-gradient(135deg,#e8891c,#d4722a);color:#fff;"
                        onclick="confirmOrder()">
                    <i class="bi bi-check-circle me-1"></i>Xác Nhận
                </button>
            </div>
        </div>
    </div>
</div>

<script>
// ═══ CART STATE ═══
let cart = [];

const cp = '${pageContext.request.contextPath}';

// ─── Format currency ─────────────────────────────
function formatVND(n) {
    return n.toLocaleString('vi-VN') + 'đ';
}

// ─── Add to cart ─────────────────────────────────
function addToCart(card) {
    const id    = card.dataset.id;
    const name  = card.dataset.name;
    const price = parseInt(card.dataset.price);
    const img   = card.dataset.img || '';

    const existing = cart.find(i => i.id === id);
    if (existing) {
        existing.qty++;
    } else {
        cart.push({ id, name, price, img, qty: 1 });
    }
    renderCart();

    // Animate card
    card.classList.remove('pop');
    void card.offsetWidth;
    card.classList.add('pop');

    // Toast
    Toastify({
        text: '☕ Đã thêm ' + name + ' vào đơn!',
        duration: 2000,
        gravity: 'top', position: 'right',
        stopOnFocus: true,
        style: {
            background: 'linear-gradient(135deg, #e8891c, #d4722a)',
            borderRadius: '12px', fontWeight: '600', fontFamily: 'inherit',
            fontSize: '14px'
        }
    }).showToast();
}

// ─── Change quantity ──────────────────────────────
function changeQty(id, delta) {
    const item = cart.find(i => i.id === id);
    if (!item) return;
    item.qty += delta;
    if (item.qty <= 0) cart = cart.filter(i => i.id !== id);
    renderCart();
}

// ─── Remove item ─────────────────────────────────
function removeItem(id) {
    cart = cart.filter(i => i.id !== id);
    renderCart();
}

// ─── Clear cart ──────────────────────────────────
function clearCart() {
    if (cart.length === 0) return;
    cart = [];
    renderCart();
}

// ─── Render cart ─────────────────────────────────
function renderCart() {
    const itemsEl  = document.getElementById('cartItems');
    const emptyEl  = document.getElementById('cartEmpty');
    const totalEl  = document.getElementById('cartTotal');
    const countEl  = document.getElementById('cartItemCount');
    const checkBtn = document.getElementById('checkoutBtn');
    const badge    = document.getElementById('floatBadge');

    const totalItems = cart.reduce((s, i) => s + i.qty, 0);
    const totalPrice = cart.reduce((s, i) => s + i.price * i.qty, 0);

    totalEl.textContent  = formatVND(totalPrice);
    checkBtn.disabled    = cart.length === 0;

    if (totalItems > 0) {
        countEl.textContent  = totalItems + ' món';
        badge.style.display  = 'flex';
        badge.textContent    = totalItems > 9 ? '9+' : totalItems;
    } else {
        countEl.textContent  = 'Giỏ trống';
        badge.style.display  = 'none';
    }

    emptyEl.style.display  = cart.length === 0 ? '' : 'none';

    itemsEl.innerHTML = '';
    cart.forEach(item => {
        const imgSrc = item.img
            ? cp + '/uploads/' + item.img
            : 'https://images.unsplash.com/photo-1509042239860-f550ce710b93?q=80&w=100&h=100&auto=format&fit=crop';

        const el = document.createElement('div');
        el.className = 'cart-item';
        el.innerHTML = `
            <img class="cart-item-img" src="${imgSrc}"
                 onerror="this.src='https://images.unsplash.com/photo-1509042239860-f550ce710b93?q=80&w=100&h=100&auto=format&fit=crop'"
                 alt="${item.name}">
            <div style="flex:1;min-width:0;">
                <div class="cart-item-name">${item.name}</div>
                <div class="cart-item-price">${formatVND(item.price)}</div>
                <div class="qty-ctrl">
                    <button class="qty-btn" onclick="changeQty('${item.id}',-1)">−</button>
                    <span class="qty-num">${item.qty}</span>
                    <button class="qty-btn" onclick="changeQty('${item.id}',1)">+</button>
                    <span class="ms-auto text-muted" style="font-size:0.8rem;font-weight:700;">${formatVND(item.price * item.qty)}</span>
                </div>
            </div>
            <button class="delete-item" onclick="removeItem('${item.id}')" title="Xoá">
                <i class="bi bi-x-lg"></i>
            </button>
        `;
        itemsEl.appendChild(el);
    });
}

// ─── Checkout ────────────────────────────────────
function checkout() {
    if (cart.length === 0) return;

    const totalPrice = cart.reduce((s, i) => s + i.price * i.qty, 0);
    const summaryEl  = document.getElementById('modalOrderSummary');
    document.getElementById('modalTotal').textContent = formatVND(totalPrice);

    summaryEl.innerHTML = cart.map(i => `
        <div class="d-flex justify-content-between py-2 border-bottom" style="font-size:0.88rem;">
            <span>${i.name} <span class="badge bg-light text-dark ms-1">×${i.qty}</span></span>
            <span class="fw-semibold">${formatVND(i.price * i.qty)}</span>
        </div>
    `).join('');

    const modal = new bootstrap.Modal(document.getElementById('checkoutModal'));
    modal.show();
}

function confirmOrder() {
    // Build order note
    const note = document.getElementById('orderNote').value;
    const totalPrice = cart.reduce((s, i) => s + i.price * i.qty, 0);

    // Show success toast
    bootstrap.Modal.getInstance(document.getElementById('checkoutModal')).hide();
    Toastify({
        text: '✅ Đặt hàng thành công! Chúng tôi đang chuẩn bị đơn của bạn.',
        duration: 4000,
        gravity: 'top', position: 'center',
        stopOnFocus: true,
        style: {
            background: 'linear-gradient(135deg, #198754, #0a3622)',
            borderRadius: '14px', fontWeight: '600', fontFamily: 'inherit',
            fontSize: '14px', maxWidth: '400px'
        }
    }).showToast();

    // Clear cart after order
    cart = [];
    renderCart();
    document.getElementById('orderNote').value = '';
}

// ─── Mobile cart toggle ───────────────────────────
function toggleMobileCart() {
    const sidebar = document.getElementById('cartSidebar');
    sidebar.style.display = sidebar.style.display === 'flex' ? 'none' : 'flex';
    sidebar.style.position = 'fixed';
    sidebar.style.right = '0';
    sidebar.style.top = '0';
    sidebar.style.bottom = '0';
    sidebar.style.zIndex = '1040';
    sidebar.style.width = '320px';
}

// ─── Live search ─────────────────────────────────
let searchTimeout;
document.getElementById('searchInput').addEventListener('input', function() {
    clearTimeout(searchTimeout);
    const q = this.value.trim().toLowerCase();
    searchTimeout = setTimeout(() => {
        const cards = document.querySelectorAll('.product-card');
        let visible = 0;
        cards.forEach(card => {
            const name = card.dataset.name.toLowerCase();
            const cat  = card.dataset.cat.toLowerCase();
            const show = q === '' || name.includes(q) || cat.includes(q);
            card.style.display = show ? '' : 'none';
            if (show) visible++;
        });
        document.getElementById('resultCount').innerHTML =
            'Hiển thị <strong>' + visible + '</strong> sản phẩm' + (q ? ' cho "<strong>' + q + '</strong>"' : '');
    }, 300);
});

// Initialize
renderCart();
</script>
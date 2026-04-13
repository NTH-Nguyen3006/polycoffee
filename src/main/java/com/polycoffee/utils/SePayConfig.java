package com.polycoffee.utils;

/**
 * SePay & VietQR Configuration
 */
public class SePayConfig {

    // ── Sepay Credentials ────────────────────────────────────────────────────
    public static final String SEPAY_API_TOKEN = "YOUR_SEPAY_API_TOKEN"; // Nếu dùng gọi API

    // Header xác thực Webhook từ SePay gửi về server
    public static final String WEBHOOK_AUTHORIZATION = "YOUR_WEBHOOK_SECRET_KEY";

    // ── VietQR Configuration ─────────────────────────────────────────────────
    // Số tài khoản và ngân hàng để tạo mã tĩnh VietQR qua SePay
    public static final String ACC = "05555530062007"; // Số tài khoản ngân hàng của bạn
    public static final String BANK = "MBBank"; // Tên hoặc mã ngân hàng, Vd: MBBank, VCB

    // Template nội dung chuyển khoản prefix (Chỉ được chứa kí tự không dấu)
    public static final String PREFIX = "Polycoffee";
}

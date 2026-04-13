package com.polycoffee.utils;

/**
 * VNPay Sandbox Configuration
 * Thông tin test từ:
 * https://sandbox.vnpayment.vn/apis/docs/thanh-toan-pay/pay.html
 */
public class VNPayConfig {

    // ── Sandbox Credentials ──────────────────────────────────────────────────
    public static final String VNP_TMN_CODE = "YUQKDZLH"; // Terminal Code (sandbox demo)
    public static final String VNP_HASH_SECRET = "MF4RI2D022PNQ1PND6XSCNVUV4WHPZ6E"; // Secret Key (sandbox demo)

    // ── Endpoints ────────────────────────────────────────────────────────────
    public static final String VNP_URL = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html";
    public static final String VNP_API_URL = "https://sandbox.vnpayment.vn/merchant_webapi/api/transaction";
    public static final String VNP_VERSION = "2.1.0";
    public static final String VNP_COMMAND = "pay";
    public static final String VNP_CURR_CODE = "VND";
    public static final String VNP_LOCALE = "vn";
    public static final String VNP_ORDER_TYPE = "other";

    // ── App Callback URLs (phải khớp với domain đã đăng ký) ─────────────────
    // Chạy localhost: http://localhost:8080/polycoffee
    public static final String VNP_RETURN_URL = "http://localhost:8080/polycoffee/payment/vnpay-return";
    public static final String VNP_IPN_URL = "http://localhost:8080/polycoffee/payment/vnpay-ipn";
}

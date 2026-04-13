package com.polycoffee.utils;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Utility class cho VNPay:
 *  - Tạo chuỗi query được ký HMAC-SHA512
 *  - Verify chữ ký trên return URL / IPN
 */
public class VNPayUtil {

    // ─── Build payment URL ──────────────────────────────────────────────────
    /**
     * Tạo URL thanh toán VNPay từ các tham số đầu vào.
     *
     * @param orderId   Mã đơn hàng (unique, tối đa 8 ký tự số/chữ)
     * @param amount    Số tiền (VND, ví dụ 50000 → truyền 50000)
     * @param orderInfo Mô tả đơn hàng
     * @param ipAddress IP của khách hàng
     * @return URL redirect đến cổng VNPay
     */
    public static String buildPaymentUrl(String orderId, long amount, String orderInfo, String ipAddress) {
        Map<String, String> params = new TreeMap<>();

        String createDate = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
        String expireDate = new SimpleDateFormat("yyyyMMddHHmmss")
                .format(new Date(System.currentTimeMillis() + 15 * 60 * 1000)); // +15 phút

        params.put("vnp_Version",    VNPayConfig.VNP_VERSION);
        params.put("vnp_Command",    VNPayConfig.VNP_COMMAND);
        params.put("vnp_TmnCode",    VNPayConfig.VNP_TMN_CODE);
        params.put("vnp_Amount",     String.valueOf(amount * 100));    // VNPay nhân 100
        params.put("vnp_CurrCode",   VNPayConfig.VNP_CURR_CODE);
        params.put("vnp_TxnRef",     orderId);
        params.put("vnp_OrderInfo",  orderInfo);
        params.put("vnp_OrderType",  VNPayConfig.VNP_ORDER_TYPE);
        params.put("vnp_Locale",     VNPayConfig.VNP_LOCALE);
        params.put("vnp_ReturnUrl",  VNPayConfig.VNP_RETURN_URL);
        params.put("vnp_IpAddr",     ipAddress);
        params.put("vnp_CreateDate", createDate);
        params.put("vnp_ExpireDate", expireDate);

        // Build query string & signature
        String hashData  = buildHashData(params);
        String queryStr  = buildQueryString(params);
        String secureHash = hmacSHA512(VNPayConfig.VNP_HASH_SECRET, hashData);

        return VNPayConfig.VNP_URL + "?" + queryStr + "&vnp_SecureHash=" + secureHash;
    }

    // ─── Verify return / IPN ────────────────────────────────────────────────
    /**
     * Xác thực chữ ký trên dữ liệu trả về từ VNPay.
     *
     * @param params Toàn bộ query parameters từ request
     * @return true nếu chữ ký hợp lệ
     */
    public static boolean verifySignature(Map<String, String[]> params) {
        String receivedHash = getParam(params, "vnp_SecureHash");
        if (receivedHash == null || receivedHash.isEmpty()) return false;

        // Lọc bỏ vnp_SecureHash và vnp_SecureHashType, sắp xếp theo key
        Map<String, String> filtered = new TreeMap<>();
        for (Map.Entry<String, String[]> entry : params.entrySet()) {
            String key = entry.getKey();
            if (!"vnp_SecureHash".equals(key) && !"vnp_SecureHashType".equals(key)) {
                filtered.put(key, entry.getValue()[0]);
            }
        }

        String hashData   = buildHashData(filtered);
        String calcHash   = hmacSHA512(VNPayConfig.VNP_HASH_SECRET, hashData);
        return calcHash.equalsIgnoreCase(receivedHash);
    }

    // ─── Helpers ────────────────────────────────────────────────────────────
    /** Ghép key=value&... theo thứ tự TreeMap, dùng để hash */
    private static String buildHashData(Map<String, String> params) {
        StringBuilder sb = new StringBuilder();
        for (Map.Entry<String, String> e : params.entrySet()) {
            if (e.getValue() != null && !e.getValue().isEmpty()) {
                if (sb.length() > 0) sb.append('&');
                sb.append(e.getKey()).append('=').append(e.getValue());
            }
        }
        return sb.toString();
    }

    /** Ghép key=URLEncoded(value)&... dùng làm query string */
    private static String buildQueryString(Map<String, String> params) {
        StringBuilder sb = new StringBuilder();
        for (Map.Entry<String, String> e : params.entrySet()) {
            if (e.getValue() != null && !e.getValue().isEmpty()) {
                if (sb.length() > 0) sb.append('&');
                sb.append(encode(e.getKey())).append('=').append(encode(e.getValue()));
            }
        }
        return sb.toString();
    }

    /** HMAC-SHA512 signing */
    public static String hmacSHA512(String key, String data) {
        try {
            Mac mac = Mac.getInstance("HmacSHA512");
            mac.init(new SecretKeySpec(key.getBytes(StandardCharsets.UTF_8), "HmacSHA512"));
            byte[] bytes = mac.doFinal(data.getBytes(StandardCharsets.UTF_8));
            StringBuilder hex = new StringBuilder();
            for (byte b : bytes) hex.append(String.format("%02x", b));
            return hex.toString();
        } catch (Exception e) {
            throw new RuntimeException("HMAC-SHA512 error", e);
        }
    }

    private static String encode(String s) {
        return URLEncoder.encode(s, StandardCharsets.UTF_8);
    }

    public static String getParam(Map<String, String[]> params, String key) {
        String[] vals = params.get(key);
        return (vals != null && vals.length > 0) ? vals[0] : "";
    }
}

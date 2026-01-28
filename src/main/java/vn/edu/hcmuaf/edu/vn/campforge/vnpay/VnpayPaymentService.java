package vn.edu.hcmuaf.edu.vn.campforge.vnpay;

import jakarta.servlet.http.HttpServletRequest;

import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.*;

public class VnpayPaymentService {

    public String buildReturnUrl(HttpServletRequest req) {
        String scheme = req.getScheme();
        String host = req.getServerName();
        int port = req.getServerPort();

        StringBuilder sb = new StringBuilder();
        sb.append(scheme).append("://").append(host);

        boolean isDefaultPort = ("http".equalsIgnoreCase(scheme) && port == 80)
                || ("https".equalsIgnoreCase(scheme) && port == 443);
        if (!isDefaultPort) sb.append(":").append(port);

        sb.append(req.getContextPath()).append("/vnpay_return");
        return sb.toString();
    }

    public String createPaymentUrl(HttpServletRequest req, int orderId, BigDecimal totalVnd, String vnpTxnRef, String locale) throws UnsupportedEncodingException {
        if (totalVnd == null) totalVnd = BigDecimal.ZERO;
        if (vnpTxnRef == null || vnpTxnRef.isBlank()) vnpTxnRef = VnpayConfig.getRandomNumber(12);

        long amount = totalVnd.setScale(0, RoundingMode.HALF_UP)
                .multiply(BigDecimal.valueOf(100L))
                .longValue();

        Map<String, String> vnp_Params = new HashMap<>();
        vnp_Params.put("vnp_Version", VnpayConfig.VNP_VERSION);
        vnp_Params.put("vnp_Command", VnpayConfig.VNP_COMMAND);
        vnp_Params.put("vnp_TmnCode", VnpayConfig.VNP_TMN_CODE);
        vnp_Params.put("vnp_Amount", String.valueOf(amount));
        vnp_Params.put("vnp_CurrCode", VnpayConfig.VNP_CURR_CODE);

        vnp_Params.put("vnp_TxnRef", vnpTxnRef);
        vnp_Params.put("vnp_OrderInfo", "orderId=" + orderId);
        vnp_Params.put("vnp_OrderType", VnpayConfig.VNP_ORDER_TYPE);

        if (locale == null || locale.isBlank()) locale = VnpayConfig.VNP_DEFAULT_LOCALE;
        vnp_Params.put("vnp_Locale", locale);

        vnp_Params.put("vnp_ReturnUrl","https://stereobatic-bobbie-mockingly.ngrok-free.dev/campforge_war/vnpay_return");
        vnp_Params.put("vnp_IpAddr", VnpayConfig.getIpAddress(req));

        Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
        String vnp_CreateDate = formatter.format(cld.getTime());
        cld.add(Calendar.MINUTE, 15);
        String vnp_ExpireDate = formatter.format(cld.getTime());

        vnp_Params.put("vnp_CreateDate", vnp_CreateDate);
        vnp_Params.put("vnp_ExpireDate", vnp_ExpireDate);

        List<String> fieldNames = new ArrayList<>(vnp_Params.keySet());
        Collections.sort(fieldNames);

        StringBuilder hashData = new StringBuilder();
        StringBuilder query = new StringBuilder();
        Iterator<String> itr = fieldNames.iterator();
        while (itr.hasNext()) {
            String fieldName = itr.next();
            String fieldValue = vnp_Params.get(fieldName);
            if (fieldValue != null && !fieldValue.isEmpty()) {
                hashData.append(fieldName).append('=')
                        .append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                query.append(URLEncoder.encode(fieldName, StandardCharsets.US_ASCII.toString()))
                        .append('=')
                        .append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));

                if (itr.hasNext()) {
                    query.append('&');
                    hashData.append('&');
                }
            }
        }

        String vnp_SecureHash = VnpayConfig.hmacSHA512(VnpayConfig.VNP_HASH_SECRET, hashData.toString());
        return VnpayConfig.VNP_PAY_URL + "?" + query + "&vnp_SecureHash=" + vnp_SecureHash;
    }
}

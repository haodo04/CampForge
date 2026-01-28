package vn.edu.hcmuaf.edu.vn.campforge.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.hcmuaf.edu.vn.campforge.dao.OrderDAO;
import vn.edu.hcmuaf.edu.vn.campforge.vnpay.VnpayConfig;
import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/vnpay_return")
public class VnpayReturnServlet extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        Map<String, String> fields = new HashMap<>();
        Enumeration<String> paramNames = request.getParameterNames();
        while (paramNames.hasMoreElements()) {
            String fieldName = paramNames.nextElement();
            String fieldValue = request.getParameter(fieldName);
            if (fieldValue != null && !fieldValue.isEmpty()) {
                fields.put(fieldName, URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
            }
        }

        String vnpSecureHash = request.getParameter("vnp_SecureHash");

        fields.remove("vnp_SecureHashType");
        fields.remove("vnp_SecureHash");

        String signValue = VnpayConfig.hashAllFields(fields);
        boolean signatureOk = signValue != null && signValue.equals(vnpSecureHash);

        int orderId = parseOrderId(request.getParameter("vnp_OrderInfo"));
        boolean success = false;

        if (signatureOk && orderId > 0) {
            String responseCode = request.getParameter("vnp_ResponseCode");
            String transactionStatus = request.getParameter("vnp_TransactionStatus");
            String amountStr = request.getParameter("vnp_Amount");

            success = "00".equals(responseCode)
                    && (transactionStatus == null || transactionStatus.isBlank() || "00".equals(transactionStatus));

            if (success && amountStr != null && !amountStr.isBlank()) {
                try {
                    BigDecimal orderTotal = orderDAO.getTotalAmountById(orderId);
                    BigDecimal paid = new BigDecimal(amountStr).divide(BigDecimal.valueOf(100), 2, RoundingMode.HALF_UP);

                    if (orderTotal != null) {
                        if (orderTotal.setScale(0, RoundingMode.HALF_UP)
                                .compareTo(paid.setScale(0, RoundingMode.HALF_UP)) != 0) {
                            success = false;
                        }
                    }
                } catch (Exception ignore) { }
            }

            try {
                if (success) {
                    orderDAO.updatePaymentStatusIfPending(orderId, "PAID");
                } else {
                    orderDAO.updatePaymentStatusIfPending(orderId, "FAILED");
                }
            } catch (SQLException ignore) { }
        }

        String ctx = request.getContextPath();
        if (orderId <= 0) {
            response.sendRedirect(ctx + "/checkout?pay=invalid");
            return;
        }
        response.sendRedirect(ctx + "/checkout?paid=" + (success ? "1" : "0") + "&orderId=" + orderId);
    }

    private int parseOrderId(String orderInfo) {
        if (orderInfo == null) return -1;
        try {
            int idx = orderInfo.indexOf("orderId=");
            if (idx < 0) return -1;
            String tail = orderInfo.substring(idx + "orderId=".length());
            tail = tail.replaceAll("[^0-9].*$", "");
            if (tail.isBlank()) return -1;
            return Integer.parseInt(tail);
        } catch (Exception e) {
            return -1;
        }
    }
}

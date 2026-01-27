package vn.edu.hcmuaf.edu.vn.campforge.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.hcmuaf.edu.vn.campforge.dao.UserDAO;
import vn.edu.hcmuaf.edu.vn.campforge.model.Order;
import vn.edu.hcmuaf.edu.vn.campforge.model.User;
import vn.edu.hcmuaf.edu.vn.campforge.service.OrderService;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Collections;
import java.util.List;

@WebServlet("/personal")
public class PersonalServlet extends HttpServlet {

    private boolean isAjax(HttpServletRequest request) {
        String xrw = request.getHeader("X-Requested-With");
        String accept = request.getHeader("Accept");
        return "XMLHttpRequest".equalsIgnoreCase(xrw) || (accept != null && accept.contains("application/json"));
    }

    private String esc(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "");
    }

    private String toIso(Timestamp ts) {
        return ts == null ? "" : ts.toInstant().toString();
    }

    private String money(BigDecimal v) {
        return v == null ? "0" : v.toPlainString();
    }

    private String toViDelivery(String st) {
        if (st == null) return "";
        return switch (st) {
            case "PENDING" -> "Chờ xác nhận";
            case "DELIVERING" -> "Đang giao";
            case "COMPLETED" -> "Hoàn thành";
            case "CANCELED" -> "Đã huỷ";
            default -> st;
        };
    }

    private String toViPayment(String st) {
        if (st == null) return "";
        return switch (st) {
            case "UNPAID" -> "Chưa thanh toán";
            case "PENDING" -> "Chờ thanh toán";
            case "PAID" -> "Đã thanh toán";
            case "FAILED" -> "Thanh toán thất bại";
            case "REFUNDED" -> "Đã hoàn tiền";
            default -> st;
        };
    }

    private void writeOrdersJson(HttpServletResponse response, List<Order> orders) throws IOException {
        response.setContentType("application/json; charset=UTF-8");

        StringBuilder sb = new StringBuilder();
        sb.append("{\"ok\":true,\"orders\":[");

        for (int i = 0; i < orders.size(); i++) {
            Order o = orders.get(i);
            String rawDel = o.getDeliveryStatus();
            boolean canCancel = "PENDING".equalsIgnoreCase(rawDel);
            boolean canReview = "COMPLETED".equalsIgnoreCase(rawDel);

            sb.append("{")
                    .append("\"id\":").append(o.getId()).append(",")
                    .append("\"orderDate\":\"").append(esc(toIso(o.getOrderDate()))).append("\",")
                    .append("\"totalAmount\":\"").append(esc(money(o.getTotalAmount()))).append("\",")
                    .append("\"paymentStatus\":\"").append(esc(o.getPaymentStatus())).append("\",")
                    .append("\"deliveryStatus\":\"").append(esc(o.getDeliveryStatus())).append("\",")
                    .append("\"paymentStatusVi\":\"").append(esc(toViPayment(o.getPaymentStatus()))).append("\",")
                    .append("\"deliveryStatusVi\":\"").append(esc(toViDelivery(o.getDeliveryStatus()))).append("\",")
                    .append("\"canCancel\":").append(canCancel).append(",")
                    .append("\"canReview\":").append(canReview)
                    .append("}");

            if (i < orders.size() - 1) sb.append(",");
        }

        sb.append("]}");
        response.getWriter().write(sb.toString());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User auth = (User) request.getSession().getAttribute("auth");
        if (auth == null) {
            if (isAjax(request)) {
                response.setContentType("application/json; charset=UTF-8");
                response.setStatus(401);
                response.getWriter().write("{\"ok\":false,\"message\":\"NOT_LOGGED_IN\"}");
            } else {
                response.sendRedirect(request.getContextPath() + "/login?return=/personal");
            }
            return;
        }

        String status = request.getParameter("status");

        List<Order> orders;
        try {
            orders = OrderService.getInstance().getOrdersByUserId(auth.getId(), status);
        } catch (Exception e) {
            e.printStackTrace();
            orders = Collections.emptyList();
        }

        if (isAjax(request)) {
            writeOrdersJson(response, orders);
            return;
        }

        User userDetail = UserDAO.getUserByUsername(auth.getUsername());
        request.setAttribute("user", userDetail);
        request.setAttribute("orders", orders);

        request.getRequestDispatcher("personal.jsp").forward(request, response);
    }
}

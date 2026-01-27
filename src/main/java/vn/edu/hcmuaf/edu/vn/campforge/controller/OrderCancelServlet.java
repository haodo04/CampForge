package vn.edu.hcmuaf.edu.vn.campforge.controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.edu.hcmuaf.edu.vn.campforge.model.User;
import vn.edu.hcmuaf.edu.vn.campforge.service.OrderService;

import java.io.IOException;

@WebServlet("/order-cancel")
public class OrderCancelServlet extends HttpServlet {

    private final OrderService orderService = OrderService.getInstance();

    private boolean isAjax(HttpServletRequest request) {
        String xrw = request.getHeader("X-Requested-With");
        String accept = request.getHeader("Accept");
        return "XMLHttpRequest".equalsIgnoreCase(xrw) || (accept != null && accept.contains("application/json"));
    }

    private static String esc(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", " ").replace("\r", " ");
    }

    private int parseInt(String s, int def) {
        try {
            if (s == null || s.isBlank()) return def;
            return Integer.parseInt(s.trim());
        } catch (Exception e) {
            return def;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        User auth = (User) req.getSession().getAttribute("auth");
        if (auth == null) {
            resp.setStatus(401);
            resp.setContentType("application/json; charset=UTF-8");
            resp.getWriter().write("{\"ok\":false,\"message\":\"NOT_LOGGED_IN\"}");
            return;
        }

        int orderId = parseInt(req.getParameter("orderId"), -1);
        if (orderId <= 0) {
            resp.setStatus(400);
            resp.setContentType("application/json; charset=UTF-8");
            resp.getWriter().write("{\"ok\":false,\"message\":\"INVALID_ORDER\"}");
            return;
        }

        try {
            orderService.cancelOrder(auth.getId(), orderId);

            resp.setContentType("application/json; charset=UTF-8");
            resp.getWriter().write("{\"ok\":true,\"orderId\":" + orderId + "}");
        } catch (Exception e) {
            resp.setStatus(400);
            resp.setContentType("application/json; charset=UTF-8");
            resp.getWriter().write("{\"ok\":false,\"message\":\"" + esc(e.getMessage()) + "\"}");
        }
    }
}

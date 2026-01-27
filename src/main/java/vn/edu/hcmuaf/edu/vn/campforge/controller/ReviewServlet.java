package vn.edu.hcmuaf.edu.vn.campforge.controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.edu.hcmuaf.edu.vn.campforge.dao.OrderItemDAO;
import vn.edu.hcmuaf.edu.vn.campforge.model.ReviewItem;
import vn.edu.hcmuaf.edu.vn.campforge.model.User;
import vn.edu.hcmuaf.edu.vn.campforge.service.ReviewService;

import java.io.IOException;
import java.util.List;

@WebServlet("/review")
public class ReviewServlet extends HttpServlet {

    private final ReviewService reviewService = new ReviewService();
    private final OrderItemDAO orderItemDAO = new OrderItemDAO();

    private boolean isAjax(HttpServletRequest request) {
        String xrw = request.getHeader("X-Requested-With");
        String accept = request.getHeader("Accept");
        return "XMLHttpRequest".equalsIgnoreCase(xrw) || (accept != null && accept.contains("application/json"));
    }

    private static String esc(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", " ").replace("\r", " ");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        User auth = (User) req.getSession().getAttribute("auth");
        if (auth == null) {
            resp.setStatus(401);
            resp.setContentType("application/json; charset=UTF-8");
            resp.getWriter().write("{\"ok\":false,\"message\":\"NOT_LOGGED_IN\"}");
            return;
        }

        String action = req.getParameter("action");
        if (!"items".equalsIgnoreCase(action)) {
            resp.setStatus(400);
            resp.setContentType("application/json; charset=UTF-8");
            resp.getWriter().write("{\"ok\":false,\"message\":\"INVALID_ACTION\"}");
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
            List<ReviewItem> items = orderItemDAO.findReviewItems(orderId, auth.getId());

            StringBuilder sb = new StringBuilder();
            sb.append("{\"ok\":true,\"items\":[");
            for (int i = 0; i < items.size(); i++) {
                ReviewItem it = items.get(i);
                sb.append("{")
                        .append("\"orderItemId\":").append(it.getOrderItemId()).append(",")
                        .append("\"productId\":").append(it.getProductId()).append(",")
                        .append("\"proName\":\"").append(esc(it.getProName())).append("\",")
                        .append("\"image\":\"").append(esc(it.getImage())).append("\",")
                        .append("\"reviewed\":").append(it.isReviewed())
                        .append("}");
                if (i < items.size() - 1) sb.append(",");
            }
            sb.append("]}");

            resp.setContentType("application/json; charset=UTF-8");
            resp.getWriter().write(sb.toString());
        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(500);
            resp.setContentType("application/json; charset=UTF-8");
            String msg = e.getClass().getSimpleName() + ": " + (e.getMessage() == null ? "" : e.getMessage());
            resp.getWriter().write("{\"ok\":false,\"message\":\"" + esc(msg) + "\"}");
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

        req.setCharacterEncoding("UTF-8");

        Integer orderId = parseIntObj(req.getParameter("orderId"));
        Integer orderItemId = parseIntObj(req.getParameter("orderItemId"));
        int productId = parseInt(req.getParameter("productId"), -1);
        int rating = parseInt(req.getParameter("rating"), 0);
        String content = req.getParameter("content");

        resp.setContentType("application/json; charset=UTF-8");

        try {
            reviewService.createReview(auth.getId(), orderId, orderItemId, productId, rating, content);
            resp.getWriter().write("{\"ok\":true}");
        } catch (Exception e) {
            resp.setStatus(400);
            resp.getWriter().write("{\"ok\":false,\"message\":\"" + esc(e.getMessage()) + "\"}");
        }
    }

    private Integer parseIntObj(String s) {
        try {
            if (s == null || s.isBlank()) return null;
            int v = Integer.parseInt(s.trim());
            return (v > 0) ? v : null;
        } catch (Exception e) {
            return null;
        }
    }

    private int parseInt(String s, int def) {
        try {
            if (s == null || s.isBlank()) return def;
            return Integer.parseInt(s.trim());
        } catch (Exception e) {
            return def;
        }
    }
}

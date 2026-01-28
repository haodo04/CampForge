package vn.edu.hcmuaf.edu.vn.campforge.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.edu.hcmuaf.edu.vn.campforge.dao.OrderDAO;

import java.io.IOException;

@WebServlet("/admin/orders")
public class AdminOrderServlet extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();

    private int parseInt(String s, int def) {
        try {
            if (s == null || s.isBlank()) return def;
            return Integer.parseInt(s.trim());
        } catch (Exception e) {
            return def;
        }
    }

    private String trim(String s) {
        return s == null ? "" : s.trim();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            req.setAttribute("orders", orderDAO.findAllForAdmin(false));
            req.getRequestDispatcher("/admin/orders.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/admin/orders?error=1");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String action = trim(req.getParameter("action")).toLowerCase();

        try {
            if ("delete".equals(action)) {
                int id = parseInt(req.getParameter("id"), -1);
                if (id > 0) orderDAO.softDeleteById(id);
                resp.sendRedirect(req.getContextPath() + "/admin/orders?deleted=1");
                return;
            }

            if ("update".equals(action)) {
                int id = parseInt(req.getParameter("id"), -1);
                String paymentStatus = trim(req.getParameter("paymentStatus"));
                String deliveryStatus = trim(req.getParameter("deliveryStatus"));

                if (id > 0 && !paymentStatus.isEmpty() && !deliveryStatus.isEmpty()) {
                    orderDAO.updateStatus(id, paymentStatus, deliveryStatus);
                }
                resp.sendRedirect(req.getContextPath() + "/admin/orders?updated=1");
                return;
            }

            resp.sendRedirect(req.getContextPath() + "/admin/orders");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/admin/orders?error=1");
        }
    }
}

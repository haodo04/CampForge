package vn.edu.hcmuaf.edu.vn.campforge.controller;

import vn.edu.hcmuaf.edu.vn.campforge.dao.CartViewDAO;
import vn.edu.hcmuaf.edu.vn.campforge.model.Cart;
import vn.edu.hcmuaf.edu.vn.campforge.model.CartViewItem;
import vn.edu.hcmuaf.edu.vn.campforge.service.CartService;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.*;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    private final CartService cartService = new CartService();
    private final CartViewDAO cartViewDAO = new CartViewDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null) action = "view";

        switch (action) {
            case "add":
                add(req, resp);
                break;
            case "remove":
                remove(req, resp);
                break;
            default:
                view(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null) action = "update";

        if ("update".equals(action)) {
            update(req, resp);
        }
    }

    private void add(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int variantId = parseInt(req.getParameter("variantId"), 0);
        int qty = parseInt(req.getParameter("qty"), 1);

        Cart cart = cartService.getOrCreate(req.getSession());
        cart.add(variantId, qty);

        resp.sendRedirect(req.getContextPath() + "/cart");
    }

    private void update(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int variantId = parseInt(req.getParameter("variantId"), 0);
        int qty = parseInt(req.getParameter("qty"), 1);

        Cart cart = cartService.getOrCreate(req.getSession());
        cart.update(variantId, qty);

        resp.sendRedirect(req.getContextPath() + "/cart");
    }

    private void remove(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int variantId = parseInt(req.getParameter("variantId"), 0);

        Cart cart = cartService.getOrCreate(req.getSession());
        cart.remove(variantId);

        resp.sendRedirect(req.getContextPath() + "/cart");
    }

    private void view(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Cart cart = cartService.getOrCreate(req.getSession());

        Map<Integer, Integer> variantQty = new LinkedHashMap<>();
        cart.getItems().forEach((k, v) -> variantQty.put(k, v.getQuantity()));

        List<CartViewItem> items = cartViewDAO.getItemsByVariantIds(variantQty);
        double subtotal = items.stream().mapToDouble(CartViewItem::getLineTotal).sum();

        req.setAttribute("items", items);
        req.setAttribute("subtotal", subtotal);
        req.setAttribute("cartCount", cart.getTotalQuantity());

        req.getRequestDispatcher("/cart.jsp").forward(req, resp);
    }

    private int parseInt(String s, int def) {
        try { return Integer.parseInt(s); }
        catch (Exception e) { return def; }
    }
}

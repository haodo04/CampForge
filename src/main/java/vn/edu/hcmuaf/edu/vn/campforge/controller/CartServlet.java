package vn.edu.hcmuaf.edu.vn.campforge.controller;

import vn.edu.hcmuaf.edu.vn.campforge.dao.CartViewDAO;
import vn.edu.hcmuaf.edu.vn.campforge.model.Cart;
import vn.edu.hcmuaf.edu.vn.campforge.model.CartItem;
import vn.edu.hcmuaf.edu.vn.campforge.model.CartMiniItem;
import vn.edu.hcmuaf.edu.vn.campforge.model.CartViewItem;
import vn.edu.hcmuaf.edu.vn.campforge.service.CartService;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.edu.hcmuaf.edu.vn.campforge.utils.CartJsonBuilder;

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
            case "addAjax":
                addAjax(req, resp);
                break;
            case "remove":
                remove(req, resp);
                break;
            case "mini":
                miniCart(req, resp);
                break;
            default:
                view(req, resp);
        }
    }

    private void miniCart(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json; charset=UTF-8");
        try {
            Cart cart = cartService.getOrCreate(req.getSession());

            if (cart.getItems() == null || cart.getItems().isEmpty()) {
                resp.getWriter().write("{\"ok\":true,\"cartCount\":0,\"totalAmount\":0,\"items\":[]}");
                return;
            }

            Map<Integer, Integer> variantQty = new LinkedHashMap<>();
            cart.getItems().forEach((k, v) -> variantQty.put(k, v.getQuantity()));

            List<CartViewItem> items = cartViewDAO.getItemsByVariantIds(variantQty);
            int cartCount = cart.getItems().size();
            double total = items.stream().mapToDouble(CartViewItem::getLineTotal).sum();

            String json = CartJsonBuilder.toMiniCartJsonFromViewItems(cartCount, total, items);
            resp.getWriter().write(json);

        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().write("{\"ok\":false}");
        }
    }



    private void addAjax(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json; charset=UTF-8");

        int variantId = parseInt(req.getParameter("variantId"), 0);
        int qty = parseInt(req.getParameter("qty"), 1);

        if (variantId <= 0) {
            resp.getWriter().write("{\"ok\":false,\"message\":\"Thiếu variantId\"}");
            return;
        }

        Cart cart = cartService.getOrCreate(req.getSession());
        cart.add(variantId, qty);

        int cartCount = cart.getItems().size();

        resp.getWriter().write("{\"ok\":true,\"cartCount\":" + cartCount + "}");
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

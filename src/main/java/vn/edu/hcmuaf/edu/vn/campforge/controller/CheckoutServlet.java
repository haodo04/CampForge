package vn.edu.hcmuaf.edu.vn.campforge.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import vn.edu.hcmuaf.edu.vn.campforge.dao.CartViewDAO;
import vn.edu.hcmuaf.edu.vn.campforge.model.Cart;
import vn.edu.hcmuaf.edu.vn.campforge.model.CartItem;
import vn.edu.hcmuaf.edu.vn.campforge.model.CartViewItem;
import vn.edu.hcmuaf.edu.vn.campforge.service.CartService;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    private final CartService cartService = new CartService();
    private final CartViewDAO cartViewDAO = new CartViewDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Cart cart = cartService.getOrCreate(request.getSession());
        request.setAttribute("cartCount", cart.getTotalQuantity());

        List<CartItem> cartItems = (List<CartItem>) cart.getItems();
        if (cartItems == null || cartItems.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        Map<Integer, Integer> variantQtyMap = new LinkedHashMap<>();
        for (CartItem ci : cartItems) {
            int vid = ci.getVariantId();
            int qty = ci.getQuantity();
            variantQtyMap.put(vid, variantQtyMap.getOrDefault(vid, 0) + qty);
        }

        List<CartViewItem> items = cartViewDAO.getItemsByVariantIds(variantQtyMap);

        BigDecimal subtotal = BigDecimal.ZERO;
        for (CartViewItem it : items) {
            BigDecimal price = BigDecimal.valueOf(it.getUnitPrice());
            BigDecimal qty = BigDecimal.valueOf(it.getQuantity());
            subtotal = subtotal.add(price.multiply(qty));
        }

        BigDecimal discount = BigDecimal.ZERO;
        BigDecimal shippingDefault = BigDecimal.valueOf(100000);
        BigDecimal total = subtotal.add(shippingDefault).subtract(discount);

        request.setAttribute("items", items);
        request.setAttribute("subtotal", subtotal);
        request.setAttribute("discount", discount);
        request.setAttribute("shippingFee", shippingDefault);
        request.setAttribute("total", total);

        request.getRequestDispatcher("/checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/checkout");
    }
}

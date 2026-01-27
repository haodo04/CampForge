package vn.edu.hcmuaf.edu.vn.campforge.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.hcmuaf.edu.vn.campforge.dao.CartViewDAO;
import vn.edu.hcmuaf.edu.vn.campforge.model.Cart;
import vn.edu.hcmuaf.edu.vn.campforge.model.CartItem;
import vn.edu.hcmuaf.edu.vn.campforge.model.CartViewItem;
import vn.edu.hcmuaf.edu.vn.campforge.model.User;
import vn.edu.hcmuaf.edu.vn.campforge.service.CartService;
import vn.edu.hcmuaf.edu.vn.campforge.service.CheckoutService;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    private final CartService cartService = new CartService();
    private final CartViewDAO cartViewDAO = new CartViewDAO();
    private final CheckoutService checkoutService = new CheckoutService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Cart cart = cartService.getOrCreate(request.getSession());
        request.setAttribute("cartCount", cart.getTotalQuantity());

        Map<Integer, Integer> variantQtyMap = buildVariantQtyMap(cart);

        if (variantQtyMap.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        List<CartViewItem> items = cartViewDAO.getItemsByVariantIds(variantQtyMap);

        BigDecimal subtotal = BigDecimal.ZERO;
        for (CartViewItem it : items) {
            BigDecimal price = BigDecimal.valueOf(it.getUnitPrice());
            BigDecimal qty = BigDecimal.valueOf(it.getQuantity());
            subtotal = subtotal.add(price.multiply(qty));
        }

        BigDecimal discount = BigDecimal.ZERO;
        BigDecimal shippingDefault = BigDecimal.ZERO;
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

        request.setCharacterEncoding("UTF-8");

        boolean isAjax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"))
                || (request.getHeader("Accept") != null && request.getHeader("Accept").contains("application/json"));

        try {
            Cart cart = cartService.getOrCreate(request.getSession());

            if (cart == null || cart.getItems() == null || cart.getItems().isEmpty()) {
                if (isAjax) {
                    writeJson(response, 400, "{\"ok\":false,\"message\":\"Giỏ hàng trống\"}");
                } else {
                    response.sendRedirect(request.getContextPath() + "/cart");
                }
                return;
            }

            String receiverName = safe(request.getParameter("receiver_name"));
            String phone = safe(request.getParameter("phone"));
            String email = safe(request.getParameter("email"));
            String addressLine = safe(request.getParameter("address_line"));
            String ward = safe(request.getParameter("ward"));
            String district = safe(request.getParameter("district"));
            String province = safe(request.getParameter("province"));
            String note = safe(request.getParameter("note"));

            BigDecimal shippingFee = parseMoney(request.getParameter("shipping"), BigDecimal.ZERO);
            String paymentMethod = safe(request.getParameter("payment"));
            if (paymentMethod.isEmpty()) paymentMethod = "COD";

            if (receiverName.isEmpty() || phone.isEmpty() || addressLine.isEmpty()) {
                if (isAjax) {
                    writeJson(response, 400,
                            "{\"ok\":false,\"message\":\"Vui lòng nhập đầy đủ Họ tên / SĐT / Địa chỉ chi tiết.\"}");
                } else {
                    request.setAttribute("checkoutError", "Vui lòng nhập đầy đủ Họ tên / SĐT / Địa chỉ chi tiết.");
                    doGet(request, response);
                }
                return;
            }

            HttpSession session = request.getSession();
            User auth = (User) session.getAttribute("auth");
            Integer userId = (auth != null) ? auth.getId() : null;

            int orderId = checkoutService.placeOrder(
                    cart, userId,
                    receiverName, phone, email,
                    addressLine, ward, district, province, note,
                    shippingFee, paymentMethod
            );

            request.getSession().removeAttribute(CartService.SESSION_CART_KEY);

            if (isAjax) {
                writeJson(response, 200, "{\"ok\":true,\"orderId\":" + orderId + "}");
            } else {
                response.sendRedirect(request.getContextPath() + "/order-success?orderId=" + orderId);
            }

        } catch (Exception ex) {
            ex.printStackTrace();

            if (isAjax) {
                String msg = escapeJson(ex.getMessage() == null ? "Đặt hàng thất bại" : ex.getMessage());
                writeJson(response, 500, "{\"ok\":false,\"message\":\"" + msg + "\"}");
            } else {
                request.setAttribute("checkoutError", "Không thể đặt hàng lúc này. Vui lòng thử lại.");
                doGet(request, response);
            }
        }
    }


private Map<Integer, Integer> buildVariantQtyMap(Cart cart) {
        Map<Integer, Integer> variantQtyMap = new LinkedHashMap<>();
        if (cart == null || cart.getItems() == null) return variantQtyMap;

        Object itemsObj = cart.getItems();

        if (itemsObj instanceof Map<?, ?> map) {
            for (var e : map.entrySet()) {
                Object k = e.getKey();
                Object v = e.getValue();

                if (k instanceof Number && v instanceof Number) {
                    int vid = ((Number) k).intValue();
                    int qty = ((Number) v).intValue();
                    variantQtyMap.put(vid, variantQtyMap.getOrDefault(vid, 0) + qty);
                }
                else if (v instanceof CartItem ci) {
                    int vid = ci.getVariantId();
                    int qty = ci.getQuantity();
                    variantQtyMap.put(vid, variantQtyMap.getOrDefault(vid, 0) + qty);
                }
            }
        }

        return variantQtyMap;
    }

    private static String safe(String s) {
        return s == null ? "" : s.trim();
    }

    private static BigDecimal parseMoney(String s, BigDecimal def) {
        try {
            if (s == null || s.isBlank()) return def;
            return new BigDecimal(s.trim());
        } catch (Exception e) {
            return def;
        }
    }

    private static void writeJson(HttpServletResponse response, int status, String json) throws IOException {
        response.setStatus(status);
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");
        response.getWriter().write(json);
    }

    private static String escapeJson(String s) {
        return s.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", " ")
                .replace("\r", " ");
    }
}

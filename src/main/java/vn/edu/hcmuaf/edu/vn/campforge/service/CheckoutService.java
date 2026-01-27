package vn.edu.hcmuaf.edu.vn.campforge.service;

import vn.edu.hcmuaf.edu.vn.campforge.dao.CartViewDAO;
import vn.edu.hcmuaf.edu.vn.campforge.dao.OrderDAO;
import vn.edu.hcmuaf.edu.vn.campforge.dao.OrderItemDAO;
import vn.edu.hcmuaf.edu.vn.campforge.dao.OrderShippingInfoDAO;
import vn.edu.hcmuaf.edu.vn.campforge.dao.db.DbConnect;
import vn.edu.hcmuaf.edu.vn.campforge.model.Cart;
import vn.edu.hcmuaf.edu.vn.campforge.model.CartItem;
import vn.edu.hcmuaf.edu.vn.campforge.model.CartViewItem;

import java.math.BigDecimal;
import java.sql.Connection;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class CheckoutService {

    private final CartViewDAO cartViewDAO = new CartViewDAO();
    private final OrderDAO orderDAO = new OrderDAO();
    private final OrderShippingInfoDAO shippingDAO = new OrderShippingInfoDAO();
    private final OrderItemDAO orderItemDAO = new OrderItemDAO();

    public int placeOrder(
            Cart cart,
            Integer userId,
            String receiverName,
            String phone,
            String email,
            String addressLine,
            String ward,
            String district,
            String province,
            String note,
            BigDecimal shippingFee,
            String paymentMethod
    ) throws Exception {

        if (cart == null || cart.isEmpty()) throw new IllegalStateException("Giỏ hàng trống");
        if (receiverName == null || receiverName.isBlank()) throw new IllegalArgumentException("Thiếu họ tên");
        if (phone == null || phone.isBlank()) throw new IllegalArgumentException("Thiếu số điện thoại");
        if (addressLine == null || addressLine.isBlank()) throw new IllegalArgumentException("Thiếu địa chỉ");

        Map<Integer, Integer> variantQtyMap = new LinkedHashMap<>();
        for (CartItem ci : cart.getItems().values()) {
            int vid = ci.getVariantId();
            int qty = ci.getQuantity();
            variantQtyMap.put(vid, variantQtyMap.getOrDefault(vid, 0) + qty);
        }

        if (variantQtyMap.isEmpty()) throw new IllegalStateException("Giỏ hàng trống");

        List<CartViewItem> items = cartViewDAO.getItemsByVariantIds(variantQtyMap);
        if (items == null || items.isEmpty()) throw new IllegalStateException("Không lấy được dữ liệu giỏ hàng");

        BigDecimal subtotal = BigDecimal.ZERO;
        for (CartViewItem it : items) {
            if (it.getQuantity() > it.getStock()) {
                throw new IllegalStateException("Sản phẩm \"" + it.getProName() + "\" vượt tồn kho");
            }
            subtotal = subtotal.add(
                    BigDecimal.valueOf(it.getUnitPrice()).multiply(BigDecimal.valueOf(it.getQuantity()))
            );
        }

        BigDecimal discount = BigDecimal.ZERO;
        BigDecimal ship = (shippingFee == null ? BigDecimal.ZERO : shippingFee);
        BigDecimal total = subtotal.add(ship).subtract(discount);

        String payMethod = (paymentMethod == null || paymentMethod.isBlank()) ? "COD" : paymentMethod.trim();

        String paymentStatus = payMethod.equalsIgnoreCase("COD") ? "UNPAID" : "PENDING";
        String deliveryStatus = "PENDING";

        int orderId;
        try (Connection conn = DbConnect.getConnection()) {
            conn.setAutoCommit(false);
            try {
                orderId = orderDAO.insertOrder(
                        conn,
                        userId,
                        subtotal, ship, discount, total,
                        payMethod,
                        paymentStatus,
                        deliveryStatus,
                        null,
                        null
                );

                shippingDAO.insert(conn, orderId,
                        receiverName, phone, email,
                        addressLine, ward, district, province,
                        note
                );

                orderItemDAO.insertBatch(conn, orderId, items);

                conn.commit();
            } catch (Exception ex) {
                conn.rollback();
                throw ex;
            }
        }

        return orderId;
    }
}

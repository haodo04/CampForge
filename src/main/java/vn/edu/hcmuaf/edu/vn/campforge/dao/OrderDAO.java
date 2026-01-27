package vn.edu.hcmuaf.edu.vn.campforge.dao;

import vn.edu.hcmuaf.edu.vn.campforge.dao.db.DbConnect;
import vn.edu.hcmuaf.edu.vn.campforge.model.Order;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    public int insertOrder(Connection conn,
                           Integer userId,
                           BigDecimal subtotal,
                           BigDecimal shippingFee,
                           BigDecimal voucherDiscount,
                           BigDecimal total,
                           String paymentMethod,
                           String paymentStatus,
                           String deliveryStatus,
                           String vnpTxnRef,
                           Integer voucherId) throws SQLException {

        String sql = """
            INSERT INTO orders
              (user_id, order_date, subtotal_amount, shipping_fee, voucher_discount, total_amount,
               payment_method, payment_status, delivery_status, delivery_date, vnp_txn_ref, voucher_id, is_delete, updated_at)
            VALUES
              (?, NOW(), ?, ?, ?, ?, ?, ?, ?, NULL, ?, ?, 0, NOW())
        """;

        try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            if (userId == null) ps.setNull(1, Types.INTEGER);
            else ps.setInt(1, userId);

            ps.setBigDecimal(2, subtotal);
            ps.setBigDecimal(3, shippingFee);
            ps.setBigDecimal(4, voucherDiscount);
            ps.setBigDecimal(5, total);

            ps.setString(6, paymentMethod);
            ps.setString(7, paymentStatus);
            ps.setString(8, deliveryStatus);

            if (vnpTxnRef == null || vnpTxnRef.isBlank()) ps.setNull(9, Types.VARCHAR);
            else ps.setString(9, vnpTxnRef);

            if (voucherId == null) ps.setNull(10, Types.INTEGER);
            else ps.setInt(10, voucherId);

            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) return rs.getInt(1);
            }
        }

        throw new SQLException("Insert orders failed: no generated key");
    }

    public List<Order> findByUserId(int userId, String deliveryStatus) throws SQLException {
        List<Order> list = new ArrayList<>();

        StringBuilder sql = new StringBuilder("""
        SELECT
            id, user_id, order_date,
            subtotal_amount, shipping_fee, voucher_discount, total_amount,
            payment_method, payment_status, delivery_status,
            delivery_date, vnp_txn_ref, voucher_id,
            is_delete, updated_at
        FROM orders
        WHERE user_id = ? AND is_delete = 0
    """);

        boolean hasStatus = deliveryStatus != null && !deliveryStatus.isBlank();
        if (hasStatus) {
            sql.append(" AND delivery_status = ? ");
        }
        sql.append(" ORDER BY order_date DESC ");

        try (Connection conn = DbConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            ps.setInt(1, userId);
            if (hasStatus) ps.setString(2, deliveryStatus.trim());

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order o = new Order();
                    o.setId(rs.getInt("id"));
                    o.setUserId((Integer) rs.getObject("user_id"));
                    o.setOrderDate(rs.getTimestamp("order_date"));

                    o.setSubtotalAmount(rs.getBigDecimal("subtotal_amount"));
                    o.setShippingFee(rs.getBigDecimal("shipping_fee"));
                    o.setVoucherDiscount(rs.getBigDecimal("voucher_discount"));
                    o.setTotalAmount(rs.getBigDecimal("total_amount"));

                    o.setPaymentMethod(rs.getString("payment_method"));
                    o.setPaymentStatus(rs.getString("payment_status"));
                    o.setDeliveryStatus(rs.getString("delivery_status"));

                    o.setDeliveryDate(rs.getTimestamp("delivery_date"));
                    o.setVnpTxnRef(rs.getString("vnp_txn_ref"));
                    o.setVoucherId((Integer) rs.getObject("voucher_id"));

                    o.setDelete(rs.getInt("is_delete") == 1);
                    o.setUpdatedAt(rs.getTimestamp("updated_at"));

                    list.add(o);
                }
            }
        }

        return list;
    }

}

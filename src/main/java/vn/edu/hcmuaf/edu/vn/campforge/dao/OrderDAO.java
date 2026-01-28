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

    public boolean isCompletedOrderOfUser(int orderId, int userId) throws java.sql.SQLException {
        String sql = "SELECT 1 FROM orders WHERE id=? AND user_id=? AND delivery_status='COMPLETED' AND is_delete=0 LIMIT 1";
        try (java.sql.Connection c = vn.edu.hcmuaf.edu.vn.campforge.dao.db.DbConnect.getConnection();
             java.sql.PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ps.setInt(2, userId);
            try (java.sql.ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }
    public boolean cancelOrderIfPending(int orderId, int userId) throws SQLException {
        String sql = """
        UPDATE orders
        SET delivery_status = 'CANCELED', updated_at = NOW()
        WHERE id = ?
          AND user_id = ?
          AND delivery_status = 'PENDING'
          AND is_delete = 0
    """;

        try (Connection c = DbConnect.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        }
    }

    public List<Order> findAllForAdmin(boolean includeDeleted) throws SQLException {
        List<Order> list = new ArrayList<>();

        String sql = """
        SELECT
            id, user_id, order_date,
            subtotal_amount, shipping_fee, voucher_discount, total_amount,
            payment_method, payment_status, delivery_status,
            delivery_date, vnp_txn_ref, voucher_id,
            is_delete, updated_at
        FROM orders
        WHERE (? = 1 OR is_delete = 0)
        ORDER BY order_date DESC, id DESC
    """;

        try (Connection conn = DbConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, includeDeleted ? 1 : 0);

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

    public boolean softDeleteById(int orderId) throws SQLException {
        String sql = "UPDATE orders SET is_delete = 1, updated_at = NOW() WHERE id = ? AND is_delete = 0";
        try (Connection c = DbConnect.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            return ps.executeUpdate() > 0;
        }
    }

    public boolean updateStatus(int orderId, String paymentStatus, String deliveryStatus) throws SQLException {
        String sql = """
        UPDATE orders
        SET payment_status = ?,
            delivery_status = ?,
            delivery_date = CASE
                WHEN ? = 'COMPLETED' AND delivery_date IS NULL THEN NOW()
                ELSE delivery_date
            END,
            updated_at = NOW()
        WHERE id = ? AND is_delete = 0
    """;

        try (Connection c = DbConnect.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, paymentStatus);
            ps.setString(2, deliveryStatus);
            ps.setString(3, deliveryStatus);
            ps.setInt(4, orderId);
            return ps.executeUpdate() > 0;
        }
    }



    public BigDecimal getTotalAmountById(int orderId) throws SQLException {
        String sql = "SELECT total_amount FROM orders WHERE id = ? AND is_delete = 0";
        try (Connection c = DbConnect.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getBigDecimal("total_amount");
                return null;
            }
        }
    }

    public void updatePaymentStatusIfPending(int orderId, String paymentStatus) throws SQLException {
        String sql = """
        UPDATE orders
        SET payment_status = ?, updated_at = NOW()
        WHERE id = ?
          AND payment_status = 'PENDING'
          AND is_delete = 0
    """;
        try (Connection c = DbConnect.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, paymentStatus);
            ps.setInt(2, orderId);
            ps.executeUpdate();
        }
    }

}

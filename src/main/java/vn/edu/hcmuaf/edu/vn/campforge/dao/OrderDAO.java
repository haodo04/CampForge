package vn.edu.hcmuaf.edu.vn.campforge.dao;

import java.math.BigDecimal;
import java.sql.*;

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
}

package vn.edu.hcmuaf.edu.vn.campforge.dao;

import vn.edu.hcmuaf.edu.vn.campforge.model.CartViewItem;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

public class OrderItemDAO {

    public void insertBatch(Connection conn, int orderId, List<CartViewItem> items) throws SQLException {
        String sql = """
            INSERT INTO order_items (order_id, variant_id, unit_price, quantity)
            VALUES (?, ?, ?, ?)
        """;

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            for (CartViewItem it : items) {
                ps.setInt(1, orderId);
                ps.setInt(2, it.getVariantId());

                BigDecimal price = BigDecimal.valueOf(it.getUnitPrice()).setScale(2, RoundingMode.HALF_UP);
                ps.setBigDecimal(3, price);

                ps.setInt(4, it.getQuantity());
                ps.addBatch();
            }
            ps.executeBatch();
        }
    }
}

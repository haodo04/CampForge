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

    public java.util.List<vn.edu.hcmuaf.edu.vn.campforge.model.ReviewItem> findReviewItems(int orderId, int userId)
            throws java.sql.SQLException {

        String sql = """
    SELECT 
        oi.id AS order_item_id,
        p.id AS product_id,
        p.proName AS pro_name,

        img.path AS image,

        CASE WHEN r.id IS NULL THEN 0 ELSE 1 END AS reviewed
    FROM orders o
    JOIN order_items oi ON oi.order_id = o.id

    JOIN product_variants pv ON pv.id = oi.variant_id
    JOIN products p ON p.id = pv.product_id

    LEFT JOIN (
        SELECT product_id, MIN(path) AS path
        FROM product_imgs
        GROUP BY product_id
    ) img ON img.product_id = p.id

    LEFT JOIN product_reviews r
      ON r.order_item_id = oi.id
     AND r.user_id = o.user_id
     AND r.is_delete = 0

    WHERE o.id = ?
      AND o.user_id = ?
      AND o.delivery_status = 'COMPLETED'
      AND o.is_delete = 0
""";
        java.util.List<vn.edu.hcmuaf.edu.vn.campforge.model.ReviewItem> list = new java.util.ArrayList<>();
        try (var c = vn.edu.hcmuaf.edu.vn.campforge.dao.db.DbConnect.getConnection();
             var ps = c.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ps.setInt(2, userId);

            try (var rs = ps.executeQuery()) {
                while (rs.next()) {
                    var it = new vn.edu.hcmuaf.edu.vn.campforge.model.ReviewItem();
                    it.setOrderItemId(rs.getInt("order_item_id"));
                    it.setProductId(rs.getInt("product_id"));
                    it.setProName(rs.getString("pro_name"));
                    it.setImage(rs.getString("image"));
                    it.setReviewed(rs.getInt("reviewed") == 1);
                    list.add(it);
                }
            }
        }
        return list;
    }

    public java.util.List<vn.edu.hcmuaf.edu.vn.campforge.model.EligibleReviewTarget>
    findEligibleReviewTargets(int userId, int productId) throws java.sql.SQLException {

        String sql = """
        SELECT
            o.id AS order_id,
            oi.id AS order_item_id,
            o.order_date
        FROM orders o
        JOIN order_items oi ON oi.order_id = o.id
        JOIN product_variants pv ON pv.id = oi.variant_id
        WHERE o.user_id = ?
          AND o.delivery_status = 'COMPLETED'
          AND o.is_delete = 0
          AND pv.product_id = ?
          AND NOT EXISTS (
              SELECT 1 FROM product_reviews r
              WHERE r.user_id = o.user_id
                AND r.order_item_id = oi.id
                AND r.is_delete = 0
          )
        ORDER BY o.order_date DESC
    """;

        java.util.List<vn.edu.hcmuaf.edu.vn.campforge.model.EligibleReviewTarget> list = new java.util.ArrayList<>();
        try (var c = vn.edu.hcmuaf.edu.vn.campforge.dao.db.DbConnect.getConnection();
             var ps = c.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            try (var rs = ps.executeQuery()) {
                while (rs.next()) {
                    var t = new vn.edu.hcmuaf.edu.vn.campforge.model.EligibleReviewTarget();
                    t.setOrderId(rs.getInt("order_id"));
                    t.setOrderItemId(rs.getInt("order_item_id"));
                    t.setOrderDate(rs.getTimestamp("order_date"));
                    list.add(t);
                }
            }
        }
        return list;
    }


}

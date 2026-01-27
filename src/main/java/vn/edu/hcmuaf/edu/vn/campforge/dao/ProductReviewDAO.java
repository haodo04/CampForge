package vn.edu.hcmuaf.edu.vn.campforge.dao;

import vn.edu.hcmuaf.edu.vn.campforge.dao.db.DbConnect;
import vn.edu.hcmuaf.edu.vn.campforge.model.ProductReview;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductReviewDAO {

    public boolean existsByUserAndOrderItem(int userId, int orderItemId) throws SQLException {
        String sql = "SELECT 1 FROM product_reviews WHERE user_id=? AND order_item_id=? AND is_delete=0 LIMIT 1";
        try (Connection c = DbConnect.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, orderItemId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    public int insert(ProductReview r) throws SQLException {
        String sql = """
            INSERT INTO product_reviews(user_id, product_id, order_id, order_item_id, rating, content, is_delete, created_at)
            VALUES(?,?,?,?,?,?,0,NOW())
        """;
        try (Connection c = DbConnect.getConnection();
             PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, r.getUserId());
            ps.setInt(2, r.getProductId());
            if (r.getOrderId() == null) ps.setNull(3, Types.INTEGER);
            else ps.setInt(3, r.getOrderId());
            if (r.getOrderItemId() == null) ps.setNull(4, Types.INTEGER);
            else ps.setInt(4, r.getOrderItemId());
            ps.setInt(5, r.getRating());

            if (r.getContent() == null || r.getContent().isBlank()) ps.setNull(6, Types.VARCHAR);
            else ps.setString(6, r.getContent().trim());

            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) return rs.getInt(1);
            }
        }
        throw new SQLException("Insert review failed: no key");
    }

    public List<ProductReview> findByProductId(int productId, int limit, int offset) throws SQLException {
        String sql = """
            SELECT r.id, r.user_id, r.product_id, r.order_id, r.order_item_id, r.rating, r.content, r.created_at,
                   u.fullName as full_name
            FROM product_reviews r
            JOIN users u ON u.id = r.user_id
            WHERE r.product_id=? AND r.is_delete=0
            ORDER BY r.created_at DESC
            LIMIT ? OFFSET ?
        """;

        List<ProductReview> list = new ArrayList<>();
        try (Connection c = DbConnect.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ps.setInt(2, limit);
            ps.setInt(3, offset);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ProductReview r = new ProductReview();
                    r.setId(rs.getInt("id"));
                    r.setUserId(rs.getInt("user_id"));
                    r.setProductId(rs.getInt("product_id"));
                    r.setOrderId(rs.getInt("order_id"));
                    r.setOrderItemId(rs.getInt("order_item_id"));
                    r.setRating(rs.getInt("rating"));
                    r.setContent(rs.getString("content"));
                    r.setCreatedAt(rs.getTimestamp("created_at"));
                    r.setUserFullName(rs.getString("full_name"));
                    list.add(r);
                }
            }
        }
        return list;
    }

    public double getAvgRating(int productId) throws SQLException {
        String sql = "SELECT AVG(rating) AS avg_rating FROM product_reviews WHERE product_id=? AND is_delete=0";
        try (Connection c = DbConnect.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, productId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getDouble("avg_rating");
            }
        }
        return 0.0;
    }

    public int countByProductId(int productId) throws SQLException {
        String sql = "SELECT COUNT(*) AS cnt FROM product_reviews WHERE product_id=? AND is_delete=0";
        try (Connection c = DbConnect.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, productId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt("cnt");
            }
        }
        return 0;
    }

    public boolean existsByUserAndProduct(int userId, int productId) throws SQLException {
        String sql = "SELECT 1 FROM product_reviews WHERE user_id=? AND product_id=? AND is_delete=0 LIMIT 1";
        try (Connection c = DbConnect.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

}

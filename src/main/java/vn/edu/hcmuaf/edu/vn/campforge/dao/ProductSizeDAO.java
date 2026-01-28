package vn.edu.hcmuaf.edu.vn.campforge.dao;

import vn.edu.hcmuaf.edu.vn.campforge.dao.db.DbConnect;
import vn.edu.hcmuaf.edu.vn.campforge.model.ProductSize;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductSizeDAO {

    public static void insert(Connection conn, int productId, String sizeName, double weight) throws SQLException {
        String sql = "INSERT INTO product_sizes(productId, sizeName, weight) VALUES (?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ps.setString(2, sizeName);
            ps.setDouble(3, weight);
            ps.executeUpdate();
        }
    }

    public static void deleteByProductId(Connection conn, int productId) throws SQLException {
        String sql = "DELETE FROM product_sizes WHERE productId = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ps.executeUpdate();
        }
    }

    public static List<ProductSize> findByProductId(int productId) {
        List<ProductSize> list = new ArrayList<>();
        String sql = "SELECT id, productId, sizeName, weight FROM product_sizes WHERE productId = ? ORDER BY id ASC";
        try (Connection conn = DbConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ProductSize s = new ProductSize();
                    s.setId(rs.getInt("id"));
                    s.setProductId(rs.getInt("productId"));
                    s.setSizeName(rs.getString("sizeName"));
                    s.setWeight(rs.getDouble("weight"));
                    list.add(s);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}

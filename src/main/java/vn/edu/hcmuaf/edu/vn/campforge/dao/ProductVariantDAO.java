package vn.edu.hcmuaf.edu.vn.campforge.dao;

import vn.edu.hcmuaf.edu.vn.campforge.dao.db.DbConnect;
import vn.edu.hcmuaf.edu.vn.campforge.model.ProductVariant;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductVariantDAO {

    private static ProductVariant mapRow(ResultSet rs) throws SQLException {
        ProductVariant v = new ProductVariant();

        v.setId(rs.getInt("id"));
        v.setProductId(rs.getInt("product_id"));

        v.setColor(rs.getString("color"));
        v.setSize(rs.getString("size"));
        v.setImagePath(rs.getString("image_path"));

        Object priceObj = rs.getObject("price");
        v.setPrice(priceObj == null ? null : rs.getDouble("price"));

        v.setStock(rs.getInt("stock"));
        v.setActive(rs.getInt("is_active") == 1);

        v.setFinalPrice(rs.getDouble("final_price"));

        return v;
    }

    public static List<ProductVariant> findByProductId(int productId) {
        List<ProductVariant> list = new ArrayList<>();

        String sql = """
                    SELECT
                        pv.id,
                        pv.product_id,
                        pv.color,
                        pv.size,
                        pv.image_path,
                        pv.price,
                        pv.stock,
                        pv.is_active,
                        COALESCE(pv.price, p.price) AS final_price
                    FROM product_variants pv
                    JOIN products p ON p.id = pv.product_id
                    WHERE pv.product_id = ?
                      AND pv.is_active = 1
                      AND p.isDelete = 0
                    ORDER BY pv.id ASC
                """;

        try (Connection conn = DbConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, productId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public static ProductVariant findById(int variantId) {
        String sql = """
                    SELECT
                        pv.id,
                        pv.product_id,
                        pv.color,
                        pv.size,
                        pv.image_path,
                        pv.price,
                        pv.stock,
                        pv.is_active,
                        COALESCE(pv.price, p.price) AS final_price
                    FROM product_variants pv
                    JOIN products p ON p.id = pv.product_id
                    WHERE pv.id = ?
                      AND pv.is_active = 1
                      AND p.isDelete = 0
                    LIMIT 1
                """;

        try (Connection conn = DbConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, variantId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public static void insert(Connection conn, int productId, String color, String size,
                              String imagePath, Double price, int stock, int isActive) throws SQLException {
        String sql = """
          INSERT INTO product_variants(product_id, color, size, image_path, price, stock, is_active)
          VALUES (?, ?, ?, ?, ?, ?, ?)
        """;
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ps.setString(2, color);
            ps.setString(3, size);
            ps.setString(4, imagePath);

            if (price == null) ps.setNull(5, Types.DOUBLE);
            else ps.setDouble(5, price);

            ps.setInt(6, stock);
            ps.setInt(7, isActive); // 1
            ps.executeUpdate();
        }
    }

    public static void deleteByProductId(Connection conn, int productId) throws SQLException {
        String sql = "DELETE FROM product_variants WHERE product_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ps.executeUpdate();
        }
    }

}

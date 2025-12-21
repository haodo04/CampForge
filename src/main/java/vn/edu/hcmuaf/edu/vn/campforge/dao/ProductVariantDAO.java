package vn.edu.hcmuaf.edu.vn.campforge.dao;

import vn.edu.hcmuaf.edu.vn.campforge.dao.db.DbConnect;
import vn.edu.hcmuaf.edu.vn.campforge.model.ProductVariant;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductVariantDAO {

    private static ProductVariant mapRow(ResultSet rs) throws SQLException {
        ProductVariant v = new ProductVariant();
        v.setId(rs.getInt("id"));
        v.setProductId(rs.getInt("product_id"));
        v.setSku(rs.getString("sku"));
        Object priceObj = rs.getObject("price");
        v.setPrice(priceObj == null ? null : rs.getDouble("price"));
        v.setStock(rs.getInt("stock"));
        v.setIsActive(rs.getInt("is_active"));

        Object finalPriceObj = rs.getObject("final_price");
        v.setFinalPrice(finalPriceObj == null ? null : rs.getDouble("final_price"));
        return v;
    }

    public static List<ProductVariant> findByProductId(int productId) {
        List<ProductVariant> list = new ArrayList<>();

        String sql = """
            SELECT
                pv.id, pv.product_id, pv.sku, pv.price, pv.stock, pv.is_active,
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
                pv.id, pv.product_id, pv.sku, pv.price, pv.stock, pv.is_active,
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
}

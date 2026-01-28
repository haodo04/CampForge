package vn.edu.hcmuaf.edu.vn.campforge.dao;

import vn.edu.hcmuaf.edu.vn.campforge.dao.db.DbConnect;
import vn.edu.hcmuaf.edu.vn.campforge.model.ProductImg;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductImgDAO {

    private static ProductImg mapRow(ResultSet rs) throws Exception {
        ProductImg img = new ProductImg();
        img.setId(rs.getInt("id"));
        img.setProductId(rs.getInt("product_id"));
        img.setPath(rs.getString("path"));
        img.setPosition(rs.getInt("position"));
        return img;
    }

    public static List<ProductImg> findByProductId(int productId) {
        List<ProductImg> list = new ArrayList<>();

        String sql = """
            SELECT id, product_id, path, position
            FROM product_imgs
            WHERE product_id = ?
            ORDER BY position ASC, id ASC
        """;

        try (Connection conn = DbConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, productId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapRow(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public static void insert(Connection conn, int productId, String path, int position) throws SQLException {
        String sql = "INSERT INTO product_imgs(product_id, path, position) VALUES (?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ps.setString(2, path);
            ps.setInt(3, position);
            ps.executeUpdate();
        }
    }

    public static void deleteByProductId(Connection conn, int productId) throws SQLException {
        String sql = "DELETE FROM product_imgs WHERE product_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ps.executeUpdate();
        }
    }

    public static void upsertMainImage(Connection conn, int productId, String path) throws SQLException {
        String updateSql = "UPDATE product_imgs SET path = ? WHERE product_id = ? AND position = 1";
        try (PreparedStatement ps = conn.prepareStatement(updateSql)) {
            ps.setString(1, path);
            ps.setInt(2, productId);
            int updated = ps.executeUpdate();

            if (updated == 0) {
                String insertSql = "INSERT INTO product_imgs(product_id, path, position) VALUES (?, ?, 1)";
                try (PreparedStatement ins = conn.prepareStatement(insertSql)) {
                    ins.setInt(1, productId);
                    ins.setString(2, path);
                    ins.executeUpdate();
                }
            }
        }
    }

    public static void deleteGalleryByProductId(Connection conn, int productId) throws SQLException {
        String sql = "DELETE FROM product_imgs WHERE product_id = ? AND position > 1";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ps.executeUpdate();
        }
    }

    public static String getMainImagePath(Connection conn, int productId) throws SQLException {
        String sql = "SELECT path FROM product_imgs WHERE product_id = ? AND position = 1 LIMIT 1";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? rs.getString(1) : null;
            }
        }
    }

}

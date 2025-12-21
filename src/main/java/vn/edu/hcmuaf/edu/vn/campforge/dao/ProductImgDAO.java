package vn.edu.hcmuaf.edu.vn.campforge.dao;

import vn.edu.hcmuaf.edu.vn.campforge.dao.db.DbConnect;
import vn.edu.hcmuaf.edu.vn.campforge.model.ProductImg;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
}

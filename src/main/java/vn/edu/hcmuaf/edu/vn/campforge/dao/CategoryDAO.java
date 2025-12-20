package vn.edu.hcmuaf.edu.vn.campforge.dao;

import vn.edu.hcmuaf.edu.vn.campforge.dao.db.DbConnect;
import vn.edu.hcmuaf.edu.vn.campforge.model.Category;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {

    public static List<Category> getFeaturedCategories(int limit) {
        List<Category> list = new ArrayList<>();
        String sql = """
        SELECT id, cateName, image
        FROM categories
        WHERE image IS NOT NULL
          AND image <> ''
        ORDER BY id ASC
        LIMIT ?
    """;

        try (Connection conn = DbConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, limit);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Category c = new Category();
                    c.setId(rs.getInt("id"));
                    c.setCateName(rs.getString("cateName"));
                    c.setImage(rs.getString("image"));
                    list.add(c);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

}

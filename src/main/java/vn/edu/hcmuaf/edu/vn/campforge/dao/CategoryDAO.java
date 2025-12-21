package vn.edu.hcmuaf.edu.vn.campforge.dao;

import vn.edu.hcmuaf.edu.vn.campforge.dao.db.DbConnect;
import vn.edu.hcmuaf.edu.vn.campforge.model.Category;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {

    private static Category mapRow(ResultSet rs) throws SQLException {
        Category c = new Category();
        c.setId(rs.getInt("id"));
        c.setCateName(rs.getString("cateName"));
        c.setImage(rs.getString("image"));
        return c;
    }

    public static List<Category> getFeaturedCategories(int limit) {
        List<Category> list = new ArrayList<>();

        String sql = """
            SELECT id, cateName, image
            FROM categories
            WHERE image IS NOT NULL
              AND TRIM(image) <> ''
            ORDER BY id ASC
            LIMIT ?
        """;

        try (Connection conn = DbConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, limit);

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

    public static List<Category> getAll() {
        List<Category> list = new ArrayList<>();

        String sql = """
            SELECT id, cateName, image
            FROM categories
            ORDER BY cateName ASC, id ASC
        """;

        try (Connection conn = DbConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapRow(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public static Category findById(int id) {
        String sql = """
            SELECT id, cateName, image
            FROM categories
            WHERE id = ?
            LIMIT 1
        """;

        try (Connection conn = DbConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }
}

package vn.edu.hcmuaf.edu.vn.campforge.dao;

import vn.edu.hcmuaf.edu.vn.campforge.model.Product;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    public static List<Product> getProductsByCategory(int categoryId) {
        List<Product> list = new ArrayList<>();

        String sql = """
            SELECT p.id, p.proName, p.price, p.description, p.cateId, p.brandId,
                   i.path AS image
            FROM products p
            LEFT JOIN product_imgs i 
                   ON p.id = i.product_id AND i.position = 1
            WHERE p.cateId = ?
        """;

        try (Connection conn = DbConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, categoryId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product p = new Product(
                        rs.getInt("id"),
                        rs.getString("proName"),
                        rs.getDouble("price"),
                        rs.getString("description"),
                        rs.getInt("cateId"),
                        rs.getInt("brandId"),
                        rs.getString("image")
                );
                list.add(p);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public static List<Product> getAllProducts() {
        List<Product> list = new ArrayList<>();

        String sql = """
        SELECT p.id, p.proName, p.price, p.description, p.cateId, p.brandId,
               i.path AS image
        FROM products p
        LEFT JOIN product_imgs i 
               ON p.id = i.product_id AND i.position = 1
    """;

        try (Connection conn = DbConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product p = new Product(
                        rs.getInt("id"),
                        rs.getString("proName"),
                        rs.getDouble("price"),
                        rs.getString("description"),
                        rs.getInt("cateId"),
                        rs.getInt("brandId"),
                        rs.getString("image")
                );
                list.add(p);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

}

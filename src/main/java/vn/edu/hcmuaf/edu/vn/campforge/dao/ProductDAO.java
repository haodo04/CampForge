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
                   i.path AS image,
                    b.name AS brandName
            FROM products p
            LEFT JOIN product_imgs i 
                   ON p.id = i.product_id AND i.position = 1
            LEFT JOIN brand b
                    ON p.brandId = b.id
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
                        rs.getString("brandName"),
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
               i.path AS image,
                b.name AS brandName
        FROM products p
        LEFT JOIN product_imgs i 
               ON p.id = i.product_id AND i.position = 1
        LEFT JOIN brand b
                ON p.brandId = b.id
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
                        rs.getString("brandName"),
                        rs.getString("image")
                );
                list.add(p);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }
    public static List<Product> getProductsByBrand(int brandId) {
        List<Product> list = new ArrayList<>();

        String sql = """
        SELECT p.id, p.proName, p.price, p.description, p.cateId, p.brandId,
               i.path AS image,
                b.name AS brandName
        FROM products p
        LEFT JOIN product_imgs i 
               ON p.id = i.product_id AND i.position = 1
        LEFT JOIN brand b
                ON p.brandId = b.id
        WHERE p.brandId = ?
        
    """;

        try (Connection conn = DbConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, brandId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product p = new Product(
                        rs.getInt("id"),
                        rs.getString("proName"),
                        rs.getDouble("price"),
                        rs.getString("description"),
                        rs.getInt("cateId"),
                        rs.getInt("brandId"),
                        rs.getString("brandName"),
                        rs.getString("image")
                );
                list.add(p);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public static List<Product> getProductsByPrice(double min, double max) {
        List<Product> list = new ArrayList<>();

        String sql = """
        SELECT p.id, p.proName, p.price, p.description, p.cateId, p.brandId,
               i.path AS image,
                b.name AS brandName
        FROM products p
        LEFT JOIN product_imgs i 
               ON p.id = i.product_id AND i.position = 1
        LEFT JOIN brand b
               ON p.brandId = b.id
        WHERE p.price BETWEEN ? AND ?
    """;

        try (Connection conn = DbConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setDouble(1, min);
            ps.setDouble(2, max);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product p = new Product(
                        rs.getInt("id"),
                        rs.getString("proName"),
                        rs.getDouble("price"),
                        rs.getString("description"),
                        rs.getInt("cateId"),
                        rs.getInt("brandId"),
                        rs.getString("brandName"),
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

package vn.edu.hcmuaf.edu.vn.campforge.dao;

import vn.edu.hcmuaf.edu.vn.campforge.dao.db.DbConnect;
import vn.edu.hcmuaf.edu.vn.campforge.model.Product;

import java.sql.*;
import java.util.*;

public class ProductDAO {

    private static final String BASE_SELECT = """
        SELECT
            p.id,
            p.cateId,
            p.brandId,
            p.proName,
            p.price,
            p.description,
            p.sold,
            p.createAt,
            p.isDelete,
            i.path AS image,
            b.name AS brandName,
            c.cateName AS cateName
        FROM products p
        LEFT JOIN product_imgs i
            ON p.id = i.product_id AND i.position = 1
        LEFT JOIN brand b
            ON p.brandId = b.id
        LEFT JOIN categories c
            ON p.cateId = c.id
    """;

    private static Product mapRow(ResultSet rs) throws SQLException {
        Product p = new Product();
        p.setId(rs.getInt("id"));
        p.setCateId(rs.getInt("cateId"));
        p.setBrandId(rs.getInt("brandId"));
        p.setProName(rs.getString("proName"));
        p.setPrice(rs.getDouble("price"));
        p.setDescription(rs.getString("description"));
        p.setSold(rs.getInt("sold"));
        p.setCreateAt(rs.getTimestamp("createAt"));
        p.setIsDelete(rs.getInt("isDelete"));
        p.setImage(rs.getString("image"));
        p.setBrandName(rs.getString("brandName"));
        p.setCateName(rs.getString("cateName"));
        return p;
    }

    public static List<Product> findProducts(Integer cateId, Integer brandId,
                                             Double min, Double max,
                                             int limit, int offset) {
        List<Product> list = new ArrayList<>();

        StringBuilder sql = new StringBuilder(BASE_SELECT);
        sql.append(" WHERE p.isDelete = 0 ");

        List<Object> params = new ArrayList<>();

        if (cateId != null) {
            sql.append(" AND p.cateId = ? ");
            params.add(cateId);
        }
        if (brandId != null) {
            sql.append(" AND p.brandId = ? ");
            params.add(brandId);
        }
        if (min != null && max != null) {
            sql.append(" AND p.price BETWEEN ? AND ? ");
            params.add(min);
            params.add(max);
        }

        sql.append(" ORDER BY p.createAt DESC ");
        sql.append(" LIMIT ? OFFSET ? ");
        params.add(limit);
        params.add(offset);

        try (Connection conn = DbConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapRow(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public static int countProducts(Integer cateId, Integer brandId, Double min, Double max) {
        StringBuilder sql = new StringBuilder("""
            SELECT COUNT(*)
            FROM products p
            WHERE p.isDelete = 0
        """);

        List<Object> params = new ArrayList<>();

        if (cateId != null) {
            sql.append(" AND p.cateId = ? ");
            params.add(cateId);
        }
        if (brandId != null) {
            sql.append(" AND p.brandId = ? ");
            params.add(brandId);
        }
        if (min != null && max != null) {
            sql.append(" AND p.price BETWEEN ? AND ? ");
            params.add(min);
            params.add(max);
        }

        try (Connection conn = DbConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public static List<Product> getLatestProducts(int limit) {
        List<Product> list = new ArrayList<>();
        String sql = """
        SELECT 
            p.id, p.cateId, p.brandId, p.proName, p.price,
            p.description, p.sold, p.createAt, p.isDelete,
            p.image, b.brandName, c.cateName
        FROM products p
        JOIN brands b ON p.brandId = b.id
        JOIN categories c ON p.cateId = c.id
        WHERE p.isDelete = 0
        ORDER BY p.createAt DESC, p.id DESC
        LIMIT ?
    """;

        try (Connection conn = DbConnect.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product p = new Product(
                        rs.getInt("id"),
                        rs.getInt("cateId"),
                        rs.getInt("brandId"),
                        rs.getString("proName"),
                        rs.getDouble("price"),
                        rs.getString("description"),
                        rs.getInt("sold"),
                        rs.getTimestamp("createAt"),
                        rs.getInt("isDelete"),
                        rs.getString("image"),
                        rs.getString("brandName"),
                        rs.getString("cateName")
                );
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

}

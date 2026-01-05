package vn.edu.hcmuaf.edu.vn.campforge.dao;

import vn.edu.hcmuaf.edu.vn.campforge.dao.db.DbConnect;
import vn.edu.hcmuaf.edu.vn.campforge.model.Product;

import java.sql.*;
import java.util.*;
import java.util.Date;

public class ProductDAO {

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
        try {
            Object dv = rs.getObject("defaultVariantId");
            p.setDefaultVariantId(dv == null ? null : ((Number) dv).intValue());
        } catch (SQLException ignore) {

        }
        return p;
    }

    public static List<Product> findProducts(
            Integer cateId,
            Integer brandId,
            Double min,
            Double max,
            Date fromDate,
            Date toDate,
            String keyword,
            String sort,
            int limit,
            int offset
    ) {
        List<Product> list = new ArrayList<>();

        StringBuilder sql = new StringBuilder("""
            SELECT
                p.id, p.cateId, p.brandId, p.proName, p.price,
                p.description, p.sold, p.createAt, p.isDelete,
                i.path AS image,
                b.name AS brandName,
                c.cateName AS cateName
            FROM products p
            LEFT JOIN product_imgs i ON p.id = i.product_id AND i.position = 1
            LEFT JOIN brand b ON p.brandId = b.id
            LEFT JOIN categories c ON p.cateId = c.id
            WHERE p.isDelete = 0
        """);

        List<Object> params = new ArrayList<>();

        if (cateId != null) {
            sql.append(" AND p.cateId = ?");
            params.add(cateId);
        }

        if (brandId != null) {
            sql.append(" AND p.brandId = ?");
            params.add(brandId);
        }

        if (min != null) {
            sql.append(" AND p.price >= ?");
            params.add(min);
        }

        if (max != null) {
            sql.append(" AND p.price <= ?");
            params.add(max);
        }

        if (fromDate != null) {
            sql.append(" AND p.createAt >= ?");
            params.add(new Timestamp(fromDate.getTime()));
        }

        if (toDate != null) {
            sql.append(" AND p.createAt <= ?");
            params.add(new Timestamp(toDate.getTime()));
        }

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND p.proName LIKE ?");
            params.add("%" + keyword.trim() + "%");
        }

        // Xử lý sort
        if ("new".equals(sort)) {
            sql.append(" ORDER BY p.createAt DESC, p.id DESC");
        } else if ("best".equals(sort)) {
            sql.append(" ORDER BY p.sold DESC, p.createAt DESC, p.id DESC");
        } else {
            sql.append(" ORDER BY p.id DESC");
        }

        sql.append(" LIMIT ? OFFSET ?");
        params.add(limit);
        params.add(offset);

        try (Connection conn = DbConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

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

    public static List<Product> findProducts(
            Integer cateId,
            Integer brandId,
            Double min,
            Double max,
            int limit,
            int offset
    ) {
        return findProducts(cateId, brandId, min, max, null, null, null, null, limit, offset);
    }

    public static int countProducts(
            Integer cateId,
            Integer brandId,
            Double min,
            Double max,
            Date fromDate,
            Date toDate,
            String keyword
    ) {
        StringBuilder sql = new StringBuilder("""
            SELECT COUNT(*)
            FROM products p
            WHERE p.isDelete = 0
        """);

        List<Object> params = new ArrayList<>();

        if (cateId != null) {
            sql.append(" AND p.cateId = ?");
            params.add(cateId);
        }

        if (brandId != null) {
            sql.append(" AND p.brandId = ?");
            params.add(brandId);
        }

        if (min != null) {
            sql.append(" AND p.price >= ?");
            params.add(min);
        }

        if (max != null) {
            sql.append(" AND p.price <= ?");
            params.add(max);
        }

        if (fromDate != null) {
            sql.append(" AND p.createAt >= ?");
            params.add(new Timestamp(fromDate.getTime()));
        }

        if (toDate != null) {
            sql.append(" AND p.createAt <= ?");
            params.add(new Timestamp(toDate.getTime()));
        }

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND p.proName LIKE ?");
            params.add("%" + keyword.trim() + "%");
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

    public static int countProducts(
            Integer cateId,
            Integer brandId,
            Double min,
            Double max
    ) {
        return countProducts(cateId, brandId, min, max, null, null, null);
    }

    public static List<Product> getLatestProducts(int limit) {
        return findProducts(null, null, null, null, null, null, null, "new", limit, 0);
    }

    public static List<Product> getBestSellerProducts(int limit) {
        List<Product> list = new ArrayList<>();

        String sql = """
            SELECT
                p.id, p.cateId, p.brandId, p.proName, p.price,
                p.description, p.sold, p.createAt, p.isDelete,
                i.path AS image,
                b.name AS brandName,
                c.cateName AS cateName
            FROM products p
            LEFT JOIN product_imgs i ON p.id = i.product_id AND i.position = 1
            LEFT JOIN brand b ON p.brandId = b.id
            LEFT JOIN categories c ON p.cateId = c.id
            WHERE p.isDelete = 0
            ORDER BY p.sold DESC, p.createAt DESC, p.id DESC
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

    public static Product findById(int productId) {
        String sql = """
            SELECT
                p.id, p.cateId, p.brandId, p.proName, p.price,
                p.description, p.sold, p.createAt, p.isDelete,
                b.name AS brandName,
                c.cateName AS cateName
            FROM products p
            LEFT JOIN brand b ON p.brandId = b.id
            LEFT JOIN categories c ON p.cateId = c.id
            WHERE p.isDelete = 0
              AND p.id = ?
            LIMIT 1
        """;

        try (Connection conn = DbConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, productId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
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
                    p.setBrandName(rs.getString("brandName"));
                    p.setCateName(rs.getString("cateName"));
                    return p;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static List<Product> getRelatedProducts(int cateId, int excludeProductId, int limit) {
        List<Product> list = new ArrayList<>();

        String sql = """
            SELECT
                p.id, p.cateId, p.brandId, p.proName, p.price,
                p.description, p.sold, p.createAt, p.isDelete,
                i.path AS image,
                b.name AS brandName,
                c.cateName AS cateName
            FROM products p
            LEFT JOIN product_imgs i ON p.id = i.product_id AND i.position = 1
            LEFT JOIN brand b ON p.brandId = b.id
            LEFT JOIN categories c ON p.cateId = c.id
            WHERE p.isDelete = 0
              AND p.cateId = ?
              AND p.id <> ?
            ORDER BY p.createAt DESC, p.sold DESC, p.id DESC
            LIMIT ?
        """;

        try (Connection conn = DbConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, cateId);
            ps.setInt(2, excludeProductId);
            ps.setInt(3, limit);

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

    public static List<Product> getLatestProductsWithDefaultVariant(int limit) {
        List<Product> list = new ArrayList<>();
        String sql = """
        SELECT
            p.id, p.cateId, p.brandId, p.proName, p.price,
            p.description, p.sold, p.createAt, p.isDelete,

            i.path AS image,
            b.name AS brandName,
            c.cateName AS cateName,

            COALESCE(v_img.id, v_min.min_variant_id) AS defaultVariantId

        FROM products p
        LEFT JOIN product_imgs i
          ON i.product_id = p.id AND i.position = 1

        LEFT JOIN product_variants v_img
          ON v_img.product_id = p.id
         AND v_img.is_active = 1
         AND v_img.image_path = i.path

        LEFT JOIN (
            SELECT product_id, MIN(id) AS min_variant_id
            FROM product_variants
            WHERE is_active = 1
            GROUP BY product_id
        ) v_min ON v_min.product_id = p.id

        LEFT JOIN brand b ON p.brandId = b.id
        LEFT JOIN categories c ON p.cateId = c.id

        WHERE p.isDelete = 0
        ORDER BY p.createAt DESC, p.id DESC
        LIMIT ?
    """;

        try (Connection conn = DbConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, limit);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product p = mapRow(rs);

                    Object dv = rs.getObject("defaultVariantId");
                    if (dv == null) p.setDefaultVariantId(null);
                    else p.setDefaultVariantId(((Number) dv).intValue());

                    list.add(p);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }


}

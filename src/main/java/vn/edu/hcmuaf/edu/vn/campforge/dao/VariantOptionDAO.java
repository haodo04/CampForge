package vn.edu.hcmuaf.edu.vn.campforge.dao;

import vn.edu.hcmuaf.edu.vn.campforge.dao.db.DbConnect;
import vn.edu.hcmuaf.edu.vn.campforge.model.VariantOption;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class VariantOptionDAO {

    private static VariantOption mapRow(ResultSet rs) throws SQLException {
        VariantOption o = new VariantOption();
        o.setVariantId(rs.getInt("variant_id"));
        o.setAttrId(rs.getInt("attr_id"));
        o.setAttrCode(rs.getString("attr_code"));
        o.setAttrName(rs.getString("attr_name"));
        o.setValue(rs.getString("value"));
        return o;
    }

    public static List<VariantOption> findByProductId(int productId) {
        List<VariantOption> list = new ArrayList<>();

        String sql = """
            SELECT
                vo.variant_id,
                vo.attr_id,
                a.code AS attr_code,
                a.name AS attr_name,
                vo.value
            FROM variant_options vo
            JOIN product_variants pv ON pv.id = vo.variant_id
            JOIN attributes a ON a.id = vo.attr_id
            WHERE pv.product_id = ?
              AND pv.is_active = 1
            ORDER BY vo.variant_id ASC, a.id ASC
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

    public static List<VariantOption> findByVariantId(int variantId) {
        List<VariantOption> list = new ArrayList<>();

        String sql = """
            SELECT
                vo.variant_id,
                vo.attr_id,
                a.code AS attr_code,
                a.name AS attr_name,
                vo.value
            FROM variant_options vo
            JOIN attributes a ON a.id = vo.attr_id
            WHERE vo.variant_id = ?
            ORDER BY a.id ASC
        """;

        try (Connection conn = DbConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, variantId);

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
}

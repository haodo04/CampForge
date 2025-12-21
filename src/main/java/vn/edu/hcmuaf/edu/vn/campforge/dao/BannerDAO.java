package vn.edu.hcmuaf.edu.vn.campforge.dao;

import vn.edu.hcmuaf.edu.vn.campforge.dao.db.DbConnect;
import vn.edu.hcmuaf.edu.vn.campforge.model.Banner;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

public class BannerDAO {

    private static Banner mapRow(ResultSet rs) throws SQLException {
        Banner b = new Banner();
        b.setId(rs.getInt("id"));
        b.setPlacement(rs.getString("placement"));
        b.setTitle(rs.getString("title"));
        b.setImageUrl(rs.getString("image_url"));
        b.setLinkUrl(rs.getString("link_url"));
        b.setBtnText(rs.getString("btn_text"));
        b.setSortOrder(rs.getInt("sort_order"));
        b.setIsActive(rs.getInt("is_active"));
        return b;
    }

    public static Banner findOneActiveByPlacement(String placement) {
        if (placement == null || placement.isBlank()) return null;

        String sql = """
            SELECT id, placement, title, image_url, link_url, btn_text, sort_order, is_active
            FROM banners
            WHERE is_active = 1
              AND placement = ?
            ORDER BY sort_order ASC, id DESC
            LIMIT 1
        """;

        try (Connection conn = DbConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, placement.trim());

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public static Map<String, Banner> findActiveByPlacements(List<String> placements) {
        Map<String, Banner> result = new HashMap<>();
        if (placements == null || placements.isEmpty()) return result;

        List<String> cleaned = new ArrayList<>();
        Set<String> seen = new HashSet<>();
        for (String p : placements) {
            if (p == null) continue;
            String t = p.trim();
            if (t.isEmpty()) continue;
            if (seen.add(t)) cleaned.add(t);
        }
        if (cleaned.isEmpty()) return result;

        // tạo (?, ?, ?, ...)
        StringJoiner sj = new StringJoiner(",", "(", ")");
        for (int i = 0; i < cleaned.size(); i++) sj.add("?");

        String sql = """
            SELECT id, placement, title, image_url, link_url, btn_text, sort_order, is_active
            FROM banners
            WHERE is_active = 1
              AND placement IN %s
            ORDER BY placement ASC, sort_order ASC, id DESC
        """.formatted(sj.toString());

        try (Connection conn = DbConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            for (int i = 0; i < cleaned.size(); i++) {
                ps.setString(i + 1, cleaned.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Banner b = mapRow(rs);
                    result.putIfAbsent(b.getPlacement(), b);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return result;
    }
}

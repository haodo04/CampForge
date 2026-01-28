package vn.edu.hcmuaf.edu.vn.campforge.dao;

import java.sql.*;

public class BrandDAO {

    public static int findOrCreateByName(Connection conn, String name) throws SQLException {
        if (name == null || name.trim().isEmpty()) {
            throw new SQLException("Brand name is empty");
        }
        name = name.trim();

        String findSql = "SELECT id FROM brand WHERE name = ? LIMIT 1";
        try (PreparedStatement ps = conn.prepareStatement(findSql)) {
            ps.setString(1, name);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        }

        String insSql = "INSERT INTO brand(name) VALUES (?)";
        try (PreparedStatement ps = conn.prepareStatement(insSql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, name);
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) return rs.getInt(1);
            }
        }

        throw new SQLException("Insert brand failed");
    }
}

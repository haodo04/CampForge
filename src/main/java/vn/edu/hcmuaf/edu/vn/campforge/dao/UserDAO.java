package vn.edu.hcmuaf.edu.vn.campforge.dao;

import vn.edu.hcmuaf.edu.vn.campforge.dao.db.DbConnect;
import vn.edu.hcmuaf.edu.vn.campforge.model.User;

import java.sql.*;

public class UserDAO {

    // Hàm map dữ liệu từ ResultSet sang Object User để tái sử dụng
    private static User mapRow(ResultSet rs) throws SQLException {
        User user = new User();
        user.setId(rs.getInt("id"));
        user.setUsername(rs.getString("username"));
        user.setPassword(rs.getString("password"));
        user.setFullName(rs.getString("fullName"));
        user.setEmail(rs.getString("email"));
        user.setPhone(rs.getString("phone"));
        user.setRole(rs.getInt("role"));
        user.setCreateAt(rs.getTimestamp("createAt"));
        return user;
    }

    /**
     * Thực hiện đăng ký người dùng mới
     * Trả về true nếu thành công
     */
    public static boolean register(User user) {
        // Chỉ dùng 6 dấu hỏi cho 6 cột chính
        String sql = "INSERT INTO users (username, password, fullName, email, phone, role) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DbConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getFullName());
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getPhone());
            ps.setInt(6, 0); // Mặc định role User

            int rowAffected = ps.executeUpdate();
            return rowAffected > 0;

        } catch (SQLException e) {
            System.err.println("LOI SQL: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    // Thêm hàm này vào class UserDAO
    public static boolean checkUsernameExists(String username) {
        String sql = "SELECT id FROM users WHERE username = ? LIMIT 1";
        try (Connection conn = DbConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next(); // Trả về true nếu tìm thấy username
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
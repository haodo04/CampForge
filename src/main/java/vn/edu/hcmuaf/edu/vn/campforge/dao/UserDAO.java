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
        user.setAddress(rs.getString("address"));
        user.setRole(rs.getInt("role"));
        user.setCreateAt(rs.getTimestamp("createAt"));
        user.setIsVerified(rs.getInt("is_verified"));
        return user;
    }

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

    public static User getUserByUsername(String username) {
        String sql = "SELECT * FROM users WHERE username = ?";
        try (Connection conn = DbConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    // Lưu token reset
    public static void saveResetToken(String email, String token) {
        String sql = "REPLACE INTO password_resets (email, token, expiry_time) VALUES (?, ?, ?)";
        try (Connection conn = DbConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, token);
            // Hết hạn sau 15 phút
            ps.setTimestamp(3, new Timestamp(System.currentTimeMillis() + 15 * 60 * 1000));
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    // Kiểm tra token hợp lệ
    public static String validateToken(String token) {
        String sql = "SELECT email FROM password_resets WHERE token = ? AND expiry_time > NOW()";
        try (Connection conn = DbConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, token);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getString("email");
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    // Cập nhật mật khẩu mới
    public static boolean updatePassword(String email, String newHashedPassword) {
        String sql = "UPDATE users SET password = ? WHERE email = ?";
        try (Connection conn = DbConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newHashedPassword);
            ps.setString(2, email);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    public static boolean checkEmailExists(String email) {
        String sql = "SELECT id FROM users WHERE email = ? LIMIT 1";
        try (Connection conn = DbConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    // Lưu token xác thực
    public static void saveVerifyToken(String email, String token) {
        String sql = "REPLACE INTO verify_tokens (email, token, expiry_time) VALUES (?, ?, DATE_ADD(NOW(), INTERVAL 24 HOUR))";
        try (Connection conn = DbConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, token);
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    // Kiểm tra token và trả về email
    public static String validateVerifyToken(String token) {
        String sql = "SELECT email FROM verify_tokens WHERE token = ? AND expiry_time > NOW()";
        try (Connection conn = DbConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, token);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getString("email");
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    // Cập nhật trạng thái đã xác thực
    public static void verifyUser(String email) {
        String sql = "UPDATE users SET is_verified = 1 WHERE email = ?";
        try (Connection conn = DbConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.executeUpdate();
            // Xóa token sau khi dùng xong
            conn.createStatement().executeUpdate("DELETE FROM verify_tokens WHERE email = '" + email + "'");
        } catch (SQLException e) { e.printStackTrace(); }
    }
    // Đăng ký người dùng từ Google (mật khẩu để trống)
    public static boolean registerGoogleUser(User user) {
        String sql = "INSERT INTO users (username, fullName, email, is_verified, role, password) VALUES (?, ?, ?, 1, 0, ?)";
        try (Connection conn = DbConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getFullName()); // Dùng fullName làm username luôn
            ps.setString(2, user.getFullName());
            ps.setString(3, user.getEmail());
            ps.setString(4, ""); // Không có mật khẩu cho login Google
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }
    public boolean updateProfile(int userId, String fullName, String phone, String email, String address) {
        String sql = "UPDATE users SET fullName = ?, phone = ?, email = ?, address = ? WHERE id = ?";

        try (Connection conn = DbConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, fullName);
            ps.setString(2, phone);
            ps.setString(3, email);
            ps.setString(4, address);
            ps.setInt(5, userId);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Lỗi Update Profile: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
}
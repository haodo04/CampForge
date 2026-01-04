package vn.edu.hcmuaf.edu.vn.campforge.service;

import vn.edu.hcmuaf.edu.vn.campforge.dao.UserDAO;
import vn.edu.hcmuaf.edu.vn.campforge.model.User;
import org.mindrot.jbcrypt.BCrypt; // Thư viện mã hóa mật khẩu

public class UserService {
    private static UserService instance;

    private UserService() {}

    public static UserService getInstance() {
        if (instance == null) instance = new UserService();
        return instance;
    }

    /**
     * Logic đăng ký người dùng
     */
    public String register(
            String username,
            String password,
            String rePassword,
            String fullName,
            String email,
            String phone) {
        // 1. Kiểm tra trống (Validation cơ bản)
        if (username == null || username.trim().isEmpty()) return "Tên đăng nhập không được để trống!";

        // 2. Kiểm tra mật khẩu khớp
        if (!password.equals(rePassword)) {
            return "Mật khẩu xác nhận không khớp!";
        }

        // 3. KIỂM TRA TRÙNG USERNAME (Rất quan trọng)
        if (UserDAO.checkUsernameExists(username)) {
            return "Tên đăng nhập đã tồn tại!";
        }

        // 4. Mã hóa mật khẩu
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

        // 5. Lưu vào DB
        User user = new User();
        user.setUsername(username);
        user.setPassword(hashedPassword);
        user.setFullName(fullName);
        user.setEmail(email);
        user.setPhone(phone);

        boolean success = UserDAO.register(user);
        return success ? "SUCCESS" : "Đăng ký thất bại, hệ thống đang bận!";
    }

    public User login(String username, String password) {
        // 1. Lấy user từ DB
        User user = UserDAO.getUserByUsername(username);

        // 2. Nếu user tồn tại, kiểm tra mật khẩu
        if (user != null) {
            // BCrypt.checkpw(mật khẩu thô, mật khẩu đã hash)
            if (BCrypt.checkpw(password, user.getPassword())) {
                return user; // Đăng nhập thành công
            }
        }
        return null; // Sai tài khoản hoặc mật khẩu
    }
}
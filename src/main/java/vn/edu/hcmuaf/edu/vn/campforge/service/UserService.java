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
    public String register(String username, String password, String rePassword,
                           String fullName, String email, String phone) {
        // 1. Validation
        if (username == null || username.trim().isEmpty()) return "Tên đăng nhập không được để trống!";
        if (!password.equals(rePassword)) return "Mật khẩu xác nhận không khớp!";
        if (UserDAO.checkUsernameExists(username)) return "Tên đăng nhập đã tồn tại!";
        if (UserDAO.checkEmailExists(email)) return "Email đã tồn tại!";

        // 2. Mã hóa mật khẩu
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

        // 3. Lưu vào DB
        User user = new User();
        user.setUsername(username);
        user.setPassword(hashedPassword);
        user.setFullName(fullName);
        user.setEmail(email);
        user.setPhone(phone);

        boolean success = UserDAO.register(user);

        // 4. NẾU LƯU THÀNH CÔNG -> GỬI MAIL VERIFY
        if (success) {
            String token = java.util.UUID.randomUUID().toString();
            UserDAO.saveVerifyToken(email, token);
            EmailService.sendVerifyEmail(email, token);
            return "SUCCESS_VERIFY"; // Trả về mã riêng để Servlet nhận biết
        }

        return "Đăng ký thất bại!";
    }

    public User login(String username, String password) {
        User user = UserDAO.getUserByUsername(username);
        if (user != null && BCrypt.checkpw(password, user.getPassword())) {
            // KIỂM TRA XÁC THỰC
            if (user.getIsVerified() == 0) {
                // Bạn có thể ném Exception hoặc xử lý tùy ý để báo lỗi chưa verify
                return null;
            }
            return user;
        }
        return null;
    }
}
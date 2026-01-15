package vn.edu.hcmuaf.edu.vn.campforge.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.mindrot.jbcrypt.BCrypt;
import vn.edu.hcmuaf.edu.vn.campforge.dao.UserDAO;

import java.io.IOException;

@WebServlet("/reset-password")
public class ResetPasswordServlet extends HttpServlet {
    // Khi click link từ email (GET)
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String token = request.getParameter("token");
        request.setAttribute("token", token);
        request.getRequestDispatcher("reset-password.jsp").forward(request, response);
    }

    // Khi nhấn nút lưu mật khẩu mới (POST)
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String token = request.getParameter("token");
        String newPass = request.getParameter("password");

        String email = UserDAO.validateToken(token); // Kiểm tra token
        if (email != null) {
            // Mã hóa mật khẩu mới trước khi lưu
            String hashed = org.mindrot.jbcrypt.BCrypt.hashpw(newPass, org.mindrot.jbcrypt.BCrypt.gensalt());
            UserDAO.updatePassword(email, hashed);
            response.sendRedirect("login.jsp?msg=reset_success");
        } else {
            request.setAttribute("error", "Link đã hết hạn hoặc không hợp lệ!");
            request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
        }
    }
}

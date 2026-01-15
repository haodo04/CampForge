package vn.edu.hcmuaf.edu.vn.campforge.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.hcmuaf.edu.vn.campforge.dao.UserDAO;

import java.io.IOException;

@WebServlet("/verify")
public class VerifyServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String token = request.getParameter("token");

        // 1. Kiểm tra token có hợp lệ không
        String email = UserDAO.validateVerifyToken(token);

        if (email != null) {
            // 2. Cập nhật trạng thái is_verified = true
            UserDAO.verifyUser(email);
            request.setAttribute("msg", "Xác thực tài khoản thành công! Bạn có thể đăng nhập.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Link xác thực đã hết hạn hoặc không hợp lệ.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}

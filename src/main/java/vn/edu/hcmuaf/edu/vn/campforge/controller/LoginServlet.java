package vn.edu.hcmuaf.edu.vn.campforge.controller;

import vn.edu.hcmuaf.edu.vn.campforge.model.User;
import vn.edu.hcmuaf.edu.vn.campforge.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String user = request.getParameter("username");
        String pass = request.getParameter("password");

        // Gọi Service xử lý
        User authenticatedUser = UserService.getInstance().login(user, pass);

        if (authenticatedUser != null) {
            // Lưu thông tin vào Session
            HttpSession session = request.getSession();
            session.setAttribute("auth", authenticatedUser);

            // Chuyển hướng về trang chủ
            response.sendRedirect(request.getContextPath() + "/home");
        } else {
            // Thông báo lỗi nếu sai thông tin
            request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
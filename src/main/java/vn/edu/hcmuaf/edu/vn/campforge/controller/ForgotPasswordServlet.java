package vn.edu.hcmuaf.edu.vn.campforge.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.hcmuaf.edu.vn.campforge.dao.UserDAO;
import vn.edu.hcmuaf.edu.vn.campforge.service.EmailService;

import java.io.IOException;
import java.util.UUID;

@WebServlet("/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException { // Xóa IOException dư thừa
        String email = request.getParameter("email");

        if (!UserDAO.checkEmailExists(email)) {
            request.setAttribute("error", "Email này không tồn tại trong hệ thống!");
            request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
            return;
        }

        String token = UUID.randomUUID().toString();
        UserDAO.saveResetToken(email, token);

        boolean isSent = EmailService.sendResetEmail(email, token);

        if (isSent) {
            request.setAttribute("msg", "Kiểm tra hòm thư của bạn để đổi mật khẩu!");
        } else {
            request.setAttribute("error", "Lỗi gửi email, vui lòng thử lại sau.");
        }
        request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
    }
}

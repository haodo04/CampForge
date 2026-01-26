package vn.edu.hcmuaf.edu.vn.campforge.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.mindrot.jbcrypt.BCrypt;
import vn.edu.hcmuaf.edu.vn.campforge.dao.UserDAO;
import vn.edu.hcmuaf.edu.vn.campforge.model.User;

import java.io.IOException;

@WebServlet("/change-password")
public class ChangePasswordServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User auth = (User) session.getAttribute("auth");

        if (auth == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String currentPass = request.getParameter("currentPassword");
        String newPass = request.getParameter("newPassword");

        // 1. Kiểm tra mật khẩu cũ có khớp với DB không
        User userDb = UserDAO.getUserByUsername(auth.getUsername());
        if (BCrypt.checkpw(currentPass, userDb.getPassword())) {
            // 2. Mã hóa mật khẩu mới và update
            String hashed = BCrypt.hashpw(newPass, BCrypt.gensalt());
            UserDAO.updatePassword(auth.getEmail(), hashed);

            response.sendRedirect("personal?msg=change_success");
        } else {
            request.setAttribute("passwordError", "Mật khẩu hiện tại không chính xác!");
            request.getRequestDispatcher("personal.jsp").forward(request, response);
        }
    }
}

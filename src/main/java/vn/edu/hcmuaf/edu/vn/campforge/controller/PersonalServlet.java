package vn.edu.hcmuaf.edu.vn.campforge.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.hcmuaf.edu.vn.campforge.dao.UserDAO;
import vn.edu.hcmuaf.edu.vn.campforge.model.User;

import java.io.IOException;

@WebServlet("/personal")
public class PersonalServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Kiểm tra đăng nhập từ session
        User auth = (User) request.getSession().getAttribute("auth");

        if (auth == null) {
            // Nếu chưa đăng nhập, đá về trang login
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // 2. Lấy lại dữ liệu mới nhất từ DB (để tránh dữ liệu cũ trong session)
        User userDetail = UserDAO.getUserByUsername(auth.getUsername());

        // 3. Đẩy dữ liệu vào request attribute
        request.setAttribute("user", userDetail);

        // 4. Chuyển hướng sang trang personal.jsp
        request.getRequestDispatcher("personal.jsp").forward(request, response);
    }
}

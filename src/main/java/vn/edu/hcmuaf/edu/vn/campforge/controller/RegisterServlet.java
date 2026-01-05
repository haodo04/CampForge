package vn.edu.hcmuaf.edu.vn.campforge.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.hcmuaf.edu.vn.campforge.service.UserService;

import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Lấy dữ liệu từ Form (Khớp với thuộc tính 'name' ở JSP)
        String fullName = request.getParameter("fullName");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String pass = request.getParameter("password");
        String rePass = request.getParameter("rePassword");

        // Tạm thời để trống phone vì giao diện mới không có field này
        String phone = "";

        // 2. Gọi Service xử lý
        String result = UserService.getInstance().register(username, pass, rePass, fullName, email, phone);

        if ("SUCCESS".equals(result)) {
            response.sendRedirect("login.jsp");
        } else {
            request.setAttribute("error", result);
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}
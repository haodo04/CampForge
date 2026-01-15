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
        String fullName = request.getParameter("fullName");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String pass = request.getParameter("password");
        String rePass = request.getParameter("rePassword");

        String result = UserService.getInstance().register(username, pass, rePass, fullName, email, "");

        if ("SUCCESS_VERIFY".equals(result)) {
            // Không redirect ngay mà forward để mang theo thông báo
            request.setAttribute("msg", "Đăng ký thành công! Vui lòng kiểm tra Email để kích hoạt tài khoản.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", result);
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}
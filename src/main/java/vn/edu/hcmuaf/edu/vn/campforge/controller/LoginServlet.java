package vn.edu.hcmuaf.edu.vn.campforge.controller;

import vn.edu.hcmuaf.edu.vn.campforge.model.User;
import vn.edu.hcmuaf.edu.vn.campforge.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private String sanitizeReturn(String r) {
        if (r == null) return null;
        r = r.trim();
        if (!r.startsWith("/")) return null;
        if (r.startsWith("//")) return null;
        if (r.contains("://")) return null;
        return r;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String ret = sanitizeReturn(request.getParameter("return"));
        if (ret != null) {
            request.getSession().setAttribute("returnAfterLogin", ret);
        }

        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String user = request.getParameter("username");
        String pass = request.getParameter("password");

        User authenticatedUser = UserService.getInstance().login(user, pass);

        if (authenticatedUser != null) {
            HttpSession session = request.getSession();
            session.setAttribute("auth", authenticatedUser);

            String ret = sanitizeReturn(request.getParameter("return"));
            if (ret == null) {
                ret = (String) session.getAttribute("returnAfterLogin");
            }
            session.removeAttribute("returnAfterLogin");

            if (ret == null) ret = "/home";
            response.sendRedirect(request.getContextPath() + ret);

        } else {
            request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
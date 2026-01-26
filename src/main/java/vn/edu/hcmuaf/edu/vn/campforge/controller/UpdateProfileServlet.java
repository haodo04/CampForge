package vn.edu.hcmuaf.edu.vn.campforge.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.hcmuaf.edu.vn.campforge.dao.UserDAO;
import vn.edu.hcmuaf.edu.vn.campforge.model.User;

import java.io.IOException;

@WebServlet(name = "UpdateProfileServlet", value = "/update-profile")
public class UpdateProfileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // 1. Lấy thông tin từ session để biết user nào đang đăng nhập
        HttpSession session = request.getSession();
        User auth = (User) session.getAttribute("auth");

        if (auth == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // 2. Lấy dữ liệu từ Form modal
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String address = request.getParameter("address");

        // 3. Gọi DAO cập nhật database
        UserDAO dao = new UserDAO();
        boolean success = dao.updateProfile(auth.getId(), fullName, phone, email, address);

        if (success) {
            // Cập nhật lại đối tượng user trong session để hiển thị thông tin mới ngay lập tức
            auth.setFullName(fullName);
            auth.setPhone(phone);
            auth.setEmail(email);
            auth.setAddress(address);
            session.setAttribute("auth", auth);

            // Chuyển hướng về trang cá nhân với thông báo thành công
            response.sendRedirect(request.getContextPath() + "/personal?msg=update_success");
        } else {
            request.setAttribute("error", "Cập nhật thất bại, vui lòng thử lại!");
            response.sendRedirect(request.getContextPath() + "/personal?error=update_failed");
        }
    }
}

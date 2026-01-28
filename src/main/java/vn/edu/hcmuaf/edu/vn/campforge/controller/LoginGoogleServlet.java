package vn.edu.hcmuaf.edu.vn.campforge.controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.http.client.fluent.Form;
import org.apache.http.client.fluent.Request;
import vn.edu.hcmuaf.edu.vn.campforge.dao.UserDAO;
import vn.edu.hcmuaf.edu.vn.campforge.model.GoogleUserInfo;
import vn.edu.hcmuaf.edu.vn.campforge.model.User;

import java.io.IOException;

@WebServlet("/login-google")
public class LoginGoogleServlet extends HttpServlet {
    private static final String CLIENT_ID = "1077549100477-97ee4he5fe0niock79ri485igr55ed1o.apps.googleusercontent.com";
    private static final String CLIENT_SECRET = "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";
    private static final String REDIRECT_URI = "http://localhost:8080/campforge_war/login-google";
    private static final String LINK_GET_TOKEN = "https://accounts.google.com/o/oauth2/token";
    private static final String LINK_GET_USER_INFO = "https://www.googleapis.com/oauth2/v3/userinfo";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String code = request.getParameter("code");

        if (code == null || code.isEmpty()) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // 1. Đổi code lấy Access Token
            String accessToken = getToken(code);

            // 2. Dùng Access Token lấy thông tin User
            GoogleUserInfo googleUser = getUserInfo(accessToken);

            // 3. Xử lý logic Login với Database
            User user = UserDAO.getUserByUsername(googleUser.getEmail());

            if (user == null) {
                // Nếu chưa có email này trong DB -> Tạo mới User
                user = new User();
                user.setUsername(googleUser.getEmail()); // Dùng email làm username
                user.setEmail(googleUser.getEmail());
                user.setFullName(googleUser.getName());
                user.setIsVerified(1); // Google đã verify email rồi

                if (UserDAO.registerGoogleUser(user)) {
                    user = UserDAO.getUserByUsername(googleUser.getEmail());
                }
            }

            // 4. Lưu vào session và vào Home
            request.getSession().setAttribute("auth", user);
            System.out.println("Google Email: " + googleUser.getEmail());
            System.out.println("User Object Username: " + (user != null ? user.getUsername() : "USER NULL"));
            response.sendRedirect(request.getContextPath() + "/home");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=google_login_failed");
        }
    }

    public String getToken(String code) throws IOException {
        String response = Request.Post(LINK_GET_TOKEN)
                .bodyForm(Form.form()
                        .add("client_id", CLIENT_ID)
                        .add("client_secret", CLIENT_SECRET)
                        .add("redirect_uri", REDIRECT_URI)
                        .add("code", code)
                        .add("grant_type", "authorization_code")
                        .build())
                .execute().returnContent().asString();

        JsonObject jobj = new Gson().fromJson(response, JsonObject.class);
        return jobj.get("access_token").getAsString();
    }

    private GoogleUserInfo getUserInfo(String accessToken) throws IOException {
        String response = Request.Get(LINK_GET_USER_INFO + "?access_token=" + accessToken)
                .execute().returnContent().asString();
        return new Gson().fromJson(response, GoogleUserInfo.class);
    }
}
package vn.edu.hcmuaf.edu.vn.campforge.service;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;

public class EmailService {

    private static final String HOST = "smtp.gmail.com";
    private static final String PORT = "465";
    private static final String USERNAME = "anhtuan220704@gmail.com";
    private static final String PASSWORD = "blxk dkjm tuuv ajph";

    public static boolean sendResetEmail(String toEmail, String token) {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.host", HOST);
        props.put("mail.smtp.port", PORT);
        // Bắt buộc thêm 2 dòng dưới đây cho cổng 465
        props.put("mail.smtp.socketFactory.port", PORT);
        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(USERNAME, PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(USERNAME, "Camp Forge Support")); // Thêm tên hiển thị
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Đặt lại mật khẩu - Camp Forge");

            String resetLink = "http://localhost:8080/campforge_war/reset-password?token=" + token;
            String htmlContent = "<div style='font-family: Arial, sans-serif;'>"
                    + "<h3>Yêu cầu đặt lại mật khẩu</h3>"
                    + "<p>Bạn nhận được email này vì đã yêu cầu đổi mật khẩu tại <b>Camp Forge</b>.</p>"
                    + "<p>Vui lòng click vào nút dưới đây để thực hiện (Hiệu lực trong 15 phút):</p>"
                    + "<a href='" + resetLink + "' style='background: #10b981; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px;'>Đổi mật khẩu ngay</a>"
                    + "<p style='margin-top:20px; color: #666;'>Nếu bạn không yêu cầu, vui lòng bỏ qua email này.</p>"
                    + "</div>";

            message.setContent(htmlContent, "text/html; charset=utf-8");

            Transport.send(message);
            return true;

        } catch (Exception e) { // Dùng Exception chung để bắt cả lỗi mã hóa font
            e.printStackTrace();
            return false;
        }
    }
    public static boolean sendVerifyEmail(String toEmail, String token) {

            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.host", HOST);
            props.put("mail.smtp.port", PORT);
            // Bắt buộc thêm 2 dòng dưới đây cho cổng 465
            props.put("mail.smtp.socketFactory.port", PORT);
            props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");

            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(USERNAME, PASSWORD);
                }
            });
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(USERNAME, "Camp Forge"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Kích hoạt tài khoản Camp Forge");

            String verifyLink = "http://localhost:8080/campforge_war/verify?token=" + token;
            String htmlContent = "<div style='font-family: Arial; padding: 20px; border: 1px solid #eee; border-radius: 10px;'>"
                    + "<h2>Chào mừng bạn đến với Camp Forge!</h2>"
                    + "<p>Vui lòng nhấn vào nút bên dưới để xác thực tài khoản của bạn:</p>"
                    + "<a href='" + verifyLink + "' style='background: #111827; color: white; padding: 12px 25px; text-decoration: none; border-radius: 8px; display: inline-block;'>Xác nhận tài khoản</a>"
                    + "<p style='margin-top:20px; color: #666;'>Link có hiệu lực trong 24 giờ.</p>"
                    + "</div>";

            message.setContent(htmlContent, "text/html; charset=utf-8");
            Transport.send(message);
            return true;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }
}
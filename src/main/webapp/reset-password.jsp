<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Đặt lại mật khẩu — Camp Forge</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="./assets/css/login.css">
</head>
<body>
<main class="shell">
    <section class="visual">
        <div class="brand">
            <img src="./assets/img/logo_new.png" alt="Camp Forge logo">
            <h1>Camp Forge</h1>
        </div>
        <div class="tag">
            <h2>Đặt lại mật khẩu mới.</h2>
            <p>Đảm bảo mật khẩu của bạn có tính bảo mật cao để bảo vệ tài khoản.</p>
        </div>
        <div class="badges">
            <div class="chip">Riêng tư & an toàn</div>
            <div class="chip">Mã hóa dữ liệu</div>
        </div>
    </section>

    <section class="panel">
        <div class="card">
            <h2>Cập nhật mật khẩu</h2>
            <p class="sub">Nhập mật khẩu mới cho tài khoản của bạn bên dưới.</p>

            <form action="reset-password" method="post" id="resetForm">
                <input type="hidden" name="token" value="${token}">

                <div class="field">
                    <input id="newPassword" name="password" class="input" type="password" placeholder=" " required />
                    <label class="label" for="newPassword">Mật khẩu mới</label>
                </div>

                <div class="field">
                    <input id="rePassword" class="input" type="password" placeholder=" " required />
                    <label class="label" for="rePassword">Xác nhận mật khẩu mới</label>
                </div>

                <%-- Hiển thị thông báo lỗi nếu có từ Servlet --%>
                <% String error = (String) request.getAttribute("error"); %>
                <% if (error != null) { %>
                <p style="color: #ef4444; font-size: 13px; margin-bottom: 10px;"><%= error %></p>
                <% } %>

                <button class="btn" type="submit">Lưu mật khẩu mới</button>

                <p class="tiny">
                    Quay lại <a href="login.jsp" style="color: var(--brand); font-weight: 600;">Đăng nhập</a>
                </p>
            </form>
        </div>
    </section>
</main>

<script>
    // Kiểm tra mật khẩu khớp nhau trước khi gửi form
    const form = document.getElementById('resetForm');
    const pass = document.getElementById('newPassword');
    const rePass = document.getElementById('rePassword');

    form.addEventListener('submit', (e) => {
        if (pass.value !== rePass.value) {
            e.preventDefault();
            alert('Mật khẩu xác nhận không khớp! Vui lòng kiểm tra lại.');
        }
    });
</script>
</body>
</html>
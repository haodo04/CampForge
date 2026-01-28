<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Create account — Register</title>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet" />
  <link rel="stylesheet" href="./assets/css/register.css">
  <link rel="stylesheet" href="./assets/css/login.css">
</head>

<body>
<main class="shell" role="main" aria-label="Register layout">
  <section class="visual" aria-hidden="true">
    <div class="brand">
      <img src="./assets/img/logo.png" alt="Camp Forge logo">
      <h1>CampForge</h1>
    </div>
    <div class="tag">
      <h2>Tạo tài khoản của bạn</h2>
    </div>
  </section>

  <section class="panel">
    <div class="card">
      <h2>Tạo Tài Khoản</h2>
      <p class="sub">Điền đầy đủ thông tin của bạn để bắt đầu.</p>

      <% String error = (String) request.getAttribute("error"); %>
      <% if (error != null) { %>
      <div style="background-color: #fff1f0; color: #ff4d4f; padding: 10px; border: 1px solid #ffccc7; border-radius: 4px; margin-bottom: 15px; font-size: 0.85rem;">
        <strong>Lỗi:</strong> <%= error %>
      </div>
      <% } %>

      <form id="registerForm" action="register" method="post">

        <div class="field">
          <input id="fullName" class="input" type="text" name="fullName" placeholder=" " required />
          <label class="label" for="fullName">Full Name</label>
        </div>

        <div class="field">
          <input id="username" class="input" type="text" name="username" placeholder=" " required />
          <label class="label" for="username">Username</label>
          <div class="err" id="userErr">Tên đăng nhập không hợp lệ.</div>
        </div>

        <div class="field">
          <input id="regEmail" class="input" type="email" name="email" placeholder=" " required />
          <label class="label" for="regEmail">Email Address</label>
        </div>

        <div class="field">
          <input id="regPassword" class="input" type="password" name="password" minlength="6" placeholder=" " required />
          <label class="label" for="regPassword">Password</label>
          <button class="toggle" type="button" onclick="togglePw('regPassword', this)">hiện</button>
        </div>

        <div class="field">
          <input id="confirm" class="input" type="password" name="rePassword" minlength="6" placeholder=" " required />
          <label class="label" for="confirm">Confirm Password</label>
          <button class="toggle" type="button" onclick="togglePw('confirm', this)">hiện</button>
        </div>

        <label class="terms">
          <input id="agree" type="checkbox" name="agree" required>
          <span>Tôi đồng ý với <a href="#">Điều khoản</a> và <a href="#">Chính sách bảo mật</a>.</span>
        </label>

        <button id="createBtn" class="btn" type="submit">Tạo Tài Khoản</button>
        <div class="oauth">

          <button type="button" class="sbtn fb">
            <i class="fa-brands fa-facebook"></i>
            Facebook
          </button>

          <button type="button" class="sbtn gg">
            <a href="https://accounts.google.com/o/oauth2/auth?scope=email%20profile&redirect_uri=http://localhost:8080/campforge_war/login-google&response_type=code&client_id=1077549100477-97ee4he5fe0niock79ri485igr55ed1o.apps.googleusercontent.com"
               class="sbtn gg">
              <i class="fa-brands fa-google"></i> Google
            </a>
          </button>

        </div>

        <p class="tiny">Bạn đã có tài khoản? <a href="login.jsp">Đăng nhập</a></p>
      </form>
    </div>
  </section>
</main>
<script src="./assets/js/register.js"></script>
</body>
</html>
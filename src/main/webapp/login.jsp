<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Đăng nhập — Camp Forge</title>

  <!-- Font + Icons -->
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

  <!-- CSS -->
  <link rel="stylesheet" href="./assets/css/login.css">
</head>

<body>
  <main class="shell" role="main">

    <!-- LEFT AREA -->
    <section class="visual">
      <div class="brand">
        <img src="./assets/img/logo_new.png" alt="Camp Forge logo">
        <h1>Camp Forge</h1>
      </div>

      <div class="tag">
        <h2>Nhẹ nhàng, sạch sẽ, dễ sử dụng.</h2>
      </div>

      <div class="badges">
        <div class="chip">Riêng tư & an toàn</div>
        <div class="chip">Không gây xao nhãng</div>
        <div class="chip">Tối giản & dễ sử dụng</div>
      </div>
    </section>

    <!-- RIGHT AREA -->
    <section class="panel">
      <div class="card">
        <h2>Chào mừng trở lại</h2>
        <p class="sub">Nhập email và mật khẩu để tiếp tục.</p>

        <form id="form" action="login" method="POST" novalidate>
          <% if(request.getAttribute("error") != null) { %>
          <div style="color: #ef4444; margin-bottom: 10px; font-size: 14px;">
            <%= request.getAttribute("error") %>
          </div>
          <% } %>
          <div class="field">
            <input id="username" name="username" class="input" type="text" placeholder=" " required />
            <label class="label" for="username">Tên đăng nhập</label>
          </div>

          <div class="field">
            <input id="password" name="password" class="input" type="password" placeholder=" " minlength="6" required />
            <label class="label" for="password">Mật khẩu</label>
            <button class="toggle" type="button" onclick="togglePw()">Hiện</button>
          </div>

          <div class="row">
            <label class="remember"><input type="checkbox" id="remember"> Ghi nhớ đăng nhập</label>
            <a href="forgot-password.jsp" class="link">Quên mật khẩu?</a>
          </div>

          <button id="submit" class="btn" type="submit">Đăng nhập</button>

          <div class="or"><span>hoặc</span></div>

          <!-- OAUTH BUTTONS -->
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

          <p class="tiny">
            Khi tiếp tục, bạn đồng ý với <a href="#">Điều khoản</a> và 
            <a href="#">Chính sách bảo mật</a>.
          </p>

          <!--Link sang trang đăng ký -->
          <p class="tiny" style="margin-top:16px;">
            Chưa có tài khoản?  
            <a href="register.jsp" style="color: var(--brand); font-weight: 600;">
              Đăng ký ngay
            </a>
          </p>

        </form>
      </div>
    </section>

  </main>

  <script src="./assets/js/login.js"></script>
</body>
</html>

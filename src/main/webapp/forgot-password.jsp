<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Quên mật khẩu — Camp Forge</title>

  <!-- Font + Icons -->
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

  <!-- Dùng lại login.css để đồng bộ giao diện -->
  <link rel="stylesheet" href="./assets/css/login.css">
</head>

<body>
  <main class="shell" role="main">

    <!-- LEFT AREA (giống login) -->
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
        <h2>Quên mật khẩu</h2>
        <p class="sub">
          Nhập email của bạn. Chúng tôi sẽ gửi liên kết để đặt lại mật khẩu (giả lập).
        </p>

        <form id="forgotForm" novalidate>
          <div class="field">
            <input id="forgotEmail" class="input" type="email" placeholder=" " required />
            <label class="label" for="forgotEmail">Email</label>
          </div>

          <button id="forgotSubmit" class="btn" type="submit">Gửi liên kết đặt lại</button>

          <p class="tiny" style="margin-top:16px;">
            Nhớ lại mật khẩu rồi? 
            <a href="login.jsp" style="color: var(--brand); font-weight: 600;">
              Quay lại đăng nhập
            </a>
          </p>
        </form>
      </div>
    </section>

  </main>

  <script src="./assets/js/forgot-password.js"></script>
</body>

</html>

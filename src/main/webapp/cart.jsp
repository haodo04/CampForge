<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Giỏ Hàng</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@flaticon/flaticon-uicons/css/all/all.css"/>
    <link rel="stylesheet" href="assets/css/styles.css">
    <link rel="stylesheet" href="assets/css/cart.css">
    <link rel="stylesheet" href="assets/css/search.css">
</head>
<body>

<div class="header-top"></div>
<section id="header">
    <a href="index.jsp"
    ><img class="logo_img" src="./assets/img/logo_new.png" alt="logo"
    /></a>

    <ul id="navbar">
        <li><a class="active" href="index.jsp">Trang chủ</a></li>
        <li><a href="category.jsp">Danh mục</a></li>
        <li><a href="blog.jsp">Blog</a></li>
        <li><a href="about.jsp">Giới thiệu</a></li>
        <li><a href="contact.jsp">Liên hệ</a></li>
    </ul>

    <div id="right-icons">
        <div id="search-box">
            <input type="text" id="searchInput" placeholder="Tìm sản phẩm..." />
            <button id="searchBtn"><i class="fa fa-search"></i></button>
        </div>
        <a href="cart.jsp"><i class="fa fa-shopping-cart"></i></a>

        <div class="auth-buttons">
            <a href="login.jsp" class="btn-login">Đăng nhập</a>
            <a href="register.jsp" class="btn-register">Đăng ký</a>
        </div>
    </div>
</section>

<!-- ===== Page Header ===== -->
<section id="page-header" class="cart-header">
    <h2>#Giỏ hàng</h2>
    <p>Nhập mã giảm giá & Giảm lên đến 70%!</p>
</section>

<!-- ===== Cart Section ===== -->
<section id="cart" class="section-p1">
    <table width="100%">
        <thead>
        <tr>
            <td>Xóa</td>
            <td>Ảnh</td>
            <td>Tên sản phẩm</td>
            <td>Giá</td>
            <td>Số lượng</td>
            <td>Tổng cộng</td>
        </tr>
        </thead>
        <tbody id="cart-body">
        </tbody>
    </table>

    <!-- Hiển thị khi giỏ trống -->
    <div id="empty-cart" class="empty-message">
        <i class="fa-solid fa-bag-shopping"></i>
        <p>Giỏ hàng của bạn đang trống!</p>
        <a href="category.jsp" class="normal">Tiếp tục mua sắm</a>
    </div>
</section>

<!-- ===== Cart Total ===== -->
<section id="cart-add" class="section-p1">
    <div id="coupon">
        <h3>Mã giảm giá</h3>
        <div>
            <input type="text" placeholder="Nhập mã giảm giá">
            <button class="normal">Áp dụng</button>
        </div>
    </div>

    <div id="subtotal">
        <h3>Tổng giỏ hàng</h3>
        <table>
            <tr>
                <td>Tổng cộng</td>
                <td id="subtotal-value">0 vnđ</td>
            </tr>
            <tr>
                <td>Vận chuyển</td>
                <td>Miễn phí</td>
            </tr>
            <tr>
                <td><strong>Tổng cộng</strong></td>
                <td id="total-value"><strong>0 vnđ</strong></td>
            </tr>
        </table>
        <button id="checkoutBtn" class="normal">Thanh toán</button>
    </div>
</section>

<section id="newsletter" class="section-p1">
    <div class="newstext">
        <h4>Đăng ký nhận tin</h4>
        <p>Nhập email về cập nhật mới nhất <span>ưu đãi đặc biệt.</span></p>
    </div>
    <div class="form">
        <input type="text" placeholder="Nhập email của bạn">
        <button class="normal">Đăng ký</button>
    </div>
</section>

<footer class="section-p1">
      <div class="col">
        <h4>Liên hệ</h4>
        <p>
          <strong>Địa chỉ: </strong> 562 Phường Linh Trung, Khu phố 6, TP.Thủ
          Đức, HCM
        </p>
        <p><strong>Điện thoại: </strong> +01 2222 365 /(+91) 01 2345 6789</p>
        <p><strong>Giờ mở cửa: </strong> 10:00 - 18:00, T2 - T7</p>
        <div class="follow">
          <h4>Theo dõi chúng tôi</h4>
          <div class="icon">
            <i class="fab fa-facebook-f"></i>
            <i class="fab fa-twitter"></i>
            <i class="fab fa-instagram"></i>
            <i class="fab fa-pinterest-p"></i>
            <i class="fab fa-youtube"></i>
          </div>
        </div>
      </div>
      <div class="col">
        <h4>Giới thiệu</h4>
        <a href="#">Về chúng tôi</a>
        <a href="#">Thông tin giao hàng</a>
        <a href="#">Chính sách</a>
        <a href="#">Điều khoản</a>
        <a href="#">Liên hệ</a>
      </div>
      <div class="col">
        <h4>Tài khoản</h4>
        <a href="#">Đăng ký</a>
        <a href="#">Giỏ hàng</a>
        <a href="#">Yêu thích</a>
        <a href="#">Đơn hàng</a>
        <a href="#">Trợ giúp</a>
      </div>
      <div class="col install">
        <h4>Tải ứng dụng</h4>
        <p>Trên App Store hoặc Google Play</p>
        <div class="app-row">
          <img src="./assets/img/pay/app.jpg" alt="" />
          <img src="./assets/img/pay/play.jpg" alt="" />
        </div>
        <p>Bảo mật cổng thanh toán</p>
        <img src="./assets/img/pay/pay.png" alt="" />
      </div>
      <div class="copyright">
        <p>@ 2025, CampShop - HTML CSS Ecommerce Website</p>
      </div>
</footer>

<script src="./assets/js/cart.js"></script>
</body>
</html>
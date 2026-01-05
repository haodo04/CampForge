<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Khuyến Mãi</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
    <link rel="stylesheet" href="assets/css/styles.css">
    <link rel="stylesheet" href="assets/css/promotion.css">
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
    />
    <link
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"
            rel="stylesheet"
    />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@flaticon/flaticon-uicons/css/all/all.css"/>
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
            <%
                // Lấy đối tượng User từ session
                vn.edu.hcmuaf.edu.vn.campforge.model.User user =
                        (vn.edu.hcmuaf.edu.vn.campforge.model.User) session.getAttribute("auth");

                if (user == null) {
            %>
            <a href="login.jsp" class="btn-login">Đăng nhập</a>
            <a href="register.jsp" class="btn-register">Đăng ký</a>
            <% } else { %>
            <div class="user-dropdown">
            <span class="user-name">
                Xin chào, <strong><%= user.getUsername() %></strong>
                <i class="fa fa-caret-down"></i>
            </span>
                <div class="dropdown-content">
                    <a href="personal.jsp"><i class="fa fa-user"></i> Thông tin cá nhân</a>
                    <hr>
                    <a href="index.jsp" class="logout-link"><i class="fa fa-sign-out-alt"></i> Đăng xuất</a>
                </div>
            </div>
            <% } %>
        </div>
    </div>
</section>

<!-- ===== Page Header ===== -->
<section id="page-header" class="promotion-header">
    <h2>Khuyến Mãi sốc</h2>
    <p>Ưu đãi trong hôm nay giảm lên tới <span>30%</span></p>
</section>

<section id="product1" class="section-p1">
    <h2>Promotion Products</h2>
    <div class="pro-container">
        <div class="pro">
            <span class="sale-badge">-30%</span>
            <img src="./assets/img/products/f1.jpg" alt="" />
            <div class="des">
                <span>BLACKDOG</span>
                <h5>Lều trung tâm (lều tăng) BLACKDOG</h5>
                <div class="star">
                    <i class="fas fa-star"></i><i class="fas fa-star"></i>
                    <i class="fas fa-star"></i><i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                </div>

                <div class="price-box">
                    <h4 class="new-price">300.000đ</h4>
                    <del class="old-price">400.000đ</del>
                </div>
                <a href="cart.jsp" class="add-cart" aria-label="Thêm vào giỏ"
                ><i class="cart fi fi-sr-shopping-cart"></i></a>
            </div>
        </div>

        <div class="pro">
            <span class="sale-badge hot">HOT</span>
            <img src="./assets/img/products/f2.png" alt="" />
            <div class="des">
                <span>adidas</span>
                <h5>Lều 6 người BLACKDOG Mountain Garden</h5>
                <div class="star">
                    <i class="fas fa-star"></i><i class="fas fa-star"></i>
                    <i class="fas fa-star"></i><i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                </div>

                <div class="price-box">
                    <h4 class="new-price">620.000đ</h4>
                    <del class="old-price">780.000đ</del>
                </div>
                <a href="#" class="add-cart" aria-label="Thêm vào giỏ"
                ><i class="cart fi fi-sr-shopping-cart"></i></a>
            </div>
        </div>

        <div class="pro">
            <span class="sale-badge new">NEW</span>
            <img src="./assets/img/products/balo1.jpg" alt="" />
            <div class="des">
                <span>MADFOX</span>
                <h5>Áo mưa trùm ba lô 35L MADFOX RC35B</h5>
                <div class="star">
                    <i class="fas fa-star"></i><i class="fas fa-star"></i>
                    <i class="fas fa-star"></i><i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                </div>

                <div class="price-box">
                    <h4 class="new-price">550.000đ</h4>
                    <del class="old-price">700.000đ</del>
                </div>
                <a href="#" class="add-cart" aria-label="Thêm vào giỏ"
                ><i class="cart fi fi-sr-shopping-cart"></i></a>
            </div>
        </div>

        <div class="pro">
            <span class="sale-badge">-20%</span>
            <img src="./assets/img/products/f4.png" alt="" />
            <div class="des">
                <span>NATUREHIKE</span>
                <h5>Lều 2 - 3 người, 2 lớp Naturehike</h5>
                <div class="star">
                    <i class="fas fa-star"></i><i class="fas fa-star"></i>
                    <i class="fas fa-star"></i><i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                </div>

                <div class="price-box">
                    <h4 class="new-price">380.000đ</h4>
                    <del class="old-price">500.000đ</del>
                </div>
                <a href="#" class="add-cart" aria-label="Thêm vào giỏ"
                ><i class="cart fi fi-sr-shopping-cart"></i></a>
            </div>
        </div>

        <div class="pro">
            <span class="sale-badge hot">HOT DEAL</span>
            <img src="./assets/img/products/f5.jpg" alt="" />
            <div class="des">
                <span>NATUREHIKE</span>
                <h5>Lều 2 - 3 người, 2 lớp Naturehike</h5>
                <div class="star">
                    <i class="fas fa-star"></i><i class="fas fa-star"></i>
                    <i class="fas fa-star"></i><i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                </div>

                <div class="price-box">
                    <h4 class="new-price">600.000đ</h4>
                    <del class="old-price">900.000đ</del>
                </div>
                <a href="#" class="add-cart" aria-label="Thêm vào giỏ"
                ><i class="cart fi fi-sr-shopping-cart"></i></a>
            </div>
        </div>
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="./assets/js/cart.js"></script>
</body>
</html>
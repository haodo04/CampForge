<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Product Details</title>
    <meta name="description" content="" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css"
    />
      <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@flaticon/flaticon-uicons/css/all/all.css"/>
    <link rel="stylesheet" href="./assets/css/styles.css" />
    <link rel="stylesheet" href="./assets/css/sproduct.css" />
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

    <section id="prodetails" class="section-p1">
        <div class="single-pro-image">
            <img src="./assets/img/products/f1.jpg" width="100%" id="MainImg" alt="">

            <div class="small-img-group">
                <div class="small-img-col">
                    <img src="./assets/img/products/f1.jpg" width="100%" class="small-img" alt="">
                </div>
                <div class="small-img-col">
                    <img src="./assets/img/products/f2.png" width="100%" class="small-img" alt="">
                </div>
                <div class="small-img-col">
                    <img src="./assets/img/products/f3.jpg" width="100%" class="small-img" alt="">
                </div>
                <div class="small-img-col">
                    <img src="./assets/img/products/f4.png" width="100%" class="small-img" alt="">
                </div>
            </div>
        </div>
        <div class="single-pro-details">
          <h6>Home / Lều trung tâm</h6>
          <h4>Lều trung tâm (lều tăng) BLACKDOG</h4>
          <h2>1.750.000đ</h2>
          <select>
            <option>Select Size</option>
            <option>XL</option>
            <option>XXL</option>
            <option>Small</option>
            <option>Large</option>
          </select>
          <input type="number" value="1">
          <button class="normal add-to-cart"
                  data-name="lều tăng"
                  data-price="1.750.000đ"
                  data-image="images/products/f1.jpg">Thêm Vào Giỏ Hàng</button>
          <h4>Mô tả sản phẩm</h4>
          <span>Sản phẩm Lều 2-3 người 2 lớp cắm trại Naturehike CNK2300ZP024 là một lựa chọn tốt cho những ai yêu thích hoạt động cắm trại hoặc du lịch ngoài trời.
              Được thiết kế với kích thước vừa phải, lều này có khả năng chứa được 2 đến 3 người,
              tạo ra không gian thoải mái để ngủ và nghỉ ngơi.Lều CNK2300ZP024 có cấu trúc 2 lớp,
              giúp bảo vệ người dùng khỏi các yếu tố thời tiết như mưa, gió hay nắng chói chang.
              Lớp ngoài chống thấm nước tốt, đảm bảo bên trong lều luôn khô ráo và thoải mái.
              Lớp trong có thể tháo rời, giúp tiện lợi trong việc vệ sinh và bảo dưỡng lều.</span>
        </div>
    </section>

    <section id="product1" class="section-p1">
      <h2>Sản Phẩm Liên Quan</h2>
      <p>Bộ sưu tập lều mới</p>
      <div class="pro-container">
        <div class="pro">
          <img src="./assets/img/products/f5.jpg" alt="" />
          <div class="des">
            <span>adidas</span>
            <h5>Lều trung tâm (lều tăng) BLACKDOG</h5>
            <div class="star">
              <i class="fas fa-star"></i>
              <i class="fas fa-star"></i>
              <i class="fas fa-star"></i>
              <i class="fas fa-star"></i>
              <i class="fas fa-star"></i>
            </div>
            <h4>970.000đ</h4>
            <a href="#"><i class="cart fi fi-sr-shopping-cart"></i></a>
          </div>
        </div>
        <div class="pro">
          <img src="./assets/img/products/f7.jpg" alt="" />
          <div class="des">
            <span>adidas</span>
            <h5>Lều trung tâm (lều tăng) BLACKDOG</h5>
            <div class="star">
              <i class="fas fa-star"></i>
              <i class="fas fa-star"></i>
              <i class="fas fa-star"></i>
              <i class="fas fa-star"></i>
              <i class="fas fa-star"></i>
            </div>
            <h4>780.000đ</h4>
            <a href="#"><i class="cart fi fi-sr-shopping-cart"></i></a>
          </div>
        </div>
        <div class="pro">
          <img src="./assets/img/products/f4.png" alt="" />
          <div class="des">
            <span>adidas</span>
            <h5>Lều trung tâm (lều tăng) BLACKDOG</h5>
            <div class="star">
              <i class="fas fa-star"></i>
              <i class="fas fa-star"></i>
              <i class="fas fa-star"></i>
              <i class="fas fa-star"></i>
              <i class="fas fa-star"></i>
            </div>
            <h4>1.200.000đ</h4>
            <a href="#"><i class="cart fi fi-sr-shopping-cart"></i></a>
          </div>
        </div>
        <div class="pro">
          <img src="./assets/img/products/f2.png" alt="" />
          <div class="des">
            <span>adidas</span>
            <h5>Lều trung tâm (lều tăng) BLACKDOG</h5>
            <div class="star">
              <i class="fas fa-star"></i>
              <i class="fas fa-star"></i>
              <i class="fas fa-star"></i>
              <i class="fas fa-star"></i>
              <i class="fas fa-star"></i>
            </div>
            <h4>1.560.000đ</h4>
            <a href="#"><i class="cart fi fi-sr-shopping-cart"></i></a>
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

  </body>
</html>

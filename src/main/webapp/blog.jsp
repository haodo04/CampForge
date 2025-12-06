<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Blog</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@flaticon/flaticon-uicons/css/all/all.css"/>
    <link rel="stylesheet" href="/assets/css/styles.css">
    <link rel="stylesheet" href="/assets/css/blog.css">
    <link rel="stylesheet" href="assets/css/search.css">
</head>
<body>
<div class="header-top"></div>
<section id="header">
    <a href="index.jsp"
    ><img class="logo_img" src="./assets/img/logo_new.png" alt="logo"
    /></a>

    <ul id="navbar">
        <li><a href="index.jsp">Trang chủ</a></li>
        <li><a href="category.jsp">Danh mục</a></li>
        <li><a class="active" href="blog.html">Blog</a></li>
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
<section id="page-header" class="blog-header">
    <h2>#Chuẩn bị tốt – chuyến đi tốt.</h2>
    <p>
        KINH NGHIỆM LỰA CHỌN ĐỒ DÃ NGOẠI &amp; KỸ NĂNG CẮM TRẠI - SINH TỒN, LEO NÚI, TREKKING
    </p>
</section>

<section id="blog">
    <div class="blog-box">
        <div class="blog-img">
            <img src="/assets/img/blog/b1.jpg" alt="">
        </div>
        <div class="blog-details">
            <h4>Dụng cụ sinh tồn đánh lửa chọn loại nào phù hợp</h4>
            <p>Đây là 2 thanh đánh lửa sinh tồn&nbsp;Magnesium, chỉ khác nhau mỗi hình dạng?Đa phần mọi người nghĩ như&nbsp;vậy vì hầu hết những người bán hàng trôi nổi đều gọi chúng là "Thanh Ma-giê", nhưng SAI!!! 2 món này khác nhau hoàn toàn từ bản...</p>
            <a href="#">Còn tiếp</a>
            <h1>13/01</h1>
        </div>
    </div>
    <div class="blog-box">
        <div class="blog-img">
            <img src="/assets/img/blog/b2.png" alt="">
        </div>
        <div class="blog-details">
            <h4>BA LÔ CỦA BẠN NÊN NẶNG BAO NHIÊU</h4>
            <p>Gói trọng lượng cho ba lô và đi bộ đường dài:
                Khi xác định trọng lượng gói của bạn, hãy làm theo các hướng dẫn sau:
                Một gói ba lô đã tải không được nặng hơn 20 phần trăm trọng lượng cơ thể của bạn. (Nếu bạn...</p>
            <a href="#">Còn tiếp</a>
            <h1>13/01</h1>
        </div>
    </div>
    <div class="blog-box">
        <div class="blog-img">
            <img src="/assets/img/blog/b3.png" alt="">
        </div>
        <div class="blog-details">
            <h4>Kinh nghiệm đi leo núi một mình - Độc hành an toàn</h4>
            <p>​
                Leo núi một mình có gì thú vị?
                Cần chuẩn bị những gì cho chuyến độc hành an toàn?
                Kinh nghiệm leo núi một mình
                1. Leo núi một mình có gì thú vị?
                Một câu hỏi khá ngớ ngẩn đế bắt đầu topic này. "Leo núi một mình...</p>
            <a href="#">Còn tiếp</a>
            <h1>13/01</h1>
        </div>
    </div>
    <div class="blog-box">
        <div class="blog-img">
            <img src="/assets/img/blog/b4.jpg" alt="">
        </div>
        <div class="blog-details">
            <h4>Chỉ số chống thấm nước của vải, rất quan trọng với dân Outdoor</h4>
            <p> Waterproof - Có nghĩa là chống thấm nước, nhưng khi khái niệm này đi cùng một con số (vd: 1000mm, 3000mm,...) thì có nghĩa là khả năng chống thấm này có giới hạn, không phải là một khái niệm tuyệt đối. Vậy phải hiểu và...</p>
            <a href="#">Còn tiếp</a>
            <h1>13/01</h1>
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
          <img src="/assets/img/pay/app.jpg" alt="" />
          <img src="/assets/img/pay/play.jpg" alt="" />
        </div>
        <p>Bảo mật cổng thanh toán</p>
        <img src="/assets/img/pay/pay.png" alt="" />
      </div>
      <div class="copyright">
        <p>@ 2025, CampShop - HTML CSS Ecommerce Website</p>
      </div>
</footer>

</body>
</html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<fmt:setLocale value="vi_VN" />
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Web</title>
    <meta name="description" content="" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"
    />
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/@flaticon/flaticon-uicons/css/all/all.css"
    />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styles.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/search.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
      <style>
          .title-decor::before {
              content: "";
              background-image: url('${pageContext.request.contextPath}/assets/img/decor-left.png');
          }
          #hero button {
              background-image: url("${pageContext.request.contextPath}/assets/img/button.png");
          }
          .title-decor::after {
              content: "";
              background-image: url('${pageContext.request.contextPath}/assets/img/decor-left.png');
          }
      </style>
  </head>
  <body>
  <c:set var="hero" value="${homeBanners['home_hero']}" />
  <c:set var="heroBg" value="${ctx}/assets/img/banner/banner11.jpg" />
  <c:if test="${not empty b_hero && not empty b_hero.imageUrl}">
      <c:choose>
          <c:when test="${fn:startsWith(b_hero.imageUrl,'http')}">
              <c:set var="heroBg" value="${b_hero.imageUrl}" />
          </c:when>
          <c:otherwise>
              <c:set var="heroBg" value="${ctx}${b_hero.imageUrl}" />
          </c:otherwise>
      </c:choose>
  </c:if>

  <c:set var="heroHref" value="${ctx}/category" />
  <c:if test="${not empty b_hero && not empty b_hero.linkUrl}">
      <c:set var="heroHref" value="${ctx}${b_hero.linkUrl}" />
  </c:if>


  <div class="header-top"></div>
  <section id="header">
      <a href="index.jsp"><img class="logo_img" src="./assets/img/logo_new.png" alt="logo"></a>
      <ul id="navbar">
          <li><a href="${pageContext.request.contextPath}/home" class="active">Trang chủ</a></li>
          <li><a href="${pageContext.request.contextPath}/category">Danh mục</a></li>
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


  <section id="hero" style="background-image: url(${pageContext.request.contextPath}${heroBg});">
      <h1>Ưu đãi cực lớn</h1>
      <p>Giảm giá lên đến 70%!</p>
      <a href="${pageContext.request.contextPath}/promotion"><button>Mua ngay</button></a>
  </section>

    <div class="intro-container">
        <div class="intro-row">
            <div class="intro-left">
                <img
                    src="https://plus.unsplash.com/premium_photo-1681882053622-605daf9b9d73?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
                    alt="Giới thiệu trang web"
                />
            </div>

            <div class="intro-right">
                <h2 class="intro-title">GIỚI THIỆU</h2>
                <div class="intro-block">
                    <h3 class="intro-subtitle">Sản phẩm đa dạng – phù hợp mọi chuyến đi</h3>
                      <p>
                          Bộ sưu tập hơn 150 sản phẩm cắm trại và du lịch, được chọn lọc kỹ lưỡng từ nhiều thương hiệu uy tín.
                          Đầy đủ danh mục: lều trại, túi ngủ, bàn ghế dã ngoại, dụng cụ sinh tồn, balo chống nước và phụ kiện tiện ích.
                          Phù hợp cho cả người mới bắt đầu lẫn những tín đồ trekking chuyên nghiệp.
                      </p>
                </div>
                <div class="intro-block">
                    <h3 class="intro-subtitle">Độ bền cao – an toàn trong mọi điều kiện</h3>
                      <p>
                          Tất cả sản phẩm được chế tạo từ vật liệu cao cấp như sợi tổng hợp chống rách, hợp kim nhôm siêu nhẹ, 
                          vải canvas chống thấm đạt tiêu chuẩn quốc tế.  
                          Thiết kế tối ưu cho môi trường ngoài trời, đảm bảo độ bền – tính ổn định – sự an toàn khi sử dụng.  
                          Mỗi sản phẩm đều được kiểm tra chất lượng trước khi lên kệ để đồng hành cùng bạn trong mọi hành trình.
                      </p>
                </div>
            </div>
        </div>
    </div>

    <section id="feature" class="section-p1">
        <div class="section-title">
            <h2>DANH MỤC NỔI BẬT</h2>
            <p>Khám phá các nhóm sản phẩm dã ngoại & cắm trại phổ biến</p>
        </div>
        <div class="feature-list">
            <c:forEach items="${featuredCategories}" var="c">
                <a href="${pageContext.request.contextPath}/category?id=${c.id}" class="fe-box">
                    <img src="${pageContext.request.contextPath}${c.image}" alt="${c.cateName}" />
                    <h6>${c.cateName}</h6>
                </a>
            </c:forEach>
        </div>
    </section>

    <section id="product1" class="section-p1">
      <h3 class="title-decor">SẢN PHẨM MỚI NHẤT</h3>
      <p>Bộ sưu tập mùa hè với thiết kế mới</p>
      <div class="pro-container">
        <c:forEach items="${latestProducts}" var="p">
          <div class="pro">
            <a href="${pageContext.request.contextPath}/product?id=${p.id}">
              <c:choose>
                <c:when test="${empty p.image}">
                  <img src="${pageContext.request.contextPath}/assets/img/products/no-image.png" alt="${p.proName}" />
                </c:when>

                <c:when test="${fn:startsWith(p.image, 'http')}">
                  <img src="${p.image}" alt="${p.proName}" />
                </c:when>

                <c:otherwise>
                  <img src="${pageContext.request.contextPath}${p.image}" alt="${p.proName}" />
                </c:otherwise>
              </c:choose>
            </a>

            <div class="des">
              <span><c:out value="${p.brandName}" default="(Không rõ hãng)"/></span>
              <h5><c:out value="${p.proName}"/></h5>

              <div class="star">
                <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i>
              </div>

              <h4>
                <fmt:formatNumber value="${p.price}" type="number" groupingUsed="true"/>đ
              </h4>
            </div>

            <a href="${pageContext.request.contextPath}/cart?action=add&productId=${p.id}">
              <i class="cart fi fi-sr-shopping-cart"></i>
            </a>
          </div>
        </c:forEach>

        <c:if test="${empty latestProducts}">
          <p style="padding:12px 0;">Chưa có sản phẩm mới.</p>
        </c:if>
      </div>
    </section>

  <c:set var="brandBanner" value="${homeBanners['home_brand']}" />

  <c:set var="brandBg" value="/assets/img/banner/banner03.jpg" />
  <c:if test="${not empty brandBanner && not empty brandBanner.imageUrl}">
      <c:set var="brandBg" value="${brandBanner.imageUrl}" />
  </c:if>
    <section id="banner"
           class="section-m1"
           style="background-image: url(${pageContext.request.contextPath}${brandBg});">
      <h4>Sản phẩm chính hãng</h4>
      <h2>Rất nhiều<span>thương hiệu</span> - Nổi tiếng toàn quốc</h2>
      <button class="normal">Xem thêm</button>
    </section>

    <section id="product1" class="section-p1">
      <h3 class="title-decor">SẢN PHẨM BÁN CHẠY</h3>
      <p>Các sản phẩm bán chạy nhất cửa hàng</p>
      <div class="pro-container">
        <c:forEach items="${bestSellerProducts}" var="p">
          <div class="pro">
            <a href="${pageContext.request.contextPath}/product?id=${p.id}">
              <c:choose>
                <c:when test="${empty p.image}">
                  <img src="${pageContext.request.contextPath}/assets/img/products/no-image.png" alt="${p.proName}" />
                </c:when>

                <c:when test="${fn:startsWith(p.image, 'http')}">
                  <img src="${p.image}" alt="${p.proName}" />
                </c:when>

                <c:otherwise>
                  <img src="${pageContext.request.contextPath}${p.image}" alt="${p.proName}" />
                </c:otherwise>
              </c:choose>
            </a>

            <div class="des">
              <span><c:out value="${p.brandName}" default="(Không rõ hãng)"/></span>
              <h5><c:out value="${p.proName}"/></h5>

              <div class="star">
                <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i>
              </div>

              <h4>
                <fmt:formatNumber value="${p.price}" type="number" groupingUsed="true"/>đ
              </h4>
            </div>

            <a href="${pageContext.request.contextPath}/cart?action=add&productId=${p.id}">
              <i class="cart fi fi-sr-shopping-cart"></i>
            </a>
          </div>
        </c:forEach>

        <c:if test="${empty bestSellerProducts}">
          <p style="padding:12px 0;">Chưa có sản phẩm bán chạy.</p>
        </c:if>
      </div>
    </section>

  <c:set var="promoBanner" value="${homeBanners['home_promo']}" />
  <c:set var="springBanner" value="${homeBanners['home_spring']}" />

  <c:set var="promoBg" value="/assets/img/banner/banner04.png" />
  <c:if test="${not empty promoBanner && not empty promoBanner.imageUrl}">
      <c:set var="promoBg" value="${promoBanner.imageUrl}" />
  </c:if>

  <c:set var="springBg" value="/assets/img/banner/banner06.png" />
  <c:if test="${not empty springBanner && not empty springBanner.imageUrl}">
      <c:set var="springBg" value="${springBanner.imageUrl}" />
  </c:if>

  <section id="sm-banner" class="section-p1">
      <div class="banner-box"
           style="background-image: url(${pageContext.request.contextPath}${promoBg});">
          <h4>Ưu đãi cực sốc</h4>
          <h2>Mua 1 tặng 1</h2>
          <span>Áp dụng cho các sản phẩm cắm trại nổi bật</span>
          <button class="white"><a href="promotion.jsp">Xem chi tiết</a></button>
      </div>
      <div class="banner-box banner-box2"
           style="background-image: url(${pageContext.request.contextPath}${springBg});">
          <h4>Xuân – Hè</h4>
          <h2>Bộ sưu tập mới</h2>
          <span>Trang bị đầy đủ cho mùa trekking sắp tới</span>
          <button class="white">Khám phá ngay</button>
      </div>
  </section>

  <c:set var="seasonBanner" value="${homeBanners['home_season']}" />
  <c:set var="outdoorBanner" value="${homeBanners['home_outdoor']}" />
  <c:set var="pinicBanner" value="${homeBanners['home_pinic']}" />

  <c:set var="seasonBg" value="/assets/img/banner/banner03.jpg" />
  <c:if test="${not empty seasonBanner && not empty seasonBanner.imageUrl}">
      <c:set var="seasonBg" value="${seasonBanner.imageUrl}" />
  </c:if>

  <c:set var="outdoorBg" value="/assets/img/banner/banner05.png" />
  <c:if test="${not empty outdoorBanner && not empty outdoorBanner.imageUrl}">
      <c:set var="outdoorBg" value="${outdoorBanner.imageUrl}" />
  </c:if>

  <c:set var="pinicBg" value="/assets/img/banner/banner01.jpeg" />
  <c:if test="${not empty pinicBanner && not empty pinicBanner.imageUrl}">
      <c:set var="pinicBg" value="${pinicBanner.imageUrl}" />
  </c:if>

    <section id="banner3">
        <div class="banner-box"
             style="background-image: url(${pageContext.request.contextPath}${seasonBg});">
        <h2>GIẢM GIÁ THEO MÙA</h2>
        <h3>Bộ sưu tập mùa đông – giảm đến 50%</h3>
      </div>
      <div class="banner-box banner-box2"
           style="background-image: url(${pageContext.request.contextPath}${outdoorBg});">
        <h2>BỘ SƯU TẬP GIÀY – DÉP OUTDOOR</h2>
        <h3>Xuân – Hè 2025</h3>
      </div>
      <div class="banner-box banner-box3"
           style="background-image: url(${pageContext.request.contextPath}${pinicBg});">
        <h2>ÁO THUN DÃ NGOẠI</h2>
        <h3>Xu hướng thiết kế mới</h3>
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

    <script src="assets/js/script.js"></script>
    <script src="assets/js/search.js"></script>
  </body>
</html>

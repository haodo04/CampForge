<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<fmt:setLocale value="vi_VN" scope="session"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Thanh Toán</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@flaticon/flaticon-uicons/css/all/all.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/checkout.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styles.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/search.css">
</head>
<body>
<div class="header-top"></div>
<section id="header">
    <a href="${pageContext.request.contextPath}/home"
    ><img class="logo_img" src="./assets/img/logo_new.png" alt="logo"
    /></a>

    <ul id="navbar">
        <li><a class="active" href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
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
        <a href="${pageContext.request.contextPath}/cart"><i class="fa fa-shopping-cart"></i></a>

        <div class="auth-buttons">
            <%
                // Lấy đối tượng User từ session
                vn.edu.hcmuaf.edu.vn.campforge.model.User user =
                        (vn.edu.hcmuaf.edu.vn.campforge.model.User) session.getAttribute("auth");

                if (user == null) {
            %>
            <a href="${pageContext.request.contextPath}/login" class="btn-login">Đăng nhập</a>
            <a href="${pageContext.request.contextPath}/register" class="btn-register">Đăng ký</a>
            <% } else { %>
            <div class="user-dropdown">
            <span class="user-name">
                Xin chào, <strong><%= user.getUsername() %></strong>
                <i class="fa fa-caret-down"></i>
            </span>
                <div class="dropdown-content">
                    <a href="${pageContext.request.contextPath}/personal"><i class="fa fa-user"></i> Thông tin cá nhân</a>
                    <hr>
                    <a href="${pageContext.request.contextPath}/home" class="logout-link"><i class="fa fa-sign-out-alt"></i> Đăng xuất</a>
                </div>
            </div>
            <% } %>
        </div>
    </div>
</section>

<section id="checkout" class="section-p1">
    <div class="checkout-container">
        <!-- Left side -->
        <div class="checkout-left">
            <h3>Thông tin thanh toán</h3>

            <form id="shipping-form">
                <div class="form-group">
                    <label for="fullname">Họ và tên *</label>
                    <input type="text" id="fullname" placeholder="Nhập họ và tên" required>
                </div>

                <div class="form-group">
                    <label for="email">Địa chỉ email *</label>
                    <input type="email" id="email" placeholder="Nhập địa chỉ email" required>
                </div>

                <div class="form-group">
                    <label for="phone">Số điện thoại *</label>
                    <input type="tel" id="phone" placeholder="Nhập số điện thoại" required>
                </div>

                <div class="form-group">
                    <label>Địa chỉ *</label>
                    <div class="address-row">
                        <select id="city">
                            <option>TP.HCM</option>
                            <option>Hai Noi</option>
                            <option>Dang Nang</option>
                        </select>
                        <select id="district">
                            <option>p1</option>
                            <option>p2</option>
                            <option>p3</option>
                        </select>
                        <select id="ward">
                            <option>xa1</option>
                            <option>xa2</option>
                            <option>xa3</option>
                        </select>
                    </div>
                </div>
            </form>

            <div class="applied-discount">
                <span>Đã áp dụng giảm giá</span>
                <strong id="appliedDiscount">
                    - <fmt:formatNumber value="${discount}" type="number" groupingUsed="true" maxFractionDigits="0"/> đ
                </strong>
            </div>

            <div class="shipping-method">
                <h3>Phương thức giao hàng</h3>
                <label>
                    <input type="radio" name="shipping" value="100000" checked> Giao hàng tiêu chuẩn - 100.000 đ
                </label><br>
                <label>
                    <input type="radio" name="shipping" value="150000"> Giao hàng nhanh - 150.000 đ
                </label>
            </div>


            <div class="payment-method">
                <h3>Phương thức thanh toán</h3>
                <label><input type="radio" name="payment" value="COD" checked> Thanh toán khi nhận hàng (COD)</label><br>
                <label><input type="radio" name="payment" value="VNPAY"> Thanh toán qua VNPAY</label>
            </div>
        </div>

        <!-- Right side -->
        <div class="checkout-right">
            <h3>Đơn hàng của bạn</h3>

            <c:choose>
                <c:when test="${empty items}">
                    <p style="padding: 12px 0;">Giỏ hàng trống.</p>
                </c:when>
                <c:otherwise>
                    <c:forEach var="it" items="${items}">
                        <div class="cart-item">
                            <img src="${ctx}${it.imagePath}" alt="<c:out value='${it.proName}'/>">

                            <div class="details">
                                <p class="name"><c:out value="${it.proName}"/></p>
                                <p class="color">
                                    <c:if test="${not empty it.color}">Màu: <c:out value="${it.color}"/></c:if>
                                    <c:if test="${not empty it.size}"> - Size: <c:out value="${it.size}"/></c:if>
                                </p>
                                <p class="price">
                                    <fmt:formatNumber value="${it.unitPrice}" type="number" groupingUsed="true" maxFractionDigits="0"/> đ
                                </p>
                            </div>

                            <input type="number" value="${it.quantity}" readonly>

                            <button type="button" title="Xóa">
                                <a href="${ctx}/cart?action=remove&variantId=${it.variantId}">
                                    <i class="fa-solid fa-xmark"></i>
                                </a>
                            </button>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>

            <div class="summary" id="order-summary"
                 data-subtotal="${subtotal}"
                 data-discount="${discount}">
                <div>
                    <span>Tạm tính</span>
                    <span id="sumSubtotal">
                <fmt:formatNumber value="${subtotal}" type="number" groupingUsed="true" maxFractionDigits="0"/> đ
            </span>
                </div>
                <div>
                    <span>Phí giao hàng</span>
                    <span id="sumShipping">
                <fmt:formatNumber value="${shippingFee}" type="number" groupingUsed="true" maxFractionDigits="0"/> đ
            </span>
                </div>
                <div>
                    <span>Đã giảm</span>
                    <span id="sumDiscount">
                - <fmt:formatNumber value="${discount}" type="number" groupingUsed="true" maxFractionDigits="0"/> đ
            </span>
                </div>
                <div class="total">
                    <span>Tổng thanh toán</span>
                    <span id="sumTotal">
                <fmt:formatNumber value="${total}" type="number" groupingUsed="true" maxFractionDigits="0"/> đ
            </span>
                </div>
            </div>

            <button class="normal" form="shipping-form" type="submit" ${empty items ? "disabled" : ""}>
                Thanh toán
            </button>
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
<script>
    (function () {
        const fmt = new Intl.NumberFormat("vi-VN");
        const summary = document.getElementById("order-summary");
        if (!summary) return;

        const subtotal = Number(summary.dataset.subtotal || 0);
        const discount = Number(summary.dataset.discount || 0);

        const elShip = document.getElementById("sumShipping");
        const elTotal = document.getElementById("sumTotal");

        function updateTotal() {
            const shipInput = document.querySelector('input[name="shipping"]:checked');
            const ship = shipInput ? Number(shipInput.value || 0) : 0;

            if (elShip) elShip.textContent = fmt.format(ship) + " đ";
            if (elTotal) elTotal.textContent = fmt.format(subtotal + ship - discount) + " đ";
        }

        document.querySelectorAll('input[name="shipping"]').forEach(r => {
            r.addEventListener("change", updateTotal);
        });

        updateTotal();
    })();
</script>

</body>
</html>
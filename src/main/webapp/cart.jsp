<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
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
    <a href="${pageContext.request.contextPath}/home">
        <img class="logo_img" src="./assets/img/logo_new.png" alt="logo"/>
    </a>

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

<section id="page-header" class="cart-header">
    <h2>#Giỏ hàng</h2>
    <p>Nhập mã giảm giá & Giảm lên đến 70%!</p>
</section>

<section id="cart" class="section-p1">

    <c:set var="isEmptyCart" value="${empty items}" />

    <table width="100%" class="${isEmptyCart ? 'hidden' : ''}">
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
        <c:forEach var="it" items="${items}">
            <tr>
                <td>
                    <a href="${pageContext.request.contextPath}/cart?action=remove&variantId=${it.variantId}"
                       onclick="return confirm('Xóa sản phẩm này khỏi giỏ hàng?');">
                        <i class="fa-solid fa-circle-xmark"></i>
                    </a>
                </td>

                <td>
                    <img src="${pageContext.request.contextPath}${it.imagePath}"
                         alt="<c:out value='${it.proName}'/>"
                         style="width: 80px; height: 80px; object-fit: cover;">
                </td>

                <td>
                    <div style="font-weight: 700;">
                        <c:out value="${it.proName}"/>
                    </div>
                    <div style="font-size: 12px; color: #666; margin-top: 4px;">
                        <c:out value="${it.color}"/>
                        <c:if test="${not empty it.size}">
                            - <c:out value="${it.size}"/>
                        </c:if>
                        &nbsp;|&nbsp; Tồn: <c:out value="${it.stock}"/>
                    </div>
                </td>

                <td>
                    <fmt:formatNumber value="${it.unitPrice}" type="number" groupingUsed="true"/> vnđ
                </td>

                <td>
                    <form action="${pageContext.request.contextPath}/cart" method="post" class="qty-form" style="display:flex; gap:8px; align-items:center; justify-content:center;">
                        <input type="hidden" name="action" value="update"/>
                        <input type="hidden" name="variantId" value="${it.variantId}"/>

                        <button type="button" class="qty-btn" data-act="minus">-</button>

                        <input name="qty"
                               class="qty-input"
                               value="${it.quantity}"
                               inputmode="numeric"
                               pattern="[0-9]*"
                               min="1"
                               max="${it.stock}"
                               style="width: 60px; text-align:center; padding:6px 8px; border:1px solid #ddd; border-radius:6px;">

                        <button type="button" class="qty-btn" data-act="plus">+</button>

                        <button type="submit" class="normal" style="padding:8px 10px;">Cập nhật</button>
                    </form>
                    <c:if test="${it.quantity > it.stock}">
                        <div style="color:#c0392b; font-size:12px; margin-top:6px;">
                            Số lượng vượt tồn kho, vui lòng giảm.
                        </div>
                    </c:if>
                </td>

                <td>
                    <fmt:formatNumber value="${it.lineTotal}" type="number" groupingUsed="true"/> vnđ
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <div id="empty-cart" class="empty-message" style="${isEmptyCart ? '' : 'display:none;'}">
        <i class="fa-solid fa-bag-shopping"></i>
        <p>Giỏ hàng của bạn đang trống!</p>
        <a href="${pageContext.request.contextPath}/category" class="normal">Tiếp tục mua sắm</a>
    </div>
</section>

<section id="cart-add" class="section-p1">
    <div id="coupon">
        <h3>Mã giảm giá</h3>
        <div>
            <input type="text" placeholder="Nhập mã giảm giá" ${isEmptyCart ? 'disabled' : ''}>
            <button class="normal" ${isEmptyCart ? 'disabled' : ''}>Áp dụng</button>
        </div>
    </div>

    <div id="subtotal">
        <h3>Tổng giỏ hàng</h3>
        <table>
            <tr>
                <td>Tổng cộng</td>
                <td id="subtotal-value">
                    <fmt:formatNumber value="${subtotal}" type="number" groupingUsed="true"/> vnđ
                </td>
            </tr>
            <tr>
                <td>Vận chuyển</td>
                <td>Miễn phí</td>
            </tr>
            <tr>
                <td><strong>Tổng cộng</strong></td>
                <td id="total-value">
                    <strong><fmt:formatNumber value="${subtotal}" type="number" groupingUsed="true"/> vnđ</strong>
                </td>
            </tr>
        </table>

        <c:choose>
            <c:when test="${isEmptyCart}">
                <button id="checkoutBtn" class="normal" disabled>Thanh toán</button>
            </c:when>
            <c:otherwise>
                <a id="checkoutBtn" class="normal" href="${pageContext.request.contextPath}/checkout"
                   style="display:inline-block; text-decoration:none; text-align:center;">
                    Thanh toán
                </a>
            </c:otherwise>
        </c:choose>
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
        document.querySelectorAll(".qty-form").forEach(function (form) {
            var input = form.querySelector(".qty-input");
            var minus = form.querySelector('.qty-btn[data-act="minus"]');
            var plus = form.querySelector('.qty-btn[data-act="plus"]');

            if (!input) return;

            function clamp(val) {
                var n = parseInt(val, 10);
                if (isNaN(n) || n < 1) n = 1;

                var max = parseInt(input.getAttribute("max") || "999999", 10);
                if (!isNaN(max) && n > max) n = max;
                return n;
            }

            if (minus) {
                minus.addEventListener("click", function () {
                    input.value = clamp(clamp(input.value) - 1);
                });
            }
            if (plus) {
                plus.addEventListener("click", function () {
                    input.value = clamp(clamp(input.value) + 1);
                });
            }

            input.addEventListener("input", function () {
                input.value = clamp(input.value);
            });
        });
    })();
</script>

</body>
</html>

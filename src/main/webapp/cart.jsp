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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styles.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/cart.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/search.css">
</head>
<body>
<c:set var="cart" value="${sessionScope.CART}"/>
<c:set var="cartCount" value="${cart != null ? cart.items.size() : 0}"/>
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
        <div class="mini-cart-wrap" id="miniCartWrap" style="position:relative; display:inline-block;">
            <a href="${pageContext.request.contextPath}/cart"
               class="mini-cart-link"
               style="position:relative; display:inline-block;">
                <i class="fa fa-shopping-cart"></i>

                <span id="miniCartQty"
                      style="position:absolute; top:-6px; right:-10px;
                              min-width:18px; height:18px; padding:0 5px;
                              border-radius:999px; font-size:12px; line-height:18px;
                              text-align:center; background:#e53935; color:#fff;
                              display:${cartCount > 0 ? 'inline-flex' : 'none'};
                              justify-content:center; align-items:center;">
                    ${cartCount}
                </span>
            </a>

            <div class="mini-cart-dropdown" id="miniCartDropdown">
                <div class="mcdd-head">
                    <strong>Giỏ hàng</strong>
                    <span class="mcdd-sub" id="mcddCount">0 sản phẩm</span>
                </div>

                <div class="mcdd-body" id="mcddBody">
                    <div class="mcdd-empty">Rê chuột để xem giỏ hàng</div>
                </div>

                <div class="mcdd-foot">
                    <div class="mcdd-total">
                        <span>Tổng:</span>
                        <strong id="mcddTotal">0</strong>
                    </div>
                    <div class="mcdd-actions">
                        <a href="${pageContext.request.contextPath}/cart" class="mcdd-btn outline">Xem giỏ</a>
                        <a href="${pageContext.request.contextPath}/checkout" class="mcdd-btn solid">Thanh toán</a>
                    </div>
                </div>
            </div>
        </div>

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
                    <a href="${pageContext.request.contextPath}/personal"> Thông tin cá nhân</a>
                    <hr>
                    <a href="logout" class="logout-link"><i class="fa fa-sign-out-alt"></i> Đăng xuất</a>
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
    <fmt:setLocale value="vi_VN" scope="session"/>

    <c:set var="isEmptyCart" value="${empty items}" />

    <table width="100%" class="${isEmptyCart ? 'hidden' : ''}">
        <thead>
        <tr>
            <td>STT</td>
            <td>Ảnh</td>
            <td>Tên sản phẩm</td>
            <td>Giá</td>
            <td>Số lượng</td>
            <td>Tổng cộng</td>
            <td>Xóa</td>
        </tr>
        </thead>
        <tbody id="cart-body">
        <c:forEach var="it" items="${items}" varStatus="st">
            <tr>
                <td class="td-stt">${st.count}</td>
                <td class="td-img">
                    <img class="cart-thumb"
                         src="${pageContext.request.contextPath}${it.imagePath}"
                         alt="<c:out value='${it.proName}'/>">
                </td>

                <td class="td-name">
                    <div class="cart-name">
                        <c:out value="${it.proName}"/>
                    </div>
                    <div class="cart-meta">
                        <c:out value="${it.color}"/>
                        <c:if test="${not empty it.size}">
                            - <c:out value="${it.size}"/>
                        </c:if>
                        &nbsp;|&nbsp; Tồn: <c:out value="${it.stock}"/>
                    </div>
                </td>

                <td class="money">
                    <fmt:formatNumber value="${it.unitPrice}" type="number" groupingUsed="true" maxFractionDigits="0"/> đ
                </td>

                <td>
                    <form class="qty-form" action="${pageContext.request.contextPath}/cart" method="post">
                        <input type="hidden" name="action" value="update"/>
                        <input type="hidden" name="variantId" value="${it.variantId}"/>

                        <button type="button" class="qty-btn" data-act="minus" aria-label="Giảm">−</button>

                        <input name="qty"
                               class="qty-input"
                               value="${it.quantity}"
                               inputmode="numeric"
                               pattern="[0-9]*"
                               min="1"
                               max="${it.stock}"/>

                        <button type="button" class="qty-btn" data-act="plus" aria-label="Tăng">+</button>
                    </form>

                    <c:if test="${it.quantity > it.stock}">
                        <div class="qty-warn">Số lượng vượt tồn kho, vui lòng giảm.</div>
                    </c:if>
                </td>

                <td class="money">
                    <fmt:formatNumber value="${it.lineTotal}" type="number" groupingUsed="true" maxFractionDigits="0"/> đ
                </td>

                <td class="td-remove">
                    <a class="remove-link"
                       href="${pageContext.request.contextPath}/cart?action=remove&variantId=${it.variantId}"
                       onclick="return confirm('Xóa sản phẩm này khỏi giỏ hàng?');"
                       title="Xóa">
                        <i class="fa fa-trash" aria-hidden="true"></i>
                    </a>
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
        <table class="summary-table">
            <tr>
                <td>Tạm tính</td>
                <td class="summary-money" id="subtotal-value">
                    <fmt:formatNumber value="${subtotal}" type="number" groupingUsed="true" maxFractionDigits="0"/> đ
                </td>
            </tr>
            <tr>
                <td>Đã giảm</td>
                <td class="summary-money" id="discount-value">
                    0 đ
                </td>
            </tr>
            <tr class="summary-total">
                <td><strong>Tổng cộng</strong></td>
                <td class="summary-money" id="total-value">
                    <strong><fmt:formatNumber value="${subtotal}" type="number" groupingUsed="true" maxFractionDigits="0"/> đ</strong>
                </td>
            </tr>
        </table>

        <c:choose>
            <c:when test="${isEmptyCart}">
                <button id="checkoutBtn" class="normal checkout-btn" disabled>Thanh toán</button>
            </c:when>
            <c:otherwise>
                <a id="checkoutBtn" class="normal checkout-btn" href="${pageContext.request.contextPath}/checkout">
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
            var plus  = form.querySelector('.qty-btn[data-act="plus"]');

            if (!input) return;

            var timer = null;

            function getMax() {
                var maxAttr = input.getAttribute("max");
                var max = parseInt(maxAttr || "999999", 10);
                return isNaN(max) ? 999999 : max;
            }

            function clamp(val) {
                var n = parseInt(val, 10);
                if (isNaN(n) || n < 1) n = 1;

                var max = getMax();
                if (n > max) n = max;

                return n;
            }

            function submitSoon() {
                // tránh spam submit khi user click liên tục
                clearTimeout(timer);
                timer = setTimeout(function () {
                    form.submit();
                }, 250);
            }

            function setQtyAndSubmit(nextVal) {
                input.value = clamp(nextVal);
                submitSoon();
            }

            if (minus) {
                minus.addEventListener("click", function () {
                    setQtyAndSubmit(clamp(input.value) - 1);
                });
            }

            if (plus) {
                plus.addEventListener("click", function () {
                    setQtyAndSubmit(clamp(input.value) + 1);
                });
            }

            input.addEventListener("input", function () {
                input.value = input.value.replace(/[^\d]/g, "");
            });

            input.addEventListener("change", function () {
                setQtyAndSubmit(input.value);
            });
            input.addEventListener("blur", function () {
                setQtyAndSubmit(input.value);
            });

            input.addEventListener("keydown", function (e) {
                if (e.key === "Enter") {
                    e.preventDefault();
                    setQtyAndSubmit(input.value);
                }
            });
        });
    })();
</script>

<script>
    window.contextPath = "${pageContext.request.contextPath}";
</script>
<script src="${pageContext.request.contextPath}/assets/js/miniCartDropdown.js"></script>
</body>
</html>

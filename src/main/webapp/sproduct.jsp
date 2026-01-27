<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<fmt:setLocale value="vi_VN"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>Product Details</title>
    <meta name="description" content=""/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@flaticon/flaticon-uicons/css/all/all.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styles.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/sproduct.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/search.css">
</head>
<body>
<c:set var="cart" value="${sessionScope.CART}"/>
<c:set var="cartCount" value="${cart != null ? cart.items.size() : 0}"/>

<c:set var="p" value="${product}"/>
<c:set var="selectedId" value="${selectedVariantId}"/>
<c:set var="selectedVariant" value="${null}"/>

<c:forEach var="v" items="${variants}">
    <c:if test="${v.id == selectedId}">
        <c:set var="selectedVariant" value="${v}"/>
    </c:if>
</c:forEach>

<c:url var="loginReturnUrl" value="/login">
    <c:param name="return" value="/product?id=${p.id}"/>
</c:url>

<div class="header-top"></div>
<section id="header">
    <a href="${pageContext.request.contextPath}/home">
        <img class="logo_img" src="${pageContext.request.contextPath}/assets/img/logo_new.png" alt="logo"/>
    </a>

    <ul id="navbar">
        <li><a href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
        <li><a href="${pageContext.request.contextPath}/category">Danh mục</a></li>
        <li><a href="blog.jsp">Blog</a></li>
        <li><a href="about.jsp">Giới thiệu</a></li>
        <li><a href="contact.jsp">Liên hệ</a></li>
    </ul>

    <div id="right-icons">
        <div id="search-box">
            <input type="text" id="searchInput" placeholder="Tìm sản phẩm..."/>
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
                vn.edu.hcmuaf.edu.vn.campforge.model.User user =
                        (vn.edu.hcmuaf.edu.vn.campforge.model.User) session.getAttribute("auth");

                if (user == null) {
            %>
            <a href="<%= request.getContextPath() %>/login" class="btn-login">Đăng nhập</a>
            <a href="<%= request.getContextPath() %>/register" class="btn-register">Đăng ký</a>
            <% } else { %>
            <div class="user-dropdown">
                <span class="user-name">
                    Xin chào, <strong><%= user.getUsername() %></strong>
                    <i class="fa fa-caret-down"></i>
                </span>
                <div class="dropdown-content">
                    <a href="${pageContext.request.contextPath}/personal">Thông tin cá nhân</a>
                    <hr>
                    <a href="${pageContext.request.contextPath}/logout" class="logout-link">
                        <i class="fa fa-sign-out-alt"></i> Đăng xuất
                    </a>
                </div>
            </div>
            <% } %>
        </div>
    </div>
</section>

<nav class="sp-breadcrumb-wrap">
    <ol class="sp-breadcrumb">
        <li>
            <a href="${pageContext.request.contextPath}/">Trang chủ</a>
        </li>
        <li class="active">
            Chạy bộ
        </li>
    </ol>
</nav>

<section id="prodetails" class="section-p1" data-product-id="${p.id}" data-ctx="${pageContext.request.contextPath}">
    <div class="single-pro-image">

        <c:set var="ctx" value="${pageContext.request.contextPath}"/>
        <c:set var="mainImgPath" value=""/>

        <c:if test="${selectedVariant != null && not empty selectedVariant.imagePath}">
            <c:set var="mainImgPath" value="${selectedVariant.imagePath}"/>
        </c:if>

        <c:if test="${empty mainImgPath}">
            <c:forEach var="img" items="${images}">
                <c:if test="${img.position == 1 && empty mainImgPath}">
                    <c:set var="mainImgPath" value="${img.path}"/>
                </c:if>
            </c:forEach>
        </c:if>

        <c:if test="${empty mainImgPath}">
            <c:if test="${not empty images}">
                <c:set var="mainImgPath" value="${images[0].path}"/>
            </c:if>
        </c:if>

        <c:if test="${empty mainImgPath}">
            <c:set var="mainImgPath" value="/assets/img/products/no-image.png"/>
        </c:if>

        <img src="<c:url value='${mainImgPath}'/>" width="100%" id="MainImg" data-all="1" alt="">
        <button type="button" class="sp-nav sp-prev" aria-label="Ảnh trước">
            <span aria-hidden="true">‹</span>
        </button>
        <button type="button" class="sp-nav sp-next" aria-label="Ảnh sau">
            <span aria-hidden="true">›</span>
        </button>

        <div class="small-img-group" id="thumbList">
            <c:forEach var="img" items="${images}">
                <c:if test="${img.position >= 2}">
                    <div class="small-img-col">
                        <img
                                src="${ctx}${img.path}"
                                width="100%"
                                class="small-img"
                                data-pos="${img.position}"
                                alt="">
                    </div>
                </c:if>
            </c:forEach>
        </div>
    </div>

    <div class="single-pro-details">
        <h4 id="pdName">
            <c:out value="${p.proName}"/>
        </h4>

        <div class="pd-review-summary">
            <span class="pd-stars">
                <c:forEach var="i" begin="1" end="5">
                    <c:choose>
                        <c:when test="${i <= avgRatingRounded}">
                            <i class="fa-solid fa-star"></i>
                        </c:when>
                        <c:otherwise>
                            <i class="fa-regular fa-star"></i>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </span>

            <span class="pd-review-text">
                <fmt:formatNumber value="${avgRating}" maxFractionDigits="1"/> / 5
                (<c:out value="${reviewCount}"/> đánh giá)
            </span>
        </div>

        <div class="pd-row">
            <div class="pd-kv">
                <span>Tồn kho:</span>
                <b id="pdStock">
                    <c:out value="${selectedVariant != null ? selectedVariant.stock : 0}"/>
                </b>
            </div>
        </div>

        <h2 id="pdPrice">
            <fmt:formatNumber value="${selectedVariant != null ? selectedVariant.finalPrice : p.price}"
                              type="number" maxFractionDigits="0"/>
            đ
        </h2>

        <c:set var="sizeSet" value=""/>
        <c:set var="sizeCount" value="0"/>

        <c:forEach var="v" items="${variants}">
            <c:if test="${not empty v.size}">
                <c:set var="s" value="${fn:toLowerCase(v.size)}"/>
                <c:if test="${s ne 'one' && s ne 'onesize' && s ne 'one size' && s ne 'free'}">
                    <c:if test="${!fn:contains(sizeSet, '|' += v.size += '|')}">
                        <c:set var="sizeSet" value="${sizeSet}${'|'}${v.size}${'|'}"/>
                        <c:set var="sizeCount" value="${sizeCount + 1}"/>
                    </c:if>
                </c:if>
            </c:if>
        </c:forEach>

        <c:if test="${sizeCount > 1}">
            <div class="pd-option">
                <div class="pd-option-head">
                    <span>Size:</span>
                </div>

                <c:set var="sizeRendered" value=""/>
                <div class="pd-chips" id="sizeChips">
                    <c:forEach var="v" items="${variants}">
                        <c:if test="${not empty v.size && fn:contains(sizeSet, '|' += v.size += '|')}">
                            <c:if test="${!fn:contains(sizeRendered, '|' += v.size += '|')}">
                                <c:set var="sizeRendered" value="${sizeRendered}${'|'}${v.size}${'|'}"/>

                                <button type="button"
                                        class="chip"
                                        data-attr="size"
                                        data-value="${v.size}">
                                    <c:out value="${v.size}"/>
                                </button>
                            </c:if>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
        </c:if>

        <c:set var="colorSet" value=""/>
        <c:set var="colorCount" value="0"/>

        <c:forEach var="v" items="${variants}">
            <c:if test="${not empty v.color}">
                <c:if test="${!fn:contains(colorSet, '|' += v.color += '|')}">
                    <c:set var="colorSet" value="${colorSet}${'|'}${v.color}${'|'}"/>
                    <c:set var="colorCount" value="${colorCount + 1}"/>
                </c:if>
            </c:if>
        </c:forEach>

        <c:if test="${colorCount > 1}">
            <div class="pd-option">
                <div class="pd-option-head">
                    <span>Màu sắc:</span>
                </div>

                <c:set var="colorRendered" value=""/>
                <div class="pd-chips" id="colorChips">
                    <c:forEach var="v" items="${variants}">
                        <c:if test="${not empty v.color && fn:contains(colorSet, '|' += v.color += '|')}">
                            <c:if test="${!fn:contains(colorRendered, '|' += v.color += '|')}">
                                <c:set var="colorRendered" value="${colorRendered}${'|'}${v.color}${'|'}"/>

                                <button type="button"
                                        class="chip chip--color"
                                        data-attr="color"
                                        data-value="${v.color}">
                                    <span class="color-swatch"></span>
                                    <span class="chip-text"><c:out value="${v.color}"/></span>
                                </button>
                            </c:if>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
        </c:if>

        <div class="pd-qty">
            <span class="pd-qty-label">Số lượng:</span>

            <div class="qty-control">
                <button type="button" class="qty-btn" id="qtyMinus" aria-label="Giảm">−</button>
                <input id="qtyInput" class="qty-input" type="text" value="1" inputmode="numeric"/>
                <button type="button" class="qty-btn" id="qtyPlus" aria-label="Tăng">+</button>
            </div>
        </div>

        <button class="normal add-to-cart"
                type="button"
                id="btnAddToCart"
                data-product-id="${p.id}"
                data-variant-id="${selectedId}"
                data-name="${p.proName}"
                data-price="${selectedVariant != null ? selectedVariant.finalPrice : p.price}"
                data-image="${mainImgPath}">
            Thêm Vào Giỏ Hàng
        </button>

        <h4>Mô tả sản phẩm:</h4>
        <span id="pdDescription">
            <c:out value="${p.description}" default="(Chưa có mô tả)"/>
        </span>
    </div>
</section>

<section id="pdReviews" class="section-p1 pd-reviews">
    <h2 class="pd-reviews-title">ĐÁNH GIÁ SẢN PHẨM</h2>

    <div class="pd-reviews-head">
        <div class="pd-reviews-score">
            <div class="pd-reviews-avg">
                <fmt:formatNumber value="${avgRating}" maxFractionDigits="1"/>
                <span class="pd-reviews-max">/5</span>
            </div>

            <div class="pd-stars">
                <c:forEach var="i" begin="1" end="5">
                    <c:choose>
                        <c:when test="${i <= avgRatingRounded}">
                            <i class="fa-solid fa-star"></i>
                        </c:when>
                        <c:otherwise>
                            <i class="fa-regular fa-star"></i>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </div>

            <div class="pd-reviews-count">
                <c:out value="${reviewCount}"/> đánh giá
            </div>
        </div>
    </div>

    <c:choose>
        <c:when test="${empty reviews && reviewCount > 0}">
            <p class="pd-reviews-empty pd-reviews-error">Không tải được nội dung đánh giá. Vui lòng tải lại trang.</p>
        </c:when>

        <c:when test="${empty reviews}">
            <p class="pd-reviews-empty">Chưa có đánh giá nào.</p>
        </c:when>

        <c:otherwise>
            <div class="pd-review-list">
                <c:forEach var="r" items="${reviews}">
                    <div class="pd-review-item">
                        <div class="pd-review-top">
                            <div class="pd-review-user">
                                <c:out value="${r.userFullName}"/>
                            </div>

                            <div class="pd-review-stars">
                                <c:forEach var="i" begin="1" end="5">
                                    <c:choose>
                                        <c:when test="${i <= r.rating}">
                                            <i class="fa-solid fa-star"></i>
                                        </c:when>
                                        <c:otherwise>
                                            <i class="fa-regular fa-star"></i>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </div>
                        </div>

                        <div class="pd-review-content">
                            <c:out value="${r.content}" default=""/>
                        </div>

                        <div class="pd-review-time">
                            <fmt:formatDate value="${r.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>

    <div class="pd-add-review" style="margin-top:16px;">
        <h3 style="margin:0 0 10px; font-size:18px;">Thêm đánh giá</h3>

        <c:choose>
            <c:when test="${empty sessionScope.auth}">
                <p class="pd-reviews-empty" style="margin-bottom:10px;">Bạn cần đăng nhập để đánh giá.</p>
                <a class="pd-login-btn" href="${loginReturnUrl}">Đăng nhập</a>
            </c:when>

            <c:otherwise>
                <form id="addReviewForm">
                    <input type="hidden" name="productId" value="${p.id}"/>

                    <div style="margin-bottom:10px;">
                        <label style="display:block; margin-bottom:6px;">Rating:</label>
                        <select name="rating" class="form-select" style="max-width:120px;">
                            <option value="5">5</option>
                            <option value="4">4</option>
                            <option value="3">3</option>
                            <option value="2">2</option>
                            <option value="1">1</option>
                        </select>
                    </div>

                    <div style="margin-bottom:10px;">
                        <label style="display:block; margin-bottom:6px;">Nội dung:</label>
                        <textarea name="content" class="form-control" rows="3"
                                  placeholder="Viết đánh giá của bạn..."></textarea>
                    </div>

                    <button type="submit" class="btn btn-primary">Gửi đánh giá</button>
                </form>
            </c:otherwise>
        </c:choose>

    </div>
</section>

<section id="product1" class="section-p1">
    <h2>SẢN PHẨM LIÊN QUAN</h2>

    <div class="pro-container">
        <c:forEach var="p" items="${relatedProducts}">
            <div class="pro" onclick="window.location.href='${pageContext.request.contextPath}/product?id=${p.id}'">

                <a href="${pageContext.request.contextPath}/product?id=${p.id}" onclick="event.stopPropagation();">
                    <c:choose>
                        <c:when test="${empty p.image}">
                            <img src="${pageContext.request.contextPath}/assets/img/products/no-image.png"
                                 alt="${p.proName}"/>
                        </c:when>

                        <c:when test="${fn:startsWith(p.image, 'http')}">
                            <img src="${p.image}" alt="${p.proName}"/>
                        </c:when>

                        <c:otherwise>
                            <img src="${pageContext.request.contextPath}${p.image}" alt="${p.proName}"/>
                        </c:otherwise>
                    </c:choose>
                </a>

                <div class="des">
                    <span><c:out value="${p.brandName}" default="(Không rõ hãng)"/></span>
                    <h5><c:out value="${p.proName}"/></h5>

                    <div class="star">
                        <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i
                            class="fas fa-star"></i><i class="fas fa-star"></i>
                    </div>

                    <h4>
                        <fmt:formatNumber value="${p.price}" type="number" groupingUsed="true"/>đ
                    </h4>
                </div>

                <c:choose>
                    <c:when test="${not empty p.defaultVariantId}">
                        <a href="javascript:void(0)"
                           class="js-add-to-cart"
                           data-variant-id="${p.defaultVariantId}"
                           onclick="event.preventDefault(); event.stopPropagation();"
                           aria-label="Thêm vào giỏ">
                            <i class="cart fi fi-sr-shopping-cart"></i>
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/product?id=${p.id}" aria-label="Chọn phân loại">
                            <i class="cart fi fi-sr-shopping-cart"></i>
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:forEach>

        <c:if test="${empty relatedProducts}">
            <p style="padding:12px 0;">Không tìm được sản phẩm liên quan.</p>
        </c:if>
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
            <img src="./assets/img/pay/app.jpg" alt=""/>
            <img src="./assets/img/pay/play.jpg" alt=""/>
        </div>
        <p>Bảo mật cổng thanh toán</p>
        <img src="./assets/img/pay/pay.png" alt=""/>
    </div>
    <div class="copyright">
        <p>@ 2025, CampShop - HTML CSS Ecommerce Website</p>
    </div>
</footer>

<script id="variantData" type="application/json">
    [
    <c:forEach var="v" items="${variants}" varStatus="st">
        {
        "id": ${v.id},
        "finalPrice": ${v.finalPrice},
        "stock": ${v.stock},
        "color": "${v.color}",
        "size": "${v.size}",
        "image": "${v.imagePath}"
        }${st.last ? '' : ','}
    </c:forEach>
    ]
</script>

<script>
    window.contextPath = "${pageContext.request.contextPath}";
</script>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        var form = document.getElementById("addReviewForm");
        if (!form) return;

        form.addEventListener("submit", async function (e) {
            e.preventDefault();

            var ctx = window.contextPath || "";
            var fd = new FormData(form);

            var target = String(fd.get("target") || "");
            var parts = target.split(":");

            var body =
                "productId=" + encodeURIComponent(fd.get("productId")) +
                "&rating=" + encodeURIComponent(fd.get("rating")) +
                "&content=" + encodeURIComponent(fd.get("content") || "");

            try {
                var res = await fetch(ctx + "/review", {
                    method: "POST",
                    headers: {
                        "Accept": "application/json",
                        "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
                        "X-Requested-With": "XMLHttpRequest"
                    },
                    body: body
                });

                var data = await res.json();
                if (!res.ok || !data || !data.ok) {
                    alert((data && data.message) ? data.message : "Gửi đánh giá thất bại");
                    return;
                }

                window.location.reload();
            } catch (err) {
                console.error(err);
                alert("Không thể gửi đánh giá lúc này.");
            }
        });
    });
</script>

<script src="${pageContext.request.contextPath}/assets/js/sproduct.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/miniCartDropdown.js"></script>
</body>
</html>

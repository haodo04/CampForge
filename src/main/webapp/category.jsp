<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>Sản phẩm</title>
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
    />
    <link
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"
            rel="stylesheet"
    />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@flaticon/flaticon-uicons/css/all/all.css"/>
    <link href="${pageContext.request.contextPath}/assets/css/category.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/assets/css/styles.css" rel="stylesheet"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/search.css">

</head>
<style>
    ul {
        padding-left: 0;
        position: relative;
        left: -5px;
        top: 1px;
    }

    #navbar li {
        padding: 10px 10px 0 0;
        margin: 10px 5px 5px 25px;
    }

    #navbar li a {
        display: flex;
        justify-content: center;
        align-items: center;
        flex-wrap: wrap;
        width: 100%;
    }

    #navbar li a:hover,
    #navbar li a.active {
        color: #088178;
    }

    #navbar li a.active::after,
    #navbar li a:hover::after {
        content: "";
        width: 40px;
        height: 2px;
        background: #088178;
        position: absolute;
        bottom: -4px;
        left: 0;
    }
</style>
<c:set var="cart" value="${sessionScope.CART}"/>
<c:set var="cartCount" value="${cart != null ? cart.items.size() : 0}"/>
<body data-ctx="${pageContext.request.contextPath}">
<div class="header-top"></div>
<section id="header">
    <a href="index.jsp"><img class="logo_img" src="${pageContext.request.contextPath}/assets/img/logo_new.png" alt="logo"></a>
    <ul id="navbar">
        <li><a href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
        <li><a class="active" href="${pageContext.request.contextPath}/category">Danh mục</a></li>
        <li><a href="blog.jsp">Blog</a></li>
        <li><a href="about.jsp">Giới thiệu</a></li>
        <li><a href="contact.jsp">Liên hệ</a></li>
    </ul>
    <div id="right-icons">
        <form action="${pageContext.request.contextPath}/search" method="get" class="d-flex">
            <div id="search-box">
                <input type="text" name="q" id="searchInput"
                       placeholder="Tìm sản phẩm..." value="${q}" />
                <button id="searchBtn" type="submit"><i class="fa fa-search"></i></button>
            </div>
        </form>

        <c:set var="cc" value="${empty cartCount ? 0 : cartCount}" />
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
                              display:${cc > 0 ? 'inline-flex' : 'none'};
                              justify-content:center; align-items:center;">
                    ${cc}
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
                    <a href="personal.jsp"><i class="fa fa-user"></i> Thông tin cá nhân</a>
                    <hr>
                    <a href="index.jsp" class="logout-link"><i class="fa fa-sign-out-alt"></i> Đăng xuất</a>
                </div>
            </div>
            <% } %>
        </div>
    </div>
</section>

<nav aria-label="breadcrumb" class="bg-light py-3">
    <div class="container">
        <ol class="breadcrumb m-0">
            <li class="breadcrumb-item"><a href="index.jsp">Trang chủ</a></li>
            <li class="breadcrumb-item active" aria-current="page">Danh mục</li>
        </ol>
    </div>
</nav>


<main class="shop-page py-3">
    <div class="container">
        <div class="row g-4">
            <!-- filter -->
            <aside class="col-12 col-lg-3">
                <div class="card">
                    <div class="card-body">

                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h5 class="m-0">Bộ lọc sản phẩm</h5>
                            <a href="category" class="btn btn-sm btn-warning">Đặt lại</a>
                        </div>

                        <!-- FORM DUY NHẤT -->
                        <form action="category" method="get">

                            <!-- GIÁ -->
                            <div class="mb-4">
                                <h6 class="mb-2">Giá (VNĐ)</h6>
                                <div class="d-flex align-items-center">
                                    <div class="input-group me-2">
                                        <input type="number" class="form-control" name="minPrice"
                                               placeholder="Từ" value="${param.minPrice}">
                                        <span class="input-group-text">đ</span>
                                    </div>

                                    <span class="mx-2">–</span>

                                    <div class="input-group">
                                        <input type="number" class="form-control" name="maxPrice"
                                               placeholder="Đến" value="${param.maxPrice}">
                                        <span class="input-group-text">đ</span>
                                    </div>
                                </div>
                            </div>

                            <!-- KÍCH THƯỚC -->
                            <div class="mb-4">
                                <h6 class="mb-2">Kích thước</h6>

                                <div class="form-check mb-2">
                                    <input class="form-check-input" type="checkbox" name="size" value="2x3" id="s1">
                                    <label class="form-check-label" for="s1">2×3 m</label>
                                </div>
                                <div class="form-check mb-2">
                                    <input class="form-check-input" type="checkbox" name="size" value="3x4" id="s2">
                                    <label class="form-check-label" for="s2">3×4 m</label>
                                </div>
                                <div class="form-check mb-2">
                                    <input class="form-check-input" type="checkbox" name="size" value="4x6" id="s3">
                                    <label class="form-check-label" for="s3">4×6 m</label>
                                </div>
                                <div class="form-check mb-2">
                                    <input class="form-check-input" type="checkbox" name="size" value="6x9" id="s4">
                                    <label class="form-check-label" for="s4">6×9 m</label>
                                </div>
                            </div>

                            <!-- CHỦ ĐỀ -->
                            <div class="mb-4">
                                <h6 class="mb-2">Chủ đề</h6>

                                <div class="form-check mb-2">
                                    <input class="form-check-input" type="checkbox" name="id" value="1" id="t1">
                                    <label class="form-check-label" for="t1">Cắm Trại</label>
                                </div>
                                <div class="form-check mb-2">
                                    <input class="form-check-input" type="checkbox" name="id" value="2" id="t2">
                                    <label class="form-check-label" for="t2">Du Lịch</label>
                                </div>
                                <div class="form-check mb-2">
                                    <input class="form-check-input" type="checkbox" name="id" value="3" id="t3">
                                    <label class="form-check-label" for="t3">Leo Núi</label>
                                </div>
                                <div class="form-check mb-2">
                                    <input class="form-check-input" type="checkbox" name="id" value="4" id="t4">
                                    <label class="form-check-label" for="t4">Dã Ngoại</label>
                                </div>
                            </div>

                            <!-- BRAND -->
                            <div class="mb-4">
                                <h6 class="mb-2">Brand</h6>

                                <div class="form-check mb-2">
                                    <input class="form-check-input" type="checkbox" name="brandId" value="1" id="a1">
                                    <label class="form-check-label" for="a1">BLACKDOG</label>
                                </div>
                                <div class="form-check mb-2">
                                    <input class="form-check-input" type="checkbox" name="brandId" value="2" id="a2">
                                    <label class="form-check-label" for="a2">ADIDAS</label>
                                </div>
                                <div class="form-check mb-2">
                                    <input class="form-check-input" type="checkbox" name="brandId" value="3" id="a3">
                                    <label class="form-check-label" for="a3">MADFOX</label>
                                </div>
                                <div class="form-check mb-2">
                                    <input class="form-check-input" type="checkbox" name="brandId" value="4" id="a4">
                                    <label class="form-check-label" for="a4">NATUREHIKE</label>
                                </div>
                                <div class="form-check mb-2">
                                    <input class="form-check-input" type="checkbox" name="brandId" value="5" id="a5">
                                    <label class="form-check-label" for="a5">JACK WOLFSKIN</label>
                                </div>
                                <div class="form-check mb-2">
                                    <input class="form-check-input" type="checkbox" name="brandId" value="6" id="a6">
                                    <label class="form-check-label" for="a6">VULTURE</label>
                                </div>
                            </div>

                            <div class="form-check mb-2">
                                <input
                                        class="form-check-input"
                                        type="checkbox"
                                        id="sortRating"
                                />
                                <label class="form-check-label" for="sortRating"
                                >Đánh giá cao <i class="fa-solid fa-star text-warning"></i
                                ></label>
                            </div>

                            <!-- SORT -->
                            <div class="form-check mb-4">
                                <input class="form-check-input" type="checkbox" name="sort" value="new" id="sortNew">
                                <label class="form-check-label" for="sortNew">Sản phẩm mới nhất</label>
                            </div>

                            <!-- THEO NGÀY -->
                            <div class="card p-3 mb-3">
                                <h6 class="mb-3">Sản phẩm theo ngày</h6>
                                <div class="row g-2">
                                    <div class="col-6">
                                        <label class="form-label">Từ ngày</label>
                                        <input type="date" name="fromDate" class="form-control form-control-sm"
                                               value="${param.fromDate}">
                                    </div>
                                    <div class="col-6">
                                        <label class="form-label">Đến ngày</label>
                                        <input type="date" name="toDate" class="form-control form-control-sm"
                                               value="${param.toDate}">
                                    </div>
                                </div>
                            </div>

                            <!-- APPLY -->
                            <button type="submit" class="btn btn-primary w-100">
                                Áp dụng
                            </button>

                        </form>
                    </div>
                </div>
            </aside>
            <section class="col-12 col-lg-9">
                <c:set var="ctx" value="${pageContext.request.contextPath}" />
                <div id="product-grid" class="row g-3" style="display: flex; flex-wrap: wrap;">
                    <c:choose>
                        <c:when test="${empty products}">
                            <div class="col-12">
                                <p>Không có sản phẩm phù hợp.</p>
                            </div>
                        </c:when>

                        <c:otherwise>
                            <c:forEach var="p" items="${products}">
                                <div class="col-12 col-sm-6 col-lg-3">
                                    <div class="pro">
                                        <a class="pro-link" href="${ctx}/product?id=${p.id}">
                                            <c:choose>
                                                <c:when test="${not empty p.image}">
                                                    <img src="${pageContext.request.contextPath}${p.image}" alt="${p.proName}"/>
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="${pageContext.request.contextPath}/assets/img/products/no-image.png" alt="${p.proName}"/>
                                                </c:otherwise>
                                            </c:choose>

                                            <div class="des">
                                                <span><c:out value="${p.brandName}" default="(Không rõ hãng)"/></span>
                                                <h5><c:out value="${p.proName}"/></h5>

                                                <div class="star" aria-label="Đánh giá 5/5">
                                                    <i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i>
                                                    <i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i>
                                                    <i class="fa-solid fa-star"></i>
                                                </div>

                                                <h4>${p.formattedPrice}</h4>
                                            </div>
                                        </a>

                                        <c:choose>
                                            <c:when test="${not empty p.defaultVariantId}">
                                                <a href="javascript:void(0)"
                                                   class="add-cart js-add-to-cart"
                                                   data-variant-id="${p.defaultVariantId}"
                                                   aria-label="Thêm vào giỏ">
                                                    <i class="fa-solid fa-cart-shopping cart"></i>
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="${ctx}/product?id=${p.id}"
                                                   class="add-cart"
                                                   aria-label="Chọn phân loại">
                                                    <i class="fa-solid fa-cart-shopping cart"></i>
                                                </a>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>

                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>

                <c:if test="${totalPages > 1}">
                    <nav class="mt-4">
                        <ul class="pagination justify-content-center">

                            <!-- Prev: -->
                            <c:if test="${page > 1}">
                                <c:url var="prevUrl" value="/category">
                                    <c:param name="page" value="${page - 1}" />
                                    <c:if test="${not empty id}"><c:param name="id" value="${id}" /></c:if>
                                    <c:if test="${not empty brandId}"><c:param name="brandId" value="${brandId}" /></c:if>
                                    <c:if test="${not empty minPrice}"><c:param name="minPrice" value="${minPrice}" /></c:if>
                                    <c:if test="${not empty maxPrice}"><c:param name="maxPrice" value="${maxPrice}" /></c:if>
                                    <c:if test="${not empty fromDate}"><c:param name="fromDate" value="${fromDate}" /></c:if>
                                    <c:if test="${not empty toDate}"><c:param name="toDate" value="${toDate}" /></c:if>
                                    <c:if test="${not empty q}"><c:param name="q" value="${q}" /></c:if>
                                    <c:if test="${not empty sort}"><c:param name="sort" value="${sort}" /></c:if>
                                </c:url>

                                <li class="page-item">
                                    <a class="page-link" href="${prevUrl}" aria-label="Previous">&laquo;</a>
                                </li>
                            </c:if>

                            <!-- Pages -->
                            <c:forEach var="i" begin="1" end="${totalPages}">
                                <c:url var="pageUrl" value="/category">
                                    <c:param name="page" value="${i}" />
                                    <c:if test="${not empty id}"><c:param name="id" value="${id}" /></c:if>
                                    <c:if test="${not empty brandId}"><c:param name="brandId" value="${brandId}" /></c:if>
                                    <c:if test="${not empty minPrice}"><c:param name="minPrice" value="${minPrice}" /></c:if>
                                    <c:if test="${not empty maxPrice}"><c:param name="maxPrice" value="${maxPrice}" /></c:if>
                                    <c:if test="${not empty fromDate}"><c:param name="fromDate" value="${fromDate}" /></c:if>
                                    <c:if test="${not empty toDate}"><c:param name="toDate" value="${toDate}" /></c:if>
                                    <c:if test="${not empty q}"><c:param name="q" value="${q}" /></c:if>
                                    <c:if test="${not empty sort}"><c:param name="sort" value="${sort}" /></c:if>
                                </c:url>

                                <li class="page-item ${i == page ? 'active' : ''}">
                                    <a class="page-link" href="${pageUrl}">${i}</a>
                                </li>
                            </c:forEach>

                            <!-- Next: -->
                            <c:if test="${page < totalPages}">
                                <c:url var="nextUrl" value="/category">
                                    <c:param name="page" value="${page + 1}" />
                                    <c:if test="${not empty id}"><c:param name="id" value="${id}" /></c:if>
                                    <c:if test="${not empty brandId}"><c:param name="brandId" value="${brandId}" /></c:if>
                                    <c:if test="${not empty minPrice}"><c:param name="minPrice" value="${minPrice}" /></c:if>
                                    <c:if test="${not empty maxPrice}"><c:param name="maxPrice" value="${maxPrice}" /></c:if>
                                    <c:if test="${not empty fromDate}"><c:param name="fromDate" value="${fromDate}" /></c:if>
                                    <c:if test="${not empty toDate}"><c:param name="toDate" value="${toDate}" /></c:if>
                                    <c:if test="${not empty q}"><c:param name="q" value="${q}" /></c:if>
                                    <c:if test="${not empty sort}"><c:param name="sort" value="${sort}" /></c:if>
                                </c:url>

                                <li class="page-item">
                                    <a class="page-link" href="${nextUrl}" aria-label="Next">&raquo;</a>
                                </li>
                            </c:if>

                        </ul>
                    </nav>
                </c:if>



            </section>

        </div>
    </div>
</main>

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
<script>
    window.contextPath = "${pageContext.request.contextPath}";
</script>
<script src="${pageContext.request.contextPath}/assets/js/miniCartDropdown.js"></script>

<script>
    document.addEventListener("click", async (e) => {
        const a = e.target.closest("a.js-add-to-cart");
        if (!a) return;

        e.preventDefault();

        const variantId = a.dataset.variantId;
        if (!variantId) return;

        try {
            const url = window.contextPath
                + "/cart?action=addAjax&variantId="
                + encodeURIComponent(variantId)
                + "&qty=1";
            const res = await fetch(url, { headers: { "Accept": "application/json" } });
            const data = await res.json();

            if (!res.ok || !data?.ok) throw new Error(data?.message || "Không thêm vào giỏ được");

            const badge = document.getElementById("miniCartQty");
            if (badge) {
                const n = Number(data.cartCount) || 0;
                badge.textContent = n;
                badge.style.display = n > 0 ? "inline-flex" : "none";
            }

            if (window.refreshMiniCartDropdown) window.refreshMiniCartDropdown();
        } catch (err) {
            console.error(err);
            alert(err.message || "Có lỗi khi thêm vào giỏ");
        }
    });
</script>

<script src="${pageContext.request.contextPath}/assets/js/search.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

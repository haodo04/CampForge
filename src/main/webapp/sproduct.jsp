<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
    <link rel="stylesheet" href="./assets/css/styles.css"/>
    <link rel="stylesheet" href="./assets/css/sproduct.css"/>
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
            <input type="text" id="searchInput" placeholder="Tìm sản phẩm..."/>
            <button id="searchBtn"><i class="fa fa-search"></i></button>
        </div>
        <a href="cart.jsp"><i class="fa fa-shopping-cart"></i></a>

        <div class="auth-buttons">
            <a href="login.jsp" class="btn-login">Đăng nhập</a>
            <a href="register.jsp" class="btn-register">Đăng ký</a>
        </div>
    </div>
</section>

<c:set var="p" value="${product}"/>
<c:set var="selectedId" value="${selectedVariantId}"/>
<c:set var="selectedVariant" value="${null}"/>

<c:forEach var="v" items="${variants}">
    <c:if test="${v.id == selectedId}">
        <c:set var="selectedVariant" value="${v}"/>
    </c:if>
</c:forEach>

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

<section id="prodetails" class="section-p1" data-product-id="${p.id}">
    <div class="single-pro-image">

        <c:set var="ctx" value="${pageContext.request.contextPath}"/>

        <c:set var="mainImgPath" value=""/>
        <c:forEach var="img" items="${images}">
            <c:if test="${img.position == 1 && empty mainImgPath}">
                <c:set var="mainImgPath" value="${img.path}"/>
            </c:if>
        </c:forEach>

        <c:if test="${empty mainImgPath}">
            <c:if test="${not empty images}">
                <c:set var="mainImgPath" value="${images[0].path}"/>
            </c:if>
        </c:if>

        <c:if test="${empty mainImgPath}">
            <c:set var="mainImgPath" value="/assets/img/products/no-image.png"/>
        </c:if>

        <img src="<c:url value='${mainImgPath}'/>" width="100%" id="MainImg" data-all = "1" alt="">
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

        <div class="pd-row">
            <div class="pd-kv">
                <span>Mã (SKU):</span>
                <b id="pdSku">
                    <c:out value="${selectedVariant != null ? selectedVariant.sku : 'N/A'}"/>
                </b>
            </div>
            <div class="pd-kv">
                <span>Tồn kho:</span>
                <b id="pdStock">
                    <c:out value="${selectedVariant != null ? selectedVariant.stock : 0}"/>
                </b>
            </div>
        </div>

        <h2 id="pdPrice">
            <fmt:formatNumber value="${selectedVariant != null ? selectedVariant.finalPrice : p.price}" type="number"
                              maxFractionDigits="0"/>
            đ
        </h2>

        <c:set var="colorSet" value="${empty colorSet ? '' : colorSet}"/>
        <div class="pd-option">
            <div class="pd-option-head">
                <span>Màu:</span>
                <b id="pickedColor">(chọn)</b>
            </div>

            <div class="pd-chips" id="colorChips">
                <c:forEach var="v" items="${variants}">
                    <c:set var="opts" value="${optionMap[v.id]}"/>
                    <c:set var="colorVal" value=""/>

                    <c:forEach var="o" items="${opts}">
                        <c:if test="${o.attrCode == 'color' || o.attrName == 'Color' || o.attrName == 'Màu'}">
                            <c:set var="colorVal" value="${o.value}"/>
                        </c:if>
                    </c:forEach>

                    <c:if test="${not empty colorVal}">
                        <!-- unique color -->
                        <c:if test="${!fn:contains(colorSet, '|' += colorVal += '|')}">
                            <c:set var="colorSet" value="${colorSet}${'|'}${colorVal}${'|'}"/>

                            <button type="button"
                                    class="chip ${v.id == selectedId ? 'is-active' : ''}"
                                    data-attr="color"
                                    data-value="${colorVal}">
                                <c:out value="${colorVal}"/>
                            </button>
                        </c:if>
                    </c:if>
                </c:forEach>
            </div>
        </div>

        <select id="sizeSelect">
            <option value="">Select Size</option>

            <c:forEach var="v" items="${variants}">
                <c:set var="opts" value="${optionMap[v.id]}"/>
                <c:set var="sizeVal" value=""/>

                <c:forEach var="o" items="${opts}">
                    <c:if test="${o.attrCode == 'size' || o.attrName == 'Size'}">
                        <c:set var="sizeVal" value="${o.value}"/>
                    </c:if>
                </c:forEach>

                <c:if test="${not empty sizeVal}">
                    <option value="${v.id}" ${v.id == selectedId ? 'selected' : ''}>
                        <c:out value="${sizeVal}"/>
                    </option>
                </c:if>
            </c:forEach>
        </select>

        <input id="qtyInput" type="number" value="1" min="1">

        <button class="normal add-to-cart"
                type="button"
                id="btnAddToCart"
                data-product-id="${p.id}"
                data-variant-id="${selectedId}"
                data-name="${p.proName}"
                data-price="${selectedVariant != null ? selectedVariant.finalPrice : p.price}"
                data-image="${mainImg}">
            Thêm Vào Giỏ Hàng
        </button>

        <h4>Mô tả sản phẩm</h4>
        <span id="pdDescription">
            <c:out value="${p.description}" default="(Chưa có mô tả)"/>
        </span>
    </div>
</section>

<section id="product1" class="section-p1">
    <h2>Sản Phẩm Liên Quan</h2>
    <p>Bộ sưu tập lều mới</p>
    <div class="pro-container">
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
    <div class="copyright">
        <p>@ 2025, CampShop - HTML CSS Ecommerce Website</p>
    </div>
</footer>

<script>
    const MainImg = document.getElementById("MainImg");
    const smallImgs = document.getElementsByClassName("small-img");
    for (let i = 0; i < smallImgs.length; i++) {
        smallImgs[i].onclick = function () {
            MainImg.src = smallImgs[i].src;
        }
    }

    const sizeSelect = document.getElementById("sizeSelect");
    const btnAddToCart = document.getElementById("btnAddToCart");
    sizeSelect?.addEventListener("change", () => {
        const variantId = sizeSelect.value;
        if (!variantId) return;
        const url = new URL(window.location.href);
        url.searchParams.set("variantId", variantId);
        window.location.href = url.toString();
    });

    const pickedColor = document.getElementById("pickedColor");
    document.querySelectorAll("#colorChips .chip").forEach(btn => {
        if (btn.classList.contains("is-active")) pickedColor.innerText = btn.dataset.value || "(chọn)";
        btn.addEventListener("click", () => {
            document.querySelectorAll("#colorChips .chip").forEach(b => b.classList.remove("is-active"));
            btn.classList.add("is-active");
            pickedColor.innerText = btn.dataset.value || "(chọn)";
        });
    });
</script>
<script src="./assets/js/sproduct.js"></script>
</body>
</html>

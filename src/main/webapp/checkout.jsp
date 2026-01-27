<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="cc" value="${empty cartCount ? 0 : cartCount}"/>
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
    <link rel="stylesheet" href="${ctx}/assets/css/checkout.css">
    <link rel="stylesheet" href="${ctx}/assets/css/styles.css">
    <link rel="stylesheet" href="${ctx}/assets/css/search.css">
</head>

<body>
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

<section id="checkout" class="section-p1">
    <div class="checkout-container">
        <!-- Left side -->
        <div class="checkout-left">
            <h3>Thông tin thanh toán</h3>

            <c:if test="${not empty checkoutError}">
                <div style="margin: 10px 0 14px; padding: 10px 12px; border: 1px solid #f1c3c3; background: #fff3f3; border-radius: 10px; color: #b42318; font-weight: 700;">
                        ${checkoutError}
                </div>
            </c:if>
            <form id="shipping-form" action="${ctx}/checkout" method="post">
                <div class="form-group">
                    <label for="fullname">Họ và tên *</label>
                    <input type="text" id="fullname" name="receiver_name" placeholder="Nhập họ và tên" required>
                </div>

                <div class="form-group">
                    <label for="email">Địa chỉ email *</label>
                    <input type="email" id="email" name="email" placeholder="Nhập địa chỉ email" required>
                </div>

                <div class="form-group">
                    <label for="phone">Số điện thoại *</label>
                    <input type="tel" id="phone" name="phone" placeholder="Nhập số điện thoại" required>
                </div>

                <div class="form-group">
                    <label>Địa chỉ *</label>
                    <div class="address-row">
                        <input type="text" id="province" name="province" placeholder="Tỉnh/Thành phố" required>
                        <input type="text" id="district" name="district" placeholder="Quận/Huyện" required>
                        <input type="text" id="ward" name="ward" placeholder="Phường/Xã" required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="addressLine">Địa chỉ chi tiết *</label>
                    <input type="text" id="addressLine" name="address_line"
                           placeholder="Số nhà, tên đường..." required>
                </div>

                <div class="form-group">
                    <label for="note">Ghi chú (tuỳ chọn)</label>
                    <input type="text" id="note" name="note" placeholder="Ví dụ: giao giờ hành chính">
                </div>

                <div class="applied-discount">
                    <span>Đã áp dụng giảm giá</span>
                    <strong id="appliedDiscount">
                        - <fmt:formatNumber value="${discount}" type="number" groupingUsed="true"
                                            maxFractionDigits="0"/> đ
                    </strong>
                </div>

                <div class="shipping-fee">
                    <h3>Phí giao hàng</h3>
                    <div class="fee-line">
                        <span>Phí tạm tính</span>
                        <strong id="shippingFeeText">
                            <fmt:formatNumber value="${shippingFee}" type="number" groupingUsed="true"
                                              maxFractionDigits="0"/> đ
                        </strong>
                    </div>
                    <div class="fee-note">Phí giao hàng sẽ được tính sau khi xác nhận địa chỉ.</div>

                    <input type="hidden" name="shipping" value="${shippingFee}">
                </div>

                <div class="payment-method">
                    <h3>Phương thức thanh toán</h3>
                    <div class="pm-cod">
                        <i class="fa-solid fa-truck"></i>
                        Thanh toán khi nhận hàng (COD)
                    </div>
                    <input type="hidden" name="payment" value="COD">
                </div>
            </form>
        </div>

        <!-- Right side -->
        <div class="checkout-right">
            <h3>Đơn hàng của bạn</h3>

            <div id="checkoutItems">
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
                                        <fmt:formatNumber value="${it.unitPrice}" type="number" groupingUsed="true"
                                                          maxFractionDigits="0"/> đ
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
            </div>

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
                        <fmt:formatNumber value="${shippingFee}" type="number" groupingUsed="true"
                                          maxFractionDigits="0"/> đ
                    </span>
                </div>
                <div>
                    <span>Đã giảm</span>
                    <span id="sumDiscount">
                        - <fmt:formatNumber value="${discount}" type="number" groupingUsed="true"
                                            maxFractionDigits="0"/> đ
                    </span>
                </div>
                <div class="total">
                    <span>Tổng thanh toán</span>
                    <span id="sumTotal">
                        <fmt:formatNumber value="${total}" type="number" groupingUsed="true" maxFractionDigits="0"/> đ
                    </span>
                </div>
            </div>

            <button id="payBtn" class="normal" form="shipping-form" type="submit" ${empty items ? "disabled" : ""}>
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
        <p><strong>Địa chỉ: </strong> 562 Phường Linh Trung, Khu phố 6, TP.Thủ Đức, HCM</p>
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
            <img src="${ctx}/assets/img/pay/app.jpg" alt=""/>
            <img src="${ctx}/assets/img/pay/play.jpg" alt=""/>
        </div>
        <p>Bảo mật cổng thanh toán</p>
        <img src="${ctx}/assets/img/pay/pay.png" alt=""/>
    </div>
    <div class="copyright">
        <p>@ 2025, CampShop - HTML CSS Ecommerce Website</p>
    </div>
</footer>

<div class="cf-modal" id="paySuccessModal" aria-hidden="true">
    <div class="cf-modal__backdrop"></div>
    <div class="cf-modal__dialog" role="dialog" aria-modal="true">
        <div class="cf-modal__icon">
            <i class="fa-solid fa-circle-check"></i>
        </div>
        <h4>Đặt hàng thành công</h4>
        <p>Mã đơn: <strong id="successOrderId">#</strong></p>
        <button type="button" class="normal" id="successOkBtn">Đóng</button>
    </div>
</div>

<div class="cf-modal" id="loginPromptModal" aria-hidden="true">
    <div class="cf-modal__backdrop"></div>
    <div class="cf-modal__dialog" role="dialog" aria-modal="true">
        <div class="cf-modal__icon">
            <i class="fa-solid fa-circle-info"></i>
        </div>
        <h4>Đăng nhập để lưu đơn hàng?</h4>
        <p>Đơn hàng sẽ được lưu vào tài khoản để xem lại lịch sử.</p>

        <div style="display:flex; gap:10px; justify-content:center; margin-top:12px;">
            <button type="button" class="normal" id="loginAgreeBtn">Đồng ý</button>
            <button type="button" class="normal" id="loginSkipBtn" style="background:#fff; color:#111; border:1px solid #ddd;">
                Không
            </button>
        </div>
    </div>
</div>


<script>
    window.contextPath = "${ctx}";
</script>
<script src="${ctx}/assets/js/miniCartDropdown.js"></script>

<script>
    const ctx = window.contextPath || "";
    window.IS_LOGGED_IN = ${not empty sessionScope.auth};
    (function () {
        var form = document.getElementById("shipping-form");
        var payBtn = document.getElementById("payBtn");

        var successModal = document.getElementById("paySuccessModal");
        var okBtn = document.getElementById("successOkBtn");
        var orderIdEl = document.getElementById("successOrderId");
        var itemsWrap = document.getElementById("checkoutItems");

        var loginModal = document.getElementById("loginPromptModal");
        var loginAgreeBtn = document.getElementById("loginAgreeBtn");
        var loginSkipBtn = document.getElementById("loginSkipBtn");

        if (!form || !payBtn || !successModal || !okBtn) return;

        let guestConfirmed = false;

        function openSuccessModal(orderId) {
            orderIdEl.textContent = orderId ? ("#" + orderId) : "#";
            successModal.classList.add("open");
            successModal.setAttribute("aria-hidden", "false");
        }
        function closeSuccessModal() {
            successModal.classList.remove("open");
            successModal.setAttribute("aria-hidden", "true");
        }

        function openLoginModal() {
            loginModal.classList.add("open");
            loginModal.setAttribute("aria-hidden", "false");
        }
        function closeLoginModal() {
            loginModal.classList.remove("open");
            loginModal.setAttribute("aria-hidden", "true");
        }

        function saveCheckoutFormToSessionStorage() {
            const keys = ["receiver_name","email","phone","province","district","ward","address_line","note"];
            const data = {};
            keys.forEach(k => {
                const el = form.querySelector(`[name="${k}"]`);
                data[k] = el ? el.value : "";
            });
            sessionStorage.setItem("checkout_form", JSON.stringify(data));
        }

        function restoreCheckoutFormFromSessionStorage() {
            try {
                const raw = sessionStorage.getItem("checkout_form");
                if (!raw) return;
                const data = JSON.parse(raw);
                Object.keys(data).forEach(k => {
                    const el = form.querySelector(`[name="${k}"]`);
                    if (el && (el.value === "" || el.value == null)) el.value = data[k] || "";
                });
            } catch (e) {}
        }

        function clearCheckoutFormCache() {
            sessionStorage.removeItem("checkout_form");
        }

        function resetUI() {
            form.reset();
            clearCheckoutFormCache();
            guestConfirmed = false;

            if (itemsWrap) {
                itemsWrap.innerHTML = '<p style="padding: 12px 0;">Giỏ hàng trống.</p>';
            }

            var fmt = new Intl.NumberFormat("vi-VN");
            var sumSubtotal = document.getElementById("sumSubtotal");
            var sumShipping = document.getElementById("sumShipping");
            var sumDiscount = document.getElementById("sumDiscount");
            var sumTotal = document.getElementById("sumTotal");

            if (sumSubtotal) sumSubtotal.textContent = fmt.format(0) + " đ";
            if (sumShipping) sumShipping.textContent = fmt.format(0) + " đ";
            if (sumDiscount) sumDiscount.textContent = "- " + fmt.format(0) + " đ";
            if (sumTotal) sumTotal.textContent = fmt.format(0) + " đ";

            payBtn.disabled = true;

            var badge = document.getElementById("miniCartQty");
            if (badge) {
                badge.textContent = "";
                badge.style.display = "none";
            }

            if (typeof window.refreshMiniCartDropdown === "function") {
                window.refreshMiniCartDropdown();
            }
        }

        okBtn.addEventListener("click", function () {
            closeSuccessModal();
        });

        var successBackdrop = successModal.querySelector(".cf-modal__backdrop");
        if (successBackdrop) successBackdrop.addEventListener("click", closeSuccessModal);

        var loginBackdrop = loginModal ? loginModal.querySelector(".cf-modal__backdrop") : null;
        if (loginBackdrop) loginBackdrop.addEventListener("click", closeLoginModal);

        if (loginAgreeBtn) {
            loginAgreeBtn.addEventListener("click", function () {
                saveCheckoutFormToSessionStorage();
                closeLoginModal();

                window.location.href = ctx + "/login?return=" + encodeURIComponent("/checkout");
            });
        }

        if (loginSkipBtn) {
            loginSkipBtn.addEventListener("click", function () {
                guestConfirmed = true;
                closeLoginModal();
                proceedCheckout();
            });
        }

        async function proceedCheckout() {
            var receiver = (form.querySelector('[name="receiver_name"]') || {}).value || "";
            var phone = (form.querySelector('[name="phone"]') || {}).value || "";
            var addressLine = (form.querySelector('[name="address_line"]') || {}).value || "";
            if (!receiver.trim() || !phone.trim() || !addressLine.trim()) {
                alert("Vui lòng nhập đầy đủ Họ tên / SĐT / Địa chỉ chi tiết.");
                return;
            }

            payBtn.disabled = true;

            try {
                var formData = new FormData(form);
                var params = new URLSearchParams(formData);

                var res = await fetch(ctx + "/checkout", {
                    method: "POST",
                    body: params,
                    headers: {
                        "Accept": "application/json",
                        "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
                        "X-Requested-With": "XMLHttpRequest"
                    }
                });

                var data = await res.json();
                if (!res.ok || !data || !data.ok) {
                    throw new Error((data && data.message) ? data.message : "Đặt hàng thất bại");
                }

                openSuccessModal(data.orderId);
                resetUI();

            } catch (err) {
                console.error(err);
                alert(err.message || "Có lỗi khi đặt hàng");
                payBtn.disabled = false;
            }
        }

        restoreCheckoutFormFromSessionStorage();

        form.addEventListener("submit", function (e) {
            e.preventDefault();

            if (!window.IS_LOGGED_IN && !guestConfirmed) {
                openLoginModal();
                return;
            }

            proceedCheckout();
        });

    })();

    const CHECKOUT_DRAFT_KEY = "checkout_draft_v1";

    function saveCheckoutDraft(form) {
        const data = {};
        new FormData(form).forEach((v, k) => data[k] = v);
        sessionStorage.setItem(CHECKOUT_DRAFT_KEY, JSON.stringify(data));
    }

    function sleep(ms){ return new Promise(r => setTimeout(r, ms)); }

    async function setSelectWhenReady(selectEl, value, tries = 20) {
        if (!selectEl || value == null) return;
        if (selectEl.tagName !== "SELECT") { selectEl.value = value; return; }

        while (tries-- > 0) {
            const hasOption = Array.from(selectEl.options).some(o => o.value == value);
            if (hasOption) {
                selectEl.value = value;
                selectEl.dispatchEvent(new Event("change", { bubbles: true }));
                return;
            }
            await sleep(150);
        }
    }

    async function restoreCheckoutDraft(form) {
        const raw = sessionStorage.getItem(CHECKOUT_DRAFT_KEY);
        if (!raw) return;

        let data;
        try { data = JSON.parse(raw); } catch { return; }

        for (const [k, v] of Object.entries(data)) {
            if (k === "province" || k === "district" || k === "ward") continue;

            const el = form.elements[k];
            if (!el) continue;

            if (el instanceof RadioNodeList) {
                const target = form.querySelector(`[name="${k}"][value="${CSS.escape(String(v))}"]`);
                if (target) target.checked = true;
            } else {
                if (el.type === "checkbox") el.checked = (String(v) === "on" || String(v) === "true" || String(v) === "1");
                else el.value = v;
            }
        }


        await setSelectWhenReady(form.elements["province"], data.province);
        await setSelectWhenReady(form.elements["district"], data.district);
        await setSelectWhenReady(form.elements["ward"], data.ward);
    }

    function clearCheckoutDraft() {
        sessionStorage.removeItem(CHECKOUT_DRAFT_KEY);
    }
</script>
</body>
</html>

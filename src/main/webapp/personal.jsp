<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Trang cá nhân</title>
    <meta name="description" content="" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
            rel="stylesheet"
    />
    <link
            rel="stylesheet"
            href="https://cdn.datatables.net/1.13.1/css/jquery.dataTables.min.css"
    />
    <link
            rel="stylesheet"
            href="https://cdn.datatables.net/buttons/2.4.2/css/buttons.dataTables.min.css"
    />
    <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
    />
    <link
            rel="stylesheet"
            href="https://cdn.jsdelivr.net/npm/@flaticon/flaticon-uicons/css/all/all.css"
    />
    <link rel="stylesheet" href="./assets/css/styles.css" />
    <link rel="stylesheet" href="./assets/css/personal.css" />
    <link rel="stylesheet" href="assets/css/search.css">
    <style>
        #top-notification {
            position: fixed;
            top: -100px;
            left: 50%;
            transform: translateX(-50%);
            z-index: 10000;
            transition: all 0.5s cubic-bezier(0.68, -0.55, 0.265, 1.55);
            min-width: 280px;
        }

        #top-notification.show {
            top: 30px;
        }

        .notif-box {
            background: #ffffff;
            color: #333;
            padding: 12px 20px;
            border-radius: 50px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
            display: flex;
            align-items: center;
            border: 1px solid #eee;
        }

        .notif-box i {
            margin-right: 12px;
            font-size: 18px;
        }

        .success-border { border-bottom: 3px solid #28a745; }
        .error-border { border-bottom: 3px solid #dc3545; }
    </style>
</head>
<body>
<div id="top-notification">
    <c:choose>
        <c:when test="${param.msg == 'change_success' || param.msg == 'update_success'}">
            <div class="notif-box success-border">
                <i class="fas fa-check-circle text-success"></i>
                <span>${param.msg == 'change_success' ? 'Đổi mật khẩu thành công!' : 'Cập nhật thông tin thành công!'}</span>
            </div>
        </c:when>
        <c:when test="${not empty passwordError || not empty error}">
            <div class="notif-box error-border">
                <i class="fas fa-times-circle text-danger"></i>
                <span>${not empty passwordError ? passwordError : error}</span>
            </div>
        </c:when>
    </c:choose>
</div>
<div class="header-top"></div>
<section id="header">
    <a href="${pageContext.request.contextPath}/home"><img class="logo_img" src="./assets/img/logo_new.png" alt="logo"></a>
    <ul id="navbar">
        <li><a href="${pageContext.request.contextPath}/home" class="active">Trang chủ</a></li>
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
<div class="container mt-5">
    <div class="card mb-4">
        <div class="card-header bg-primary text-white">
            <h4>Thông Tin Cá Nhân</h4>
        </div>
        <div class="card-body">
            <div>
                <p><strong>Họ và tên:</strong> ${user.fullName}</p>
                <p><strong>Số điện thoại:</strong> ${user.phone != null ? user.phone : 'Chưa cập nhật'}</p>
                <p><strong>Email:</strong> ${user.email}</p>
                <p><strong>Địa chỉ:</strong> ${user.address != null ? user.address : 'Chưa cập nhật'}</p>
                <div class="button-group">
                    <button
                            class="btn btn-warning btn-sm"
                            data-bs-toggle="modal"
                            data-bs-target="#changePassword"
                    >
                        <i class="fas fa-key"></i> Đổi mật khẩu
                    </button>
                    <button
                            class="btn btn-success btn-sm"
                            data-bs-toggle="modal"
                            data-bs-target="#editPersonalInfoModal"
                    >
                        <i class="fas fa-edit"></i> Chỉnh sửa
                    </button>
                    <a href="logout" class="btn btn-danger btn-sm logout-link"><i class="fa fa-sign-out-alt"></i> Đăng xuất</a>
                    <button
                            class="btn btn-primary btn-sm"
                            data-bs-toggle="modal"
                            data-bs-target="#voucherModal"
                    >
                        <i class="fas fa-ticket-alt"></i> Voucher của tôi
                    </button>
                    <button
                            class="btn btn-dark btn-sm"
                            onclick="window.location.href='admin/dashboard.jsp'"
                    >
                        <i class="fas fa-user-shield"></i> Admin
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<div
        class="modal fade"
        id="editPersonalInfoModal"
        data-bs-backdrop="false"
        data-bs-focus="false"
        tabindex="-1"
        aria-labelledby="editLabel"
        aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editLabel">Chỉnh Sửa Thông Tin Cá Nhân</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="update-profile" method="post">
                    <div class="mb-3">
                        <label for="nameChange" class="form-label">Họ và tên</label>
                        <input type="text" class="form-control" id="nameChange" name="fullName" value="${user.fullName}" required />
                    </div>
                    <div class="mb-3">
                        <label for="phoneChange" class="form-label">Số điện thoại</label>
                        <input type="text" class="form-control" id="phoneChange" name="phone" value="${user.phone}" />
                    </div>
                    <div class="mb-3">
                        <label for="emailChange" class="form-label">Email</label>
                        <input type="email" class="form-control" id="emailChange" name="email" value="${user.email}" />
                    </div>
                    <div class="mb-3">
                        <label for="addressChange" class="form-label">Địa chỉ</label>
                        <input type="text" class="form-control" id="addressChange" name="address" value="${user.address}" />
                    </div>
                    <button type="submit" class="btn btn-primary" style="background-color: #088178 !important; border:none;">Lưu Thay Đổi</button>
                </form>
            </div>
        </div>
    </div>
</div>
<div
        class="modal fade"
        id="changePassword"
        tabindex="-1"
        aria-labelledby="changePasswordLabel"
        aria-hidden="true"
>
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="changePasswordLabel">Đổi mật khẩu</h5>
                <button
                        type="button"
                        class="btn-close"
                        data-bs-dismiss="modal"
                        aria-label="Đóng"
                ></button>
            </div>
            <div class="modal-body">
                <form action="change-password" method="post">
                    <div class="mb-3">
                        <label for="currentPassword" class="form-label"
                        >Mật khẩu hiện tại</label
                        >
                        <input
                                type="password"
                                class="form-control"
                                id="currentPassword"
                                name="currentPassword"
                                placeholder="Nhập mật khẩu hiện tại"
                                required
                        />
                        <div class="text-danger small" id="currentPasswordError"></div>
                    </div>
                    <div class="mb-3">
                        <label for="newPassword" class="form-label">Mật khẩu mới</label>
                        <input
                                type="password"
                                class="form-control"
                                id="newPassword"
                                name="newPassword"
                                placeholder="Nhập mật khẩu mới"
                                required
                        />
                        <div class="text-danger small" id="newPasswordError"></div>
                    </div>
                    <div class="mb-3">
                        <label for="confirmPassword" class="form-label"
                        >Nhập lại mật khẩu mới</label
                        >
                        <input
                                type="password"
                                class="form-control"
                                id="confirmPassword"
                                name="confirmPassword"
                                placeholder="Nhập lại mật khẩu mới"
                                required
                        />
                        <div class="text-danger small" id="confirmPasswordError"></div>
                    </div>
                    <button
                            type="submit"
                            class="btn btn-primary"
                            style="background-color: var(--primary-color) !important"
                    >
                        Lưu Thay Đổi
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="card mb-4" style="margin: 30px">
    <div
            class="card-header text-white"
            style="background: #088178 !important"
    >
        <h4>Đơn Hàng Của Bạn</h4>
    </div>
    <div class="card-body">
        <div
                class="order-status-tabs d-flex justify-content-start mb-4"
                id="orderStatusTabs"
        >
            <button class="status-tab active" data-status="">Tất cả</button>
            <button class="status-tab" data-status="PENDING">Chờ xác nhận</button>
            <button class="status-tab" data-status="DELIVERING">Đang giao</button>
            <button class="status-tab" data-status="COMPLETED">Hoàn thành</button>
            <button class="status-tab" data-status="CANCELED">Đã huỷ</button>
        </div>

        <table id="allOrders" class="table table-bordered display">
            <thead>
            <tr data-order-id="12345">
                <th>Mã đơn</th>
                <th>Ngày đặt</th>
                <th>Tổng tiền</th>
                <th>Thanh toán</th>
                <th>Vận chuyển</th>
                <th>Hành động</th>
            </tr>
            </thead>
            <tbody id="ordersTbody">
            <c:choose>
                <c:when test="${empty orders}">
                    <tr>
                        <td colspan="6" style="text-align:center;">
                            <c:choose>
                                <c:when test="${not empty orderError}">
                                    ${orderError}
                                </c:when>
                                <c:otherwise>
                                    Bạn chưa có đơn hàng nào.
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:when>

                <c:otherwise>
                    <c:forEach var="o" items="${orders}">
                        <tr>
                            <td>#ODR${o.id}</td>

                            <td>
                                <fmt:formatDate value="${o.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
                            </td>

                            <td class="text-right">
                                <fmt:formatNumber value="${o.totalAmount}" type="number"/> đ
                            </td>

                            <td>
                                <c:choose>
                                    <c:when test="${o.paymentStatus == 'UNPAID'}">Chưa thanh toán</c:when>
                                    <c:when test="${o.paymentStatus == 'PENDING'}">Chờ thanh toán</c:when>
                                    <c:when test="${o.paymentStatus == 'PAID'}">Đã thanh toán</c:when>
                                    <c:when test="${o.paymentStatus == 'FAILED'}">Thanh toán thất bại</c:when>
                                    <c:when test="${o.paymentStatus == 'REFUNDED'}">Đã hoàn tiền</c:when>
                                    <c:otherwise>${o.paymentStatus}</c:otherwise>
                                </c:choose>
                            </td>

                            <td>
                                <c:choose>
                                    <c:when test="${o.deliveryStatus == 'PENDING'}">Chờ xác nhận</c:when>
                                    <c:when test="${o.deliveryStatus == 'DELIVERING'}">Đang giao</c:when>
                                    <c:when test="${o.deliveryStatus == 'COMPLETED'}">Hoàn thành</c:when>
                                    <c:when test="${o.deliveryStatus == 'CANCELED'}">Đã huỷ</c:when>
                                    <c:otherwise>${o.deliveryStatus}</c:otherwise>
                                </c:choose>
                            </td>

                            <td>
                                <c:choose>

                                    <c:when test="${o.deliveryStatus == 'PENDING'}">
                                        <form method="post" action="${pageContext.request.contextPath}/order-cancel" style="display:inline;">
                                            <input type="hidden" name="orderId" value="${o.id}" />
                                            <button type="submit" class="btn btn-sm btn-danger"
                                                    onclick="return confirm('Bạn chắc chắn muốn huỷ đơn này?');">
                                                Huỷ đơn
                                            </button>
                                        </form>
                                    </c:when>

                                    <c:when test="${o.deliveryStatus == 'COMPLETED'}">
                                        <a class="btn btn-sm btn-success"
                                           href="${pageContext.request.contextPath}/review?orderId=${o.id}">
                                            Đánh giá
                                        </a>
                                    </c:when>

                                    <c:when test="${o.deliveryStatus == 'DELIVERING'}">
                                        <button type="button" class="btn btn-sm btn-secondary" disabled>Đang giao</button>
                                    </c:when>

                                    <c:when test="${o.deliveryStatus == 'CANCELED'}">
                                        <button type="button" class="btn btn-sm btn-secondary" disabled>Đã huỷ</button>
                                    </c:when>

                                    <c:otherwise>
                                        <button type="button" class="btn btn-sm btn-secondary" disabled>—</button>
                                    </c:otherwise>

                                </c:choose>
                            </td>

                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
            </tbody>


        </table>
    </div>
</div>

<div
        class="modal fade"
        id="orderDetailsModal"
        tabindex="-1"
        aria-labelledby="orderDetailsModalLabel"
        aria-hidden="true"
>
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="orderDetailsModalLabel">
                    Chi Tiết Đơn Hàng
                </h5>
                <button
                        type="button"
                        class="btn-close"
                        data-bs-dismiss="modal"
                        aria-label="Close"
                ></button>
            </div>
            <div class="modal-body">
                <div id="orderRecipientInfo">
                    <p><strong>Người nhận:</strong> Nguyễn Văn A</p>
                    <p>
                        <strong>Địa chỉ:</strong> 123 Đường ABC, Phường 1, Quận 2, TP.
                        Hồ Chí Minh
                    </p>
                </div>
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th>Mã sản phẩm</th>
                        <th>Tên Sản Phẩm</th>
                        <th>Ảnh</th>
                        <th>Kích Thước</th>
                        <th>Số Lượng</th>
                        <th>Giá</th>
                        <th class="review-column">Đánh giá</th>
                    </tr>
                    </thead>
                    <tbody id="orderDetailsBody">
                    <tr>
                        <td>P001</td>
                        <td>Lều cắm trại</td>
                        <td>
                            <img
                                    src="./assets/img/products/f3.jpg"
                                    alt="Ảnh sản phẩm"
                                    width="50"
                            />
                        </td>
                        <td>40x60cm</td>
                        <td>1</td>
                        <td>1.500.000 ₫</td>
                        <td class="review-column">
                            <button
                                    class="btn btn-secondary btn-sm"
                                    data-bs-toggle="modal"
                                    data-bs-target="#reviewModal"
                            >
                                Đánh giá
                            </button>
                        </td>
                    </tr>
                    </tbody>
                </table>
                <div id="totalPrice" class="fw-bold text-end">
                    Tổng tiền: 1.500.000 ₫
                </div>
            </div>
        </div>
    </div>
</div>

<div
        class="modal fade"
        id="reviewModal"
        tabindex="-1"
        aria-labelledby="reviewModalLabel"
        aria-hidden="true"
>
    <div class="modal-dialog modal-md">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="reviewModalLabel">Đánh giá sản phẩm</h5>
                <button
                        type="button"
                        class="btn-close"
                        data-bs-dismiss="modal"
                        aria-label="Đóng"
                ></button>
            </div>
            <div class="modal-body">
                <input type="hidden" id="reviewOrderId" value="">

                <div id="reviewItemsWrap">
                    <p class="text-muted mb-0">Đang tải danh sách sản phẩm...</p>
                </div>
            </div>
        </div>
    </div>
</div>

<div
        class="modal fade"
        id="addressModal"
        tabindex="-1"
        aria-labelledby="addressModalLabel"
        aria-hidden="true"
>
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addressModalLabel">
                    Nhập địa chỉ nhận hàng
                </h5>
                <button
                        type="button"
                        class="btn-close"
                        data-bs-dismiss="modal"
                        aria-label="Close"
                ></button>
            </div>
            <div class="modal-body">
                <div class="mb-3">
                    <label for="province" class="form-label">Tỉnh/Thành phố:</label>
                    <input
                            type="text"
                            class="form-control"
                            id="province"
                            placeholder="Tỉnh/Thành phố"
                            required
                    />
                </div>
                <div class="mb-3">
                    <label for="district" class="form-label">Quận/Huyện:</label>
                    <input
                            type="text"
                            class="form-control"
                            id="district"
                            placeholder="Quận/Huyện"
                            required
                    />
                </div>
                <div class="mb-3">
                    <label for="ward" class="form-label">Phường/Xã:</label>
                    <input
                            type="text"
                            class="form-control"
                            id="ward"
                            placeholder="Phường/xã"
                            required
                    />
                </div>
                <div class="mb-3">
                    <label for="specificAddress" class="form-label"
                    >Địa chỉ cụ thể:</label
                    >
                    <input
                            type="text"
                            class="form-control"
                            id="specificAddress"
                            placeholder="Số nhà, tên đường..."
                            required
                    />
                </div>
            </div>
            <div class="modal-footer">
                <button
                        type="button"
                        class="btn btn-secondary"
                        id="closeAddressModal"
                        data-bs-dismiss="modal"
                >
                    Hủy
                </button>
                <button type="button" class="btn btn-primary" id="saveAddress">
                    Lưu
                </button>
            </div>
        </div>
    </div>
</div>

<div
        class="modal fade"
        id="voucherModal"
        tabindex="-1"
        aria-labelledby="voucherModalLabel"
        aria-hidden="true"
>
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title" id="voucherModalLabel">
                    Danh sách voucher của bạn
                </h5>
                <button
                        type="button"
                        class="btn-close"
                        data-bs-dismiss="modal"
                        aria-label="Đóng"
                ></button>
            </div>
            <div class="modal-body">
                <table class="table table-bordered table-striped">
                    <thead>
                    <tr>
                        <th>Tên voucher</th>
                        <th>Mã</th>
                        <th>Giảm (%)</th>
                        <th>Hiệu lực</th>
                        <th>Hết hạn</th>
                        <th>Trạng thái</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>Giảm giá đặc biệt</td>
                        <td>SALE20</td>
                        <td>20</td>
                        <td>2025-01-01</td>
                        <td>2025-12-31</td>
                        <td>Chưa dùng</td>
                    </tr>
                    <tr>
                        <td>Ưu đãi cho thành viên mới</td>
                        <td>NEWBIE10</td>
                        <td>10</td>
                        <td>2024-01-01</td>
                        <td>2025-06-30</td>
                        <td>Đã dùng</td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button
                        type="button"
                        class="btn btn-secondary"
                        data-bs-dismiss="modal"
                >
                    Đóng
                </button>
            </div>
        </div>
    </div>
</div>
<section id="newsletter" class="section-p1">
    <div class="newstext">
        <h4>Đăng ký nhận tin</h4>
        <p>Nhập email về cập nhật mới nhất <span>ưu đãi đặc biệt.</span></p>
    </div>
    <div class="form">
        <input type="text" placeholder="Nhập email của bạn" />
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
<div class="modal fade" id="cancelOrderModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Xác nhận huỷ đơn</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
            </div>

            <div class="modal-body">
                <p style="margin:0;">Bạn chắc chắn muốn huỷ đơn <b id="cancelOrderCode">#</b>?</p>
                <input type="hidden" id="cancelOrderId" value="">
                <div id="cancelOrderErr" style="display:none; margin-top:8px; color:#b42318; font-size:13px;"></div>
            </div>

            <div class="modal-footer" style="gap:8px;">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Không</button>
                <button type="button" class="btn btn-danger" id="btnConfirmCancel">Huỷ đơn</button>
            </div>
        </div>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.datatables.net/1.13.1/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.4.2/js/dataTables.buttons.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.7/pdfmake.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.7/vfs_fonts.js"></script>
<script src="https://cdn.datatables.net/buttons/2.4.2/js/buttons.html5.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.4.2/js/buttons.print.min.js"></script>
<script>
    const ctx = "${pageContext.request.contextPath}";

    document.addEventListener("DOMContentLoaded", function () {
        const notif = document.getElementById("top-notification");
        if (notif && notif.querySelector(".notif-box")) {
            setTimeout(function () { notif.classList.add("show"); }, 300);
            setTimeout(function () { notif.classList.remove("show"); }, 3300);

            const url = new URL(window.location.href);
            url.searchParams.delete("msg");
            window.history.replaceState({}, "", url.toString());
        }
    });

    function fmtMoneyVn(numStr) {
        const n = Number(numStr || 0);
        return new Intl.NumberFormat("vi-VN").format(n) + " đ";
    }

    function fmtDateVn(iso) {
        if (!iso) return "";
        const d = new Date(iso);
        const pad = function (x) { return String(x).padStart(2, "0"); };
        return pad(d.getDate()) + "/" + pad(d.getMonth() + 1) + "/" + d.getFullYear() + " " +
            pad(d.getHours()) + ":" + pad(d.getMinutes());
    }

    function renderOrders(orders) {
        const tbody = document.getElementById("ordersTbody");
        if (!tbody) return;

        if (!orders || orders.length === 0) {
            tbody.innerHTML = '<tr><td colspan="6" style="text-align:center;">Bạn chưa có đơn hàng nào.</td></tr>';
            return;
        }

        let html = "";
        for (let i = 0; i < orders.length; i++) {
            const o = orders[i];

            let actionHtml = '<button type="button" class="btn btn-sm btn-secondary" disabled>—</button>';

            if (o.canCancel) {
                actionHtml =
                    '<button type="button" class="btn btn-sm btn-danger btn-open-cancel" ' +
                    'data-order-id="' + o.id + '" ' +
                    'data-bs-toggle="modal" data-bs-target="#cancelOrderModal">' +
                    'Huỷ đơn' +
                    '</button>';
            }
            else if (o.canReview) {
            actionHtml =
                '<button type="button" class="btn btn-sm btn-success btn-open-review" ' +
                'data-order-id="' + o.id + '" ' +
                'data-bs-toggle="modal" data-bs-target="#reviewModal">' +
                'Đánh giá' +
                '</button>';
            }


        html +=
                "<tr>" +
                "<td>#ODR" + o.id + "</td>" +
                "<td>" + fmtDateVn(o.orderDate) + "</td>" +
                '<td class="text-right">' + fmtMoneyVn(o.totalAmount) + "</td>" +
                "<td>" + (o.paymentStatusVi || o.paymentStatus || "") + "</td>" +
                "<td>" + (o.deliveryStatusVi || o.deliveryStatus || "") + "</td>" +
                "<td>" + actionHtml + "</td>" +
                "</tr>";
        }

        tbody.innerHTML = html;
    }

    async function loadOrdersByStatus(status) {
        let url = ctx + "/personal";
        if (status) url += "?status=" + encodeURIComponent(status);

        const res = await fetch(url, {
            headers: {
                "Accept": "application/json",
                "X-Requested-With": "XMLHttpRequest"
            }
        });

        if (res.status === 401) {
            window.location.href = ctx + "/login?return=/personal";
            return;
        }

        const data = await res.json();
        if (!data || !data.ok) throw new Error((data && data.message) || "Load orders failed");

        renderOrders(data.orders);
    }

    document.addEventListener("DOMContentLoaded", function () {
        const tabs = document.querySelectorAll(".status-tab[data-status]");

        for (let i = 0; i < tabs.length; i++) {
            tabs[i].addEventListener("click", async function () {
                for (let j = 0; j < tabs.length; j++) tabs[j].classList.remove("active");
                this.classList.add("active");

                const st = this.getAttribute("data-status") || "";
                try {
                    await loadOrdersByStatus(st);
                } catch (e) {
                    console.error(e);
                    window.location.href = st ? (ctx + "/personal?status=" + encodeURIComponent(st)) : (ctx + "/personal");
                }
            });
        }

        const active = document.querySelector(".status-tab.active[data-status]");
        const initStatus = active ? (active.getAttribute("data-status") || "") : "";
        loadOrdersByStatus(initStatus).catch(console.error);
    });

    function escHtml(s) {
        if (s == null) return "";
        return String(s)
            .replace(/&/g, "&amp;")
            .replace(/</g, "&lt;")
            .replace(/>/g, "&gt;")
            .replace(/"/g, "&quot;")
            .replace(/'/g, "&#039;");
    }

    async function fetchReviewItems(orderId) {
        const url = ctx + "/review?action=items&orderId=" + encodeURIComponent(orderId);
        const res = await fetch(url, {
            headers: { "Accept": "application/json", "X-Requested-With": "XMLHttpRequest" }
        });
        if (res.status === 401) {
            window.location.href = ctx + "/login?return=/personal";
            return null;
        }
        const data = await res.json();
        if (!data || !data.ok) throw new Error((data && data.message) || "Load review items failed");
        return data.items || [];
    }

    function renderStarsHtml(orderItemId, ratingValue) {
        let html = '<div class="rv-stars" data-order-item-id="' + orderItemId + '">';
        for (let i = 1; i <= 5; i++) {
            const cls = (i <= ratingValue) ? "fa fa-star text-warning rv-star" : "fa fa-star rv-star";
            html += '<i class="' + cls + '" data-value="' + i + '"></i>';
        }
        html += '</div>';
        html += '<input type="hidden" class="rv-rating" id="rv_rating_' + orderItemId + '" value="' + ratingValue + '">';
        return html;
    }

    function normalizeImgUrl(path) {
        if (!path) return "";
        if (path.startsWith("http://") || path.startsWith("https://")) return path;
        if (path.startsWith(ctx + "/")) return path;

        if (!path.startsWith("/")) path = "/" + path;
        return ctx + path;
    }

    function renderReviewItems(orderId, items) {
        const wrap = document.getElementById("reviewItemsWrap");
        if (!wrap) return;

        if (!items || items.length === 0) {
            wrap.innerHTML = '<p class="mb-0">Không có sản phẩm để đánh giá (chỉ cho phép đơn Hoàn thành).</p>';
            return;
        }

        let html = "";
        for (let i = 0; i < items.length; i++) {
            const it = items[i];

            const reviewed = !!it.reviewed;
            const img = normalizeImgUrl(it.image);
            const name = it.proName ? it.proName : "";
            const size = it.size ? it.size : "";
            const qty = it.quantity ? it.quantity : "";

            html +=
                '<div class="d-flex align-items-start mb-3 border p-2 rounded" data-order-item-id="' + it.orderItemId + '">' +
                '<img src="' + escHtml(img) + '" alt="Ảnh sản phẩm" width="60" height="60" style="object-fit:cover;border-radius:4px;">' +
                '<div class="ms-3 flex-grow-1">' +
                '<div class="fw-bold">' + escHtml(name) + '</div>' +
                '<div class="d-flex flex-wrap text-muted" style="gap:12px;">' +
                (size ? ('<div>Kích thước: <span>' + escHtml(size) + '</span></div>') : '') +
                (qty ? ('<div>Số lượng: <span>' + escHtml(qty) + '</span></div>') : '') +
                '</div>' +

                (reviewed
                        ? '<div class="mt-2 text-success fw-semibold">Bạn đã đánh giá sản phẩm này.</div>'
                        : (
                            '<div class="mt-2">' +
                            renderStarsHtml(it.orderItemId, 5) +
                            '<textarea class="form-control mt-2 rv-content" id="rv_content_' + it.orderItemId + '" rows="3" placeholder="Viết đánh giá của bạn..."></textarea>' +
                            '<div class="mt-2">' +
                            '<button type="button" class="btn btn-primary btn-submit-review" ' +
                            'data-order-id="' + orderId + '" ' +
                            'data-order-item-id="' + it.orderItemId + '" ' +
                            'data-product-id="' + it.productId + '">' +
                            'Gửi đánh giá' +
                            '</button>' +
                            '</div>' +
                            '</div>'
                        )
                ) +
                '</div>' +
                '</div>';
        }

        wrap.innerHTML = html;
    }

    async function submitReview(orderId, orderItemId, productId) {
        const ratingEl = document.getElementById("rv_rating_" + orderItemId);
        const contentEl = document.getElementById("rv_content_" + orderItemId);

        const rating = ratingEl ? ratingEl.value : "5";
        const content = contentEl ? contentEl.value : "";

        const body =
            "orderId=" + encodeURIComponent(orderId) +
            "&orderItemId=" + encodeURIComponent(orderItemId) +
            "&productId=" + encodeURIComponent(productId) +
            "&rating=" + encodeURIComponent(rating) +
            "&content=" + encodeURIComponent(content);

        const res = await fetch(ctx + "/review", {
            method: "POST",
            headers: {
                "Accept": "application/json",
                "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
                "X-Requested-With": "XMLHttpRequest"
            },
            body: body
        });

        const data = await res.json();
        if (!res.ok || !data || !data.ok) {
            alert((data && data.message) ? data.message : "Gửi đánh giá thất bại");
            return;
        }

        const items = await fetchReviewItems(orderId);
        renderReviewItems(orderId, items);
    }

    document.addEventListener("click", async function (e) {
        const btn = e.target.closest(".btn-open-review");
        if (!btn) return;

        const orderId = btn.getAttribute("data-order-id");
        if (!orderId) return;

        document.getElementById("reviewOrderId").value = orderId;
        const wrap = document.getElementById("reviewItemsWrap");
        if (wrap) wrap.innerHTML = '<p class="text-muted mb-0">Đang tải danh sách sản phẩm...</p>';

        try {
            const items = await fetchReviewItems(orderId);
            renderReviewItems(Number(orderId), items);
        } catch (err) {
            console.error(err);
            if (wrap) wrap.innerHTML = "<p>Không tải được dữ liệu đánh giá.</p>";
        }
    });

    document.addEventListener("click", function (e) {
        const star = e.target.closest(".rv-star");
        if (!star) return;

        const starsWrap = star.closest(".rv-stars");
        if (!starsWrap) return;

        const orderItemId = starsWrap.getAttribute("data-order-item-id");
        const val = star.getAttribute("data-value");

        const input = document.getElementById("rv_rating_" + orderItemId);
        if (input) input.value = val;

        const all = starsWrap.querySelectorAll(".rv-star");
        for (let i = 0; i < all.length; i++) {
            const v = all[i].getAttribute("data-value");
            if (Number(v) <= Number(val)) {
                all[i].classList.add("text-warning");
            } else {
                all[i].classList.remove("text-warning");
            }
        }
    });

    document.addEventListener("click", function (e) {
        const btn = e.target.closest(".btn-submit-review");
        if (!btn) return;

        const orderId = btn.getAttribute("data-order-id");
        const orderItemId = btn.getAttribute("data-order-item-id");
        const productId = btn.getAttribute("data-product-id");

        submitReview(orderId, orderItemId, productId).catch(console.error);
    });

    document.addEventListener("hidden.bs.modal", function (e) {
        if (e.target && e.target.id === "reviewModal") {
            const wrap = document.getElementById("reviewItemsWrap");
            if (wrap) wrap.innerHTML = '<p class="text-muted mb-0">Đang tải danh sách sản phẩm...</p>';
            const hid = document.getElementById("reviewOrderId");
            if (hid) hid.value = "";
        }
    });
</script>
<script>
    (function () {
        var modalEl = document.getElementById("cancelOrderModal");
        if (!modalEl) return;

        var cancelOrderIdEl = document.getElementById("cancelOrderId");
        var cancelOrderCodeEl = document.getElementById("cancelOrderCode");
        var cancelErrEl = document.getElementById("cancelOrderErr");
        var btnConfirm = document.getElementById("btnConfirmCancel");

        function showErr(msg) {
            cancelErrEl.style.display = "block";
            cancelErrEl.textContent = msg || "Huỷ đơn thất bại";
        }
        function clearErr() {
            cancelErrEl.style.display = "none";
            cancelErrEl.textContent = "";
        }

        document.addEventListener("click", function (e) {
            var btn = e.target.closest(".btn-open-cancel");
            if (!btn) return;

            clearErr();

            var orderId = btn.getAttribute("data-order-id");
            if (!orderId) return;

            cancelOrderIdEl.value = orderId;
            cancelOrderCodeEl.textContent = "#ODR" + orderId;
        });

        btnConfirm.addEventListener("click", async function () {
            clearErr();

            var orderId = cancelOrderIdEl.value;
            if (!orderId) return;

            btnConfirm.disabled = true;

            try {
                var res = await fetch(ctx + "/order-cancel", {
                    method: "POST",
                    headers: {
                        "Accept": "application/json",
                        "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
                        "X-Requested-With": "XMLHttpRequest"
                    },
                    body: "orderId=" + encodeURIComponent(orderId)
                });

                if (res.status === 401) {
                    window.location.href = ctx + "/login?return=/personal";
                    return;
                }

                var data = await res.json();
                if (!res.ok || !data || !data.ok) {
                    showErr((data && data.message) ? data.message : "Huỷ đơn thất bại");
                    return;
                }

                var row = document.querySelector('tr[data-order-id="' + orderId + '"]');
                if (row) row.remove();

                try {
                    var active = document.querySelector(".status-tab.active[data-status]");
                    var st = active ? (active.getAttribute("data-status") || "") : "";
                    if (typeof loadOrdersByStatus === "function") {
                        await loadOrdersByStatus(st);
                    }
                } catch (err) {}

                if (window.bootstrap && bootstrap.Modal) {
                    var ins = bootstrap.Modal.getInstance(modalEl);
                    if (ins) ins.hide();
                }

            } catch (err) {
                console.error(err);
                showErr("Không thể huỷ đơn lúc này.");
            } finally {
                btnConfirm.disabled = false;
            }
        });

        modalEl.addEventListener("hidden.bs.modal", function () {
            clearErr();
            cancelOrderIdEl.value = "";
        });

    })();
</script>
</body>
</html>
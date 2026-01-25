<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
  </head>
  <body>
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
      <form action="${pageContext.request.contextPath}/search" method="get" class="d-flex">
        <div id="search-box">
          <input type="text" name="q" id="searchInput" placeholder="Tìm sản phẩm..." value="${q}" />
          <button id="searchBtn" type="submit"><i class="fa fa-search"></i></button>
        </div>
      </form>

      <!-- mini cart -->
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

      <!-- auth button/user -->
      <div class="auth-buttons">
        <%
          vn.edu.hcmuaf.edu.vn.campforge.model.User user =
                  (vn.edu.hcmuaf.edu.vn.campforge.model.User) session.getAttribute("auth");

          if (user == null) {
        %>
        <a href="logout" class="logout-link">
          <i class="fas fa-sign-out-alt"></i> Đăng xuất
        </a>
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
    <!-- main -->
    <div class="container mt-5">
      <div class="card mb-4">
        <div class="card-header bg-primary text-white">
          <h4>Thông Tin Cá Nhân</h4>
        </div>
        <div class="card">
          <div class="card-body">
            <div>
              <p><strong>Họ và tên:</strong> ${user.fullName}</p>
              <p><strong>Số điện thoại:</strong> ${user.phone != null ? user.phone : 'Chưa cập nhật'}</p>
              <p><strong>Email:</strong> ${user.email}</p>
              <p><strong>Địa chỉ:</strong>Chưa cập nhật</p>
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

              <div
                class="modal fade"
                id="deleteAccountModal"
                tabindex="-1"
                aria-labelledby="deleteAccountLabel"
                aria-hidden="true"
              ></div>

              <div
                class="modal fade"
                id="editPersonalInfoModal"
                tabindex="-1"
                aria-labelledby="editPersonalInfoModalLabel"
                aria-hidden="true"
              >
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-header">
                      <h5 class="modal-title" id="editPersonalInfoModalLabel">
                        Chỉnh Sửa Thông Tin Cá Nhân
                      </h5>
                      <button
                        type="button"
                        class="btn-close"
                        data-bs-dismiss="modal"
                        aria-label="Đóng"
                      ></button>
                    </div>
                    <div class="modal-body">
                      <form id="editPersonalInfoForm">
                        <div class="mb-3">
                          <label for="nameChange" class="form-label"
                            >Họ và tên <span style="color: red">*</span></label
                          >
                          <input
                            type="text"
                            class="form-control"
                            id="nameChange"
                            name="fullName"
                            value="Nguyễn Văn A"
                          />
                          <div class="error" id="nameChangeError"></div>
                        </div>
                        <div class="mb-3">
                          <label for="phoneChange" class="form-label"
                            >Số điện thoại</label
                          >
                          <input
                            type="text"
                            class="form-control"
                            id="phoneChange"
                            name="phone"
                            value="0901234567"
                          />
                          <div class="error" id="phoneChangeError"></div>
                        </div>
                        <div class="mb-3">
                          <label for="emailChange" class="form-label"
                            >Email <span style="color: red">*</span></label
                          >
                          <input
                            type="email"
                            class="form-control"
                            id="emailChange"
                            name="email"
                            value="nguyenvana@example.com"
                          />
                          <div class="error" id="emailChangeError"></div>
                        </div>
                        <div class="mb-3">
                          <label for="addressChange" class="form-label"
                            >Địa chỉ</label
                          >
                          <input
                            type="text"
                            class="form-control"
                            id="addressChange"
                            name="address"
                            value="123 Đường ABC, Phường 1, Quận 2, TP. Hồ Chí Minh"
                          />
                          <div class="error" id="addressChangeError"></div>
                        </div>
                        <button
                          type="submit"
                          class="btn btn-primary"
                          style="
                            background-color: var(--primary-color) !important;
                          "
                        >
                          Lưu Thay Đổi
                        </button>
                      </form>
                    </div>
                  </div>
                </div>
              </div>
            </div>
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
          <button class="status-tab active" data-status="ALL">Tất cả</button>
          <button class="status-tab" data-status="chờ">Chờ xác nhận</button>
          <button class="status-tab" data-status="đang giao">Vận chuyển</button>
          <button class="status-tab" data-status="hoàn thành">
            Hoàn thành
          </button>
          <button class="status-tab" data-status="đã hủy giao hàng">
            Đã hủy
          </button>
          <button class="status-tab" data-status="giao hàng thất bại">
            Thất bại
          </button>
        </div>

        <table id="allOrders" class="table table-bordered display">
          <thead>
            <tr>
              <th>Mã Đơn Hàng</th>
              <th>Tổng Tiền</th>
              <th>Ngày Đặt</th>
              <th>Thanh Toán</th>
              <th>Phương thức TT</th>
              <th>Vận chuyển</th>
              <th>Hành Động</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>#ODR12345</td>
              <td><span class="fw-bold">1.500.000 ₫</span></td>
              <td>2025-10-25</td>
              <td>Đã thanh toán</td>
              <td>COD</td>
              <td>Hoàn thành</td>
              <td>
                <button
                  class="btn btn-info btn-sm view-order"
                  data-bs-toggle="modal"
                  data-bs-target="#orderDetailsModal"
                >
                  Chi tiết
                </button>
              </td>
            </tr>
            <tr>
              <td>#ODR12346</td>
              <td><span class="fw-bold">850.000 ₫</span></td>
              <td>2025-10-28</td>
              <td>Chưa thanh toán</td>
              <td>VNPay</td>
              <td>Đang giao</td>
              <td>
                <button
                  class="btn btn-info btn-sm view-order"
                  data-bs-toggle="modal"
                  data-bs-target="#orderDetailsModal"
                >
                  Chi tiết
                </button>
              </td>
            </tr>
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
            <div class="d-flex align-items-center mb-3 border p-2 rounded">
              <img
                id="productImage"
                src="./assets/img/products/f3.jpg"
                alt="Ảnh sản phẩm"
                width="60"
                height="60"
                style="object-fit: cover; border-radius: 4px"
              />
              <div class="ms-3 flex-grow-1">
                <div id="productName" class="fw-bold">
                  Tranh Phong Cảnh (Mẫu)
                </div>
                <div class="d-flex">
                  <div class="me-3">
                    Kích thước: <span id="productSize">40x60cm</span>
                  </div>
                  <div>Số lượng: <span id="productQuantity">1</span></div>
                </div>
              </div>
            </div>

            <form id="reviewForm">
              <input
                type="hidden"
                id="paintingId"
                name="paintingId"
                value="1"
              />
              <input type="hidden" id="itemId" name="itemId" value="101" />

              <div id="starRating" class="mb-2">
                <i class="fa fa-star text-warning" data-value="1"></i>
                <i class="fa fa-star text-warning" data-value="2"></i>
                <i class="fa fa-star text-warning" data-value="3"></i>
                <i class="fa fa-star" data-value="4"></i>
                <i class="fa fa-star" data-value="5"></i>
              </div>

              <textarea
                id="comment"
                class="form-control mb-2"
                rows="4"
                placeholder="Viết đánh giá của bạn..."
              ></textarea>
              <input type="hidden" id="rating" value="3" />
              <button type="submit" class="btn btn-primary">
                Gửi đánh giá
              </button>
            </form>
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
    <!-- newsletters -->
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
    <!-- footer -->
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
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.1/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.4.2/js/dataTables.buttons.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.7/pdfmake.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.7/vfs_fonts.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.4.2/js/buttons.html5.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.4.2/js/buttons.print.min.js"></script>
  </body>
</html>

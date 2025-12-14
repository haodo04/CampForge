<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
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
    <link rel="stylesheet" href="./assets/css/styles.css" />
    <link href="./assets/css/category.css" rel="stylesheet" />
    <link href="./assets/css/styles.css" rel="stylesheet" />
      <link rel="stylesheet" href="assets/css/search.css">
      <script src="assets/js/search.js"></script>
  </head>
  <style>
      ul{
          padding-left: 0;
          position: relative;
          left: -5px;
          top: 1px;
      }
      #navbar li{
          padding: 10px 10px 0 0;
          margin: 10px 5px 5px 25px;
      }
      #navbar li a{
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
  <body>
  <div class="header-top"></div>
  <section id="header">
      <a href="index.jsp"><img class="logo_img" src="./assets/img/logo_new.png" alt="logo"></a>
      <ul id="navbar">
          <li><a href="index.jsp">Trang chủ</a></li>
          <li><a class="active" href="category">Danh mục</a></li>
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
                <div
                  class="d-flex justify-content-between align-items-center mb-3"
                >
                  <h5 class="m-0">Bộ lọc sản phẩm</h5>
                  <button class="btn btn-sm btn-warning">Đặt lại</button>
                </div>

                  <form action="category" method="get">
                      <div class="mb-4">
                          <h6 class="mb-2">Giá (VNĐ)</h6>

                          <div class="d-flex align-items-center">
                              <div class="input-group me-2">
                                  <input
                                          type="number"
                                          class="form-control"
                                          name="minPrice"
                                          placeholder="Từ"
                                  />
                                  <span class="input-group-text">đ</span>
                              </div>

                              <span class="mx-2">–</span>

                              <div class="input-group">
                                  <input
                                          type="number"
                                          class="form-control"
                                          name="maxPrice"
                                          placeholder="Đến"
                                          onchange="this.form.submit()"
                                  />
                                  <span class="input-group-text">đ</span>
                              </div>
                          </div>
                      </div>
                  </form>

                  <div class="mb-4">
                  <h6 class="mb-2">Kích thước</h6>
                  <div class="form-check mb-2">
                    <input
                      class="form-check-input"
                      type="checkbox"
                      id="s1"
                    /><label class="form-check-label" for="s1">2×3 m</label>
                  </div>
                  <div class="form-check mb-2">
                    <input
                      class="form-check-input"
                      type="checkbox"
                      id="s2"
                    /><label class="form-check-label" for="s2">3×4 m</label>
                  </div>
                  <div class="form-check mb-2">
                    <input
                      class="form-check-input"
                      type="checkbox"
                      id="s3"
                    /><label class="form-check-label" for="s3">4×6 m</label>
                  </div>
                  <div class="form-check mb-2">
                    <input
                      class="form-check-input"
                      type="checkbox"
                      id="s4"
                    /><label class="form-check-label" for="s4">6×9 m</label>
                  </div>
                </div>

                <form action="category" method="get">
                  <div class="mb-4">
                    <h6 class="mb-2">Chủ đề</h6>

                    <div class="form-check mb-2">
                      <input type="checkbox" class="form-check-input" id="t1" name="id" value="1" onchange="this.form.submit()">
                      <label class="form-check-label" for="t1">Cắm Trại</label>
                    </div>

                    <div class="form-check mb-2">
                      <input type="checkbox" class="form-check-input" id="t2" name="id" value="2" onchange="this.form.submit()">
                      <label class="form-check-label" for="t2">Du Lịch</label>
                    </div>

                    <div class="form-check mb-2">
                      <input type="checkbox" class="form-check-input" id="t3" name="id" value="3" onchange="this.form.submit()">
                      <label class="form-check-label" for="t3">Leo Núi</label>
                    </div>

                    <div class="form-check mb-2">
                      <input type="checkbox" class="form-check-input" id="t4" name="id" value="4" onchange="this.form.submit()">
                      <label class="form-check-label" for="t4">Dã Ngoại</label>
                    </div>
                  </div>
                </form>

                <form action="category" method="get">
                  <div class="mb-4">
                    <h6 class="mb-2">Brand</h6>

                    <div class="form-check mb-2">
                      <input
                              class="form-check-input"
                              type="checkbox"
                              id="a1"
                              name="brandId"
                              value="1"
                              onchange="this.form.submit()"
                      />
                      <label class="form-check-label" for="a1">BLACKDOG</label>
                    </div>

                    <div class="form-check mb-2">
                      <input
                              class="form-check-input"
                              type="checkbox"
                              id="a2"
                              name="brandId"
                              value="2"
                              onchange="this.form.submit()"
                      />
                      <label class="form-check-label" for="a2">ADIDAS</label>
                    </div>

                    <div class="form-check mb-2">
                      <input
                              class="form-check-input"
                              type="checkbox"
                              id="a3"
                              name="brandId"
                              value="3"
                              onchange="this.form.submit()"
                      />
                      <label class="form-check-label" for="a3">MADFOX</label>
                    </div>

                    <div class="form-check mb-2">
                      <input
                              class="form-check-input"
                              type="checkbox"
                              id="a4"
                              name="brandId"
                              value="4"
                              onchange="this.form.submit()"
                      />
                      <label class="form-check-label" for="a4">NATUREHIKE</label>
                    </div>

                    <div class="form-check mb-2">
                      <input
                              class="form-check-input"
                              type="checkbox"
                              id="a5"
                              name="brandId"
                              value="5"
                              onchange="this.form.submit()"
                      />
                      <label class="form-check-label" for="a4">JACK WOLFSKIN</label>
                    </div>

                    <div class="form-check mb-2">
                      <input
                              class="form-check-input"
                              type="checkbox"
                              id="a6"
                              name="brandId"
                              value="6"
                              onchange="this.form.submit()"
                      />
                      <label class="form-check-label" for="a4">VULTURE</label>
                    </div>
                  </div>
                </form>


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
                <div class="form-check mb-4">
                  <input
                    class="form-check-input"
                    type="checkbox"
                    id="sortNew"
                  />
                  <label class="form-check-label" for="sortNew"
                    >Sản phẩm mới nhất</label
                  >
                </div>

                <!-- Theo ngày -->
                <div class="card p-3 mb-3">
                  <h6 class="mb-3">Sản phẩm theo ngày</h6>
                  <div class="row g-2">
                    <div class="col-6">
                      <label class="form-label" for="d1">Từ ngày</label>
                      <input
                        type="date"
                        id="d1"
                        class="form-control form-control-sm"
                      />
                    </div>
                    <div class="col-6">
                      <label class="form-label" for="d2">Đến ngày</label>
                      <input
                        type="date"
                        id="d2"
                        class="form-control form-control-sm"
                      />
                    </div>
                  </div>
                </div>

                <button type="button" class="btn btn-primary w-100">
                  Áp dụng
                </button>
              </div>
            </div>
          </aside>
            <section class="col-12 col-lg-9">

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

                                        <c:choose>
                                            <c:when test="${not empty p.image}">
                                                <img src="${pageContext.request.contextPath}${p.image}" alt="${p.proName}" />
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${pageContext.request.contextPath}/assets/img/products/no-image.png" alt="${p.proName}" />
                                            </c:otherwise>
                                        </c:choose>

                                        <div class="des">
                <span>
                  <c:out value="${p.brandName}" default="(Không rõ hãng)"/>
                </span>

                                            <h5><c:out value="${p.proName}" /></h5>

                                            <div class="star" aria-label="Đánh giá 5/5">
                                                <i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i>
                                                <i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i>
                                                <i class="fa-solid fa-star"></i>
                                            </div>

                                            <h4>${p.formattedPrice}</h4>

                                            <a href="${pageContext.request.contextPath}/sproduct?id=${p.id}"
                                               class="add-cart" aria-label="Thêm vào giỏ">
                                                <i class="fa-solid fa-cart-shopping cart"></i>
                                            </a>
                                        </div>

                                    </div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>

                <c:if test="${totalPages > 1}">

                    <c:url var="baseUrl" value="/category">
                        <c:if test="${not empty cateId}">
                            <c:param name="id" value="${cateId}" />
                        </c:if>
                        <c:if test="${not empty brandId}">
                            <c:param name="brandId" value="${brandId}" />
                        </c:if>

                        <c:if test="${not empty minPrice}">
                            <c:param name="minPrice" value="${minPrice}" />
                        </c:if>
                        <c:if test="${not empty maxPrice}">
                            <c:param name="maxPrice" value="${maxPrice}" />
                        </c:if>
                    </c:url>

                    <c:set var="startPage" value="${page - 2}" />
                    <c:set var="endPage" value="${page + 2}" />

                    <c:if test="${startPage < 1}">
                        <c:set var="endPage" value="${endPage + (1 - startPage)}" />
                        <c:set var="startPage" value="1" />
                    </c:if>

                    <c:if test="${endPage > totalPages}">
                        <c:set var="startPage" value="${startPage - (endPage - totalPages)}" />
                        <c:set var="endPage" value="${totalPages}" />
                    </c:if>

                    <c:if test="${startPage < 1}">
                        <c:set var="startPage" value="1" />
                    </c:if>

                    <nav class="mt-4" aria-label="Page navigation">
                        <ul class="pagination justify-content-center">

                            <c:url var="prevUrl" value="${baseUrl}">
                                <c:param name="page" value="${page - 1}" />
                            </c:url>
                            <li class="page-item ${page <= 1 ? 'disabled' : ''}">
                                <a class="page-link" href="${page <= 1 ? '#' : prevUrl}" tabindex="${page <= 1 ? '-1' : '0'}">«</a>
                            </li>

                            <c:if test="${startPage > 1}">
                                <c:url var="firstUrl" value="${baseUrl}">
                                    <c:param name="page" value="1" />
                                </c:url>
                                <li class="page-item ${page == 1 ? 'active' : ''}">
                                    <a class="page-link" href="${firstUrl}">1</a>
                                </li>
                                <c:if test="${startPage > 2}">
                                    <li class="page-item disabled"><a class="page-link" href="#">...</a></li>
                                </c:if>
                            </c:if>

                            <c:forEach var="i" begin="${startPage}" end="${endPage}">
                                <c:url var="pageUrl" value="${baseUrl}">
                                    <c:param name="page" value="${i}" />
                                </c:url>
                                <li class="page-item ${i == page ? 'active' : ''}">
                                    <a class="page-link" href="${pageUrl}">${i}</a>
                                </li>
                            </c:forEach>

                            <c:if test="${endPage < totalPages}">
                                <c:if test="${endPage < totalPages - 1}">
                                    <li class="page-item disabled"><a class="page-link" href="#">...</a></li>
                                </c:if>
                                <c:url var="lastUrl" value="${baseUrl}">
                                    <c:param name="page" value="${totalPages}" />
                                </c:url>
                                <li class="page-item ${page == totalPages ? 'active' : ''}">
                                    <a class="page-link" href="${lastUrl}">${totalPages}</a>
                                </li>
                            </c:if>

                            <c:url var="nextUrl" value="${baseUrl}">
                                <c:param name="page" value="${page + 1}" />
                            </c:url>
                            <li class="page-item ${page >= totalPages ? 'disabled' : ''}">
                                <a class="page-link" href="${page >= totalPages ? '#' : nextUrl}">»</a>
                            </li>

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


    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  </body>
</html>

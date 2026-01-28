<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<fmt:setLocale value="vi_VN"/>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Quản lý sản phẩm</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css" rel="stylesheet" />
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/products.css">
  <style>
    #addProductModal .modal-dialog { max-height: calc(100vh - 2rem); }
    #addProductModal .modal-content { max-height: calc(100vh - 2rem); }
    #addProductModal { overflow-y: auto !important; }
    #addProductModal .modal-body {
      max-height: calc(100vh - 210px);
      overflow-y: auto !important;
      -webkit-overflow-scrolling: touch;
    }
    #addProductModal #variantTable thead th,
    #addProductModal #sizeTable thead th {
      font-weight: 400 !important;
    }
    #editProductModal .modal-dialog { max-height: calc(100vh - 2rem); }
    #editProductModal .modal-content { max-height: calc(100vh - 2rem); }
    #editProductModal { overflow-y: auto !important; }
    #editProductModal .modal-body {
      max-height: calc(100vh - 210px);
      overflow-y: auto !important;
      -webkit-overflow-scrolling: touch;
    }
    #editProductModal #editVariantTable thead th,
    #editProductModal #editSizeTable thead th {
      font-weight: 400 !important;
    }
  </style>
</head>
<body>
<div class="sidebar">
  <a href="#" class="sidebar-title">Admin Panel</a>
  <a href="${pageContext.request.contextPath}/admin/dashboard.jsp">Tổng quan</a>
  <a href="${pageContext.request.contextPath}/admin/products">Quản lý sản phẩm</a>
  <a href="${pageContext.request.contextPath}/admin/orders">Quản lý đơn hàng</a>
  <a href="${pageContext.request.contextPath}/admin/users">Quản lý người dùng</a>
  <a href="${pageContext.request.contextPath}/admin/reviews">Quản lý đánh giá</a>
  <a href="${pageContext.request.contextPath}/admin/discounts">Quản lý giảm giá</a>
  <a href="${pageContext.request.contextPath}/admin/vouchers">Quản lý voucher</a>
  <a href="${pageContext.request.contextPath}/admin/warehouse">Quản lý kho</a>
  <a href="${pageContext.request.contextPath}/admin/logs">Nhật ký</a>
</div>
<div class="content">
  <div class="card mb-4">
    <div class="card-header text-white" style="background:#2b2e34 !important;">
      <h4 class="mb-0">Quản lý sản phẩm</h4>
    </div>

    <div class="card-body">
      <div class="mb-1 d-flex justify-content-between align-items-center">
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addProductModal">
          Thêm sản phẩm
        </button>
      </div>

      <table id="products" class="table table-bordered display">
        <thead>
        <tr>
          <th>Mã SP</th>
          <th>Ảnh</th>
          <th>Tên sản phẩm</th>
          <th>Danh mục</th>
          <th>Thương hiệu</th>
          <th>Giá</th>
          <th>Ngày tạo</th>
          <th style="width:90px;">Thao tác</th>
        </tr>
        </thead>

        <tbody>
        <c:choose>
          <c:when test="${empty products}">
            <tr>
              <td colspan="8" class="text-center text-muted">Chưa có dữ liệu sản phẩm.</td>
            </tr>
          </c:when>

          <c:otherwise>
            <c:forEach var="p" items="${products}">
              <tr>
                <td>${p.id}</td>

                <td style="width:90px;">
                  <c:choose>
                    <c:when test="${not empty p.image}">
                      <c:choose>
                        <c:when test="${fn:startsWith(p.image, 'http')}">
                          <img src="${p.image}" alt="${p.proName}" style="width:60px;height:60px;object-fit:cover;border-radius:6px;">
                        </c:when>
                        <c:otherwise>
                          <img src="${pageContext.request.contextPath}${p.image}" alt="${p.proName}" style="width:60px;height:60px;object-fit:cover;border-radius:6px;">
                        </c:otherwise>
                      </c:choose>
                    </c:when>
                    <c:otherwise>
                      <span class="text-muted">--</span>
                    </c:otherwise>
                  </c:choose>
                </td>

                <td>${p.proName}</td>
                <td>${p.cateName}</td>
                <td>${p.brandName}</td>
                <td data-order="${p.price}">
                  <fmt:formatNumber value="${p.price}" pattern="#,##0"/> đ
                </td>

                <td>
                  <c:choose>
                    <c:when test="${not empty p.createAt}">
                      <fmt:formatDate value="${p.createAt}" pattern="yyyy-MM-dd" />
                    </c:when>
                    <c:otherwise>--</c:otherwise>
                  </c:choose>
                </td>

                <td class="text-center" style="white-space:nowrap;">
                  <button type="button"
                          class="btn btn-sm btn-outline-warning btn-open-edit"
                          data-bs-toggle="modal" data-bs-target="#editProductModal"
                          data-id="${p.id}"
                          data-proname="${fn:escapeXml(p.proName)}"
                          data-cateid="${p.cateId}"
                          data-brandname="${fn:escapeXml(p.brandName)}"
                          data-price="${p.price}"
                          data-description="${fn:escapeXml(p.description)}"
                          data-image="${fn:escapeXml(p.image)}"
                          title="Sửa">
                    <i class="bi bi-pencil-square"></i>
                  </button>


                  <button type="button"
                          class="btn btn-sm btn-outline-danger ms-1 btn-open-delete"
                          data-bs-toggle="modal"
                          data-bs-target="#deleteProductModal"
                          data-id="${p.id}"
                          data-name="${fn:escapeXml(p.proName)}"
                          title="Xóa">
                    <i class="bi bi-trash"></i>
                  </button>

                </td>

              </tr>
            </c:forEach>
          </c:otherwise>
        </c:choose>
        </tbody>
      </table>
    </div>
  </div>
</div>

<div class="modal fade" id="addProductModal" tabindex="-1" aria-labelledby="addProductModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-scrollable">
    <div class="modal-content">
      <form id="addProductForm"
            method="post"
            action="${pageContext.request.contextPath}/admin/products?action=create"
            enctype="multipart/form-data">

        <div class="modal-header">
          <h5 class="modal-title" id="addProductModalLabel">Thêm sản phẩm</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
        </div>

        <div class="modal-body">
          <div class="row g-3 mb-3">
            <div class="col-md-6">
              <label class="form-label">Tên sản phẩm</label>
              <input type="text" class="form-control form-control-sm" name="proName" required
                     placeholder="VD: Lều 2 người">
            </div>

            <div class="col-md-3">
              <label class="form-label">Danh mục</label>
              <select class="form-select form-select-sm" name="cateId" required>
                <c:choose>
                  <c:when test="${not empty categories}">
                    <c:forEach var="c" items="${categories}">
                      <option value="${c.id}">${c.cateName}</option>
                    </c:forEach>
                  </c:when>
                  <c:otherwise>
                    <option value="1">Trang phục</option>
                    <option value="2">Giày dép</option>
                    <option value="3">Leo núi</option>
                    <option value="4">Cắm trại</option>
                    <option value="7">Đạp xe</option>
                    <option value="8">Đồ du lịch</option>
                    <option value="9">Đồ fitness</option>
                  </c:otherwise>
                </c:choose>
              </select>
            </div>

            <div class="col-md-3">
              <label class="form-label">Thương hiệu</label>
              <input type="text" class="form-control form-control-sm" name="brandName" required
                     placeholder="VD: Naturehike">
            </div>
          </div>

          <div class="row g-3 mb-3">
            <div class="col-md-6">
              <label class="form-label">Giá gốc (đ)</label>
              <input type="number" min="0" step="1000" class="form-control form-control-sm" name="price" required
                     placeholder="VD: 1500000">
            </div>

            <input type="hidden" name="isDelete" value="0">
          </div>

          <div class="mb-3">
            <label class="form-label">Mô tả</label>
            <textarea class="form-control form-control-sm" name="description" rows="3"
                      placeholder="VD:  Sản phẩm mới của thương hiệu..."></textarea>
          </div>

          <hr class="my-3"/>

          <div class="row g-3 mb-3">
            <div class="col-md-6">
              <label class="form-label">Ảnh đại diện</label>
              <input type="file" class="form-control form-control-sm" name="mainImage" id="mainImageInput"
                     accept="image/*" required>
              <div class="mt-2">
                <img id="mainImagePreview" src="" alt=""
                     style="display:none; max-height:120px; border:1px solid #eee; border-radius:6px;">
              </div>
            </div>

            <div class="col-md-6">
              <label class="form-label">Ảnh phụ (chọn nhiều)</label>
              <input type="file" class="form-control form-control-sm" name="galleryImages" multiple accept="image/*">
            </div>
          </div>

          <hr class="my-3"/>

          <div class="mb-3">
            <div class="d-flex justify-content-between align-items-center mb-2">
              <label class="form-label m-0">Thông số phụ</label>
              <button type="button" class="btn btn-sm btn-outline-primary" id="addVariantRowBtn">+ Thêm dòng</button>
            </div>

            <div class="table-responsive">
              <table class="table table-sm table-bordered mb-0" id="variantTable">
                <thead>
                <tr>
                  <th>Màu</th>
                  <th>Kích thước</th>
                  <th>Giá</th>
                  <th>Số lượng</th>
                  <th style="width:60px;">Xoá</th>
                </tr>
                </thead>
                <tbody id="variantTbody">
                <tr class="variant-row">
                  <td><input class="form-control form-control-sm" name="variantColor[]" placeholder="VD: Đen,..."></td>
                  <td><input class="form-control form-control-sm" name="variantSize[]" placeholder="VD: XL,..."></td>
                  <td><input class="form-control form-control-sm" name="variantPrice[]" type="number" min="0" step="1000" placeholder="VD: 1500000"></td>
                  <td><input class="form-control form-control-sm" name="variantStock[]" type="number" min="0" value="0" placeholder="VD: 20"></td>
                  <td class="text-center">
                    <button type="button" class="btn btn-sm btn-outline-danger remove-variant">✕</button>
                  </td>
                </tr>
                </tbody>
              </table>
            </div>
          </div>

          <hr class="my-3"/>

          <div class="mb-3">
            <div class="d-flex justify-content-between align-items-center mb-2">
              <label class="form-label m-0">Trọng lượng (tuỳ chọn)</label>
              <button type="button" class="btn btn-sm btn-outline-primary" id="addSizeRowBtn">+ Thêm dòng</button>
            </div>

            <div class="table-responsive">
              <table class="table table-sm table-bordered mb-0" id="sizeTable">
                <thead>
                <tr>
                  <th>Số người</th>
                  <th>Trọng lượng (g)</th>
                  <th style="width:60px;">Xoá</th>
                </tr>
                </thead>
                <tbody id="sizeTbody">
                <tr class="size-row">
                  <td><input class="form-control form-control-sm" name="sizeName[]" placeholder="VD: 2 người,..."></td>
                  <td><input class="form-control form-control-sm" name="sizeWeight[]" type="number" min="0" step="1" placeholder="VD: 2500"></td>
                  <td class="text-center">
                    <button type="button" class="btn btn-sm btn-outline-danger remove-size">✕</button>
                  </td>
                </tr>
                </tbody>
              </table>
            </div>
          </div>

        </div>

        <div class="modal-footer">
          <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Đóng</button>
          <button type="submit" class="btn btn-primary btn-sm">Hoàn thành</button>
        </div>
      </form>
    </div>
  </div>
</div>
<div class="modal fade" id="deleteProductModal" tabindex="-1" aria-labelledby="deleteProductModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <form id="deleteProductForm" method="post" action="${pageContext.request.contextPath}/admin/products">
        <input type="hidden" name="action" value="delete">
        <input type="hidden" name="id" id="deleteProductId">

        <div class="modal-header">
          <h5 class="modal-title" id="deleteProductModalLabel">Xác nhận xóa</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
        </div>

        <div class="modal-body">
          <div class="mb-2">
            Bạn chắc chắn muốn xóa sản phẩm:
          </div>
          <div class="p-2 rounded" style="background:#f8f9fa;">
            <div><strong>ID:</strong> <span id="deleteProductIdText">--</span></div>
            <div><strong>Tên:</strong> <span id="deleteProductName">--</span></div>
          </div>

          <div class="text-danger mt-3" style="font-size:13px;">
            Hành động này sẽ xóa cả dữ liệu và không thể khôi phục.
          </div>
        </div>

        <div class="modal-footer">
          <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Hủy</button>
          <button type="submit" class="btn btn-danger btn-sm">Xóa</button>
        </div>
      </form>

    </div>
  </div>
</div>
<div class="modal fade" id="editProductModal" tabindex="-1" aria-labelledby="editProductModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-scrollable">
    <div class="modal-content">
      <form id="editProductForm"
            method="post"
            action="${pageContext.request.contextPath}/admin/products?action=update"
            enctype="multipart/form-data">

        <div class="modal-header">
          <h5 class="modal-title" id="editProductModalLabel">Sửa sản phẩm</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
        </div>

        <div class="modal-body">
          <input type="hidden" name="id" id="edit_id">

          <div class="row g-3 mb-3">
            <div class="col-md-6">
              <label class="form-label">Tên sản phẩm</label>
              <input type="text" class="form-control form-control-sm" name="proName" id="edit_proName" required
                     placeholder="VD: Lều 2 người">
            </div>

            <div class="col-md-3">
              <label class="form-label">Danh mục</label>
              <select class="form-select form-select-sm" name="cateId" id="edit_cateId" required>
                <c:choose>
                  <c:when test="${not empty categories}">
                    <c:forEach var="c" items="${categories}">
                      <option value="${c.id}">${c.cateName}</option>
                    </c:forEach>
                  </c:when>
                  <c:otherwise>
                    <option value="1">Trang phục</option>
                    <option value="2">Giày dép</option>
                    <option value="3">Leo núi</option>
                    <option value="4">Cắm trại</option>
                    <option value="5">Chạy bộ</option>
                    <option value="6">Bơi lặn</option>
                    <option value="7">Đạp xe</option>
                    <option value="8">Đồ du lịch</option>
                    <option value="9">Đồ fitness</option>
                  </c:otherwise>
                </c:choose>
              </select>
            </div>

            <div class="col-md-3">
              <label class="form-label">Thương hiệu</label>
              <input type="text" class="form-control form-control-sm" name="brandName" id="edit_brandName" required
                     placeholder="VD: Naturehike">
            </div>
          </div>

          <div class="row g-3 mb-3">
            <div class="col-md-6">
              <label class="form-label">Giá gốc (đ)</label>
              <input type="number" min="0" step="1000" class="form-control form-control-sm" name="price" id="edit_price" required
                     placeholder="VD: 1500000">
            </div>
          </div>

          <div class="mb-3">
            <label class="form-label">Mô tả</label>
            <textarea class="form-control form-control-sm" name="description" id="edit_description" rows="3"
                      placeholder="VD: Sản phẩm mới của thương hiệu..."></textarea>
          </div>

          <hr class="my-3"/>

          <div class="row g-3 mb-3">
            <div class="col-md-6">
              <label class="form-label">Ảnh đại diện (nếu muốn đổi)</label>
              <input type="file" class="form-control form-control-sm" name="mainImage" id="edit_mainImageInput" accept="image/*">
              <div class="mt-2">
                <img id="edit_mainImagePreview" src="" alt=""
                     style="display:none; max-height:120px; border:1px solid #eee; border-radius:6px;">
              </div>
            </div>

            <div class="col-md-6">
              <label class="form-label">Ảnh gallery (nếu muốn thay mới)</label>
              <input type="file" class="form-control form-control-sm" name="galleryImages" multiple accept="image/*">
            </div>
          </div>

          <hr class="my-3"/>

          <div class="mb-3">
            <div class="d-flex justify-content-between align-items-center mb-2">
              <label class="form-label m-0">Thông số kỹ thuật</label>
              <button type="button" class="btn btn-sm btn-outline-primary" id="editAddVariantRowBtn">+ Thêm dòng</button>
            </div>

            <div class="table-responsive">
              <table class="table table-sm table-bordered mb-0" id="editVariantTable">
                <thead>
                <tr>
                  <th>Màu</th>
                  <th>Size</th>
                  <th>Giá</th>
                  <th>Tồn kho</th>
                  <th style="width:60px;">Xoá</th>
                </tr>
                </thead>
                <tbody id="editVariantTbody">
                <tr class="variant-row">
                  <td><input class="form-control form-control-sm" name="variantColor[]" placeholder="VD: Đen,..."></td>
                  <td><input class="form-control form-control-sm" name="variantSize[]" placeholder="VD: XL,..."></td>
                  <td><input class="form-control form-control-sm" name="variantPrice[]" type="number" min="0" step="1000" placeholder="VD: 1500000"></td>
                  <td><input class="form-control form-control-sm" name="variantStock[]" type="number" min="0" value="0" placeholder="VD: 20"></td>
                  <td class="text-center">
                    <button type="button" class="btn btn-sm btn-outline-danger edit-remove-variant">&times;</button>
                  </td>
                </tr>
                </tbody>
              </table>
            </div>
          </div>

          <hr class="my-3"/>

          <div class="mb-3">
            <div class="d-flex justify-content-between align-items-center mb-2">
              <label class="form-label m-0">Size & trọng lượng (tuỳ chọn)</label>
              <button type="button" class="btn btn-sm btn-outline-primary" id="editAddSizeRowBtn">+ Thêm dòng</button>
            </div>

            <div class="table-responsive">
              <table class="table table-sm table-bordered mb-0" id="editSizeTable">
                <thead>
                <tr>
                  <th>Số người</th>
                  <th>Trọng lượng (g)</th>
                  <th style="width:60px;">Xoá</th>
                </tr>
                </thead>
                <tbody id="editSizeTbody">
                <tr class="size-row">
                  <td><input class="form-control form-control-sm" name="sizeName[]" placeholder="VD: 2 người,..."></td>
                  <td><input class="form-control form-control-sm" name="sizeWeight[]" type="number" min="0" step="1" placeholder="VD: 2500"></td>
                  <td class="text-center">
                    <button type="button" class="btn btn-sm btn-outline-danger edit-remove-size">&times;</button>
                  </td>
                </tr>
                </tbody>
              </table>
            </div>
          </div>

        </div>

        <div class="modal-footer">
          <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Đóng</button>
          <button type="submit" class="btn btn-primary btn-sm">Lưu</button>
        </div>

      </form>
    </div>
  </div>
</div>


<script>
    $(function () {
        $("#products").DataTable();

        document.getElementById("addProductModal")?.addEventListener("shown.bs.modal", function () {
            const body = this.querySelector(".modal-body");
            if (!body) return;
            body.style.maxHeight = (window.innerHeight - 210) + "px";
            body.style.overflowY = "auto";
            body.scrollTop = 0;
        });

        $("#mainImageInput").off("change").on("change", function () {
            const file = this.files && this.files[0];
            const img = $("#mainImagePreview");
            if (!file) {
                img.hide().attr("src", "");
                return;
            }
            img.attr("src", URL.createObjectURL(file)).show();
        });

        $("#addVariantRowBtn").off("click").on("click", function () {
            const row = `
        <tr class="variant-row">
          <td><input class="form-control form-control-sm" name="variantColor[]" placeholder="VD: Đen / Xanh rêu"></td>
          <td><input class="form-control form-control-sm" name="variantSize[]" placeholder="VD: M / L / 2 người"></td>
          <td><input class="form-control form-control-sm" name="variantPrice[]" type="number" min="0" step="1000" placeholder="VD: 1500000"></td>
          <td><input class="form-control form-control-sm" name="variantStock[]" type="number" min="0" value="0" placeholder="VD: 20"></td>
          <td class="text-center">
            <button type="button" class="btn btn-sm btn-outline-danger remove-variant">✕</button>
          </td>
        </tr>`;
            $("#variantTbody").append(row);
        });

        $(document).off("click.removeVariant").on("click.removeVariant", ".remove-variant", function () {
            $(this).closest("tr").remove();
        });

        $("#addSizeRowBtn").off("click").on("click", function () {
            const row = `
        <tr class="size-row">
          <td><input class="form-control form-control-sm" name="sizeName[]" placeholder="VD: XL / 2P / 3P"></td>
          <td><input class="form-control form-control-sm" name="sizeWeight[]" type="number" min="0" step="1" placeholder="VD: 2500"></td>
          <td class="text-center">
            <button type="button" class="btn btn-sm btn-outline-danger remove-size">✕</button>
          </td>
        </tr>`;
            $("#sizeTbody").append(row);
        });

        $(document).off("click.removeSize").on("click.removeSize", ".remove-size", function () {
            $(this).closest("tr").remove();
        });

        $("#addProductModal").off("hidden.bs.modal").on("hidden.bs.modal", function () {
            const form = document.getElementById("addProductForm");
            if (form) form.reset();

            $("#mainImagePreview").hide().attr("src", "");
            $("#variantTbody").empty();
            f
            $("#sizeTbody").empty();
        });
        });
        $(function () {
        $(document).on("click", ".btn-edit-product", function () {
            const $btn = $(this);
            const id = $btn.data("id");
            const proName = $btn.data("proname") || "";
            const cateId = $btn.data("cateid");
            const brandName = $btn.data("brandname") || "";
            const price = $btn.data("price");
            const description = $btn.data("description") || "";
            const image = $btn.data("image") || "";

            $("#edit_id").val(id);
            $("#edit_proName").val(proName);
            $("#edit_cateId").val(String(cateId));
            $("#edit_brandName").val(brandName);
            $("#edit_price").val(price);
            $("#edit_description").val(description);

            $("#edit_existingMainImage").val(image);

            const $img = $("#edit_mainImagePreview");
            if (image) {
                const src = image.startsWith("http") ? image : ("${pageContext.request.contextPath}" + image);
                $img.attr("src", src).show();
            } else {
                $img.hide().attr("src", "");
            }

            $("#edit_mainImageInput").val("");

            $("#editVariantTbody").html(`
        <tr class="variant-row">
          <td><input class="form-control form-control-sm" name="variantColor[]" placeholder="VD: Đen,..."></td>
          <td><input class="form-control form-control-sm" name="variantSize[]" placeholder="VD: XL,..."></td>
          <td><input class="form-control form-control-sm" name="variantPrice[]" type="number" min="0" step="1000" placeholder="VD: 1500000"></td>
          <td><input class="form-control form-control-sm" name="variantStock[]" type="number" min="0" value="0" placeholder="VD: 20"></td>
          <td class="text-center">
            <button type="button" class="btn btn-sm btn-outline-danger edit-remove-variant">✕</button>
          </td>
        </tr>
      `);

            $("#editSizeTbody").html(`
        <tr class="size-row">
          <td><input class="form-control form-control-sm" name="sizeName[]" placeholder="VD: 2 người,..."></td>
          <td><input class="form-control form-control-sm" name="sizeWeight[]" type="number" min="0" step="1" placeholder="VD: 2500"></td>
          <td class="text-center">
            <button type="button" class="btn btn-sm btn-outline-danger edit-remove-size">✕</button>
          </td>
        </tr>
      `);
        });

        $("#edit_mainImageInput").on("change", function () {
        const file = this.files && this.files[0];
        const img = $("#edit_mainImagePreview");
        if (!file) return;
        img.attr("src", URL.createObjectURL(file)).show();
        });

        $("#editAddVariantRowBtn").on("click", function () {
        const row = `
        <tr class="variant-row">
          <td><input class="form-control form-control-sm" name="variantColor[]" placeholder="VD: Đen,..."></td>
          <td><input class="form-control form-control-sm" name="variantSize[]" placeholder="VD: XL,..."></td>
          <td><input class="form-control form-control-sm" name="variantPrice[]" type="number" min="0" step="1000" placeholder="VD: 1500000"></td>
          <td><input class="form-control form-control-sm" name="variantStock[]" type="number" min="0" value="0" placeholder="VD: 20"></td>
          <td class="text-center">
            <button type="button" class="btn btn-sm btn-outline-danger edit-remove-variant">✕</button>
          </td>
        </tr>`;
        $("#editVariantTbody").append(row);
        });

        $(document).on("click", ".edit-remove-variant", function () {
        const rows = $("#editVariantTbody .variant-row");
        if (rows.length <= 1) return;
        $(this).closest("tr").remove();
        });

        $("#editAddSizeRowBtn").on("click", function () {
        const row = `
        <tr class="size-row">
          <td><input class="form-control form-control-sm" name="sizeName[]" placeholder="VD: 2 người,..."></td>
          <td><input class="form-control form-control-sm" name="sizeWeight[]" type="number" min="0" step="1" placeholder="VD: 2500"></td>
          <td class="text-center">
            <button type="button" class="btn btn-sm btn-outline-danger edit-remove-size">✕</button>
          </td>
        </tr>`;
        $("#editSizeTbody").append(row);
    });

        $(document).on("click", ".edit-remove-size", function () {
        const rows = $("#editSizeTbody .size-row");
        if (rows.length <= 1) return;
        $(this).closest("tr").remove();
    });
    });
    $(document).on("click", ".btn-open-delete", function () {
      const id = $(this).data("id");
      const name = $(this).data("name");

      $("#deleteProductId").val(id);
      $("#deleteProductIdText").text(id);
      $("#deleteProductName").text(name || "--");
    });

    (function () {
      const ctx = "${pageContext.request.contextPath}";

      function escHtml(s) {
        s = (s === null || s === undefined) ? "" : String(s);
        return s.replace(/[&<>"']/g, function (c) {
          return ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#39;" })[c];
        });
      }

      function emptyVariantRow() {
        return `
      <tr class="variant-row">
        <td><input class="form-control form-control-sm" name="variantColor[]" placeholder="VD: Đen,..."></td>
        <td><input class="form-control form-control-sm" name="variantSize[]" placeholder="VD: XL,..."></td>
        <td><input class="form-control form-control-sm" name="variantPrice[]" type="number" min="0" step="1000" placeholder="VD: 1500000"></td>
        <td><input class="form-control form-control-sm" name="variantStock[]" type="number" min="0" value="0" placeholder="VD: 20"></td>
        <td class="text-center">
          <button type="button" class="btn btn-sm btn-outline-danger edit-remove-variant">&times;</button>
        </td>
      </tr>
    `;
      }

      function emptySizeRow() {
        return `
      <tr class="size-row">
        <td><input class="form-control form-control-sm" name="sizeName[]" placeholder="VD: 2 người,..."></td>
        <td><input class="form-control form-control-sm" name="sizeWeight[]" type="number" min="0" step="1" placeholder="VD: 2500"></td>
        <td class="text-center">
          <button type="button" class="btn btn-sm btn-outline-danger edit-remove-size">&times;</button>
        </td>
      </tr>
    `;
      }

      $(document).off("click.openEdit").on("click.openEdit", ".btn-open-edit", async function () {
        const id = $(this).data("id");
        const proName = $(this).data("proname") || "";
        const cateId = $(this).data("cateid");
        const brandName = $(this).data("brandname") || "";
        const price = $(this).data("price");
        const description = $(this).data("description") || "";
        const image = $(this).data("image") || "";

        $("#edit_id").val(id);
        $("#edit_proName").val(proName);
        $("#edit_cateId").val(String(cateId));
        $("#edit_brandName").val(brandName);
        $("#edit_price").val(price);
        $("#edit_description").val(description);

        const $img = $("#edit_mainImagePreview");
        if (image) {
          const src = image.startsWith("http")
                  ? image
                  : (ctx + (String(image).startsWith("/") ? image : ("/" + image)));
          $img.attr("src", src).show();
        } else {
          $img.hide().attr("src", "");
        }

        $("#edit_mainImageInput").val("");

        $("#editVariantTbody").html(emptyVariantRow());
        $("#editSizeTbody").html(emptySizeRow());

        try {
          const url = ctx + "/admin/products?action=detail&id=" + id;
          const res = await fetch(url, { cache: "no-store" });
          if (!res.ok) return;

          const data = await res.json();

          if (Array.isArray(data.images)) {
            const main = data.images.find(x => Number(x.position) === 1);
            if (main && main.path) {
              const src = String(main.path).startsWith("http") ? main.path : (ctx + main.path);
              $("#edit_mainImagePreview").attr("src", src).show();
            }
          }

          const $vt = $("#editVariantTbody").empty();
          if (Array.isArray(data.variants) && data.variants.length > 0) {
            data.variants.forEach(v => {
              const colorVal = escHtml(v.color);
              const sizeVal = escHtml(v.size);
              const priceVal = (v.price === null || v.price === undefined) ? "" : v.price;
              const stockVal = (v.stock === null || v.stock === undefined) ? 0 : v.stock;

              $vt.append(
                      '<tr class="variant-row">' +
                      '<td><input class="form-control form-control-sm" name="variantColor[]" value="' + colorVal + '"></td>' +
                      '<td><input class="form-control form-control-sm" name="variantSize[]" value="' + sizeVal + '"></td>' +
                      '<td><input class="form-control form-control-sm" name="variantPrice[]" type="number" min="0" step="1000" value="' + priceVal + '"></td>' +
                      '<td><input class="form-control form-control-sm" name="variantStock[]" type="number" min="0" value="' + stockVal + '"></td>' +
                      '<td class="text-center"><button type="button" class="btn btn-sm btn-outline-danger edit-remove-variant">&times;</button></td>' +
                      '</tr>'
              );
            });
          } else {
            $vt.append(emptyVariantRow());
          }

          const $st = $("#editSizeTbody").empty();
          if (Array.isArray(data.sizes) && data.sizes.length > 0) {
            data.sizes.forEach(s => {
              const nameVal = escHtml(s.sizeName);
              const weightVal = (s.weight === null || s.weight === undefined) ? "" : s.weight;

              $st.append(
                      '<tr class="size-row">' +
                      '<td><input class="form-control form-control-sm" name="sizeName[]" value="' + nameVal + '"></td>' +
                      '<td><input class="form-control form-control-sm" name="sizeWeight[]" type="number" min="0" step="1" value="' + weightVal + '"></td>' +
                      '<td class="text-center"><button type="button" class="btn btn-sm btn-outline-danger edit-remove-size">&times;</button></td>' +
                      '</tr>'
              );
            });
          } else {
            $st.append(emptySizeRow());
          }
        } catch (e) {
          console.error("fetch detail error", e);
        }
      });

      $("#edit_mainImageInput").off("change.editPreview").on("change.editPreview", function () {
        const file = this.files && this.files[0];
        if (!file) return;
        $("#edit_mainImagePreview").attr("src", URL.createObjectURL(file)).show();
      });

      $("#editAddVariantRowBtn").off("click.editAddVar").on("click.editAddVar", function () {
        $("#editVariantTbody").append(emptyVariantRow());
      });

      $(document).off("click.editRemoveVar").on("click.editRemoveVar", ".edit-remove-variant", function () {
        const rows = $("#editVariantTbody .variant-row");
        if (rows.length <= 1) return;
        $(this).closest("tr").remove();
      });

      $("#editAddSizeRowBtn").off("click.editAddSize").on("click.editAddSize", function () {
        $("#editSizeTbody").append(emptySizeRow());
      });

      $(document).off("click.editRemoveSize").on("click.editRemoveSize", ".edit-remove-size", function () {
        const rows = $("#editSizeTbody .size-row");
        if (rows.length <= 1) return;
        $(this).closest("tr").remove();
      });
    })();


</script>
<script src="${pageContext.request.contextPath}/assets/js/admin/products.js"></script>
</body>
</html>

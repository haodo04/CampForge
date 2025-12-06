<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Quản lý vouchers</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css" rel="stylesheet" />
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  <link rel="stylesheet" href="../assets/css/admin/vouchers.css">
</head>
<body>
  <!-- Sidebar -->
  <div class="sidebar">
    <a href="#" class="sidebar-title">Admin Panel</a>
    <a href="dashboard.jsp">Tổng quan</a>
    <a href="products.jsp">Quản lý sản phẩm</a>
    <a href="orders.jsp">Quản lý đơn hàng</a>
    <a href="users.jsp">Quản lý người dùng</a>
    <a href="previews.jsp">Quản lý đánh giá</a>
    <a href="discounts.jsp">Quản lý giảm giá</a>
    <a href="#">Quản lý voucher</a>
    <a href="warehouse.jsp">Quản lý kho</a>
    <a href="logs.jsp">Nhật ký</a>
  </div>

  <!-- Main Content -->
  <div class="content">
    <div class="card mb-4">
      <div class="card-header bg-success text-white" style="background: #088178 !important;">
        <h4>Danh sách Voucher</h4>
      </div>
      <div class="card-body">
        <button type="button" class="btn btn-primary" style="margin-bottom: 15px;">
          Thêm voucher
        </button>
        <table id="vouchers" class="table table-bordered display">
          <thead>
            <tr>
              <th>Mã voucher</th>
              <th>Tên voucher</th>
              <th>Phần trăm giảm</th>
              <th>Trạng thái</th>
              <th>Ngày tạo</th>
              <th>Ngày bắt đầu</th>
              <th>Ngày kết thúc</th>
              <th>Hành động</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>V001</td>
              <td>Voucher 20%</td>
              <td>20%</td>
              <td>Hoạt động</td>
              <td>2023-11-01</td>
              <td>2023-11-05</td>
              <td>2023-12-31</td>
              <td>
                <button class="btn btn-info btn-sm">Chỉnh sửa</button>
                <button class="btn btn-danger btn-sm">Xóa</button>
              </td>
            </tr>
            <tr>
              <td>V002</td>
              <td>Voucher 15%</td>
              <td>15%</td>
              <td>Chưa kích hoạt</td>
              <td>2023-11-15</td>
              <td>2023-12-01</td>
              <td>2023-12-31</td>
              <td>
                <button class="btn btn-info btn-sm">Chỉnh sửa</button>
                <button class="btn btn-danger btn-sm">Xóa</button>
              </td>
            </tr>
            <tr>
              <td>V003</td>
              <td>Voucher 10%</td>
              <td>10%</td>
              <td>Hoạt động</td>
              <td>2023-11-10</td>
              <td>2023-11-20</td>
              <td>2023-12-15</td>
              <td>
                <button class="btn btn-info btn-sm">Chỉnh sửa</button>
                <button class="btn btn-danger btn-sm">Xóa</button>
              </td>
            </tr>
            <tr>
              <td>V004</td>
              <td>Voucher 12%</td>
              <td>12%</td>
              <td>Hoạt động</td>
              <td>2023-11-10</td>
              <td>2023-11-20</td>
              <td>2023-12-15</td>
              <td>
                <button class="btn btn-info btn-sm">Chỉnh sửa</button>
                <button class="btn btn-danger btn-sm">Xóa</button>
              </td>
            </tr>
            <tr>
              <td>V005</td>
              <td>Voucher 15%</td>
              <td>15%</td>
              <td>Hoạt động</td>
              <td>2023-11-10</td>
              <td>2023-11-20</td>
              <td>2023-12-15</td>
              <td>
                <button class="btn btn-info btn-sm">Chỉnh sửa</button>
                <button class="btn btn-danger btn-sm">Xóa</button>
              </td>
            </tr>
            <tr>
              <td>V006</td>
              <td>Voucher 5%</td>
              <td>5%</td>
              <td>Hết Hạn</td>
              <td>2023-11-10</td>
              <td>2023-11-20</td>
              <td>2023-12-15</td>
              <td>
                <button class="btn btn-info btn-sm">Chỉnh sửa</button>
                <button class="btn btn-danger btn-sm">Xóa</button>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
  <script src="../assets/js/admin/vouchers.js"></script>
</body>
</html>

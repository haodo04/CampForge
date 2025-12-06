<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Logs</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="../assets/css/admin/logs.css">
</head>
<body>
  <!-- Sidebar -->
    <div class="sidebar">
      <a href="#" class="sidebar-title">Admin Panel</a>
      <a href="dashboard.jsp">Tổng quan</a>
      <a href="products.jsp">Quản lý sản phẩm</a>
      <a href="orders.jsp">Quản lý đơn hàng</a>
      <a href="users.jsp">Quản lý người dùng</a>
      <a href="#">Quản lý đánh giá</a>
      <a href="discounts.jsp">Quản lý giảm giá</a>
      <a href="vouchers.jsp">Quản lý voucher</a>
      <a href="warehouse.jsp">Quản lý kho</a>
      <a href="#">Nhật ký</a>
    </div>

  <!-- Main Content -->
  <div class="content">
    <div class="card mb-4">
      <div class="card-header bg-success text-white" style="background: #088178 !important;">
        <h4>Logs</h4>
      </div>
      <div class="card-body">
        <table id="logs" class="table table-bordered display">
          <thead>
            <tr>
              <th>Mã log</th>
              <th>Người dùng</th>
              <th>Loại</th>
              <th>Thời gian</th>
              <th>Tài nguyên</th>
              <th>Hành Động</th>
            </tr>
          </thead>
          <tbody>
    
            <tr>
              <td>LOG001</td>
              <td>Nguyễn Văn A</td>
              <td>Đăng nhập</td>
              <td>2023-11-01 10:15</td>
              <td>Hệ thống</td>
              <td>
                <button class="btn btn-info btn-sm">Xem Chi Tiết</button>
                <button class="btn btn-danger btn-sm">Xoá</button>
              </td>
            </tr>
            <tr>
              <td>LOG002</td>
              <td>Trần Thị B</td>
              <td>Cập nhật thông tin</td>
              <td>2023-11-02 14:25</td>
              <td>Trang người dùng</td>
              <td>
                <button class="btn btn-info btn-sm">Xem Chi Tiết</button>
                <button class="btn btn-danger btn-sm">Xoá</button>
              </td>
            </tr>
            <tr>
              <td>LOG003</td>
              <td>Lê Thị C</td>
              <td>Xóa sản phẩm</td>
              <td>2023-11-03 09:05</td>
              <td>Quản lý sản phẩm</td>
              <td>
                <button class="btn btn-info btn-sm">Xem Chi Tiết</button>
                <button class="btn btn-danger btn-sm">Xoá</button>
              </td>
            </tr>
            <tr>
              <td>LOG004</td>
              <td>Lê Thị C</td>
              <td>Xóa sản phẩm</td>
              <td>2023-11-03 09:05</td>
              <td>Quản lý sản phẩm</td>
              <td>
                <button class="btn btn-info btn-sm">Xem Chi Tiết</button>
                <button class="btn btn-danger btn-sm">Xoá</button>
              </td>
            </tr>
            <tr>
              <td>LOG005</td>
              <td>Lê Thị C</td>
              <td>Xóa sản phẩm</td>
              <td>2023-11-03 09:05</td>
              <td>Quản lý sản phẩm</td>
              <td>
                <button class="btn btn-info btn-sm">Xem Chi Tiết</button>
                <button class="btn btn-danger btn-sm">Xoá</button>
              </td>
            </tr>
            <tr>
              <td>LOG006</td>
              <td>Lê Thị C</td>
              <td>Xóa sản phẩm</td>
              <td>2023-11-03 09:05</td>
              <td>Quản lý sản phẩm</td>
              <td>
                <button class="btn btn-info btn-sm">Xem Chi Tiết</button>
                <button class="btn btn-danger btn-sm">Xoá</button>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</body>
</html>

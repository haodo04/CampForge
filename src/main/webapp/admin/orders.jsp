<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Quản lý đơn hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="../assets/css/admin/orders.css">

</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <a href="#" class="sidebar-title">Admin Panel</a>
        <a href="dashboard.jsp">Tổng quan</a>
        <a href="products.jsp">Quản lý sản phẩm</a>
        <a href="#">Quản lý đơn hàng</a>
        <a href="users.jsp">Quản lý người dùng</a>
        <a href="previews.jsp">Quản lý đánh giá</a>
        <a href="discounts.jsp">Quản lý giảm giá</a>
        <a href="vouchers.jsp">Quản lý voucher</a>
        <a href="warehouse.jsp">Quản lý kho</a>
        <a href="logs.jsp">Nhật ký</a>
    </div>

    <!-- Main Content -->
    <div class="content">
        <!-- Đơn hàng hiện tại -->
        <div class="card mb-4">
            <div class="card-header bg-success text-white" style="background: #088178 !important;">
                <h4>Đơn Hàng Hiện Tại</h4>
            </div>
            <div class="card-body">
                <table id="currentOrders" class="table table-bordered display">
                    <thead>
                        <tr>
                            <th>Mã Đơn Hàng</th>
                            <th>Tổng Tiền</th>
                            <th>Ngày Đặt</th>
                            <th>Thanh Toán</th>
                            <th>Phương Thức TT</th>
                            <th>Vận chuyển</th>
                            <th>Hành Động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>001</td>
                            <td>1,000,000 ₫</td>
                            <td>2023-11-08</td>
                            <td>Đã thanh toán</td>
                            <td>Chuyển khoản</td>
                            <td>Đang giao</td>
                            <td>
                                <button class="btn btn-info btn-sm view-order">Xem Chi Tiết</button>
                                <button class="btn btn-danger btn-sm delete-order">Xóa</button>
                            </td>
                        </tr>
                        <tr>
                            <td>002</td>
                            <td>800,000 ₫</td>
                            <td>2023-10-15</td>
                            <td>Chưa thanh toán</td>
                            <td>Tiền mặt</td>
                            <td>Chờ giao</td>
                            <td>
                                <button class="btn btn-info btn-sm view-order">Xem Chi Tiết</button>
                                <button class="btn btn-danger btn-sm delete-order">Xóa</button>
                            </td>
                        </tr>
                        <tr>
                            <td>003</td>
                            <td>900,000 ₫</td>
                            <td>2023-10-15</td>
                            <td>Chưa thanh toán</td>
                            <td>Tiền mặt</td>
                            <td>Chờ giao</td>
                            <td>
                                <button class="btn btn-info btn-sm view-order">Xem Chi Tiết</button>
                                <button class="btn btn-danger btn-sm delete-order">Xóa</button>
                            </td>
                        </tr>
                        <tr>
                            <td>004</td>
                            <td>500,000 ₫</td>
                            <td>2023-10-15</td>
                            <td>Chưa thanh toán</td>
                            <td>Tiền mặt</td>
                            <td>Chờ giao</td>
                            <td>
                                <button class="btn btn-info btn-sm view-order">Xem Chi Tiết</button>
                                <button class="btn btn-danger btn-sm delete-order">Xóa</button>
                            </td>
                        </tr>
                        <tr>
                            <td>005</td>
                            <td>700,000 ₫</td>
                            <td>2023-10-15</td>
                            <td>Chưa thanh toán</td>
                            <td>Tiền mặt</td>
                            <td>Chờ giao</td>
                            <td>
                                <button class="btn btn-info btn-sm view-order">Xem Chi Tiết</button>
                                <button class="btn btn-danger btn-sm delete-order">Xóa</button>
                            </td>
                        </tr>
                        <tr>
                            <td>006</td>
                            <td>800,000 ₫</td>
                            <td>2023-10-15</td>
                            <td>Chưa thanh toán</td>
                            <td>Tiền mặt</td>
                            <td>Chờ giao</td>
                            <td>
                                <button class="btn btn-info btn-sm view-order">Xem Chi Tiết</button>
                                <button class="btn btn-danger btn-sm delete-order">Xóa</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Lịch sử đơn hàng -->
        <div class="card mb-4">
            <div class="card-header bg-secondary text-white">
                <h4>Lịch Sử Đơn Hàng</h4>
            </div>
            <div class="card-body">
                <table id="orderHistory" class="table table-bordered display">
                    <thead>
                        <tr>
                            <th>Mã Đơn Hàng</th>
                            <th>Tổng Tiền</th>
                            <th>Ngày Đặt</th>
                            <th>Ngày Giao</th>
                            <th>Thanh Toán</th>
                            <th>Phương Thức TT</th>
                            <th>Vận chuyển</th>
                            <th>Hành Động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>001</td>
                            <td>1,500,000 ₫</td>
                            <td>2023-09-20</td>
                            <td>2023-09-25</td>
                            <td>Đã thanh toán</td>
                            <td>Chuyển khoản</td>
                            <td>Đã giao</td>
                            <td>
                                <button class="btn btn-info btn-sm view-order">Xem Chi Tiết</button>
                                <button class="btn btn-danger btn-sm delete-order">Xóa</button>
                            </td>
                        </tr>
                        <tr>
                            <td>002</td>
                            <td>3,000,000 ₫</td>
                            <td>2023-09-20</td>
                            <td>2023-09-25</td>
                            <td>Đã thanh toán</td>
                            <td>Chuyển khoản</td>
                            <td>Đã giao</td>
                            <td>
                                <button class="btn btn-info btn-sm view-order">Xem Chi Tiết</button>
                                <button class="btn btn-danger btn-sm delete-order">Xóa</button>
                            </td>
                        </tr>
                        <tr>
                            <td>003</td>
                            <td>2,000,000 ₫</td>
                            <td>2023-09-20</td>
                            <td>2023-09-25</td>
                            <td>Đã thanh toán</td>
                            <td>Chuyển khoản</td>
                            <td>Đã giao</td>
                            <td>
                                <button class="btn btn-info btn-sm view-order">Xem Chi Tiết</button>
                                <button class="btn btn-danger btn-sm delete-order">Xóa</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Đơn hàng đã xóa -->
        <div class="card mb-4">
            <div class="card-header bg-success text-white" style="background: #e7621b !important;">
                <h4>Đơn Hàng đã xóa</h4>
            </div>
            <div class="card-body">
                <table id="orderD" class="table table-bordered display">
                    <thead>
                        <tr>
                            <th>Mã Đơn Hàng</th>
                            <th>Tổng Tiền</th>
                            <th>Ngày Đặt</th>
                            <th>Thanh Toán</th>
                            <th>Phương Thức TT</th>
                            <th>Hành Động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>004</td>
                            <td>1,200,000 ₫</td>
                            <td>2023-08-10</td>
                            <td>Đã thanh toán</td>
                            <td>Chuyển khoản</td>
                            <td>
                                <button class="btn btn-info btn-sm view-order">Xem Chi Tiết</button>
                                <button class="btn btn-primary btn-sm restore-order">Khôi phục</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Modal: Xem chi tiết Đơn hàng -->
<div class="modal fade" id="viewOrderModal" tabindex="-1" aria-labelledby="viewOrderModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-md">
    <div class="modal-content">
      <div class="modal-header">
        <h5 id="viewOrderModalLabel" class="modal-title">Chi tiết đơn hàng</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
      </div>
      <div class="modal-body">
        <div class="row g-2">
          <div class="col-6"><strong>Mã ĐH:</strong> <span id="v_id">--</span></div>
          <div class="col-6"><strong>Tổng tiền:</strong> <span id="v_total">--</span></div>
          <div class="col-6"><strong>Ngày đặt:</strong> <span id="v_orderDate">--</span></div>
          <div class="col-6"><strong>Ngày giao:</strong> <span id="v_shipDate">--</span></div>
          <div class="col-6"><strong>TT thanh toán:</strong> <span id="v_payStatus">--</span></div>
          <div class="col-6"><strong>Phương thức TT:</strong> <span id="v_payMethod">--</span></div>
          <div class="col-12"><strong>Vận chuyển:</strong> <span id="v_shipStatus">--</span></div>
        </div>
        <hr class="my-3">
      </div>
      <div class="modal-footer">
        <button class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Đóng</button>
      </div>
    </div>
  </div>
</div>

<!-- Modal: Xác nhận Xóa -->
<div class="modal fade" id="deleteOrderModal" tabindex="-1" aria-labelledby="deleteOrderModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 id="deleteOrderModalLabel" class="modal-title">Xác nhận xóa</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
      </div>
      <div class="modal-body">
        Xóa đơn hàng <strong id="d_id">--</strong> (tổng tiền: <strong id="d_total">--</strong>)?
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Hủy</button>
        <button type="button" class="btn btn-danger btn-sm" id="confirmDeleteOrderBtn">Xóa</button>
      </div>
    </div>
  </div>
</div>

<!-- Modal: Xác nhận Khôi phục -->
<div class="modal fade" id="restoreOrderModal" tabindex="-1" aria-labelledby="restoreOrderModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 id="restoreOrderModalLabel" class="modal-title">Khôi phục đơn hàng</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
      </div>
      <div class="modal-body">
        Khôi phục đơn hàng <strong id="r_id">--</strong> ?
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Hủy</button>
        <button type="button" class="btn btn-primary btn-sm" id="confirmRestoreOrderBtn">Khôi phục</button>
      </div>
    </div>
  </div>
</div>


    <script src="../assets/js/admin/orders.js"></script>
</body>
</html>

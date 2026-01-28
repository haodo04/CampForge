<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi_VN"/>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Quản lý đơn hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/orders.css">
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
            <h4 class="mb-0">Quản lý đơn hàng</h4>
        </div>

        <div class="card-body">

            <table id="orders" class="table table-bordered display">
                <thead>
                <tr>
                    <th>Mã ĐH</th>
                    <th>User</th>
                    <th>Ngày đặt</th>
                    <th>Tổng tiền</th>
                    <th>PTTT</th>
                    <th>TT thanh toán</th>
                    <th>TT giao hàng</th>
                    <th>Ngày giao</th>
                    <th style="width:90px;">Thao tác</th>
                </tr>
                </thead>

                <tbody>
                <c:choose>
                    <c:when test="${empty orders}">
                        <tr>
                            <td colspan="9" class="text-center text-muted">Chưa có đơn hàng.</td>
                        </tr>
                    </c:when>

                    <c:otherwise>
                        <c:forEach var="o" items="${orders}">
                            <tr>
                                <td>${o.id}</td>

                                <td>
                                    <c:choose>
                                        <c:when test="${not empty o.userId}">${o.userId}</c:when>
                                        <c:otherwise>--</c:otherwise>
                                    </c:choose>
                                </td>

                                <td>
                                    <c:choose>
                                        <c:when test="${not empty o.orderDate}">
                                            <fmt:formatDate value="${o.orderDate}" pattern="yyyy-MM-dd HH:mm" />
                                        </c:when>
                                        <c:otherwise>--</c:otherwise>
                                    </c:choose>
                                </td>

                                <td>
                                    <c:choose>
                                        <c:when test="${not empty o.totalAmount}">
                                            <fmt:formatNumber value="${o.totalAmount}" pattern="#,##0" /> đ
                                        </c:when>
                                        <c:otherwise>--</c:otherwise>
                                    </c:choose>
                                </td>

                                <td>${o.paymentMethod}</td>

                                <td>
                                    <c:choose>
                                        <c:when test="${o.paymentStatus == 'PAID'}">Đã thanh toán</c:when>
                                        <c:when test="${o.paymentStatus == 'UNPAID'}">Chưa thanh toán</c:when>
                                        <c:when test="${o.paymentStatus == 'REFUNDED'}">Hoàn tiền</c:when>
                                        <c:otherwise>${o.paymentStatus}</c:otherwise>
                                    </c:choose>
                                </td>

                                <td>
                                    <c:choose>
                                        <c:when test="${o.deliveryStatus == 'PENDING'}">Chờ xác nhận</c:when>
                                        <c:when test="${o.deliveryStatus == 'SHIPPING'}">Đang giao</c:when>
                                        <c:when test="${o.deliveryStatus == 'DELIVERED'}">Đã giao</c:when>
                                        <c:when test="${o.deliveryStatus == 'COMPLETED'}">Hoàn thành</c:when>
                                        <c:when test="${o.deliveryStatus == 'CANCELED'}">Đã hủy</c:when>
                                        <c:otherwise>${o.deliveryStatus}</c:otherwise>
                                    </c:choose>
                                </td>

                                <td>
                                    <c:choose>
                                        <c:when test="${not empty o.deliveryDate}">
                                            <fmt:formatDate value="${o.deliveryDate}" pattern="yyyy-MM-dd" />
                                        </c:when>
                                        <c:otherwise>--</c:otherwise>
                                    </c:choose>
                                </td>

                                <td class="text-center" style="white-space:nowrap;">
                                    <button type="button"
                                            class="btn btn-sm btn-outline-warning btn-open-edit"
                                            data-bs-toggle="modal"
                                            data-bs-target="#editOrderModal"
                                            data-id="${o.id}"
                                            data-paymentstatus="${o.paymentStatus}"
                                            data-deliverystatus="${o.deliveryStatus}"
                                            title="Sửa">
                                        <i class="bi bi-pencil-square"></i>
                                    </button>

                                    <button type="button"
                                            class="btn btn-sm btn-outline-danger ms-1 btn-open-delete"
                                            data-bs-toggle="modal"
                                            data-bs-target="#deleteOrderModal"
                                            data-id="${o.id}"
                                            data-total="${o.totalAmount}"
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

<div class="modal fade" id="editOrderModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form method="post" action="${pageContext.request.contextPath}/admin/orders">
                <input type="hidden" name="action" value="update" />
                <input type="hidden" name="id" id="edit_order_id" />

                <div class="modal-header">
                    <h5 class="modal-title">Cập nhật đơn hàng #<span id="edit_order_id_text">--</span></h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                </div>

                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">Trạng thái thanh toán</label>
                        <select class="form-select form-select-sm" name="paymentStatus" id="edit_payment_status" required>
                            <option value="UNPAID">Chưa thanh toán</option>
                            <option value="PAID">Đã thanh toán</option>
                            <option value="REFUNDED">Đã hoàn tiền</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Trạng thái giao hàng</label>
                        <select class="form-select form-select-sm" name="deliveryStatus" id="edit_delivery_status" required>
                            <option value="PENDING">Chờ xác nhận</option>
                            <option value="SHIPPING">Đang giao</option>
                            <option value="DELIVERED">Đã giao</option>
                            <option value="COMPLETED">Hoàn thành</option>
                            <option value="CANCELED">Đã hủy</option>
                        </select>
                    </div>
                </div>

                <div class="modal-footer">
                    <button class="btn btn-secondary btn-sm" type="button" data-bs-dismiss="modal">Hủy</button>
                    <button class="btn btn-primary btn-sm" type="submit">Lưu</button>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal fade" id="deleteOrderModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form method="post" action="${pageContext.request.contextPath}/admin/orders">
                <input type="hidden" name="action" value="delete" />
                <input type="hidden" name="id" id="delete_order_id" />

                <div class="modal-header">
                    <h5 class="modal-title">Xác nhận xóa</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                </div>

                <div class="modal-body">
                    Xóa đơn hàng <strong>#<span id="delete_order_id_text">--</span></strong> ?
                </div>

                <div class="modal-footer">
                    <button class="btn btn-secondary btn-sm" type="button" data-bs-dismiss="modal">Hủy</button>
                    <button class="btn btn-danger btn-sm" type="submit">Xóa</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/assets/js/admin/orders.js"></script>
</body>
</html>

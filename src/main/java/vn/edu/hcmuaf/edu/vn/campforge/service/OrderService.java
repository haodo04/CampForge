package vn.edu.hcmuaf.edu.vn.campforge.service;

import vn.edu.hcmuaf.edu.vn.campforge.dao.OrderDAO;
import vn.edu.hcmuaf.edu.vn.campforge.model.Order;

import java.sql.SQLException;
import java.util.List;

public class OrderService {

    private static final OrderService INSTANCE = new OrderService();
    private final OrderDAO orderDAO = new OrderDAO();

    private OrderService() {}

    public static OrderService getInstance() {
        return INSTANCE;
    }

    public List<Order> getOrdersByUserId(int userId, String deliveryStatus) throws SQLException {
        return orderDAO.findByUserId(userId, deliveryStatus);
    }

    public void cancelOrder(int userId, int orderId) throws Exception {
        if (orderId <= 0) throw new IllegalArgumentException("Order không hợp lệ");

        boolean ok = orderDAO.cancelOrderIfPending(orderId, userId);
        if (!ok) {
            throw new IllegalStateException("Chỉ có thể huỷ đơn khi đang chờ xác nhận.");
        }
    }

}

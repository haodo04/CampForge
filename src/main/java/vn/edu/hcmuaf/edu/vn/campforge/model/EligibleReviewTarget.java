package vn.edu.hcmuaf.edu.vn.campforge.model;

import java.sql.Timestamp;

public class EligibleReviewTarget {
    private int orderId;
    private int orderItemId;
    private Timestamp orderDate;

    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }

    public int getOrderItemId() { return orderItemId; }
    public void setOrderItemId(int orderItemId) { this.orderItemId = orderItemId; }

    public Timestamp getOrderDate() { return orderDate; }
    public void setOrderDate(Timestamp orderDate) { this.orderDate = orderDate; }
}

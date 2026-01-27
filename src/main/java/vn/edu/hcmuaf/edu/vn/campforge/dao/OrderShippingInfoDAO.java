package vn.edu.hcmuaf.edu.vn.campforge.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class OrderShippingInfoDAO {

    public void insert(Connection conn,
                       int orderId,
                       String receiverName,
                       String phone,
                       String email,
                       String addressLine,
                       String ward,
                       String district,
                       String province,
                       String note) throws SQLException {

        String sql = """
            INSERT INTO order_shipping_info
              (order_id, receiver_name, phone, email, address_line, ward, district, province, note, created_at, updated_at)
            VALUES
              (?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), NOW())
        """;

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ps.setString(2, receiverName);
            ps.setString(3, phone);
            ps.setString(4, email);
            ps.setString(5, addressLine);
            ps.setString(6, ward);
            ps.setString(7, district);
            ps.setString(8, province);
            ps.setString(9, note);
            ps.executeUpdate();
        }
    }
}

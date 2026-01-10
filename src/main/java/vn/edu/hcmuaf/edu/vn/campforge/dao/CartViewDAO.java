package vn.edu.hcmuaf.edu.vn.campforge.dao;

import vn.edu.hcmuaf.edu.vn.campforge.dao.db.DbConnect;
import vn.edu.hcmuaf.edu.vn.campforge.model.CartItem;
import vn.edu.hcmuaf.edu.vn.campforge.model.CartMiniItem;
import vn.edu.hcmuaf.edu.vn.campforge.model.CartViewItem;

import java.sql.*;
import java.util.*;

public class CartViewDAO {

    public List<CartViewItem> getItemsByVariantIds(Map<Integer, Integer> variantQtyMap) {

        if (variantQtyMap == null || variantQtyMap.isEmpty()) {
            return new ArrayList<>();
        }

        List<Integer> ids = new ArrayList<>(variantQtyMap.keySet());
        String placeholders = String.join(",", Collections.nCopies(ids.size(), "?"));

        String sql =
                "SELECT pv.id AS variantId, pv.product_id AS productId, " +
                        "p.proName, pv.color, pv.size, " +
                        "COALESCE(pv.image_path, " +
                        "  (SELECT pi.path FROM product_imgs pi WHERE pi.product_id = p.id " +
                        "   ORDER BY pi.position ASC, pi.id ASC LIMIT 1)" +
                        ") AS imagePath, " +
                        "COALESCE(pv.price, p.price) AS unitPrice, " +
                        "pv.stock " +
                        "FROM product_variants pv " +
                        "JOIN products p ON p.id = pv.product_id " +
                        "WHERE pv.id IN (" + placeholders + ") " +
                        "AND COALESCE(pv.is_active, 1) = 1 " +
                        "AND COALESCE(p.isDelete, 0) = 0";

        Map<Integer, CartViewItem> temp = new HashMap<>();

        try (Connection conn = DbConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            for (int i = 0; i < ids.size(); i++) {
                ps.setInt(i + 1, ids.get(i));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                CartViewItem item = new CartViewItem();
                item.setVariantId(rs.getInt("variantId"));
                item.setProductId(rs.getInt("productId"));
                item.setProName(rs.getString("proName"));
                item.setColor(rs.getString("color"));
                item.setSize(rs.getString("size"));
                item.setImagePath(rs.getString("imagePath"));
                item.setUnitPrice(rs.getDouble("unitPrice"));
                item.setStock(rs.getInt("stock"));

                temp.put(item.getVariantId(), item);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        List<CartViewItem> result = new ArrayList<>();
        for (Integer vid : ids) {
            CartViewItem item = temp.get(vid);
            if (item != null) {
                item.setQuantity(variantQtyMap.get(vid));
                result.add(item);
            }
        }

        return result;
    }

    public List<CartMiniItem> getMiniItemsByVariantIds(List<CartItem> cartItems) {
        List<CartMiniItem> result = new ArrayList<>();
        if (cartItems == null || cartItems.isEmpty()) return result;

        StringBuilder in = new StringBuilder();
        for (int i = 0; i < cartItems.size(); i++) {
            if (i > 0) in.append(",");
            in.append("?");
        }

        String placeholders = String.join(",", java.util.Collections.nCopies(cartItems.size(), "?"));

        StringBuilder sb = new StringBuilder();
        sb.append("SELECT v.id AS variantId, p.id AS productId, p.proName AS name, ");
        sb.append("v.price AS unitPrice, COALESCE(i.path, v.image_path) AS img ");
        sb.append("FROM product_variants v ");
        sb.append("JOIN products p ON p.id = v.product_id ");
        sb.append("LEFT JOIN product_imgs i ON i.product_id = p.id AND i.position = 1 ");
        sb.append("WHERE v.id IN (").append(placeholders).append(")");

        String sql = sb.toString();

        try (Connection conn = DbConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            int idx = 1;
            for (CartItem ci : cartItems) {
                ps.setInt(idx++, ci.getVariantId());
            }

            ResultSet rs = ps.executeQuery();
            Map<Integer, CartMiniItem> map = new HashMap<>();

            while (rs.next()) {
                CartMiniItem it = new CartMiniItem();
                it.setVariantId(rs.getInt("variantId"));
                it.setProductId(rs.getInt("productId"));
                it.setName(rs.getString("name"));
                it.setUnitPrice(rs.getDouble("unitPrice"));
                it.setImg(rs.getString("img"));
                map.put(it.getVariantId(), it);
            }

            for (CartItem ci : cartItems) {
                CartMiniItem it = map.get(ci.getVariantId());
                if (it != null) {
                    it.setQty(ci.getQuantity());
                    result.add(it);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

}

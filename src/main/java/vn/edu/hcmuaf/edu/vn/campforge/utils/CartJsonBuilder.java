package vn.edu.hcmuaf.edu.vn.campforge.utils;

import vn.edu.hcmuaf.edu.vn.campforge.model.CartMiniItem;

public class CartJsonBuilder {

    public static String toMiniCartJson(int cartCount, double totalAmount, java.util.List<CartMiniItem> items) {
        StringBuilder sb = new StringBuilder();
        sb.append("{\"ok\":true");
        sb.append(",\"cartCount\":").append(cartCount);
        sb.append(",\"totalAmount\":\"").append(totalAmount).append("\"");
        sb.append(",\"items\":[");

        boolean first = true;
        for (CartMiniItem it : items) {
            if (!first) sb.append(",");
            first = false;

            double lineTotal = it.getUnitPrice() * it.getQty();

            sb.append("{");
            sb.append("\"variantId\":").append(it.getVariantId()).append(",");
            sb.append("\"productId\":").append(it.getProductId()).append(",");
            sb.append("\"name\":\"").append(escape(it.getName())).append("\",");
            sb.append("\"img\":\"").append(escape(it.getImg())).append("\",");
            sb.append("\"unitPrice\":\"").append(it.getUnitPrice()).append("\",");
            sb.append("\"qty\":").append(it.getQty()).append(",");
            sb.append("\"lineTotal\":\"").append(lineTotal).append("\"");
            sb.append("}");
        }

        sb.append("]}");
        return sb.toString();
    }

    private static String escape(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\").replace("\"", "\\\"");
    }
}

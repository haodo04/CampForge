package vn.edu.hcmuaf.edu.vn.campforge.model;

import java.io.Serializable;
import java.util.LinkedHashMap;
import java.util.Map;

public class Cart implements Serializable {

    private final Map<Integer, CartItem> items = new LinkedHashMap<>();

    public Map<Integer, CartItem> getItems() {
        return items;
    }

    public boolean isEmpty() {
        return items.isEmpty();
    }

    public int getTotalQuantity() {
        return items.values().stream()
                .mapToInt(CartItem::getQuantity)
                .sum();
    }

    public void add(int variantId, int qty) {
        if (qty <= 0) return;

        CartItem item = items.get(variantId);
        if (item == null) {
            items.put(variantId, new CartItem(variantId, qty));
        } else {
            item.setQuantity(item.getQuantity() + qty);
        }
    }

    public void update(int variantId, int qty) {
        if (qty <= 0) {
            items.remove(variantId);
            return;
        }

        CartItem item = items.get(variantId);
        if (item == null) {
            items.put(variantId, new CartItem(variantId, qty));
        } else {
            item.setQuantity(qty);
        }
    }

    public void remove(int variantId) {
        items.remove(variantId);
    }

    public void clear() {
        items.clear();
    }

    public int getDistinctCount() {
        return items == null ? 0 : items.size();
    }
}

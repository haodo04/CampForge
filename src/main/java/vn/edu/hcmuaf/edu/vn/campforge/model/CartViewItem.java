package vn.edu.hcmuaf.edu.vn.campforge.model;

import java.io.Serializable;

public class CartViewItem implements Serializable {

    private int variantId;
    private int productId;

    private String proName;
    private String color;
    private String size;
    private String imagePath;

    private double unitPrice;
    private int stock;
    private int quantity;

    public double getLineTotal() {
        return unitPrice * quantity;
    }

    // getters & setters
    public int getVariantId() { return variantId; }
    public void setVariantId(int variantId) { this.variantId = variantId; }

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public String getProName() { return proName; }
    public void setProName(String proName) { this.proName = proName; }

    public String getColor() { return color; }
    public void setColor(String color) { this.color = color; }

    public String getSize() { return size; }
    public void setSize(String size) { this.size = size; }

    public String getImagePath() { return imagePath; }
    public void setImagePath(String imagePath) { this.imagePath = imagePath; }

    public double getUnitPrice() { return unitPrice; }
    public void setUnitPrice(double unitPrice) { this.unitPrice = unitPrice; }

    public int getStock() { return stock; }
    public void setStock(int stock) { this.stock = stock; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
}

package vn.edu.hcmuaf.edu.vn.campforge.model;

import java.io.Serializable;

public class ProductVariant implements Serializable {
    private int id;
    private int productId;
    private String sku;
    private Double price;
    private int stock;
    private int isActive;
    private Double finalPrice;

    public ProductVariant(int id, int productId, String sku, Double price, int stock, int isActive, Double finalPrice) {
        this.id = id;
        this.productId = productId;
        this.sku = sku;
        this.price = price;
        this.stock = stock;
        this.isActive = isActive;
        this.finalPrice = finalPrice;
    }

    public ProductVariant() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public String getSku() { return sku; }
    public void setSku(String sku) { this.sku = sku; }

    public Double getPrice() { return price; }
    public void setPrice(Double price) { this.price = price; }

    public int getStock() { return stock; }
    public void setStock(int stock) { this.stock = stock; }

    public int getIsActive() { return isActive; }
    public void setIsActive(int isActive) { this.isActive = isActive; }

    public Double getFinalPrice() { return finalPrice; }
    public void setFinalPrice(Double finalPrice) { this.finalPrice = finalPrice; }
}

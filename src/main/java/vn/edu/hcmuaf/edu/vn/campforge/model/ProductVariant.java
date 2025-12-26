package vn.edu.hcmuaf.edu.vn.campforge.model;

import java.io.Serializable;

public class ProductVariant implements Serializable {
    private int id;
    private int productId;

    private String color;
    private String size;

    private String imagePath;

    private Long price;
    private long finalPrice;

    private int stock;
    private boolean isActive;

    public ProductVariant(int id, int productId, String color, String size, String imagePath, Long price, long finalPrice, int stock, boolean isActive) {
        this.id = id;
        this.productId = productId;
        this.color = color;
        this.size = size;
        this.imagePath = imagePath;
        this.price = price;
        this.finalPrice = finalPrice;
        this.stock = stock;
        this.isActive = isActive;
    }

    public ProductVariant() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

    public Long getPrice() {
        return price;
    }

    public void setPrice(Long price) {
        this.price = price;
    }

    public long getFinalPrice() {
        return finalPrice;
    }

    public void setFinalPrice(long finalPrice) {
        this.finalPrice = finalPrice;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }
}

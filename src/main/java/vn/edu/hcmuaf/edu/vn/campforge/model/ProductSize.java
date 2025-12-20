package vn.edu.hcmuaf.edu.vn.campforge.model;

import java.io.Serializable;

public class ProductSize implements Serializable {
    private int id;
    private int productId;
    private String sizeName;
    private double weight;

    public ProductSize(int id, int productId, String sizeName, double weight) {
        this.id = id;
        this.productId = productId;
        this.sizeName = sizeName;
        this.weight = weight;
    }

    public ProductSize() {
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

    public String getSizeName() {
        return sizeName;
    }

    public void setSizeName(String sizeName) {
        this.sizeName = sizeName;
    }

    public double getWeight() {
        return weight;
    }

    public void setWeight(double weight) {
        this.weight = weight;
    }
}

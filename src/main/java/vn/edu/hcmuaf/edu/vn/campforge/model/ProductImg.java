package vn.edu.hcmuaf.edu.vn.campforge.model;

import java.io.Serializable;

public class ProductImg implements Serializable {
    private int id;
    private int productId;
    private String path;
    private int position;

    public ProductImg(int id, int productId, String path, int position) {
        this.id = id;
        this.productId = productId;
        this.path = path;
        this.position = position;
    }

    public ProductImg() {
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public String getPath() { return path; }
    public void setPath(String path) { this.path = path; }

    public int getPosition() { return position; }
    public void setPosition(int position) { this.position = position; }
}

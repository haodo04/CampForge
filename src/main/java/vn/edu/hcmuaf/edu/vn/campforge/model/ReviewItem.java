package vn.edu.hcmuaf.edu.vn.campforge.model;

public class ReviewItem {
    private int orderItemId;
    private int productId;
    private String proName;
    private String image;
    private boolean reviewed;

    public int getOrderItemId() { return orderItemId; }
    public void setOrderItemId(int orderItemId) { this.orderItemId = orderItemId; }

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public String getProName() { return proName; }
    public void setProName(String proName) { this.proName = proName; }

    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }

    public boolean isReviewed() { return reviewed; }
    public void setReviewed(boolean reviewed) { this.reviewed = reviewed; }
}

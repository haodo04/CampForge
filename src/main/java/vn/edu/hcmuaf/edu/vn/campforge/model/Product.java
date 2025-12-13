package vn.edu.hcmuaf.edu.vn.campforge.model;

public class Product {
    private int id;
    private String proName;
    private double price;
    private String description;
    private int cateId;
    private int brandId;
    private String brandName;
    private String image;

    public Product(int id, String proName, double price,
                   String description, int cateId, int brandId, String brandName, String image) {
        this.id = id;
        this.proName = proName;
        this.price = price;
        this.description = description;
        this.cateId = cateId;
        this.brandId = brandId;
        this.brandName = brandName;
        this.image = image;
    }

    public int getId() {
        return id;
    }

    public String getProName() {
        return proName;
    }

    public double getPrice() {
        return price;
    }

    public String getDescription() {
        return description;
    }

    public int getCateId() {
        return cateId;
    }

    public int getBrandId() {
        return brandId;
    }

    public String getBrandName() {
        return brandName;
    }

    public String getImage() {
        return image;
    }
}

package vn.edu.hcmuaf.edu.vn.campforge.model;

import java.io.Serializable;
import java.util.Date;

public class Product implements Serializable {
    private int id;
    private int cateId;
    private int brandId;
    private String proName;
    private double price;
    private String description;
    private int sold;
    private Date createAt;
    private int isDelete;
    private String image;
    private String brandName;
    private String cateName;
    private Integer defaultVariantId;

    public Product(int id, int cateId, int brandId, String proName, double price, String description, int sold, Date createAt, int isDelete, String image, String brandName, String cateName) {
        this.id = id;
        this.cateId = cateId;
        this.brandId = brandId;
        this.proName = proName;
        this.price = price;
        this.description = description;
        this.sold = sold;
        this.createAt = createAt;
        this.isDelete = isDelete;
        this.image = image;
        this.brandName = brandName;
        this.cateName = cateName;
    }

    public Product(int id, int cateId, int brandId, String proName, double price, String description, int sold, Date createAt, int isDelete, String image, String brandName) {
        this.id = id;
        this.cateId = cateId;
        this.brandId = brandId;
        this.proName = proName;
        this.price = price;
        this.description = description;
        this.sold = sold;
        this.createAt = createAt;
        this.isDelete = isDelete;
        this.image = image;
        this.brandName = brandName;
    }

    public Integer getDefaultVariantId() {
        return defaultVariantId;
    }

    public void setDefaultVariantId(Integer defaultVariantId) {
        this.defaultVariantId = defaultVariantId;
    }

    public Product() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCateId() {
        return cateId;
    }

    public void setCateId(int cateId) {
        this.cateId = cateId;
    }

    public int getBrandId() {
        return brandId;
    }

    public void setBrandId(int brandId) {
        this.brandId = brandId;
    }

    public String getProName() {
        return proName;
    }

    public void setProName(String proName) {
        this.proName = proName;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getSold() {
        return sold;
    }

    public void setSold(int sold) {
        this.sold = sold;
    }

    public Date getCreateAt() {
        return createAt;
    }

    public void setCreateAt(Date createAt) {
        this.createAt = createAt;
    }

    public int getIsDelete() {
        return isDelete;
    }

    public void setIsDelete(int isDelete) {
        this.isDelete = isDelete;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    public String getCateName() {
        return cateName;
    }

    public void setCateName(String cateName) {
        this.cateName = cateName;
    }

    public String getFormattedPrice() {
        return String.format("%,.0f đ", price);
    }
}

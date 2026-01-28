package vn.edu.hcmuaf.edu.vn.campforge.service.dto;

import java.util.ArrayList;
import java.util.List;

public class CreateProductRequest {
    public String proName;
    public int cateId;
    public String brandName;
    public double price;
    public String description;
    public int isDelete;

    public String mainImagePath;
    public List<String> galleryPaths = new ArrayList<>();

    public List<ProductVariantInput> variants = new ArrayList<>();
    public List<ProductSizeInput> sizes = new ArrayList<>();

    public static class ProductVariantInput {
        public String color;
        public String size;
        public String imagePath;
        public Double price;
        public int stock;
    }

    public static class ProductSizeInput {
        public String sizeName;
        public double weight;
    }
}

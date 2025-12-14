package vn.edu.hcmuaf.edu.vn.campforge.service;

import vn.edu.hcmuaf.edu.vn.campforge.dao.ProductDAO;
import vn.edu.hcmuaf.edu.vn.campforge.model.Product;
import java.util.List;

public class ProductService {

    // "lấy tất cả" (không phân trang), dùng limit lớn.
    public static List<Product> getAllProducts() {
        return ProductDAO.findProducts(null, null, null, null, Integer.MAX_VALUE, 0);
    }

    public static List<Product> getByCategory(int cateId) {
        return ProductDAO.findProducts(cateId, null, null, null, Integer.MAX_VALUE, 0);
    }

    public static List<Product> getByBrand(int brandId) {
        return ProductDAO.findProducts(null, brandId, null, null, Integer.MAX_VALUE, 0);
    }

    public static List<Product> getByPrice(double min, double max) {
        if (min < 0) min = 0;
        if (max < min) return List.of();
        return ProductDAO.findProducts(null, null, min, max, Integer.MAX_VALUE, 0);
    }

    // Dùng cho trang category: có phân trang
    public static List<Product> findProducts(Integer cateId, Integer brandId,
                                             Double min, Double max,
                                             int limit, int offset) {

        if (limit <= 0) limit = 12;
        if (offset < 0) offset = 0;

        if (min != null && min < 0) min = 0.0;
        if (min != null && max != null && max < min) {
            return List.of();
        }

        return ProductDAO.findProducts(cateId, brandId, min, max, limit, offset);
    }

    public static int countProducts(Integer cateId, Integer brandId, Double min, Double max) {
        if (min != null && min < 0) min = 0.0;
        if (min != null && max != null && max < min) return 0;
        return ProductDAO.countProducts(cateId, brandId, min, max);
    }
}



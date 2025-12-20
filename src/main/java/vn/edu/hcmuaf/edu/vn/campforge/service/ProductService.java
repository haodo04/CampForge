package vn.edu.hcmuaf.edu.vn.campforge.service;

import vn.edu.hcmuaf.edu.vn.campforge.dao.ProductDAO;
import vn.edu.hcmuaf.edu.vn.campforge.model.Product;

import java.util.Date;
import java.util.List;

public class ProductService {

    // Lấy tất cả (không phân trang)
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

    public static List<Product> findProducts(
            Integer cateId,
            Integer brandId,
            Double min,
            Double max,
            int limit,
            int offset
    ) {
        return findProducts(cateId, brandId, min, max, null, null, limit, offset);
    }

    // Hàm mới – có lọc ngày
    public static List<Product> findProducts(
            Integer cateId,
            Integer brandId,
            Double min,
            Double max,
            Date fromDate,
            Date toDate,
            int limit,
            int offset
    ) {
        if (limit <= 0) limit = 12;
        if (offset < 0) offset = 0;

        if (min != null && min < 0) min = 0.0;
        if (min != null && max != null && max < min) return List.of();

        // ngày không hợp lệ
        if (fromDate != null && toDate != null && fromDate.after(toDate)) {
            return List.of();
        }

        if (fromDate == null && toDate == null) {
            return ProductDAO.findProducts(
                    cateId, brandId, min, max, limit, offset
            );
        }

        return ProductDAO.findProducts(
                cateId, brandId, min, max, fromDate, toDate, limit, offset
        );
    }


    public static int countProducts(
            Integer cateId,
            Integer brandId,
            Double min,
            Double max
    ) {
        return countProducts(cateId, brandId, min, max, null, null);
    }

    public static int countProducts(
            Integer cateId,
            Integer brandId,
            Double min,
            Double max,
            Date fromDate,
            Date toDate
    ) {
        if (min != null && min < 0) min = 0.0;
        if (min != null && max != null && max < min) return 0;

        if (fromDate != null && toDate != null && fromDate.after(toDate)) {
            return 0;
        }

        if (fromDate == null && toDate == null) {
            return ProductDAO.countProducts(cateId, brandId, min, max);
        }

        return ProductDAO.countProducts(
                cateId, brandId, min, max, fromDate, toDate
        );
    }

    public static List<Product> getLatestProducts(int limit) {
        return ProductDAO.getLatestProducts(limit);
    }

    public static List<Product> getBestSellerProducts(int limit) {
        if (limit <= 0) limit = 8;
        return ProductDAO.getBestSellerProducts(limit);
    }

    public static List<Product> getHomeLatest(int limit) {
        return getLatestProducts(limit);
    }

    public static List<Product> getHomeBestSeller(int limit) {
        return getBestSellerProducts(limit);
    }

}

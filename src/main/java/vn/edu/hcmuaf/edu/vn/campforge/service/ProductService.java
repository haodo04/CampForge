package vn.edu.hcmuaf.edu.vn.campforge.service;

import vn.edu.hcmuaf.edu.vn.campforge.dao.ProductDAO;
import vn.edu.hcmuaf.edu.vn.campforge.model.Product;
import java.util.List;

public class ProductService {

    public static List<Product> getAllProducts() {
        return ProductDAO.getAllProducts();
    }

    public static List<Product> getByCategory(int cateId) {
        return ProductDAO.getProductsByCategory(cateId);
    }

    public static List<Product> getByBrand(int brandId) {
        return ProductDAO.getProductsByBrand(brandId);
    }

    public static List<Product> getByPrice(double min, double max) {
        return ProductDAO.getProductsByPrice(min, max);
    }
}

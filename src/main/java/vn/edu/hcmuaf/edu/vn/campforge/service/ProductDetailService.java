package vn.edu.hcmuaf.edu.vn.campforge.service;

import vn.edu.hcmuaf.edu.vn.campforge.dao.ProductDAO;
import vn.edu.hcmuaf.edu.vn.campforge.dao.ProductImgDAO;
import vn.edu.hcmuaf.edu.vn.campforge.model.Product;
import vn.edu.hcmuaf.edu.vn.campforge.model.ProductImg;
import vn.edu.hcmuaf.edu.vn.campforge.model.ProductVariant;
import vn.edu.hcmuaf.edu.vn.campforge.model.VariantOption;

import java.util.List;
import java.util.Map;

public class ProductDetailService {

    private final ProductVariantService variantService = new ProductVariantService();

    public Product getProduct(int productId) {
        return ProductDAO.findById(productId);
    }

    public List<ProductVariant> getVariants(int productId) {
        return variantService.getVariantsByProductId(productId);
    }

    public Map<Integer, List<VariantOption>> getOptionMap(int productId) {
        return variantService.getOptionMapByProductId(productId);
    }

    public List<ProductImg> getImages(int productId) {
        return ProductImgDAO.findByProductId(productId);
    }
}

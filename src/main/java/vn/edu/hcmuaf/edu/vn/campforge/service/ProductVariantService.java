package vn.edu.hcmuaf.edu.vn.campforge.service;

import vn.edu.hcmuaf.edu.vn.campforge.dao.ProductVariantDAO;
import vn.edu.hcmuaf.edu.vn.campforge.model.ProductVariant;

import java.util.Collections;
import java.util.List;

public class ProductVariantService {

    public List<ProductVariant> getVariantsByProductId(int productId) {
        if (productId <= 0) return Collections.emptyList();
        return ProductVariantDAO.findByProductId(productId);
    }

    public ProductVariant getVariantById(int variantId) {
        if (variantId <= 0) return null;
        return ProductVariantDAO.findById(variantId);
    }
}

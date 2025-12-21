package vn.edu.hcmuaf.edu.vn.campforge.service;

import vn.edu.hcmuaf.edu.vn.campforge.dao.ProductVariantDAO;
import vn.edu.hcmuaf.edu.vn.campforge.dao.VariantOptionDAO;
import vn.edu.hcmuaf.edu.vn.campforge.model.ProductVariant;
import vn.edu.hcmuaf.edu.vn.campforge.model.VariantOption;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ProductVariantService {

    public List<ProductVariant> getVariantsByProductId(int productId) {
        return ProductVariantDAO.findByProductId(productId);
    }

    public ProductVariant getVariantById(int variantId) {
        return ProductVariantDAO.findById(variantId);
    }

    public List<VariantOption> getOptionsByProductId(int productId) {
        return VariantOptionDAO.findByProductId(productId);
    }

    public List<VariantOption> getOptionsByVariantId(int variantId) {
        return VariantOptionDAO.findByVariantId(variantId);
    }

    public Map<Integer, List<VariantOption>> getOptionMapByProductId(int productId) {
        List<VariantOption> options = VariantOptionDAO.findByProductId(productId);
        Map<Integer, List<VariantOption>> map = new HashMap<>();

        for (VariantOption o : options) {
            map.computeIfAbsent(o.getVariantId(), k -> new java.util.ArrayList<>()).add(o);
        }
        return map;
    }
}

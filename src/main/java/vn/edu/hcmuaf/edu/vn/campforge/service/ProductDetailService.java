package vn.edu.hcmuaf.edu.vn.campforge.service;

import vn.edu.hcmuaf.edu.vn.campforge.dao.ProductDAO;
import vn.edu.hcmuaf.edu.vn.campforge.dao.ProductImgDAO;
import vn.edu.hcmuaf.edu.vn.campforge.model.Product;
import vn.edu.hcmuaf.edu.vn.campforge.model.ProductImg;
import vn.edu.hcmuaf.edu.vn.campforge.model.ProductVariant;

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

    public List<Product> getRelatedProducts(int productId, int limit) {
        Product p = getProduct(productId);
        if (p == null) return List.of();

        List<Product> related = ProductDAO.getRelatedProducts(p.getCateId(), productId, limit);

        // fallback nếu cate ít sản phẩm
        if (related.size() < limit) {
            int need = limit - related.size();
            List<Product> best = ProductDAO.getBestSellerProducts(need + 10);
            for (Product x : best) {
                if (related.size() >= limit) break;
                if (x.getId() == productId) continue;
                boolean existed = related.stream().anyMatch(r -> r.getId() == x.getId());
                if (!existed) related.add(x);
            }
        }
        return related;
    }

}

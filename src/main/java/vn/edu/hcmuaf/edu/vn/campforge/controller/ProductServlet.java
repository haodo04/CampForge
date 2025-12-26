package vn.edu.hcmuaf.edu.vn.campforge.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.hcmuaf.edu.vn.campforge.model.Product;
import vn.edu.hcmuaf.edu.vn.campforge.model.ProductImg;
import vn.edu.hcmuaf.edu.vn.campforge.model.ProductVariant;
import vn.edu.hcmuaf.edu.vn.campforge.service.ProductDetailService;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/product")
public class ProductServlet extends HttpServlet {

    private final ProductDetailService detailService = new ProductDetailService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int productId = parseInt(req.getParameter("id"), -1);
        if (productId <= 0) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing or invalid product id");
            return;
        }

        Product product = detailService.getProduct(productId);
        if (product == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found");
            return;
        }

        List<ProductVariant> variants = detailService.getVariants(productId);
        Map<Integer, List<VariantOption>> optionMap = detailService.getOptionMap(productId);

        Integer selectedVariantId = parseIntObj(req.getParameter("variantId"));
        if (selectedVariantId == null) {
            selectedVariantId = (!variants.isEmpty()) ? variants.get(0).getId() : null;
        }

        List<ProductImg> images = detailService.getImages(productId);
        List<Product> relatedProducts = detailService.getRelatedProducts(productId, 8);

        req.setAttribute("product", product);
        req.setAttribute("variants", variants);
        req.setAttribute("optionMap", optionMap);
        req.setAttribute("selectedVariantId", selectedVariantId);
        req.setAttribute("images", images);
        req.setAttribute("relatedProducts", relatedProducts);

        req.getRequestDispatcher("/sproduct.jsp").forward(req, resp);
    }

    private int parseInt(String s, int def) {
        try {
            if (s == null) return def;
            return Integer.parseInt(s.trim());
        } catch (Exception e) {
            return def;
        }
    }

    private Integer parseIntObj(String s) {
        try {
            if (s == null || s.isBlank()) return null;
            return Integer.valueOf(s.trim());
        } catch (Exception e) {
            return null;
        }
    }
}

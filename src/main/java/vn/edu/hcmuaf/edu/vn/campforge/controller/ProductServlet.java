package vn.edu.hcmuaf.edu.vn.campforge.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.hcmuaf.edu.vn.campforge.dao.OrderItemDAO;
import vn.edu.hcmuaf.edu.vn.campforge.model.*;
import vn.edu.hcmuaf.edu.vn.campforge.service.ProductDetailService;
import vn.edu.hcmuaf.edu.vn.campforge.service.ReviewService;

import java.io.IOException;
import java.util.Collections;
import java.util.List;

@WebServlet("/product")
public class ProductServlet extends HttpServlet {

    private final ProductDetailService detailService = new ProductDetailService();
    private final ReviewService reviewService = new ReviewService();
    private final OrderItemDAO orderItemDAO = new OrderItemDAO();

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


        req.setAttribute("reviewTargets", Collections.emptyList());
        User auth = (User) req.getSession().getAttribute("auth");
        if (auth != null) {
            try {
                var targets = orderItemDAO.findEligibleReviewTargets(auth.getId(), productId);
                req.setAttribute("reviewTargets", targets);
            } catch (Exception e) {
                e.printStackTrace();
                req.setAttribute("reviewTargets", Collections.emptyList());
            }
        }


        Integer selectedVariantId = parseIntObj(req.getParameter("variantId"));
        ProductVariant selectedVariant = null;

        if (!variants.isEmpty()) {
            if (selectedVariantId != null) {
                for (ProductVariant v : variants) {
                    if (v.getId() == selectedVariantId) {
                        selectedVariant = v;
                        break;
                    }
                }
            }

            if (selectedVariant == null) {
                selectedVariant = variants.get(0);
                selectedVariantId = selectedVariant.getId();
            }
        } else {
            selectedVariantId = null;
        }

        List<ProductImg> images = detailService.getImages(productId);
        List<Product> relatedProducts = detailService.getRelatedProducts(productId, 8);

        req.setAttribute("product", product);
        req.setAttribute("variants", variants);
        req.setAttribute("selectedVariantId", selectedVariantId);
        req.setAttribute("selectedVariant", selectedVariant);
        req.setAttribute("images", images);
        req.setAttribute("relatedProducts", relatedProducts);

        double avgRating = 0.0;
        int reviewCount = 0;
        int avgRatingRounded = 0;
        List<ProductReview> reviews = Collections.emptyList();

        try {
            avgRating = reviewService.getAvgRating(productId);
            reviewCount = reviewService.countReviews(productId);
            avgRatingRounded = (int) Math.round(avgRating);
            reviews = reviewService.getReviews(productId, 20, 0);
        } catch (Exception e) {
            e.printStackTrace();
        }

        req.setAttribute("avgRating", avgRating);
        req.setAttribute("avgRatingRounded", avgRatingRounded);
        req.setAttribute("reviewCount", reviewCount);
        req.setAttribute("reviews", reviews);


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

package vn.edu.hcmuaf.edu.vn.campforge.service;

import vn.edu.hcmuaf.edu.vn.campforge.dao.OrderDAO;
import vn.edu.hcmuaf.edu.vn.campforge.dao.ProductReviewDAO;
import vn.edu.hcmuaf.edu.vn.campforge.model.ProductReview;

public class ReviewService {

    private final ProductReviewDAO reviewDAO = new ProductReviewDAO();
    private final OrderDAO orderDAO = new OrderDAO();

    public void createReview(int userId,
                             Integer orderId,
                             Integer orderItemId,
                             int productId,
                             int rating,
                             String content) throws Exception {

        if (rating < 1 || rating > 5) throw new IllegalArgumentException("Rating phải từ 1 đến 5");

        boolean hasOrderContext = (orderId != null && orderId > 0 && orderItemId != null && orderItemId > 0);

        if (hasOrderContext) {
            boolean okOrder = orderDAO.isCompletedOrderOfUser(orderId, userId);
            if (!okOrder) throw new IllegalStateException("Đơn hàng không hợp lệ hoặc chưa hoàn thành");

            if (reviewDAO.existsByUserAndOrderItem(userId, orderItemId)) {
                throw new IllegalStateException("Sản phẩm này đã được đánh giá rồi");
            }
        } else {
            if (reviewDAO.existsByUserAndProduct(userId, productId)) {
                throw new IllegalStateException("Bạn đã đánh giá sản phẩm này rồi");
            }
        }

        ProductReview r = new ProductReview();
        r.setUserId(userId);
        r.setProductId(productId);
        r.setOrderId(hasOrderContext ? orderId : null);
        r.setOrderItemId(hasOrderContext ? orderItemId : null);
        r.setRating(rating);
        r.setContent(content);

        reviewDAO.insert(r);
    }

    public double getAvgRating(int productId) throws Exception {
        return reviewDAO.getAvgRating(productId);
    }

    public int countReviews(int productId) throws Exception {
        return reviewDAO.countByProductId(productId);
    }

    public java.util.List<ProductReview> getReviews(int productId, int limit, int offset) throws Exception {
        return reviewDAO.findByProductId(productId, limit, offset);
    }


}

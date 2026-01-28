package vn.edu.hcmuaf.edu.vn.campforge.service;

import vn.edu.hcmuaf.edu.vn.campforge.dao.*;
import vn.edu.hcmuaf.edu.vn.campforge.dao.db.DbConnect;
import vn.edu.hcmuaf.edu.vn.campforge.service.dto.CreateProductRequest;

import java.sql.Connection;

public class AdminProductService {

    public java.util.List<vn.edu.hcmuaf.edu.vn.campforge.model.Product> getAllProducts() {
        return ProductDAO.findProducts(null, null, null, null, 200, 0);
    }

    public int createProduct(CreateProductRequest req) throws Exception {
        try (Connection conn = DbConnect.getConnection()) {
            conn.setAutoCommit(false);
            try {
                int brandId = BrandDAO.findOrCreateByName(conn, req.brandName);
                int productId = ProductDAO.insert(conn, req.cateId, brandId, req.proName, req.price, req.description, req.isDelete);

                // ảnh đại diện + gallery
                ProductImgDAO.insert(conn, productId, req.mainImagePath, 1);
                int pos = 2;
                for (String p : req.galleryPaths) {
                    ProductImgDAO.insert(conn, productId, p, pos++);
                }

                for (CreateProductRequest.ProductVariantInput v : req.variants) {
                    ProductVariantDAO.insert(conn, productId, v.color, v.size, v.imagePath, v.price, v.stock, 1);
                }

                for (CreateProductRequest.ProductSizeInput s : req.sizes) {
                    ProductSizeDAO.insert(conn, productId, s.sizeName, s.weight);
                }

                conn.commit();
                return productId;
            } catch (Exception ex) {
                conn.rollback();
                throw ex;
            }
        }
    }
    public void deleteProductCascade(int productId) throws Exception {
        try (Connection conn = DbConnect.getConnection()) {
            conn.setAutoCommit(false);
            try {
                ProductVariantDAO.deleteByProductId(conn, productId);
                ProductImgDAO.deleteByProductId(conn, productId);
                ProductSizeDAO.deleteByProductId(conn, productId);

                ProductDAO.deleteById(conn, productId);

                conn.commit();
            } catch (Exception ex) {
                conn.rollback();
                throw ex;
            }
        }
    }

    public void updateProductBasic(
            int productId,
            int cateId,
            String brandName,
            String proName,
            double price,
            String description,
            String newMainImagePath
    ) throws Exception {

        try (Connection conn = DbConnect.getConnection()) {
            conn.setAutoCommit(false);
            try {
                int brandId = BrandDAO.findOrCreateByName(conn, brandName);

                ProductDAO.updateBasic(conn, productId, cateId, brandId, proName, price, description);

                if (newMainImagePath != null && !newMainImagePath.trim().isEmpty()) {
                    ProductImgDAO.upsertMainImage(conn, productId, newMainImagePath);
                }

                conn.commit();
            } catch (Exception ex) {
                conn.rollback();
                throw ex;
            }
        }
    }

    public static class ProductDetailDTO {
        public vn.edu.hcmuaf.edu.vn.campforge.model.Product product;
        public java.util.List<vn.edu.hcmuaf.edu.vn.campforge.model.ProductImg> images;
        public java.util.List<vn.edu.hcmuaf.edu.vn.campforge.model.ProductVariant> variants;
        public java.util.List<vn.edu.hcmuaf.edu.vn.campforge.model.ProductSize> sizes;
    }

    public ProductDetailDTO getProductDetail(int productId) {
        ProductDetailDTO dto = new ProductDetailDTO();
        dto.product = ProductDAO.findById(productId);
        dto.images = ProductImgDAO.findByProductId(productId);
        dto.variants = ProductVariantDAO.findByProductId(productId);
        dto.sizes = ProductSizeDAO.findByProductId(productId);
        return dto.product == null ? null : dto;
    }

    public void updateProductFull(
            int productId,
            int cateId,
            String brandName,
            String proName,
            double price,
            String description,
            String newMainImagePath,
            boolean replaceGallery,
            java.util.List<String> newGalleryPaths,
            java.util.List<CreateProductRequest.ProductVariantInput> newVariants,
            java.util.List<CreateProductRequest.ProductSizeInput> newSizes
    ) throws Exception {

        try (Connection conn = DbConnect.getConnection()) {
            conn.setAutoCommit(false);
            try {
                int brandId = BrandDAO.findOrCreateByName(conn, brandName);

                ProductDAO.updateBasic(conn, productId, cateId, brandId, proName, price, description);

                if (newMainImagePath != null && !newMainImagePath.trim().isEmpty()) {
                    ProductImgDAO.upsertMainImage(conn, productId, newMainImagePath);
                }

                if (replaceGallery) {
                    ProductImgDAO.deleteGalleryByProductId(conn, productId);
                    int pos = 2;
                    for (String p : newGalleryPaths) {
                        ProductImgDAO.insert(conn, productId, p, pos++);
                    }
                }

                if (newVariants != null && !newVariants.isEmpty()) {
                    String mainPath = (newMainImagePath != null && !newMainImagePath.isBlank())
                            ? newMainImagePath
                            : ProductImgDAO.getMainImagePath(conn, productId);

                    ProductVariantDAO.deleteByProductId(conn, productId);
                    for (CreateProductRequest.ProductVariantInput v : newVariants) {
                        String img = (v.imagePath == null || v.imagePath.isBlank()) ? mainPath : v.imagePath;
                        ProductVariantDAO.insert(conn, productId, v.color, v.size, img, v.price, v.stock, 1);
                    }
                }

                if (newSizes != null && !newSizes.isEmpty()) {
                    ProductSizeDAO.deleteByProductId(conn, productId);
                    for (CreateProductRequest.ProductSizeInput s : newSizes) {
                        ProductSizeDAO.insert(conn, productId, s.sizeName, s.weight);
                    }
                }

                conn.commit();
            } catch (Exception ex) {
                conn.rollback();
                throw ex;
            }
        }
    }

}

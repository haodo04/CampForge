package vn.edu.hcmuaf.edu.vn.campforge.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.edu.hcmuaf.edu.vn.campforge.service.AdminProductService;
import vn.edu.hcmuaf.edu.vn.campforge.service.dto.CreateProductRequest;
import java.io.IOException;
import java.nio.file.*;
import java.util.*;

@WebServlet("/admin/products")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 10L * 1024 * 1024,
        maxRequestSize = 50L * 1024 * 1024
)
public class AdminProductServlet extends HttpServlet {
    private final AdminProductService productService = new AdminProductService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("detail".equalsIgnoreCase(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            var dto = productService.getProductDetail(id);
            if (dto == null) { resp.sendError(404); return; }

            resp.setContentType("application/json; charset=UTF-8");
            resp.getWriter().print(toJson(dto));
            return;
        }

        req.setAttribute("products", productService.getAllProducts());
        req.getRequestDispatcher("/admin/products.jsp").forward(req, resp);
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String action = req.getParameter("action");
        if (action == null) action = "";

        try {
            switch (action.toLowerCase()) {
                case "create" -> handleCreate(req, resp);
                case "delete" -> handleDelete(req, resp);
                case "update" -> handleUpdate(req, resp);
                default -> resp.sendRedirect(req.getContextPath() + "/admin/products");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/admin/products?error=1");
        }
    }

    private void handleUpdate(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        int id = Integer.parseInt(req.getParameter("id"));
        String proName = trim(req.getParameter("proName"));
        int cateId = Integer.parseInt(req.getParameter("cateId"));
        String brandName = trim(req.getParameter("brandName"));
        double price = Double.parseDouble(req.getParameter("price"));
        String description = trim(req.getParameter("description"));

        Part mainImagePart = req.getPart("mainImage");
        String newMainImagePath = null;
        if (mainImagePart != null && mainImagePart.getSize() > 0) {
            String folder = cateFolder(cateId);
            String uploadDir = getServletContext().getRealPath("/assets/img/products/" + folder);
            Files.createDirectories(Paths.get(uploadDir));
            String publicBase = "/assets/img/products/" + folder;
            newMainImagePath = saveUpload(mainImagePart, uploadDir, publicBase);
        }

        String folder = cateFolder(cateId);
        String uploadDir = getServletContext().getRealPath("/assets/img/products/" + folder);
        Files.createDirectories(Paths.get(uploadDir));
        String publicBase = "/assets/img/products/" + folder;

        boolean replaceGallery = false;
        List<String> newGallery = new ArrayList<>();
        for (Part p : req.getParts()) {
            if (!"galleryImages".equals(p.getName())) continue;
            if (p.getSize() <= 0) continue;
            replaceGallery = true;
            String path = saveUpload(p, uploadDir, publicBase);
            if (path != null) newGallery.add(path);
        }

        List<CreateProductRequest.ProductVariantInput> variants = new ArrayList<>();
        String[] vColors = req.getParameterValues("variantColor[]");
        String[] vSizes  = req.getParameterValues("variantSize[]");
        String[] vPrices = req.getParameterValues("variantPrice[]");
        String[] vStocks = req.getParameterValues("variantStock[]");
        int vLen = maxLen(vColors, vSizes, vPrices, vStocks);

        for (int i = 0; i < vLen; i++) {
            String color = trim(getAt(vColors, i));
            String size  = trim(getAt(vSizes, i));
            String priceStr = trim(getAt(vPrices, i));
            String stockStr = trim(getAt(vStocks, i));

            int stock = stockStr.isEmpty() ? 0 : Integer.parseInt(stockStr);
            if (color.isEmpty() && size.isEmpty() && priceStr.isEmpty() && stock == 0) continue;

            Double vPrice = priceStr.isEmpty() ? null : Double.parseDouble(priceStr);

            CreateProductRequest.ProductVariantInput vi = new CreateProductRequest.ProductVariantInput();
            vi.color = color.isEmpty() ? null : color;
            vi.size = size.isEmpty() ? null : size;
            vi.price = vPrice;
            vi.stock = stock;
            vi.imagePath = null;
            variants.add(vi);
        }

        List<CreateProductRequest.ProductSizeInput> sizes = new ArrayList<>();
        String[] sNames = req.getParameterValues("sizeName[]");
        String[] sWeights = req.getParameterValues("sizeWeight[]");
        int sLen = maxLen(sNames, sWeights);
        for (int i = 0; i < sLen; i++) {
            String name = trim(getAt(sNames, i));
            String wStr = trim(getAt(sWeights, i));
            if (name.isEmpty() && wStr.isEmpty()) continue;

            double w = wStr.isEmpty() ? 0 : Double.parseDouble(wStr);
            CreateProductRequest.ProductSizeInput si = new CreateProductRequest.ProductSizeInput();
            si.sizeName = name.isEmpty() ? null : name;
            si.weight = w;
            sizes.add(si);
        }

        productService.updateProductFull(
                id, cateId, brandName, proName, price, description,
                newMainImagePath,
                replaceGallery, newGallery,
                variants,
                sizes
        );

        resp.sendRedirect(req.getContextPath() + "/admin/products?updated=1");
    }


    private void handleDelete(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        String idStr = req.getParameter("id");
        if (idStr == null || idStr.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/admin/products?delete_error=missing_id");
            return;
        }

        int id = Integer.parseInt(idStr);
        productService.deleteProductCascade(id);

        resp.sendRedirect(req.getContextPath() + "/admin/products?deleted=1");
    }

    private void handleCreate(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        String proName = trim(req.getParameter("proName"));
        int cateId = Integer.parseInt(req.getParameter("cateId"));
        String brandName = trim(req.getParameter("brandName"));
        double price = Double.parseDouble(req.getParameter("price"));
        String description = trim(req.getParameter("description"));
        int isDelete = 0;

        if (proName.isEmpty() || brandName.isEmpty()) {
            throw new IllegalArgumentException("Tên sản phẩm / thương hiệu không được để trống.");
        }

        String folder = cateFolder(cateId);

        String uploadDir = getServletContext().getRealPath("/assets/img/products/" + folder);
        Files.createDirectories(Paths.get(uploadDir));

        String publicBase = "/assets/img/products/" + folder;

        Part mainImagePart = req.getPart("mainImage");
        String mainImagePath = saveUpload(mainImagePart, uploadDir, publicBase);
        if (mainImagePath == null) throw new IllegalArgumentException("Thiếu ảnh đại diện.");

        List<String> galleryPaths = new ArrayList<>();
        for (Part p : req.getParts()) {
            if (!"galleryImages".equals(p.getName())) continue;
            String path = saveUpload(p, uploadDir, publicBase);
            if (path != null) galleryPaths.add(path);
        }

        List<CreateProductRequest.ProductVariantInput> variants = new ArrayList<>();
        String[] vColors = req.getParameterValues("variantColor[]");
        String[] vSizes  = req.getParameterValues("variantSize[]");
        String[] vPrices = req.getParameterValues("variantPrice[]");
        String[] vStocks = req.getParameterValues("variantStock[]");

        int vLen = maxLen(vColors, vSizes, vPrices, vStocks);
        for (int i = 0; i < vLen; i++) {
            String color = trim(getAt(vColors, i));
            String size  = trim(getAt(vSizes, i));
            String priceStr = trim(getAt(vPrices, i));
            String stockStr = trim(getAt(vStocks, i));

            int stock = 0;
            if (!stockStr.isEmpty()) {
                stock = Integer.parseInt(stockStr);
            }

            if (color.isEmpty() && size.isEmpty() && priceStr.isEmpty() && stock == 0) {
                continue;
            }

            Double vPrice = priceStr.isEmpty() ? null : Double.parseDouble(priceStr);

            CreateProductRequest.ProductVariantInput vi = new CreateProductRequest.ProductVariantInput();
            vi.color = color.isEmpty() ? null : color;
            vi.size = size.isEmpty() ? null : size;
            vi.price = vPrice;
            vi.stock = stock;
            vi.imagePath = mainImagePath;

            variants.add(vi);
        }

        List<CreateProductRequest.ProductSizeInput> sizes = new ArrayList<>();
        String[] sNames = req.getParameterValues("sizeName[]");
        String[] sWeights = req.getParameterValues("sizeWeight[]");
        int sLen = maxLen(sNames, sWeights);

        for (int i = 0; i < sLen; i++) {
            String name = trim(getAt(sNames, i));
            String wStr = trim(getAt(sWeights, i));

            if (name.isEmpty() && wStr.isEmpty()) continue;

            double w = wStr.isEmpty() ? 0 : Double.parseDouble(wStr);

            CreateProductRequest.ProductSizeInput si = new CreateProductRequest.ProductSizeInput();
            si.sizeName = name.isEmpty() ? null : name;
            si.weight = w;
            sizes.add(si);
        }

        CreateProductRequest dto = new CreateProductRequest();
        dto.proName = proName;
        dto.cateId = cateId;
        dto.brandName = brandName;
        dto.price = price;
        dto.description = description;
        dto.isDelete = isDelete;
        dto.mainImagePath = mainImagePath;
        dto.galleryPaths = galleryPaths;
        dto.variants = variants;
        dto.sizes = sizes;

        productService.createProduct(dto);

        resp.sendRedirect(req.getContextPath() + "/admin/products?created=1");
    }

    private static String trim(String s) {
        return s == null ? "" : s.trim();
    }

    private static int maxLen(String[]... arrs) {
        int m = 0;
        for (String[] a : arrs) if (a != null) m = Math.max(m, a.length);
        return m;
    }

    private static String getAt(String[] a, int i) {
        if (a == null || i < 0 || i >= a.length) return "";
        return a[i];
    }

    private static String saveUpload(Part part, String uploadDir, String publicBase) throws IOException {
        if (part == null) return null;
        String submitted = part.getSubmittedFileName();
        if (submitted == null || submitted.trim().isEmpty() || part.getSize() == 0) return null;

        String ext = "";
        int dot = submitted.lastIndexOf('.');
        if (dot >= 0) ext = submitted.substring(dot);

        String fileName = UUID.randomUUID().toString().replace("-", "") + ext;
        Path savePath = Paths.get(uploadDir, fileName);

        try {
            part.write(savePath.toString());
        } catch (Exception ex) {
            Files.copy(part.getInputStream(), savePath, StandardCopyOption.REPLACE_EXISTING);
        }

        return publicBase + "/" + fileName;
    }

    private static String esc(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "");
    }

    private static String toJson(AdminProductService.ProductDetailDTO dto) {
        var p = dto.product;
        StringBuilder sb = new StringBuilder();
        sb.append("{");
        sb.append("\"product\":{")
                .append("\"id\":").append(p.getId()).append(",")
                .append("\"proName\":\"").append(esc(p.getProName())).append("\",")
                .append("\"cateId\":").append(p.getCateId()).append(",")
                .append("\"brandName\":\"").append(esc(p.getBrandName())).append("\",")
                .append("\"price\":").append(p.getPrice()).append(",")
                .append("\"description\":\"").append(esc(p.getDescription())).append("\"")
                .append("},");

        sb.append("\"images\":[");
        for (int i=0;i<dto.images.size();i++){
            var im=dto.images.get(i);
            if(i>0) sb.append(",");
            sb.append("{\"path\":\"").append(esc(im.getPath())).append("\",\"position\":").append(im.getPosition()).append("}");
        }
        sb.append("],");

        sb.append("\"variants\":[");
        for (int i=0;i<dto.variants.size();i++){
            var v=dto.variants.get(i);
            if(i>0) sb.append(",");
            sb.append("{\"color\":\"").append(esc(v.getColor())).append("\",")
                    .append("\"size\":\"").append(esc(v.getSize())).append("\",")
                    .append("\"price\":").append(v.getPrice()==null?"null":v.getPrice()).append(",")
                    .append("\"stock\":").append(v.getStock()).append("}");
        }
        sb.append("],");

        sb.append("\"sizes\":[");
        for (int i=0;i<dto.sizes.size();i++){
            var s=dto.sizes.get(i);
            if(i>0) sb.append(",");
            sb.append("{\"sizeName\":\"").append(esc(s.getSizeName())).append("\",\"weight\":").append(s.getWeight()).append("}");
        }
        sb.append("]");

        sb.append("}");
        return sb.toString();
    }


    private static String cateFolder(int cateId) {
        return switch (cateId) {
            case 1 -> "trangphuc";
            case 2 -> "giaydep";
            case 3 -> "leonui";
            case 4 -> "camtrai";
            case 5 -> "chaybo";
            case 6 -> "boilan";
            case 7 -> "dapxe";
            case 8 -> "dodulich";
            case 9 -> "fitness";
            default -> "other";
        };
    }
}

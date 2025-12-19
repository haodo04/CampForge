package vn.edu.hcmuaf.edu.vn.campforge.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.hcmuaf.edu.vn.campforge.model.Product;
import vn.edu.hcmuaf.edu.vn.campforge.service.ProductService;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

@WebServlet("/category")
public class CategoryServlet extends HttpServlet {

    private static final int PAGE_SIZE = 12;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Integer cateId  = parseIntOrNull(request.getParameter("id"));
        Integer brandId = parseIntOrNull(request.getParameter("brandId"));

        Double minPrice = parseDoubleOrNull(request.getParameter("minPrice"));
        Double maxPrice = parseDoubleOrNull(request.getParameter("maxPrice"));

        String fromDateStr = request.getParameter("fromDate");
        String toDateStr   = request.getParameter("toDate");

        Date fromDate = null;
        Date toDate   = null;

        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

            if (fromDateStr != null && !fromDateStr.isBlank()) {
                fromDate = sdf.parse(fromDateStr);
            }

            if (toDateStr != null && !toDateStr.isBlank()) {
                Date tmp = sdf.parse(toDateStr);
                Calendar cal = Calendar.getInstance();
                cal.setTime(tmp);
                cal.set(Calendar.HOUR_OF_DAY, 23);
                cal.set(Calendar.MINUTE, 59);
                cal.set(Calendar.SECOND, 59);
                toDate = cal.getTime();
            }
        } catch (Exception ignored) {}

        int page = parsePage(request.getParameter("page"));

        Double min = null, max = null;
        if (minPrice != null || maxPrice != null) {
            double minVal = (minPrice != null) ? minPrice : 0.0;
            double maxVal = (maxPrice != null) ? maxPrice : Double.MAX_VALUE;
            if (maxVal >= minVal) {
                min = minVal;
                max = maxVal;
            }
        }

        int totalItems = ProductService.countProducts(
                cateId, brandId, min, max, fromDate, toDate
        );

        int totalPages = (int) Math.ceil(totalItems / (double) PAGE_SIZE);
        if (totalPages <= 0) totalPages = 1;

        if (page > totalPages) page = totalPages;
        int offset = (page - 1) * PAGE_SIZE;

        List<Product> products = ProductService.findProducts(
                cateId, brandId, min, max, fromDate, toDate, PAGE_SIZE, offset
        );

        List<Product> latestProducts = ProductService.getLatestProducts(12);

        request.setAttribute("products", products);
        request.setAttribute("latestProducts", latestProducts);

        request.setAttribute("page", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalItems", totalItems);

        request.setAttribute("cateId", cateId);
        request.setAttribute("brandId", brandId);
        request.setAttribute("minPrice", min);
        request.setAttribute("maxPrice", (max != null && max < Double.MAX_VALUE) ? max : null);

        request.setAttribute("fromDate", fromDateStr);
        request.setAttribute("toDate", toDateStr);

        request.getRequestDispatcher("/category.jsp").forward(request, response);
    }

    private Integer parseIntOrNull(String s) {
        try {
            if (s == null || s.isBlank()) return null;
            return Integer.parseInt(s.trim());
        } catch (Exception e) {
            return null;
        }
    }

    private Double parseDoubleOrNull(String s) {
        try {
            if (s == null || s.isBlank()) return null;
            return Double.parseDouble(s.trim());
        } catch (Exception e) {
            return null;
        }
    }

    private int parsePage(String s) {
        try {
            int p = (s == null || s.isBlank()) ? 1 : Integer.parseInt(s.trim());
            return Math.max(p, 1);
        } catch (Exception e) {
            return 1;
        }
    }
}

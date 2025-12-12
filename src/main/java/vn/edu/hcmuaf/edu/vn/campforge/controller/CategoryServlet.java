package vn.edu.hcmuaf.edu.vn.campforge.controller;

import vn.edu.hcmuaf.edu.vn.campforge.dao.ProductDAO;
import vn.edu.hcmuaf.edu.vn.campforge.model.Product;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/category")
public class CategoryServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String cateIdRaw = request.getParameter("id");
        String brandIdRaw = request.getParameter("brandId");
        List<Product> products;

        // Không có category và brand => lấy tất cả
        if (cateIdRaw == null && brandIdRaw == null) {
            products = ProductDAO.getAllProducts();
        }
        // Có category => lọc theo category
        else if (cateIdRaw != null) {
            int cateId = Integer.parseInt(cateIdRaw);
            products = ProductDAO.getProductsByCategory(cateId);
        }
        // Có brand => lọc theo brand
        else {
            int brandId = Integer.parseInt(brandIdRaw);
            products = ProductDAO.getProductsByBrand(brandId);
        }

        request.setAttribute("products", products);
        request.getRequestDispatcher("/category.jsp").forward(request, response);
    }
}

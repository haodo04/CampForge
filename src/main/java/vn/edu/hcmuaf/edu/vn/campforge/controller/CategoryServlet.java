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

        List<Product> products;

        // Nếu không có id => lấy tất cả sản phẩm
        if (cateIdRaw == null) {
            products = ProductDAO.getAllProducts();
        } else {
            int cateId = Integer.parseInt(cateIdRaw);
            products = ProductDAO.getProductsByCategory(cateId);
        }

        request.setAttribute("products", products);
        request.getRequestDispatcher("/category.jsp").forward(request, response);
    }
}

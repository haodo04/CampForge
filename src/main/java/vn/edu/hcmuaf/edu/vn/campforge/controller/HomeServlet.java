package vn.edu.hcmuaf.edu.vn.campforge.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.hcmuaf.edu.vn.campforge.model.Product;
import vn.edu.hcmuaf.edu.vn.campforge.service.ProductService;

import java.io.IOException;
import java.util.List;

@WebServlet({"/", "/home"})
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Sản phẩm mới nhất
        List<Product> latestProducts = ProductService.getLatestProducts(8);

        // Sản phẩm bán chạy
        List<Product> bestSellerProducts = ProductService.getBestSellerProducts(8);

        request.setAttribute("latestProducts", latestProducts);
        request.setAttribute("bestSellerProducts", bestSellerProducts);

        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
}

package vn.edu.hcmuaf.edu.vn.campforge.controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;
import java.nio.file.*;

@WebServlet("/assets/img/products/*")
public class ProductImageServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String pathInfo = req.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/") || pathInfo.contains("..")) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        Path base = Paths.get(System.getProperty("catalina.base"), "campforge_uploads", "products");
        Path file = base.resolve(pathInfo.substring(1)).normalize();

        if (file.startsWith(base) && Files.exists(file) && Files.isRegularFile(file)) {
            String ct = Files.probeContentType(file);
            resp.setContentType(ct != null ? ct : "application/octet-stream");
            resp.setHeader("Cache-Control", "public, max-age=86400");
            try (OutputStream os = resp.getOutputStream()) {
                Files.copy(file, os);
            }
            return;
        }

        String resourcePath = "/assets/img/products" + pathInfo;
        try (InputStream is = getServletContext().getResourceAsStream(resourcePath)) {
            if (is == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }
            String ct = getServletContext().getMimeType(resourcePath);
            resp.setContentType(ct != null ? ct : "application/octet-stream");
            resp.setHeader("Cache-Control", "public, max-age=86400");
            try (OutputStream os = resp.getOutputStream()) {
                is.transferTo(os);
            }
        }
    }
}

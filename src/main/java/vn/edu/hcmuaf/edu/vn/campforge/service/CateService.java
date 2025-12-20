package vn.edu.hcmuaf.edu.vn.campforge.service;

import vn.edu.hcmuaf.edu.vn.campforge.dao.CategoryDAO;
import vn.edu.hcmuaf.edu.vn.campforge.model.Category;

import java.util.List;

public class CateService {
    public static List<Category> getFeaturedCategories() {
        return CategoryDAO.getFeaturedCategories(6);
    }
}

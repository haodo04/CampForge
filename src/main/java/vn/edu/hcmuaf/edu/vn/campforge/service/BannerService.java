package vn.edu.hcmuaf.edu.vn.campforge.service;

import vn.edu.hcmuaf.edu.vn.campforge.dao.BannerDAO;
import vn.edu.hcmuaf.edu.vn.campforge.model.Banner;

import java.util.List;
import java.util.Map;

public class BannerService {

    public static Map<String, Banner> getHomeBanners() {
        return BannerDAO.findActiveByPlacements(List.of(
                "home_hero",
                "home_intro",
                "home_brand",
                "home_promo",
                "home_spring",
                "home_season",
                "home_outdoor",
                "home_pinic"
        ));
    }
}

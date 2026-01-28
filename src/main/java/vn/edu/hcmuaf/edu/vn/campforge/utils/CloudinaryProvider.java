package vn.edu.hcmuaf.edu.vn.campforge.utils;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;

public final class CloudinaryProvider {
    private static Cloudinary cloudinary;

    private CloudinaryProvider() {}

    public static synchronized Cloudinary get() {
        if (cloudinary != null) return cloudinary;

        cloudinary = new Cloudinary(ObjectUtils.asMap(
                "cloud_name", AppProperties.require("cloudinary.cloud_name"),
                "api_key", AppProperties.require("cloudinary.api_key"),
                "api_secret", AppProperties.require("cloudinary.api_secret"),
                "secure", true
        ));
        return cloudinary;
    }
}

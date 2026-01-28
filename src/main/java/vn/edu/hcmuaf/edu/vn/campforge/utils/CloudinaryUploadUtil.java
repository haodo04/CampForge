package vn.edu.hcmuaf.edu.vn.campforge.utils;

import com.cloudinary.utils.ObjectUtils;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.io.InputStream;
import java.util.Map;

public final class CloudinaryUploadUtil {
    private CloudinaryUploadUtil() {}

    public static String uploadImage(Part part, String folder) throws IOException {
        if (part == null || part.getSize() <= 0) return null;

        String ct = part.getContentType();
        if (ct == null || !ct.toLowerCase().startsWith("image/")) {
            throw new IllegalArgumentException("File upload không phải ảnh hợp lệ.");
        }

        byte[] bytes;
        try (InputStream in = part.getInputStream()) {
            bytes = in.readAllBytes();
        }

        try {
            Map<?, ?> res = CloudinaryProvider.get().uploader().upload(
                    bytes,
                    ObjectUtils.asMap(
                            "folder", folder,
                            "resource_type", "image",
                            "unique_filename", true,
                            "overwrite", false
                    )
            );

            Object secureUrl = res.get("secure_url");
            if (secureUrl == null) throw new RuntimeException("Cloudinary thiếu secure_url");
            return secureUrl.toString();
        } catch (Exception e) {
            throw new IOException("Upload Cloudinary failed: " + e.getMessage(), e);
        }
    }
}

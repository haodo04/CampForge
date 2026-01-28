package vn.edu.hcmuaf.edu.vn.campforge.utils;

import java.io.InputStream;
import java.util.Properties;

public final class AppProperties {
    private static final Properties PROPS = new Properties();

    static {
        try (InputStream is = AppProperties.class.getClassLoader().getResourceAsStream("db.properties")) {
            if (is == null) throw new IllegalStateException("Không tìm thấy db.properties trong classpath.");
            PROPS.load(is);
        } catch (Exception e) {
            throw new RuntimeException("Load db.properties failed", e);
        }
    }

    private AppProperties() {}

    public static String get(String key) {
        String v = PROPS.getProperty(key);
        return v == null ? "" : v.trim();
    }

    public static String require(String key) {
        String v = get(key);
        if (v.isEmpty()) throw new IllegalStateException("Missing config: " + key);
        return v;
    }
}

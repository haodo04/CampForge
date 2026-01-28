package vn.edu.hcmuaf.edu.vn.campforge.model;

public enum UserRole {
    USER(0, "User"),
    ADMIN(1, "Admin");

    private final int code;
    private final String label;

    UserRole(int code, String label) {
        this.code = code;
        this.label = label;
    }

    public int getCode() { return code; }
    public String getLabel() { return label; }

    public static UserRole fromCode(int code) {
        for (UserRole r : values()) {
            if (r.code == code) return r;
        }
        return USER;
    }
}

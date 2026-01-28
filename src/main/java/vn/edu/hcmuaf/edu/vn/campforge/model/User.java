package vn.edu.hcmuaf.edu.vn.campforge.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class User implements Serializable {
    private int id;
    private String username;
    private String password;
    private String fullName;
    private String email;
    private String phone;
    private int role;
    private Timestamp createAt;
    private int isVerified;
    private String address;

    public User() {}

    public User(int id, String username, String password, String fullName, String email,
                String phone, int role, Timestamp createAt, String address) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.role = role;
        this.createAt = createAt;
        this.address = address;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public int getRole() { return role; }
    public void setRole(int role) { this.role = role; }

    public UserRole getRoleEnum() {
        return UserRole.fromCode(this.role);
    }

    public void setRoleEnum(UserRole roleEnum) {
        this.role = (roleEnum == null) ? UserRole.USER.getCode() : roleEnum.getCode();
    }

    public boolean isAdmin() {
        return getRoleEnum() == UserRole.ADMIN;
    }

    public String getRoleLabel() {
        return getRoleEnum().getLabel();
    }

    public Timestamp getCreateAt() { return createAt; }
    public void setCreateAt(Timestamp createAt) { this.createAt = createAt; }

    public int getIsVerified() { return isVerified; }
    public void setIsVerified(int isVerified) { this.isVerified = isVerified; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", fullName='" + fullName + '\'' +
                ", email='" + email + '\'' +
                ", role=" + role +
                ", roleEnum=" + getRoleEnum() +
                '}';
    }
}

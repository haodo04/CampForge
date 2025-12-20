package vn.edu.hcmuaf.edu.vn.campforge.dao.db;

import java.sql.*;

public class DbConnect {
    static String url = "jdbc:mysql://" + DbProperties.host() + ":" + DbProperties.port() + "/" +
            DbProperties.dbname() + "?" + DbProperties.option();

    static Connection conn;
    private static final ThreadLocal<Connection> threadLocal = new ThreadLocal<>();
    private static volatile boolean printed = false;

    public static Connection getConnection() {
        try {
            if (conn == null || conn.isClosed()) {
                conn = makeConnect();
                threadLocal.set(conn);

                if (!printed) {
                    printed = true;
                    System.out.println("DB connected.");
                }
            }
            return conn;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return null;
        }
    }

    private static Connection makeConnect() throws ClassNotFoundException, SQLException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(url, DbProperties.username(), DbProperties.password());
    }
}

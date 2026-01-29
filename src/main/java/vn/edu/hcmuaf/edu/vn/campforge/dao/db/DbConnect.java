package vn.edu.hcmuaf.edu.vn.campforge.dao.db;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import org.jdbi.v3.core.Jdbi;

import java.sql.Connection;
import java.sql.SQLException;

public class DbConnect {

    private static final HikariDataSource DATA_SOURCE;
    private static final Jdbi JDBI;

    static {
        HikariConfig cfg = new HikariConfig();

        cfg.setJdbcUrl(
                "jdbc:mysql://" +
                        DbProperties.host() + ":" +
                        DbProperties.port() + "/" +
                        DbProperties.dbname() + "?" +
                        DbProperties.option()
        );

        cfg.setUsername(DbProperties.username());
        cfg.setPassword(DbProperties.password());

        cfg.setMaximumPoolSize(10);
        cfg.setMinimumIdle(2);
        cfg.setConnectionTimeout(30000);
        cfg.setIdleTimeout(300000);
        cfg.setMaxLifetime(1800000);

        cfg.setDriverClassName("com.mysql.cj.jdbc.Driver");

        DATA_SOURCE = new HikariDataSource(cfg);

        JDBI = Jdbi.create(DATA_SOURCE);

        System.out.println("HikariCP pool initialized.");
    }

    public static Connection getConnection() throws SQLException {
        return DATA_SOURCE.getConnection();
    }

    public static Jdbi getJdbi() {
        return JDBI;
    }
}

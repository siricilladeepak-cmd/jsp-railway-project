package com.virtual;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    public static Connection getConnection() {
        Connection con = null;

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            String host = System.getenv("MYSQL_ADDON_HOST");

            if (host == null) {
                // Local database (Eclipse)
                con = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/virtual_lab",
                        "root",
                        "root"
                );
            } else {
                // Cloud database
                String db = System.getenv("MYSQL_ADDON_DB");
                String user = System.getenv("MYSQL_ADDON_USER");
                String password = System.getenv("MYSQL_ADDON_PASSWORD");
                String port = System.getenv("MYSQL_ADDON_PORT");

                String url = "jdbc:mysql://" + host + ":" + port + "/" + db;

                con = DriverManager.getConnection(url, user, password);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return con;
    }
}


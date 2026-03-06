package com.virtual;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    public static Connection getConnection() {
        Connection con = null;

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            String url = "jdbc:mysql://bu29wefvk7wf56njip0e-mysql.services.clever-cloud.com:3306/bu29wefvk7wf56njip0e";
            String user = "utf2zovxkquuz29a";
            String pass = "Db6QsS6e1MNbqof6qmw2";

            con = DriverManager.getConnection(url, user, pass);

            System.out.println("Connection successful");

        } catch (Exception e) {
            e.printStackTrace();
        }

        return con;
    }
}

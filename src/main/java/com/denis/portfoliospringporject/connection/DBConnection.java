package com.denis.portfoliospringporject.connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    public static Connection createConnection() throws  ClassNotFoundException, SQLException{
        System.out.println("Connection Call");

        Connection con = null;
        String url = "jdbc:mysql://eu-cdbr-west-03.cleardb.net/heroku_4d7afbd8f51c846";
        String username = "bb038e77878d8e";
        String password = "c55e3952";
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(url,username,password);

        return con;
    }
}

package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String URL = "jdbc:mysql://srv825.hstgr.io:3306/u737164144_bdexaFLORES";
    private static final String USER = "u737164144_victor";
    private static final String PASSWORD = "Victor88LM";
    
    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");  
            return DriverManager.getConnection(URL, USER, PASSWORD);  // Establecer la conexión
        } catch (ClassNotFoundException e) {
            throw new SQLException("No se encuentra el driver de MySQL", e);
        }
    } 
}

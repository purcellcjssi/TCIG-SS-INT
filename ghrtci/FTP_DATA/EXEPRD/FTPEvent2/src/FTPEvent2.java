import com.sun.source.tree.IfTree;

import java.io.File;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;

public class FTPEvent2 {
    public static void main(String [] args){
        File temp;
        String url = "jdbc:sqlserver://BAYLEAF:1433;databaseName=DBShrpn";
        //String url = "jdbc:sqlserver://APPSRV:1433;databaseName=DBShrpn";
        String user = "DBS";        String password =   "password";

        try {
            File tempFile = new File("C:\\FTP_Data\\Data\\DEV\\Interface.txt");
            boolean exists = tempFile.exists();

            if (exists == true) {
                Connection connection = DriverManager.getConnection(url, user, password);
                CallableStatement myStmt = connection.prepareCall("gsp_interface_event");
                myStmt.execute();
                myStmt.close();
                System.out.println("Successfully connected 1");
            }
        } //End of Try
        catch (Exception e){
            System.out.println("Error when connecting to MS SQL");
            e.printStackTrace();
        }

    }  //End of main
}  // End of Class

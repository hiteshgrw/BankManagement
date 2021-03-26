package prepackage;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
public class ConnectionProvider {
    public static Connection getconn() throws ClassNotFoundException, SQLException
    {
        String dbdriver = "org.postgresql.Driver";
        String dbusername = "fzdafijwblwxaq";
        String dbpassword = "a0a41ce68a401547f06b91e63328d8c11dd71a1dfe1eea6be5fb2c68ed5cf537";
        String dburl = "jdbc:postgresql://ec2-54-146-73-98.compute-1.amazonaws.com:5432/d60ahip3jgvr3b";
        if(dbdriver.isEmpty() || dburl.isEmpty())
            return null;
        else{
            Class.forName(dbdriver);
            Connection conn = DriverManager.getConnection(dburl,dbusername,dbpassword);
            return conn;
            }
    }
}

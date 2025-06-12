package conn.dao;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
public class Dbconnection  {
		private static final String url="jdbc:mysql://localhost:3306/hackathonproject";
		private static final String user="root";
		private static final String pass="root";
	public static Connection getconnection() {
		Connection conn=null;
	    try{
	    	Class.forName("com.mysql.cj.jdbc.Driver");
	        conn=DriverManager.getConnection(url,user,pass);
	        System.out.println("connected successfully");
	    
	}
	    catch(ClassNotFoundException e) {
	    	e.printStackTrace();
	    }
	catch(SQLException e){
	System.out.println("Database connection failed" );
	return null;
	}
	    return conn;
	}
	

	}

package conn.dao;
import java.sql.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class Daomethodsimpl implements Daomethods{
public  boolean createuser(String name,String email,String phonenumber,String dateofbirth,String password){
	String query="Insert into users(name,email,phonenumber,dateofbirth,password) values (?,?,?,?,?)";
	try(Connection conn=Dbconnection.getconnection()){
		PreparedStatement pt=conn.prepareStatement(query);
		pt.setString(1,name);
		pt.setString(2, email);
		pt.setString(3, phonenumber);
		pt.setString(4, dateofbirth);
		pt.setString(5, password);
		
		int rs=pt.executeUpdate();
		
		System.out.println("user created successfully");
		return true;
		
	}
	catch(SQLException E) {
		E.printStackTrace();
		
	}
	return false;
	
}
public boolean validuser(String email,String password) {
		String query="select * from users where email=? and password=?";
		
		try(Connection conn=Dbconnection.getconnection();) {
			PreparedStatement pt=conn.prepareStatement(query);
			pt.setString(1, email);
			pt.setString(2, password);
			ResultSet rs=pt.executeQuery();
			return rs.next();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}return false;
		
	}
}

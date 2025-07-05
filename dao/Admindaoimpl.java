package conn.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.mindrot.jbcrypt.BCrypt;
import java.sql.*;
public class Admindaoimpl {
	public boolean validadmin(String email,String password) {
		 String storedHash = null;

			String query="select password from admins where email=?";
			
			try(Connection conn=Dbconnection.getconnection();) {
				PreparedStatement pt=conn.prepareStatement(query);
				pt.setString(1, email);
				
				ResultSet rs=pt.executeQuery();
				if(rs.next()) {
					storedHash=rs.getString("password");
				}
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}return storedHash!=null &&BCrypt.checkpw(password,storedHash);
			
	
}
	public int getadminidbyemail(String email) {
		try(Connection conn=Dbconnection.getconnection()){
			PreparedStatement pt=conn.prepareStatement("select admin_id from admins where email=?");
			pt.setString(1, email);
			ResultSet rs = pt.executeQuery();
	        if (rs.next()) {
	            return rs.getInt("admin_id"); 
	        }

		} catch (SQLException e) {
			
			e.printStackTrace();
		}return 0;
	}
	
	public String getAdminnameByEmail(String email) {
	    String name = null;
	    try (Connection con = Dbconnection.getconnection();
	         PreparedStatement ps = con.prepareStatement("SELECT name FROM admins WHERE email = ?")) {
	        ps.setString(1, email);
	        ResultSet rs = ps.executeQuery();
	        if (rs.next()) {
	            name = rs.getString("name");
	        }
	    } catch (Exception e) {
	        e.printStackTrace(); 
	    }
	    return name;
	}
	public int getgithubcount() {
		String query="select count(github_url) from project;";
		try(Connection conn=Dbconnection.getconnection()){
			Statement st=conn.createStatement();
			ResultSet rs=st.executeQuery(query);
			if(rs.next()) {
			return rs.getInt(1);	}
		} catch (SQLException e) {
			
			e.printStackTrace();
		}return 0;
	}
	public int getwordcount() {
		String query="select count(filename) from project;";
		try(Connection conn=Dbconnection.getconnection()){
			Statement st=conn.createStatement();
			ResultSet rs=st.executeQuery(query);
			if(rs.next()) {
			return rs.getInt(1);	}
		} catch (SQLException e) {
			
			e.printStackTrace();
		}return 0;
	}
	public int gettotalregister() {
		String query="select count(sid) from users;";
		try(Connection conn=Dbconnection.getconnection()){
			Statement st=conn.createStatement();
			ResultSet rs=st.executeQuery(query);
			if(rs.next()) {
			return rs.getInt(1);	}
		} catch (SQLException e) {
			
			e.printStackTrace();
		}return 0;
	}
	public int getprojectcount() {
		String query="select count(pid) from project;";
		try(Connection conn=Dbconnection.getconnection()){
			Statement st=conn.createStatement();
			ResultSet rs=st.executeQuery(query);
			if(rs.next()) {
			return rs.getInt(1);	}
		} catch (SQLException e) {
			
			e.printStackTrace();
		}return 0;
	}
	public int getprojectdocscount() {
		String query="select count(*) from project where github_submitted is true and docs_submitted is true;";
		try(Connection conn=Dbconnection.getconnection()){
			Statement st=conn.createStatement();
			ResultSet rs=st.executeQuery(query);
			if(rs.next()) {
			return rs.getInt(1);	}
		} catch (SQLException e) {
			
			e.printStackTrace();
		}return 0;
	}

}

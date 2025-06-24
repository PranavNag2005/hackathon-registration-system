package conn.dao;
import java.sql.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

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
public boolean forgotpassword(String email,String password) {
	
	String query="update users set password=? where email=?";
	try(Connection conn=Dbconnection.getconnection();){
		PreparedStatement pt=conn.prepareStatement(query);
		pt.setString(1,password);
		pt.setString(2, email);
		int rs=pt.executeUpdate();
		return true;
	} catch (SQLException e) {
		
		e.printStackTrace();
	}return false;
}
public boolean validemail(String email) {
	String query="select * from users where email=?";
	try(Connection conn=Dbconnection.getconnection()){
		PreparedStatement pt=conn.prepareStatement(query);
		pt.setString(1, email);
		ResultSet rs=pt.executeQuery();
		return rs.next();
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}return false;
}
public String getUsernameByEmail(String email) {
    String name = null;
    try (Connection con = Dbconnection.getconnection();
         PreparedStatement ps = con.prepareStatement("SELECT name FROM users WHERE email = ?")) {
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
public boolean updatepassword(String email,String password)  {
	try(Connection conn=Dbconnection.getconnection()){
		PreparedStatement pt=conn.prepareStatement("update users set password=? where email=?");
		pt.setString(1, password);
		pt.setString(2, email);
		int rs=pt.executeUpdate();
		return true;
	}
	catch(Exception e) {
		e.printStackTrace();
	}
	return false;
}
public int getuseridbyemail(String email) {
	try(Connection conn=Dbconnection.getconnection()){
		PreparedStatement pt=conn.prepareStatement("select sid from users where email=?");
		pt.setString(1, email);
		ResultSet rs = pt.executeQuery();
        if (rs.next()) {
            return rs.getInt("sid"); 
        }

	} catch (SQLException e) {
		
		e.printStackTrace();
	}return 0;
}
public boolean projectdetails(int sid,String title,String domain,String description,String techstack) {
	try(Connection conn =Dbconnection.getconnection()){
		
String query="INSERT INTO project(sid, project_title, project_domain, project_description,technology_stack)VALUES (?, ?, ?, ?, ?)";
PreparedStatement pt=conn.prepareStatement(query);
pt.setInt(1, sid);
pt.setString(2, title);
pt.setString(3, domain);
pt.setString(4, description);
pt.setString(5, techstack);
int row=pt.executeUpdate();
return row>0;
	} catch (SQLException e) {
		
		e.printStackTrace();
	}return false;
}
public boolean projectexists(int sid) {
	try(Connection conn=Dbconnection.getconnection())
{
		PreparedStatement pt=conn.prepareStatement("select * from project where sid=?");
		pt.setInt(1, sid);
		ResultSet rs= pt.executeQuery();
		return rs.next();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}return false;
}
public Project getProjectBySid(int sid) {
    Project project = null;
    try (Connection conn = Dbconnection.getconnection()) {
        PreparedStatement ps = conn.prepareStatement("SELECT * FROM project WHERE sid = ?");
        ps.setInt(1, sid);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            project = new Project();
            project.setTitle(rs.getString("title"));
            project.setDomain(rs.getString("domain"));
            project.setDescription(rs.getString("description"));
            project.setTechStack(rs.getString("techstack"));
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return project;
}
public boolean updateprojectdetails(int sid,String title,String domain,String description,String techstack) {
	try(Connection conn =Dbconnection.getconnection()){
		
String query="update project set sid=?, project_title=?, project_domain=?, project_description=?,technology_stack=? where sid=?";
PreparedStatement pt=conn.prepareStatement(query);
pt.setInt(1, sid);
pt.setString(2, title);
pt.setString(3, domain);
pt.setString(4, description);
pt.setString(5, techstack);
int row=pt.executeUpdate();
return row>0;
	} catch (SQLException e) {
		
		e.printStackTrace();
	}return false;
}
}

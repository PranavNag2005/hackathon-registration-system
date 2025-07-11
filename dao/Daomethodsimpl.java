package conn.dao;
import java.sql.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.mindrot.jbcrypt.BCrypt;
public class Daomethodsimpl implements Daomethods{
public  boolean createuser(String name,String email,String phonenumber,String dateofbirth,String password,String rollnumber,String branch,String year,String clgname){
	String query="Insert into users(name,email,phonenumber,dateofbirth,password,roll_number,branch,year_of_study,college_name) values (?,?,?,?,?,?,?,?,?)";
	try(Connection conn=Dbconnection.getconnection()){
		PreparedStatement pt=conn.prepareStatement(query);
		pt.setString(1,name);
		pt.setString(2, email);
		pt.setString(3, phonenumber);
		pt.setString(4, dateofbirth);
		pt.setString(5, password);
		pt.setString(6, rollnumber);
		pt.setString(7, branch);
		pt.setString(8, year);
		pt.setString(9, clgname);
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
	 String storedHash = null;

		String query="select password from users where email=?";
		
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
            project.setTitle(rs.getString("project_title"));
            project.setDomain(rs.getString("project_domain"));
            project.setDescription(rs.getString("project_description"));
            project.setTechStack(rs.getString("technology_stack"));
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return project;
}
public boolean updateprojectdetails(int sid,String title,String domain,String description,String techstack) {
	try(Connection conn =Dbconnection.getconnection()){
		
String query="update project set  project_title=?, project_domain=?, project_description=?,technology_stack=? where sid=?";
PreparedStatement pt=conn.prepareStatement(query);
pt.setInt(5, sid);
pt.setString(1, title);
pt.setString(2, domain);
pt.setString(3, description);
pt.setString(4, techstack);
int row=pt.executeUpdate();
return row>0;
	} catch (SQLException e) {
		
		e.printStackTrace();
	}return false;
}
public boolean updategithub(int sid,String url) {
	String query="update project set github_url=?,github_submitted=true where sid=?";
	try(Connection conn=Dbconnection.getconnection()){
		PreparedStatement pt=conn.prepareStatement(query);
		pt.setString(1, url);
		pt.setInt(2, sid);
		int rs=pt.executeUpdate();
		if(rs>0) {
			return true;
		}
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}return false;
}
public void logactivity(int userid,String activitytype,String details) {
	String sql="insert into useractivities(user_id,activity_type,activity_details) values(?,?,?)";
	try(Connection conn=Dbconnection.getconnection()){
		PreparedStatement pt=conn.prepareStatement(sql);
		pt.setInt(1, userid);
		pt.setString(2, activitytype);
		pt.setString(3, details);
		int rs=pt.executeUpdate();
	} catch (SQLException e) {
		
		e.printStackTrace();
	}
}


public List<Activity> getUserActivities(int userId) {
 List<Activity> activities = new ArrayList<>();
 String sql = "SELECT * FROM useractivities WHERE user_id = ? ORDER BY activity_date DESC LIMIT 5";
 
 try (Connection conn = Dbconnection.getconnection();
      PreparedStatement pstmt = conn.prepareStatement(sql)) {
     pstmt.setInt(1, userId);
     ResultSet rs = pstmt.executeQuery();
     
     while (rs.next()) {
         Activity activity = new Activity();
         activity.setActivityId(rs.getInt("activity_id"));
         activity.setUserId(rs.getInt("user_id"));
         activity.setActivityType(rs.getString("activity_type"));
         activity.setActivityDetails(rs.getString("activity_details"));
         activity.setActivityDate(rs.getTimestamp("activity_date"));
         activities.add(activity);
     }
 } catch (SQLException e) {
     e.printStackTrace();
 }
 return activities;
}
public boolean insertdocument(int sid,String filename,String filepath,String filetype,boolean docs_submitted) {
	String query="update project set filename=?,filepath=?,filetype=?,docs_submitted=true where sid=? ";
	try(Connection conn=Dbconnection.getconnection()){
		PreparedStatement pt=conn.prepareStatement(query);
		pt.setInt(4, sid);
		pt.setString(1, filename);
		pt.setString(2, filepath);
		pt.setString(3,filetype);
		int rs=pt.executeUpdate();
		if(rs>0) {
			return true;
		}
		
	} catch (SQLException e) {
		
		e.printStackTrace();
	}return false;
}
}

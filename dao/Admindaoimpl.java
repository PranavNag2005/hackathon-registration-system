package conn.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mindrot.jbcrypt.BCrypt;

import conn.servlet.ProjectInfo;
import conn.servlet.TopProjectinfo;
import conn.servlet.Users;

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
	public boolean updatepassword(String email,String password) {
		try(Connection conn=Dbconnection.getconnection()){
			String query="update admins set password=? where email=?";
			PreparedStatement pt=conn.prepareStatement(query);
			pt.setString(1, password);
			pt.setString(2, email);
			pt.executeUpdate();
			System.out.println("hello world");
			return true;
			} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}return false;
	}
	public boolean validemail(String email) {
		String query="select * from admins where email=?";
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
	public List<Users> viewUsers() {
	    List<Users> userList = new ArrayList<>();

	    String query = "SELECT name, email, phonenumber, dateofbirth FROM users";

	    try (Connection conn = Dbconnection.getconnection()) {
	        Statement st = conn.createStatement();
	        ResultSet rs = st.executeQuery(query);

	        System.out.println("User query executed");

	        while (rs.next()) {
	            Users user = new Users();
	            user.setName(rs.getString("name"));
	            user.setEmail(rs.getString("email"));
	            user.setPhoneNumber(rs.getString("phonenumber"));
	            user.setDateOfBirth(rs.getDate("dateofbirth"));

	            userList.add(user);
	        }

	    } catch (SQLException e) {
	        System.out.println("Error fetching users: " + e.getMessage());
	        e.printStackTrace();
	    }

	    return userList;
	}
	public List<ProjectInfo> viewProjects() {
	    List<ProjectInfo> projectList = new ArrayList<>();

	    String query = "SELECT u.name, u.email, p.pid, p.project_title, p.project_domain, " +
	                   "p.project_description, p.technology_stack, p.github_url, p.filepath " +
	                   "FROM users u JOIN project p ON u.sid = p.sid";

	    try (Connection conn = Dbconnection.getconnection()) {
	        Statement st = conn.createStatement();
	        ResultSet rs = st.executeQuery(query);

	        System.out.println("Project view query executed");

	        while (rs.next()) {
	            ProjectInfo proj = new ProjectInfo();
	            proj.setName(rs.getString("name"));
	            proj.setEmail(rs.getString("email"));
	            proj.setPid(rs.getInt("pid"));
	            proj.setProjectTitle(rs.getString("project_title"));
	            proj.setProjectDomain(rs.getString("project_domain"));
	            proj.setProjectDescription(rs.getString("project_description"));
	            proj.setTechnologyStack(rs.getString("technology_stack"));
	            proj.setGithubUrl(rs.getString("github_url"));
	            proj.setFilepath(rs.getString("filepath"));

	            projectList.add(proj);
	        }

	    } catch (SQLException e) {
	        System.out.println("Error fetching projects: " + e.getMessage());
	        e.printStackTrace();
	    }

	    return projectList;
	}
public  void insertratings(String ratevalue,String comment,String adminname,String pid) {
	String query="insert into ratings(pid,rating,comment,rated_by)values(?,?,?,?)";
	try(Connection conn=Dbconnection.getconnection()){
		PreparedStatement pt=conn.prepareStatement(query);
		pt.setString(1,pid);
		pt.setString(2, ratevalue);
		pt.setString(3,comment);
		pt.setString(4,adminname);
		int rs=pt.executeUpdate();
		
	} catch (SQLException e) {
		
		e.printStackTrace();
	}
	
}
public static boolean checkRatingExists(int pid, String adminName) {
    String query = "SELECT 1 FROM ratings WHERE pid = ? AND rated_by = ?";
    try (Connection conn = Dbconnection.getconnection();
         PreparedStatement ps = conn.prepareStatement(query)) {
        ps.setInt(1, pid);
        ps.setString(2, adminName);
        
        ResultSet rs = ps.executeQuery();
        return rs.next(); // true if this admin already rated this project
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}
public List<TopProjectinfo> getTopRatedProjects() {
    List<TopProjectinfo> list = new ArrayList<>();
    String sql = "SELECT p.pid, p.project_title, s.name, ROUND(AVG(r.rating), 2) AS avg_rating, COUNT(r.rated_by) AS total_raters " +
                 "FROM project p JOIN ratings r ON p.pid = r.pid " +
                 "JOIN users s ON p.sid = s.sid " +
                 "GROUP BY p.pid, p.project_title, s.name " +
                 "ORDER BY avg_rating DESC";

    try (Connection con = Dbconnection.getconnection();
         PreparedStatement ps = con.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {

        while (rs.next()) {
            TopProjectinfo info = new TopProjectinfo();
            info.setPid(rs.getInt("pid"));
            info.setProjectTitle(rs.getString("project_title"));
            info.setStudentName(rs.getString("name"));
            info.setAvgRating(rs.getDouble("avg_rating"));
            info.setTotalRaters(rs.getInt("total_raters"));
            list.add(info);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}
public Map<String, Integer> getRatingStatusByAdmin(String Adminname) {
    Map<String, Integer> statusMap = new HashMap<>();

    String ratedSql = "SELECT COUNT(*) FROM ratings WHERE rated_by = ?";
    String totalSql = "SELECT COUNT(*) FROM project";

    try (Connection con = Dbconnection.getconnection()) {
        // Rated count
        try (PreparedStatement ps = con.prepareStatement(ratedSql)) {
            ps.setString(1, Adminname);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                statusMap.put("rated", rs.getInt(1));
            }
        }

        // Total projects
        try (PreparedStatement ps2 = con.prepareStatement(totalSql)) {
            ResultSet rs2 = ps2.executeQuery();
            if (rs2.next()) {
                statusMap.put("total", rs2.getInt(1));
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    int rated = statusMap.getOrDefault("rated", 0);
    int total = statusMap.getOrDefault("total", 0);
    statusMap.put("pending", total - rated);

    return statusMap;
}
}

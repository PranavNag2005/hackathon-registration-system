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

import conn.servlet.Eventconfig;
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

	    String query = "SELECT name, email, phonenumber, dateofbirth,college_name,branch,year_of_study FROM users";

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
	            user.setCollegeName(rs.getString("college_name"));
	            user.setBranch(rs.getString("branch"));
	            user.setYearOfStudy(rs.getString("year_of_study"));	
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
public List<Users> getUsersByFilters(String branch, String college, String year) {
    List<Users> filteredList = new ArrayList<>();

    StringBuilder query = new StringBuilder("SELECT * FROM users WHERE 1=1");
    List<Object> params = new ArrayList<>();

    if (branch != null && !branch.isEmpty()) {
        query.append(" AND branch = ?");
        params.add(branch);
    }
    if (college != null && !college.isEmpty()) {
        query.append(" AND college_name LIKE ?");
        params.add("%" + college + "%");
    }
    if (year != null && !year.isEmpty()) {
        query.append(" AND year_of_study = ?");
        params.add(Integer.parseInt(year));
    }

    try (Connection conn = Dbconnection.getconnection();
         PreparedStatement pst = conn.prepareStatement(query.toString())) {

        for (int i = 0; i < params.size(); i++) {
            pst.setObject(i + 1, params.get(i));
        }

        ResultSet rs = pst.executeQuery();
        while (rs.next()) {
            Users user = new Users();
            // Populate all fields from result set
            filteredList.add(user);
        }

    } catch (SQLException e) {
        e.printStackTrace();
    }

    return filteredList;
}
public Eventconfig getEventConfig() {
    Eventconfig config = new Eventconfig();
    String query = "SELECT * FROM eventconfig ORDER BY id DESC LIMIT 1";

    try (Connection conn = Dbconnection.getconnection();
         PreparedStatement pst = conn.prepareStatement(query);
         ResultSet rs = pst.executeQuery()) {

        if (rs.next()) {
            config.setRegistrationDeadline(rs.getTimestamp("registration_deadline"));
            config.setSubmissionDeadline(rs.getTimestamp("submission_deadline"));
            config.setResultsDeclaration(rs.getTimestamp("results_declaration"));
            config.setEventStatus(rs.getString("event_status"));
        }

    } catch (SQLException e) {
        e.printStackTrace();
    }

    return config;
}
public boolean allProjectsRatedByAllAdmins() {
    String sql = "SELECT COUNT(DISTINCT admin_id) AS total_admins FROM Admins";
    String sql2 = "SELECT COUNT(DISTINCT pid) AS total_projects FROM project";
    String sql3 = "SELECT COUNT(*) FROM ratings";

    try (Connection con = Dbconnection.getconnection()) {
        int totalAdmins = 0;
        int totalProjects = 0;
        int totalRatings = 0;

        // Count admins
        try (PreparedStatement ps1 = con.prepareStatement(sql);
             ResultSet rs1 = ps1.executeQuery()) {
            if (rs1.next()) totalAdmins = rs1.getInt(1);
        }

        // Count projects
        try (PreparedStatement ps2 = con.prepareStatement(sql2);
             ResultSet rs2 = ps2.executeQuery()) {
            if (rs2.next()) totalProjects = rs2.getInt(1);
        }

        // Count total ratings
        try (PreparedStatement ps3 = con.prepareStatement(sql3);
             ResultSet rs3 = ps3.executeQuery()) {
            if (rs3.next()) totalRatings = rs3.getInt(1);
        }

        // Return true if all projects rated by all admins
        return totalRatings >= totalAdmins * totalProjects;
    } catch (Exception e) {
        e.printStackTrace();
        return false;
    }
}
public void contactquery(String name,String email,String subject,String message) {
	String query="insert into contactqueries(name,email,subject,message) values (?,?,?,?)";
	try(Connection conn=Dbconnection.getconnection()){
		PreparedStatement pt=conn.prepareStatement(query);
		pt.setString(1, name);
		pt.setString(2, email);
		pt.setString(3, subject);
		pt.setString(4, message);
		int rs=pt.executeUpdate();
	} catch (SQLException e) {
		
		e.printStackTrace();
	}
}
public boolean checkAdminAccess(int adminId) throws SQLException {
    String sql = "SELECT specialaccess FROM admins WHERE admin_id = ?";
    try(Connection conn=Dbconnection.getconnection()){
    	PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, adminId);
        ResultSet rs = ps.executeQuery();
        return rs.next() && rs.getBoolean("specialaccess");
    }
    catch(SQLException e) {
    	e.printStackTrace();
    	return false;
    }
    
}
}

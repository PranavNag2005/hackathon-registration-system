	package conn.servlet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import conn.dao.Admindaoimpl;
import conn.dao.CaptchaVerifier;
import conn.dao.Dbconnection;
import java.sql.*;
import java.util.*;
@WebServlet("/AdminServlet")
public class AdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
     Admindaoimpl dao=new Admindaoimpl();
     
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
		
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email=request.getParameter("email");
		String password=request.getParameter("password");
		String gRecaptchaResponse = request.getParameter("g-recaptcha-response");
		boolean isCaptchaValid = CaptchaVerifier.verifyCaptcha(gRecaptchaResponse);
		if (!isCaptchaValid) {
	        response.sendRedirect("adminlogin.jsp?error=Captcha failed"); // Notify user of CAPTCHA failure
	        return; // Stop further execution
	    }
		if(isCaptchaValid) {
			if(dao.validadmin(email, password)) {
				HttpSession session=request.getSession();
			 	 String name = dao.getAdminnameByEmail(email);
			 	
				 int sid=dao.getadminidbyemail(email);
				 session.setAttribute("admin_id", sid);
				session.setAttribute("email", email);
				session.setAttribute("name", name);
				int githubcount=dao.getgithubcount();
				int doccount=dao.getwordcount();
				int both=dao.getprojectdocscount();
				int registered=dao.gettotalregister();
				int project=dao.getprojectcount();
				session.setAttribute("githubCount", githubcount);
				session.setAttribute("docCount", doccount);
				session.setAttribute("bothCount", both);
				session.setAttribute("registeredCount", registered);
				session.setAttribute("projectsubmitted",project);
				String query="SELECT project_domain, COUNT(*) AS total_count FROM project GROUP BY project_domain;";
				try(Connection connn=Dbconnection.getconnection()){
					
					Statement st=connn.createStatement();
					ResultSet rs=st.executeQuery(query);
					while (rs.next()) {
		                String domain = rs.getString("project_domain");
		                int count = rs.getInt("total_count");

		                switch (domain) {
		                    case "Web Development":
		                    	System.out.println("WEb"+count);
		                        session.setAttribute("webDevCount", count);
		                        break;
		                    case "AI & ML":
		                    	session.setAttribute("aiCount", count);
		                    	System.out.println("ai"+count);
		                        break;
		                    case "CloudComputing":
		                    	session.setAttribute("cloudCount", count);
		                    	System.out.println("clo"+count);
		                        break;
		                    case "IOT Solutions":
		                    	session.setAttribute("iotCount", count);
		                        break;
		                    case "Game Dev":
		                    	session.setAttribute("gameDevCount", count);
		                        break;
		                    case "Mobile App Dev":
		                    	session.setAttribute("mobileCount", count);
		                        break;
		                    case "Sensor-Based Applications":
		                    	session.setAttribute("sensorCount", count);
		                        break;
		                    case "Data Science":
		                    	session.setAttribute("dataScienceCount", count);
		                        break;
		                    default:
		                        break;
		                }
		                Map<String, Integer> chartData = dao.getRatingStatusByAdmin(name);
		                session.setAttribute("rated", chartData.get("rated"));
		        		session.setAttribute("pending", chartData.get("pending"));
		            }
					
				} catch (SQLException e) {
					
					e.printStackTrace();
				}
				response.sendRedirect("admindashboard.jsp");
			}
			else {
				response.sendRedirect("adminlogin.jsp?invalidpassword=0");
			}
		}
	}

}

package conn.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import conn.dao.Daomethodsimpl;

/**
 * Servlet implementation class Githubservlet
 */
@WebServlet("/Githubservlet")
public class Githubservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
     Daomethodsimpl dao=new Daomethodsimpl();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Githubservlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession s=request.getSession(false);
		if (s == null || s.getAttribute("sid") == null) {
		    response.sendRedirect("login.jsp");
		    return;
		}
		int sid=(int)s.getAttribute("sid");
		String githuburl= request.getParameter("githubUrl");
		String pattern = "^(https?:\\/\\/)?(www\\.)?github\\.com\\/[\\w.-]+\\/[\\w.-]+\\/?$";


		System.out.println(githuburl);	
		String activityType,activityMessage;
		if(githuburl.matches(pattern)) {
			
		
		boolean success=dao.updategithub(sid, githuburl);
		
		if(success) {
			activityType="GITHUB_UPDATE";
			activityMessage="github link updated successfully";
			dao.logactivity(sid, activityType, activityMessage);
			response.sendRedirect("welcome.jsp");
		}
		}
		else {
			activityType="GITHUB_UPDATE";
			activityMessage="github link failed to update it does not match";
			dao.logactivity(sid, activityType, activityMessage);
			response.sendRedirect("welcome.jsp");
			
		}
		}

}

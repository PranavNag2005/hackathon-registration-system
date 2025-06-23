package conn.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import conn.dao.Daomethodsimpl;
import conn.dao.Project;

/**
 * Servlet implementation class Projectservlet
 */
@WebServlet("/Projectservlet")
public class Projectservlet extends HttpServlet {
	Daomethodsimpl dao=new Daomethodsimpl();
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Projectservlet() {
        super();
        // TODO Auto-generated constructor stub
    }
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession s=request.getSession(false);
		if (s == null || s.getAttribute("sid") == null) {
		    response.sendRedirect("login.jsp");
		    return;
		}
		int sid=(int)s.getAttribute("sid");
		String title=request.getParameter("title");
		String domain=request.getParameter("domain");
		String description=request.getParameter("description");
		String techstack=request.getParameter("techstack");
		boolean exists=dao.projectexists(sid);
		boolean success;
		if(exists) {
			 success=dao.updateprojectdetails(sid, title, domain, description, techstack);
		}else {
			
		
		 success=dao.projectdetails(sid, title, domain, description, techstack);
		}
		if(success) {
			s.setAttribute("projectupdated", true);
			response.sendRedirect("welcome.jsp");
		}
		else {
			response.sendRedirect("project.jsp");
		}
		
	}

}

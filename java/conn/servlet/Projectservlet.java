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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession s = request.getSession(false);
        if (s == null || s.getAttribute("sid") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        int sid = (int) s.getAttribute("sid");
        Project proj = dao.getProjectBySid(sid); // You'll need to implement this method
        if (proj != null) {
            request.setAttribute("project", proj);
            request.setAttribute("mode", "edit");

        }else {
        	
        	    request.setAttribute("mode", "new");
        	

        }
        request.getRequestDispatcher("project.jsp").forward(request, response);
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
		String activityType;
		String activityMessage;
		boolean exists=dao.projectexists(sid);
		boolean success;
		if(exists) {
			 success=dao.updateprojectdetails(sid, title, domain, description, techstack);
			 activityType="PROJECT_EDIT";
			 activityMessage="project updated successfully";
		}else {
			
		
		 success=dao.projectdetails(sid, title, domain, description, techstack);
		 activityType="PROJECT_CREATE";
		 activityMessage="project created successfully";
		}
		if (success) {
			dao.logactivity(sid, activityType, activityMessage);
		    s.setAttribute("projectupdated", true);
		    s.setAttribute("successMessage", "Project details saved successfully!");
		    response.sendRedirect("welcome.jsp");
		}
		else {
			response.sendRedirect("Projectservlet");
		}
		
	}

}

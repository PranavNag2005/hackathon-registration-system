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
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        // ✅ Check if session is valid
        if (session == null || session.getAttribute("sid") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // ✅ Retrieve sid and fetch project
        int sid = (int) session.getAttribute("sid");
        System.out.println("SID from session: " + sid);

        Project project = dao.getProjectBySid(sid);

        // ✅ Log what we received from DB
        if (project != null) {
            System.out.println("From Servlet → Title: " + project.getTitle());
        } else {
            System.out.println("No project found for sid: " + sid);
        }

        // ✅ Send project to JSP for pre-filling the form
        request.setAttribute("project", project);
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

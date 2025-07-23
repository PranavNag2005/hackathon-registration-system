package conn.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import conn.dao.Admindaoimpl;


@WebServlet("/Eventservlet")
public class Eventservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Admindaoimpl dao=new Admindaoimpl();
       
    
    public Eventservlet() {
        super();
       
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Event event = dao.getSingleEvent(); 
        if (event != null) {
            request.setAttribute("event", event);
            request.setAttribute("isUpdate", true);
        } else {
            request.setAttribute("isUpdate", false);
        }
        request.getRequestDispatcher("eventdetails.jsp").forward(request, response);
    }
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");

	    if ("delete".equalsIgnoreCase(action)) {
	        dao.deleteEvent(); // Create this method in DAO
	        response.sendRedirect("admindashboard.jsp");
	        return;
	    }

		
		String eventname=request.getParameter("eventName");
		String eventcode=request.getParameter("eventCode");
		String regdeadline=request.getParameter("regDeadline");
		String subdeadline=request.getParameter("subDeadline");
		String eventstatus=request.getParameter("status");
		String resultdate=request.getParameter("resultDate");
		String notes=request.getParameter("notes");
		boolean eventExists = dao.hasevent(); 

	    if (eventExists) {
	    	dao.updateeventconfig(regdeadline,subdeadline,resultdate,eventstatus,eventname,eventcode,notes);
	    } else {
	    	dao.eventconfig(regdeadline,subdeadline,resultdate,eventstatus,eventname,eventcode,notes);
	    }


		
		response.sendRedirect("admindashboard.jsp");
	}

}

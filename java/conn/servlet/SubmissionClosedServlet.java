package conn.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import conn.dao.Admindaoimpl;

/**
 * Servlet implementation class SubmissionClosedServlet
 */
@WebServlet("/SubmissionClosedServlet")
public class SubmissionClosedServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SubmissionClosedServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Admindaoimpl dao = new Admindaoimpl();
        Eventconfig config = dao.getEventConfig();

        if (config != null) {
            
            request.setAttribute("SubmissionDeadline", config.getSubmissionDeadline());
        }
        request.getRequestDispatcher("submissionClosed.jsp").forward(request, response);

	}

	

}

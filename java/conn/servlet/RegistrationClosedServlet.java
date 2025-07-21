package conn.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import conn.dao.Admindaoimpl;

/**
 * Servlet implementation class RegistrationClosedServlet
 */
@WebServlet("/RegistrationClosedServlet")
public class RegistrationClosedServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegistrationClosedServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 Admindaoimpl dao = new Admindaoimpl();
	        Eventconfig config = dao.getEventConfig();

	        if (config != null) {
	            
	            request.setAttribute("RegistrationDeadline", config.getRegistrationDeadline());
	        }
	        request.getRequestDispatcher("registrationClosed.jsp").forward(request, response);

	}

	

}

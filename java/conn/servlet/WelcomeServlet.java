package conn.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.Duration;
import java.time.LocalDateTime;

import conn.dao.Admindaoimpl;

/**
 * Servlet implementation class WelcomeServlet
 */
@WebServlet("/WelcomeServlet")
public class WelcomeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public WelcomeServlet() {
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
            request.setAttribute("submissionDeadline", config.getSubmissionDeadline());
        }
        System.out.println("Event status: " + config.getEventStatus());
        System.out.println("All rated: " + dao.allProjectsRatedByAllAdmins());
        System.out.println("Submission time: " + config.getSubmissionDeadline());
        System.out.println("Results declaration: " + config.getResultsDeclaration());


        boolean showResults = false;
        if (config != null
            && "closed".equalsIgnoreCase(config.getEventStatus())
            && dao.allProjectsRatedByAllAdmins()
            && config.getSubmissionDeadline() != null
            && config.getResultsDeclaration() != null) {
            
            LocalDateTime submissionTime = config.getSubmissionDeadline().toLocalDateTime();
            LocalDateTime resultTime = config.getResultsDeclaration().toLocalDateTime();

            Duration gap = Duration.between(submissionTime, resultTime);
            if (gap.toMinutes() >= 30) {
                showResults = true;
            }
        }
System.out.println(showResults);
        request.setAttribute("showResultsToUsers", showResults);
        request.getRequestDispatcher("/welcome.jsp").forward(request, response);
    }
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

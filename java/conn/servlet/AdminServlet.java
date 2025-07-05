package conn.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import conn.dao.Admindaoimpl;
import conn.dao.CaptchaVerifier;


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
				response.sendRedirect("admindashboard.jsp");
			}
			else {
				response.sendRedirect("adminlogin.jsp?invalidpassword=0");
			}
		}
	}

}

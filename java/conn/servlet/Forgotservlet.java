package conn.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import conn.dao.CaptchaVerifier;
import conn.dao.Daomethodsimpl;

@WebServlet("/Forgotservlet")
public class Forgotservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Daomethodsimpl dao=new Daomethodsimpl();
    public Forgotservlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email=request.getParameter("email");
		String password=request.getParameter("password");
		String confirmpassword=request.getParameter("confirmpassword");
		String gRecaptchaResponse = request.getParameter("g-recaptcha-response");
		boolean isCaptchaValid = CaptchaVerifier.verifyCaptcha(gRecaptchaResponse);
		if (!isCaptchaValid) {
	        response.sendRedirect("login.jsp?error=Captcha failed"); // Notify user of CAPTCHA failure
	        return; // Stop further execution
	    }
		if(password.equals(confirmpassword) && dao.validemail(email)) {
			dao.forgotpassword(email, password);
			response.sendRedirect("login.jsp?forgotpassword=success");
			
		}
		else {
			response.sendRedirect("login.jsp?email=pass");
		}
	}

}

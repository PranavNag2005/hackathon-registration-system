package conn.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import conn.dao.CaptchaVerifier;
import conn.dao.Daomethodsimpl;

@WebServlet("/Loginservlet")
public class Loginservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Daomethodsimpl dao=new Daomethodsimpl();
    
    public Loginservlet() {
        super();
      
    }

	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email=request.getParameter("email");
		String password=request.getParameter("password");
		String gRecaptchaResponse = request.getParameter("g-recaptcha-response");
		boolean isCaptchaValid = CaptchaVerifier.verifyCaptcha(gRecaptchaResponse);
		if(isCaptchaValid) {
			if(dao.validuser(email, password)) {
				HttpSession session=request.getSession();
				
				response.sendRedirect("welcome.jsp");
			}
		}
	}

}

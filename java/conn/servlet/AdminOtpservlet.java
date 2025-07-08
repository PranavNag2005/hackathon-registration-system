package conn.servlet;

import jakarta.mail.MessagingException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import conn.dao.Admindaoimpl;
import conn.dao.CaptchaVerifier;

/**
 * Servlet implementation class AdminOtpservlet
 */
@WebServlet("/AdminOtpservlet")
public class AdminOtpservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    Mailutility mail=new Mailutility();
    Otpgenerator otp=new Otpgenerator();
    Admindaoimpl dao=new Admindaoimpl();
   
    public AdminOtpservlet() {
        super();
        
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email=request.getParameter("email");
		String gRecaptchaResponse = request.getParameter("g-recaptcha-response");
		boolean isCaptchaValid = CaptchaVerifier.verifyCaptcha(gRecaptchaResponse);
		if (!isCaptchaValid) {
	        response.sendRedirect("login.jsp?error=Captcha failed"); // Notify user of CAPTCHA failure
	        return; // Stop further execution
	    }
		if(!dao.validemail(email)) {
			response.sendRedirect("adminforgot.jsp?invalidemail=0");
			return;
		}
		String getotp=otp.generateOTP();
		HttpSession session=request.getSession();
		session.setMaxInactiveInterval(10 * 60);
		session.setAttribute("otp",getotp);
		session.setAttribute("email",email);
		try {
			mail.sendOTP(email,getotp );
			session.setAttribute("sendotp","success");
			
			response.sendRedirect("adminverifyotp.jsp");
			return;
		} catch (MessagingException e) {
			
			e.printStackTrace();
			response.sendRedirect("adminforgot.jsp?otpfailure=0");
		}
	}

}

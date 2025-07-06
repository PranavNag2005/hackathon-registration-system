package conn.servlet;

import jakarta.mail.MessagingException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import conn.dao.CaptchaVerifier;
import conn.dao.Daomethodsimpl;

/**
 * Servlet implementation class Otpservlet
 */
@WebServlet("/Otpservlet")
public class Otpservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    Mailutility mail=new Mailutility();
    Otpgenerator otp=new Otpgenerator();
    Daomethodsimpl dao=new Daomethodsimpl();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Otpservlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        if (email == null || email.trim().isEmpty()) {
            response.sendRedirect("forgot.jsp?invalidemail=0");
            return;
        }
        // Regenerate and send OTP
        String newOtp = otp.generateOTP(); // Replace with your OTP logic
        try {
			mail.sendOTP(email, newOtp);
			HttpSession session = request.getSession();
	        session.setAttribute("otp", newOtp);

	        // Redirect back to OTP entry page
	        response.sendRedirect("verifyotp.jsp?email=" + email);
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}     

        
    }
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws  ServletException, IOException {
		String email=request.getParameter("email");
		String gRecaptchaResponse = request.getParameter("g-recaptcha-response");
		boolean isCaptchaValid = CaptchaVerifier.verifyCaptcha(gRecaptchaResponse);
		if (!isCaptchaValid) {
	        response.sendRedirect("login.jsp?error=Captcha failed"); // Notify user of CAPTCHA failure
	        return; // Stop further execution
	    }
		if(!dao.validemail(email)) {
			response.sendRedirect("forgot.jsp?invalidemail=0");
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
			
			response.sendRedirect("verifyotp.jsp");
			return;
		} catch (MessagingException e) {
			
			e.printStackTrace();
			response.sendRedirect("forgot.jsp?otpfailure=0");
		}
		
	}

}

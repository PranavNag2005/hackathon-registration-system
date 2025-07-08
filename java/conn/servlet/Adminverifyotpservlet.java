package conn.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Servlet implementation class Adminverifyotpservlet
 */
@WebServlet("/Adminverifyotpservlet")
public class Adminverifyotpservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Adminverifyotpservlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String digit1 = request.getParameter("otp1");
		String digit2 = request.getParameter("otp2");
		String digit3 = request.getParameter("otp3");
		String digit4 = request.getParameter("otp4");
		String digit5 = request.getParameter("otp5");
		String digit6 = request.getParameter("otp6");

		
		String userOtp = digit1 + digit2 + digit3 + digit4 + digit5 + digit6;
		HttpSession session=request.getSession(false);
		if (session == null || session.getAttribute("otp") == null) {
		    response.sendRedirect("adminlogin.jsp?error=sessionExpired");
		    return;
		}

		String otp=(String)session.getAttribute("otp");
		if(userOtp.equals(otp)) {
			session.removeAttribute("otp");
			response.sendRedirect("adminresetpassword.jsp");
		}else {
			response.sendRedirect("adminverifyotp.jsp?invalid=0");
		}
	}

}

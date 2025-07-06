package conn.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import org.mindrot.jbcrypt.BCrypt;

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
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("email") == null) {
		    response.sendRedirect("login.jsp?error=sessionExpired");
		    return;
		}
		String email=(String)session.getAttribute("email");
		String password=request.getParameter("password");
		String confirmpassword=request.getParameter("confirmpassword");
		
		if(password.equals(confirmpassword) && dao.validemail(email)) {
			String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt(12));

			dao.forgotpassword(email, hashedPassword);
			response.sendRedirect("login.jsp?forgotpassword=success");
			
		}
		else {
			response.sendRedirect("login.jsp?email=pass");
		}
	}

}

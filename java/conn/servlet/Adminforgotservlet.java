package conn.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import org.mindrot.jbcrypt.BCrypt;

import conn.dao.Admindaoimpl;

/**
 * Servlet implementation class Adminforgotservlet
 */
@WebServlet("/Adminforgotservlet")
public class Adminforgotservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Admindaoimpl dao=new Admindaoimpl();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Adminforgotservlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("email") == null) {
		    response.sendRedirect("adminlogin.jsp?error=sessionExpired");
		    return;
		}
		String email=(String)session.getAttribute("email");
		String password=request.getParameter("password");
		String confirmpassword=request.getParameter("confirmpassword");
		
		if(password.equals(confirmpassword) && dao.validemail(email)) {
			String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt(12));

			dao.updatepassword(email, hashedPassword);
			response.sendRedirect("adminlogin.jsp?forgotpassword=success");
			
		}
		else {
			response.sendRedirect("adminlogin.jsp?email=pass");
		}
	}

}

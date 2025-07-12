package conn.servlet;

import jakarta.mail.MessagingException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import org.mindrot.jbcrypt.BCrypt;

import conn.dao.Daomethodsimpl;


@WebServlet("/Updatepasswordservlet")
public class Updatepasswordservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   Daomethodsimpl dao=new Daomethodsimpl();
   Mailutility mail=new Mailutility();
    public Updatepasswordservlet() {
        super();
        // TODO Auto-generated constructor stub
    }
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String currentpassword=request.getParameter("currentpassword");
		String password=request.getParameter("password");
		String confirmpassword=request.getParameter("confirmpassword");
		HttpSession session = request.getSession(false);
	    String email = (String) session.getAttribute("email");
	    if(password.equals(confirmpassword)&& dao.validuser(email, currentpassword)) {
	    	String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt(12));

	    	boolean is=dao.updatepassword(email, hashedPassword);
	    	if(is) {
	    		
	    		
	    		int sid=(int)session.getAttribute("sid");
	    		try {
					mail.sendpasswordupdatemail(email);
				} catch (MessagingException e) {
					
					e.printStackTrace();
				}
	    		session.setAttribute("passwordUpdate", "success");
	    		dao.logactivity(sid, "PASSWORD_CHANGE", "Password updated");
	    		response.sendRedirect("welcome.jsp");
	    	}
	    	
	    }
	    else {
	    	response.sendRedirect("updatepassword.jsp?invalid=failed");
	    }

	}

}

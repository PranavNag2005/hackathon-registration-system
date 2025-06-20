package conn.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import conn.dao.Daomethodsimpl;


@WebServlet("/Updatepasswordservlet")
public class Updatepasswordservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   Daomethodsimpl dao=new Daomethodsimpl();
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
	    	boolean is=dao.updatepassword(email, password);
	    	if(is) {
	    		HttpSession sessions=request.getSession(false);
	    		sessions.setAttribute("passwordUpdate", "success");
	    		response.sendRedirect("welcome.jsp");
	    	}
	    	
	    }
	    else {
	    	response.sendRedirect("updatepassword.jsp?invalid=failed");
	    }

	}

}

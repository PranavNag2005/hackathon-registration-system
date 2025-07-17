package conn.servlet;

import jakarta.mail.MessagingException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import conn.dao.Admindaoimpl;

/**
 * Servlet implementation class Contactservlet
 */
@WebServlet("/Contactservlet")
public class Contactservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
     Admindaoimpl dao=new Admindaoimpl();
     Mailutility mail=new Mailutility();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Contactservlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name=request.getParameter("name");
		String useremail=request.getParameter("email");
		String subject=request.getParameter("subject");
		String message=request.getParameter("message");
		String remail="uppalapatipranavnag@gmail.com";
		dao.contactquery(name, useremail, subject, message);
		try {
			mail.sendContactQueryMail(name, useremail, subject, message, remail);
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		response.sendRedirect("welcome.jsp");
		
	}

}

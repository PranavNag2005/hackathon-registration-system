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
 * Servlet implementation class AdminUpdatepasswordservlet
 */
@WebServlet("/AdminUpdatepasswordservlet")
public class AdminUpdatepasswordservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Admindaoimpl dao=new Admindaoimpl();
	
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminUpdatepasswordservlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	 HttpSession session=request.getSession(false);
	 if(session==null) {
		 response.sendRedirect("login.jsp");
	 }
	 String email=(String) session.getAttribute("email");
	 System.out.println(email);
	 String password=request.getParameter("password");
	 String confirmpassword=request.getParameter("confirmpassword");
	 System.out.println(password+confirmpassword);
	 if(password.equals(confirmpassword)) {
		 String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt(12));
		 dao.updatepassword(email, hashedPassword);
		 response.sendRedirect("admindashboard.jsp");
	 }
	}

}

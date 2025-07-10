package conn.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import conn.dao.Admindaoimpl;

@WebServlet("/AdminRatingservlet")
public class AdminRatingservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    Admindaoimpl dao=new Admindaoimpl();
    public AdminRatingservlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String rate=request.getParameter("rating");
		String pid=request.getParameter("pid");
		String comment=request.getParameter("comment");
		HttpSession session=request.getSession(false);
		
		if (session == null || session.getAttribute("name") == null) {
		    response.sendRedirect("adminlogin.jsp");
		    return;
		}
		String adminname=(String)session.getAttribute("name");
		dao.insertratings(rate,comment,adminname,pid);
		response.sendRedirect("Adminviewprojectservlet");
	}

}

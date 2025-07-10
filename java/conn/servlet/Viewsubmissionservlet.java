package conn.servlet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import conn.dao.Admindaoimpl;

@WebServlet("/Viewsubmissionservlet")
public class Viewsubmissionservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
      Admindaoimpl dao=new Admindaoimpl();
    
    public Viewsubmissionservlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<Users> users = dao.viewUsers();
		System.out.println("Users size: " + users.size());
		request.setAttribute("userList", users);
        RequestDispatcher dispatcher = request.getRequestDispatcher("viewsubmissions.jsp");
        dispatcher.forward(request, response);

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

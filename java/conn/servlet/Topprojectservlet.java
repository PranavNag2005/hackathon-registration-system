package conn.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import conn.dao.Admindaoimpl;
import java.util.*;
/**
 * Servlet implementation class Topprojectservlet
 */
@WebServlet("/Topprojectservlet")
public class Topprojectservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    Admindaoimpl dao=new Admindaoimpl();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Topprojectservlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<TopProjectinfo> topProjects = dao.getTopRatedProjects();
		request.setAttribute("topProjects", topProjects);
		request.getRequestDispatcher("/topprojects.jsp").forward(request, response);


	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}

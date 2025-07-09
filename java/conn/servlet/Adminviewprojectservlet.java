package conn.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import conn.dao.Admindaoimpl;

/**
 * Servlet implementation class Adminviewprojectservlet
 */
@WebServlet("/Adminviewprojectservlet")
public class Adminviewprojectservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	Admindaoimpl dao=new Admindaoimpl();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Adminviewprojectservlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
        List<ProjectInfo> projectList = dao.viewProjects();

        request.setAttribute("projectList", projectList);
        request.getRequestDispatcher("/adminviewproject.jsp").forward(request, response);

	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

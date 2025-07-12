package conn.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

import conn.dao.CaptchaVerifier;
import conn.dao.Daomethodsimpl;
import org.mindrot.jbcrypt.BCrypt;
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static Daomethodsimpl dao=new Daomethodsimpl();
    Mailutility m=new Mailutility();
    
    public RegisterServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String fullname=request.getParameter("fullname");
		String email=request.getParameter("email");
		String phonenumber=request.getParameter("phonenumber");
		System.out.println(phonenumber);
		String dob=request.getParameter("dob");
		String password=request.getParameter("password");
		String confirmpassword=request.getParameter("confirmpassword");
		String rollnumber=request.getParameter("rollnumber");
		String branch=request.getParameter("branch");
		String year=request.getParameter("year");
		String clgname=request.getParameter("collegename");
		System.out.println(fullname+" "+email+" "+phonenumber+" "+dob+" "+password);
		String gRecaptchaResponse = request.getParameter("g-recaptcha-response");
		boolean isCaptchaValid = CaptchaVerifier.verifyCaptcha(gRecaptchaResponse);
try {
		if (isCaptchaValid) {
		    if (password.equals(confirmpassword)) {
		    	if(!dao.validemail(email)) {
		    		String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt(12));

		        if (dao.createuser(fullname,email,phonenumber,dob,password, rollnumber,branch,year,clgname)) {
		        	m.sendRegistrationEmail(email);
		            response.sendRedirect("login.jsp?registration=success");
		        } else {
		            response.sendRedirect("Register.jsp?errorcreation=1");
		        }
		    }
		    	 else {
				    	response.sendRedirect("Register.jsp?exists=1");
				    }
		    	}
		   
		    else {
	            response.sendRedirect("Register.jsp?passwords=1");
	        }
		}else {
		    response.sendRedirect("Register.jsp?error=captcha");
		}

	}
	catch(Exception e) {
		e.printStackTrace();
	}

}}

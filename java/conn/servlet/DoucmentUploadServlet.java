package conn.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;

import conn.dao.Daomethodsimpl;

/**
 * Servlet implementation class DoucmentUploadServlet
 */
@MultipartConfig

@WebServlet("/DoucmentUploadServlet")
public class DoucmentUploadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final long MIN_FILE_SIZE = 0 * 1024 * 1024; 
    private static final long MAX_FILE_SIZE = 20 * 1024 * 1024; 

       Daomethodsimpl dao=new Daomethodsimpl();
   
    public DoucmentUploadServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Part filePart = request.getPart("documentFile");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String fileType = "docx";
        HttpSession session = request.getSession(false);
        int sid = (int) session.getAttribute("sid");
        String message;

        // Extension check
        if (!fileName.toLowerCase().endsWith(".docx")) {
            message = "❌ Only .docx files are allowed.";
            request.setAttribute("message", message);
            return;
        }

        // File size validation
        long fileSize = filePart.getSize();
        if (fileSize < MIN_FILE_SIZE || fileSize > MAX_FILE_SIZE) {
            message = "❌ File must be between 5MB and 20MB.";
            request.setAttribute("message", message);
            return;
        }

        // Construct upload path
        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        // Save file
        File savedFile = new File(uploadPath + File.separator + fileName);
        filePart.write(savedFile.getAbsolutePath());

        // Save relative path for browser access
        String dbFilePath = "uploads/" + fileName;
        dao.insertdocument(sid, fileName, dbFilePath, fileType, true);

        // Log activity
        dao.logactivity(sid, "DOCS_UPLOAD", "Document uploaded successfully");

        // Redirect to welcome page
        
        response.sendRedirect("welcome.jsp");
        

	
	}
}

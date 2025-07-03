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
		System.out.println(filePart+" was printed");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        System.out.println(fileName);
        String message;
        String uploadPath;
        String filetype="docx";
        HttpSession sessions=request.getSession(false);
		int sid=(int)sessions.getAttribute("sid");
		String activityType="DOCS_UPLOAD";
		String activityMessage="Document uploaded successfully";

        // Check file extension
        if (!fileName.toLowerCase().endsWith(".docx")) {
            message = "❌ Only .docx files are allowed.";
            System.out.println(message);
        } else {
            long fileSize = filePart.getSize();

            if (fileSize < MIN_FILE_SIZE || fileSize > MAX_FILE_SIZE) {
                message = "❌ File must be between 5MB and 10MB.";
                System.out.println(message);
            } else {
            	 uploadPath = "C:/Users/uppal/OneDrive/Dokumen/Desktop/uploads";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdir();

                filePart.write(uploadPath + File.separator + fileName);
                message = "✅ Your .docx file was uploaded successfully!";
                System.out.println(message);
                dao.insertdocument(sid, fileName,uploadPath, filetype, true);
                dao.logactivity(sid, activityType, activityMessage);
            }
        }
        request.setAttribute("message", message);

	}

}

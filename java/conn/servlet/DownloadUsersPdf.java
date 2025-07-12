package conn.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.awt.Color;  // Using java.awt.Color instead of BaseColor

// iText/OpenPDF imports
import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.FontFactory;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Chunk;
import com.lowagie.text.PageSize;
import com.lowagie.text.Phrase;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;

import conn.dao.Admindaoimpl;

@WebServlet("/DownloadUsersPdf")
public class DownloadUsersPdf extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String DATE_FORMAT = "dd-MM-yyyy HH:mm:ss";
    private static final String DOB_FORMAT = "dd-MM-yyyy";
    
    private final Admindaoimpl dao = new Admindaoimpl();
    private Document document;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "attachment; filename=users_report_"
                    + new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()) + ".pdf");

            document = new Document(PageSize.A4, 50, 50, 50, 50);
            PdfWriter.getInstance(document, response.getOutputStream());
            document.open();

            // Using java.awt.Color instead of BaseColor
            Font titleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 18, Color.DARK_GRAY);
            Paragraph title = new Paragraph("USER DETAILS REPORT", titleFont);
            title.setAlignment(Element.ALIGN_CENTER);
            title.setSpacingAfter(20f);
            document.add(title);

            Font metaFont = FontFactory.getFont(FontFactory.HELVETICA, 10, Color.GRAY);
            document.add(new Paragraph("Generated on: " 
                    + new SimpleDateFormat(DATE_FORMAT).format(new Date()), metaFont));
            document.add(Chunk.NEWLINE);

            PdfPTable table = new PdfPTable(7);
            table.setWidthPercentage(100);
            table.setSpacingBefore(10f);
            table.setSpacingAfter(20f);

            Font headerFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12, Color.WHITE);
            addTableHeader(table, "Name", headerFont, Color.DARK_GRAY);
            addTableHeader(table, "Email", headerFont, Color.DARK_GRAY);
            addTableHeader(table, "Phone", headerFont, Color.DARK_GRAY);
            addTableHeader(table, "Date of Birth", headerFont, Color.DARK_GRAY);
            addTableHeader(table, "College", headerFont, Color.DARK_GRAY);
            addTableHeader(table, "Branch", headerFont, Color.DARK_GRAY);
            addTableHeader(table, "Year", headerFont, Color.DARK_GRAY);

            Font dataFont = FontFactory.getFont(FontFactory.HELVETICA, 10);
            List<Users> userList = dao.viewUsers();
            
            if (userList.isEmpty()) {
                PdfPCell cell = new PdfPCell(new Phrase("No user data available", dataFont));
                cell.setColspan(7);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                cell.setPadding(10f);
                table.addCell(cell);
            } else {
                for (Users user : userList) {
                    addTableCell(table, user.getName(), dataFont);
                    addTableCell(table, user.getEmail(), dataFont);
                    addTableCell(table, user.getPhoneNumber(), dataFont);
                    addTableCell(table, 
                            new SimpleDateFormat(DOB_FORMAT).format(user.getDateOfBirth()), 
                            dataFont);
                    
                    addTableCell(table, user.getCollegeName(), dataFont);
                    addTableCell(table, user.getBranch(), dataFont);
                    addTableCell(table, String.valueOf(user.getYearOfStudy()), dataFont);


                }
            }

            document.add(table);
            
            Paragraph footer = new Paragraph("© Your Company Name", metaFont);
            footer.setAlignment(Element.ALIGN_CENTER);
            document.add(footer);

        } catch (DocumentException e) {
            log("PDF generation error", e);
            response.reset();
            response.setContentType("text/html");
            response.getWriter().println("<h3>Error generating PDF: " + e.getMessage() + "</h3>");
        } finally {
            if (document != null && document.isOpen()) {
                document.close();
            }
        }
    }

    private void addTableHeader(PdfPTable table, String text, Font font, Color bgColor) {
        PdfPCell header = new PdfPCell(new Phrase(text, font));
        header.setBackgroundColor(bgColor);
        header.setHorizontalAlignment(Element.ALIGN_CENTER);
        header.setPadding(8f);
        table.addCell(header);
    }

    private void addTableCell(PdfPTable table, String text, Font font) {
        PdfPCell cell = new PdfPCell(new Phrase(text, font));
        cell.setPadding(6f);
        table.addCell(cell);
    }
}
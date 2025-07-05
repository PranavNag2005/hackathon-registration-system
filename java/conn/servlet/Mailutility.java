package conn.servlet;
import java.util.Properties;


import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;


public class Mailutility {

    public   void sendOTP(String recipientEmail, String otp) throws MessagingException {
        final String senderEmail = "uppalapatipranavnag@gmail.com";         
        final String senderPassword = "lcft vipq ywwl corq";     

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(senderEmail, senderPassword);
            }
        });
        

        MimeMessage message = new MimeMessage(session);
        message.setFrom(new InternetAddress(senderEmail));
        message.setRecipient(Message.RecipientType.TO, new InternetAddress(recipientEmail));
        message.setSubject("🔐 Your OTP Code");
        

        String htmlContent = "<h2 style='color:#2E86C1;'>Your One-Time Password</h2>"
                           + "<p style='font-size:16px;'>Hi there! 👋<br><br>"
                           + "Your <strong>OTP</strong> is: <span style='font-size:18px; color:green;'>" + otp + "</span><br>"
                           + "This code will expire in <strong>10 minutes</strong>.<br><br>"
                           + "If you didn't request this, you can safely ignore it.</p>"
                           + "<hr><p style='font-size:12px; color:#888;'>- Regard's Admin</p>";

        message.setContent(htmlContent, "text/html; charset=utf-8");

        Transport.send(message);
        System.out.println("successfully");
    }
    
    
}
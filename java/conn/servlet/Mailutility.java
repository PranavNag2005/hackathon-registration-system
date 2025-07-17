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
        final String senderEmail = "teamofadm1n123@gmail.com";         
        final String senderPassword = "pvtd aodb trnm wspv";     

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
        message.setSubject("🔐 Your OTP Code for password Reset");
        

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
    

        public  void sendRegistrationEmail(String recipientEmail) throws MessagingException {
            final String senderEmail = "teamofadm1n123@gmail.com";   // Replace with a secure config in production
            final String senderPassword = "pvtd aodb trnm wspv";           // Consider moving this to an environment variable

            // Email properties
            Properties props = new Properties();
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");

            // Auth session
            Session session = Session.getInstance(props, new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(senderEmail, senderPassword);
                }
            });

            // Compose message
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(senderEmail));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(recipientEmail));
            message.setSubject("✅ Registration Successful");

            // Email HTML content
            String htmlContent = "<h2 style='color:#27AE60;'>🎉 Registration Successful!</h2>"
                    + "<p style='font-size:16px;'>Hello there! 👋<br><br>"
                    + "We're excited to let you know that your registration was <strong>successful</strong>.<br><br>"
                    
                    + "<p style='font-size:15px; color:#555;'>If you have any questions, feel free to reach out to our support team.</p>"
                    + "<hr><p style='font-size:13px; color:#999;'>- Regards,<br><strong>Admin Team</strong></p>";

            message.setContent(htmlContent, "text/html; charset=utf-8");

            // Send
            Transport.send(message);
            System.out.println("Registration email sent successfully!");
        }
        public  void sendpasswordupdatemail(String recipientEmail) throws MessagingException {
            final String senderEmail = "teamofadm1n123@gmail.com";   // Replace with a secure config in production
            final String senderPassword = "pvtd aodb trnm wspv";           // Consider moving this to an environment variable

            // Email properties
            Properties props = new Properties();
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");

            // Auth session
            Session session = Session.getInstance(props, new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(senderEmail, senderPassword);
                }
            });

            // Compose message
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(senderEmail));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(recipientEmail));
            message.setSubject("✅ Password Updated Successfully");

            // Email HTML content
            String htmlContent = "<h2 style='color:#27AE60;'>🎉 password updated Successfully !</h2>"
                    + "<p style='font-size:16px;'>Hello there! 👋<br><br>"
                    + "password updated <strong>successful</strong>.<br><br>"
                    
                    + "<p style='font-size:15px; color:#555;'>If you have not done this , feel free to reach out to our support team.</p>"
                    + "<hr><p style='font-size:13px; color:#999;'>- Regards,<br><strong>Admin Team</strong></p>";

            message.setContent(htmlContent, "text/html; charset=utf-8");

            // Send
            Transport.send(message);
            System.out.println("Registration email sent successfully!");
        }
        public void sendContactQueryMail(String name, String userEmail,String subject, String queryText, String recipientEmail) throws MessagingException {
            final String senderEmail = "teamofadm1n123@gmail.com";  // Consider securing this
            final String senderPassword = "pvtd aodb trnm wspv";    // Move to environment variable

            // SMTP configuration
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

            // Compose the email
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(senderEmail));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(recipientEmail));
            message.setSubject("📬 New Contact Query Received");

            String htmlContent = "<h2 style='color:#3498DB;'>📨 User Contact Query Received</h2>"
                    + "<p style='font-size:16px;'>Hi Admin 👋,<br><br>"
                    + "A new query was submitted via the Contact Us page.<br><br>"
                    + "<strong>Name:</strong> " + name + "<br>"
                    + "<strong>Email:</strong> " + userEmail + "<br>"
                    +"<strong>Subject:</strong> " + subject + "<br>"
                    + "<strong>Message:</strong><br><blockquote style='background:#f9f9f9;padding:10px;border-left:3px solid #ccc;'>" + queryText + "</blockquote><br>"
                    + "<hr><p style='font-size:13px; color:#999;'>- This message was auto-generated by the event platform backend.</p>";

            message.setContent(htmlContent, "text/html; charset=utf-8");

            Transport.send(message);
            System.out.println("Contact query email sent to admin successfully!");
        }
    }
    

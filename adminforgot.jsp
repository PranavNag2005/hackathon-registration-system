<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="style.css">
<title>Admin Forgot Password</title>
</head>
<body>
<h2>Admin Forgot Password</h2>
    <form action="AdminOtpservlet" method="post">
        

        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required><br>

       

        

        <!-- Google reCAPTCHA -->
        <div class="g-recaptcha" data-sitekey="6LcHoVgrAAAAANEZvPFfWDVCAdIuSVz7go5IcuhG"></div><br>
        <script src="https://www.google.com/recaptcha/api.js" async defer></script>

    <%String error=request.getParameter("error");
    if(error!=null && error.equals("Captcha failed")){%>
    <p style="color:red;text-align:center;";>Captcha verification failed.</p>
    <%} %>
    <%String invalidemail=request.getParameter("invalidemail");
    if(invalidemail!=null && invalidemail.equals("0")){%>
    <p style="color:red;text-align:center;";>User not exists!</p>
    <%} %>
        <input type="submit" value="Send Otp">
    
  


    </form>
</body>
</html>
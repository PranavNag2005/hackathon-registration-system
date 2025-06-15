<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="style.css">
<title>Forgot Password</title>
</head>
<body>
<h2>Forgot Password</h2>
    <form action="Forgotservlet" method="post">
        

        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required><br>

       

        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required><br>

       <label for="confirmpassword">Confirm Password:</label>
        <input type="password" id="confirmpassword" name="confirmpassword" required><br>
       

        <!-- Google reCAPTCHA -->
        <div class="g-recaptcha" data-sitekey="6LcHoVgrAAAAANEZvPFfWDVCAdIuSVz7go5IcuhG"></div><br>
        <script src="https://www.google.com/recaptcha/api.js" async defer></script>

    <%String error=request.getParameter("error");
    if(error!=null && error.equals("Captcha failed")){%>
    <p style="color:red;text-align:center;";>Captcha verification failed.</p>
    <%} %>
        <input type="submit" value="Update Password">
    
  


    </form>
</body>
</html>
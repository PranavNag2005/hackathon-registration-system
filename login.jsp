<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="style.css">
<title>Login</title>
</head>
<body>
<h2>Login</h2>
    <form action="Loginservlet" method="post">
        

        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required><br>

       

        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required><br>

       

        <!-- Google reCAPTCHA -->
        <div class="g-recaptcha" data-sitekey="6LcHoVgrAAAAANEZvPFfWDVCAdIuSVz7go5IcuhG"></div><br>
        <script src="https://www.google.com/recaptcha/api.js" async defer></script>

    <%String error=request.getParameter("error");
    if(error!=null && error.equals("Captcha failed")){%>
    <p style="color:red;text-align:center;">Captcha verification failed.</p>
    <%} %>

    	
    <%String email=request.getParameter("email");
    if(email!=null && email.equals("pass")){%>
    <p style="color:red;text-align:center;">Invalid email or password mismatch</p>
    <%} %>
    
    
    <% String forgotpassword=request.getParameter("forgotpassword");
    if(forgotpassword!=null && forgotpassword.equals("success")){%>
    <p style="color:green;text-align:center;">Password Updated Successfully.</p>
    <%} %>
    
    
    
    
    
        <input type="submit" value="Register">
    
    
    
    
    
  <div style="display: flex; justify-content: space-between;">
  <a href="forgot.jsp">Forgot Password</a>
  <a href="Register.jsp">Create One</a>
</div>


    </form>
</body>
</html>
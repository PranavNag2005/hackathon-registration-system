<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="style.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<title>Admin Login</title>
<style>

</style>
</head>
<body>
<nav class="navbar navbar-expand-lg fixed-top">
        <div class="container">
            <a class="navbar-brand" href="index.html" style="font-size:50px";>
                <i class="fas fa-code me-2"></i>HackX
            </a></div></nav>
<h2>ADMIN 	LOGIN</h2>
    <form action="AdminServlet" method="post">
        

        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required><br>

       

        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required><br>

       

        <!-- Google reCAPTCHA -->
        <div class="g-recaptcha" data-sitekey="6LcHoVgrAAAAANEZvPFfWDVCAdIuSVz7go5IcuhG"></div><br>
        <script src="https://www.google.com/recaptcha/api.js" async defer></script>

    <% String error = request.getParameter("error");
   if(error != null && error.equals("Captcha failed")) { %>
   <div id="captchaError" style="color:red;text-align:center;">
       Captcha verification failed.
   </div>
   <script>
       setTimeout(function() {
           var msg = document.getElementById("captchaError");
           if (msg) {
               msg.style.display = "none";
           }
       }, 3000); 
   </script>
<% } %>

    	
    <% String email = request.getParameter("email");
   if(email != null && email.equals("pass")) { %>
   <div id="emailError" style="color:red;text-align:center;">
       Invalid email
   </div>
   <script>
       setTimeout(function() {
           var msg = document.getElementById("emailError");
           if (msg) {
               msg.style.display = "none";
           }
       }, 3000); 
   </script>
<% } %>
    
    
    <% String forgotpassword = request.getParameter("forgotpassword");
   if(forgotpassword != null && forgotpassword.equals("success")) { %>
   <div id="successMsg" style="color:green;text-align:center;">
       Password Updated Successfully.
   </div>
   <script>
       setTimeout(function() {
           var msg = document.getElementById("successMsg");
           if (msg) {
               msg.style.display = "none";
           }
       }, 3000); 
   </script>
<% } %>
    
    
      <% String invalidpassword = request.getParameter("invalidpassword");
   if(invalidpassword != null && invalidpassword.equals("0")) { %>
   <div id="successMsg" style="color:red;text-align:center;">
       Invalid Email or Password.
   </div>
   <script>
       setTimeout(function() {
           var msg = document.getElementById("successMsg");
           if (msg) {
               msg.style.display = "none";
           }
       }, 5000); 
   </script>
<% } %>
    
    
        <input type="submit" value="Login">
    
    
    
    
    
  <div style=" text-align:center; margin-top:15px;">
  <a href="adminforgot.jsp">Forgot Password</a>
  
</div>


    </form>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="style.css">
<title>Update Password</title>
</head>
<body>
<h2>Update Password</h2>
<% HttpSession seession =request.getSession();
if(seession==null || seession.getAttribute("email")==null){
	response.sendRedirect("login.jsp");
	return;
}
%>
    <form action="AdminUpdatepasswordservlet" method="post">
        

        <label for="currentpassword">Current Password:</label>
        <input type="password" id="currentpassword" name="currentpassword" required><br>

       

        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required><br>

       <label for="confirmpassword">Confirm Password:</label>
        <input type="password" id="confirmpassword" name="confirmpassword" required><br>

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
<% String updatepassword = request.getParameter("invalid");
   if(updatepassword != null && updatepassword.equals("failed")) { %>
   <div id="updatepassword" style="color:red;text-align:center;">
       Current password or password mismatches...
   </div>
   <script>
       setTimeout(function() {
           var msg = document.getElementById("updatepassword");
           if (msg) {
               msg.style.display = "none";
           }
       }, 3000); 
   </script>
    	<% } %>
   
    
   
    
    
     
    
        <input type="submit" value="Update Password">
    
    
    
    
    
  


    </form>
</body>
</html>
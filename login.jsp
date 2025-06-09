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

     
        <input type="submit" value="Register">
    
    <p style="text-align:center;">Dont't have account ? <a href="Register.jsp">Create One</a></p>
    </form>
</body>
</html>
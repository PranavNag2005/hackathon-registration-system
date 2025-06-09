<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hackathon Registration</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h2>Hackathon Registration</h2>
    <form action="RegisterServlet" method="post">
        <label for="fullName">Full Name:</label>
        <input type="text" id="fullName" name="fullname" required><br>

        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required><br>

        <label for="phone">Phone Number:</label>
        <input type="tel" id="phone" name="phonenumber" required><br>

        <label for="dob">Date of Birth:</label>
        <input type="date" id="dob" name="dob" required><br>

        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required><br>

        <label for="confirmPassword">Confirm Password:</label>
        <input type="password" id="confirmPassword" name="confirmpassword" required><br>

        <!-- Google reCAPTCHA -->
        <div class="g-recaptcha" data-sitekey="6LcHoVgrAAAAANEZvPFfWDVCAdIuSVz7go5IcuhG"></div><br>
        <script src="https://www.google.com/recaptcha/api.js" async defer></script>

      
        <input type="submit" value="Register">
    
    </form>
    
</body>
</html>
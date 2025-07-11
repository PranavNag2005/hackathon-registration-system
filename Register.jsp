<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hackathon Registration</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="style.css">
</head>
<body>
<nav class="navbar navbar-expand-lg fixed-top">
        <div class="container">
            <a class="navbar-brand" href="index.html" style="font-size:50px";>
                <i class="fas fa-code me-2"></i>HackX
            </a></div></nav>
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

        <label for="rollnumber">Roll Number:</label>
		<input type="text" id="rollnumber" name="rollnumber" placeholder="Roll Number" required><br>
		<label for="branch">Branch</label>
<select name="branch" required style="width:100%;padding:8px;">
  <option value="">--Select Branch--</option>
  <option value="CSE">CSE</option>
  <option value="ECE">ECE</option>
  <option value="EEE">EEE</option>
  <option value="AI">AI</option>
  <option value="AIML">AIML</option>
  <option value="AIDS">AIDS</option>
  <option value="CSDS">CSDS</option>
  <option value="ME">ME</option>
  <option value="Civil">Civil</option>
  <option value="VLSI">VLSI</option>
  <option value="IoT">IoT</option>
  <option value="IT">IT</option>
  <option value="CSIT">CSIT</option>
</select>
<br>
<label for="year">Year</label>
<input type="number"  style="width:100%;padding:8px;"name="year" id="year" placeholder="Year of Study" min="1" max="4" required>
<br>
<label for="clg">College</label>
<input type="text" name="collegename" placeholder="College Name" required>
<br>

        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required><br>

        <label for="confirmPassword">Confirm Password:</label>
        <input type="password" id="confirmPassword" name="confirmpassword" required><br>
        <!-- Google reCAPTCHA -->
        <div class="g-recaptcha" data-sitekey="6LcHoVgrAAAAANEZvPFfWDVCAdIuSVz7go5IcuhG"></div><br>
        <script src="https://www.google.com/recaptcha/api.js" async defer></script>

      <% String password=request.getParameter("passwords");
    if(password!=null && password.equals("1")){%>
    <p style="color:red;text-align:center;";>Password does not match</p>
    <%} 
    %>
    <%String user=request.getParameter("exists");
    if(user!=null && user.equals("1")){%>
    <p style="color:red;text-align:center;";>Email or phone number already exists </p>
    <%} %>
        <input type="submit" value="Register">
    <p style="text-align:center;">Have an Account <a href="login.jsp">Login Here</a></p>
    </form>
    
</body>
</html>

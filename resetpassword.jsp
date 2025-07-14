<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="style.css">
</head>
<body>

    <h2>Reset Password</h2>
    <form action="Forgotservlet" method="post">
        

        

        

        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required><br>

        <label for="confirmPassword">Confirm Password:</label>
        <input type="password" id="confirmPassword" name="confirmpassword" required><br>

        

      <% String password=request.getParameter("passwords");
    if(password!=null && password.equals("1")){%>
    <p style="color:red;text-align:center;";>Password does not match</p>
    <%} 
    %>
    
        <input type="submit" value="Reset Password">
    
    </form>
    
</body>
</html>
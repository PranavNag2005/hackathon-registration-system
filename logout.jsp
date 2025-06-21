<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Logout</title>
</head>
<body>
<% HttpSession s=request.getSession(false);
s.invalidate();
response.sendRedirect("login.jsp");%>
</body>
</html>
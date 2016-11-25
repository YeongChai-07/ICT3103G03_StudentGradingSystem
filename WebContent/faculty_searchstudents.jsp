<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.util.*" %>
    <%
//Retrieve lecturer username and role
session = request.getSession();
String username= (String)session.getAttribute("uname");
Integer urole = (Integer)session.getAttribute("urole");

if (username==null || urole !=1 || username == null && urole != 1) {
	request.setAttribute("message", "Please login!");
    request.getRequestDispatcher("/login.jsp").forward(request, response);
    return;
	//response.sendRedirect("login.jsp?invaliduser");
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Student Grading System</title>

</head>
<body>



<% ArrayList<Object[]> name = (ArrayList<Object[]>) session.getAttribute("studentObject"); %>


<h5>Students</h5>

<table border = "1">
<tr>
<th>Username</th>
<th>Name</th>
<th>Module</th>
</tr>

<tr>
<td> <%  for(int i = 0; i < name.size(); i++) {
 %><p><%= name.get(i)[0] %></p>
 <%} %></td>
 
 <td> <%  for(int i = 0; i < name.size(); i++) {
 %><p><%= name.get(i)[1] %></p>
 <%} %></td>
 
 <td> <%  for(int i = 0; i < name.size(); i++) {
 %><p><%= name.get(i)[2] %></p>
 <%} %></td>
</tr>


</table>

</body>
</html>
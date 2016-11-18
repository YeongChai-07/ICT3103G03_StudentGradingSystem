<%@ page import="java.sql.*" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
session = request.getSession();
String username= (String)session.getAttribute("uname");
Integer urole = (Integer)session.getAttribute("urole");

System.out.println("uname = " + username +". urole = " + urole + ".");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Student Grading System</title>
</head>
<body>
<style>
table, th, td {
    border: 1px solid black;
    border-collapse: collapse;
    padding: 5px;
}
</style>
<center>
  <h1>Enrolled Modules</h1>
  <table border="1" width="60%">
  <tr>
  	<th><font color='#663300'>ID</font></th>
  	<th><font color='#663300'>Module Name</font></th>
  	<th><font color='#663300'>Description</font></th>
  </tr>
  <c:forEach items="${results}" var="module">
  	<tr>
		<td><b><font color='Black'><c:out value="${module.getModId()}" /></font></b></td>
		<td><b><font color='Black'><c:out value="${module.getModName()}" /></font></b></td>
		<td><b><font color='Black'><c:out value="${module.getModDesc()}" /></font></b></td>
	</tr>
</c:forEach>
 </table>
 <br/>
<form method="get">
  		<button type="submit" formaction="student_home.jsp">Back to Home</button>
 </form>
 </center>
</body>
</html>
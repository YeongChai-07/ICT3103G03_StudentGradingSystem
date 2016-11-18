<!-- 
This page will display a list of modules taught under logged in lecturer.
Values are triggered from FacultyController when a button is clicked. 
By clicking on 'Add' button, values are being passed over to a controller to be 
loaded in faculty_addmarks.jsp.

 -->

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
session = request.getSession();
//retrieve username and role
String username= (String)session.getAttribute("uname");
Integer urole = (Integer)session.getAttribute("urole");

System.out.println("uname = " + username +". urole = " + urole + ".");

if (username==null || urole !=1 || username == null && urole != 1) {
	response.sendRedirect("login.jsp?invaliduser");
}
else
{
%> 
	<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
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
            <h1>Students Enrolled in Your Module</h1>
	  <table border="1" width="60%">
	  <tr><th>
	  <font color='Gray'>Student ID </font></th><th>
	  <font color='Gray'>Name </font></th><th>
	  <font color='Gray'>Module </font></th><th>
	  <font color='Gray'>Module Name </font></th><th>
	  <font color='Gray'>Assign / Current Marks </font></th><tr>

	<c:forEach items="${results}" var="studentModule">
		<tr>
			<td><font color='#663300'><c:out value="${studentModule.getUsername()}" /></font></td>
			<td><font color='#663300'><c:out value="${studentModule.getName()}" /></font></td>
			<td><font color='#663300'><c:out value="${studentModule.getIdMod()}" /></font></td>
			<td><font color='#663300'><c:out value="${studentModule.getModName()}" /></font></td>
			
			<td><center><form name="" method="get" action="AddMarksController">
			<input type="hidden" name="stID" value="<c:out value="${studentModule.getUsername()}" />">
			<input type="hidden" name="stName" value="<c:out value="${studentModule.getName()}" />">
			<input type="hidden" name="stModID" value="<c:out value="${studentModule.getIdMod()}" />">
			<input type="hidden" name="stModName" value="<c:out value="${studentModule.getModName()}" />">
			<c:choose>
				<c:when test="${studentModule.getGrade() != 'Not Graded' }">
					<c:out value="${studentModule.getGrade()}" />
				</c:when>
				<c:otherwise>
					<input type="submit" value="Add" />
				</c:otherwise>
			</c:choose>
			</form></center></td>
		</tr>
	</c:forEach>
	 </table>
	 </br>
	 <form method="get">
  		<button type="submit" formaction="faculty_home.jsp">Back to Home</button>
 </form>
	 </center>
	 
	</body>
	</html>
<%}%>
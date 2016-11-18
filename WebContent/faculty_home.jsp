<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
		<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.util.*" %>
<%
System.out.println("faculty_home.jsp");
session = request.getSession();
String username= (String)session.getAttribute("uname");
Integer urole = (Integer)session.getAttribute("urole");

if (username==null || urole!=1) {
	System.out.println("Error. Login failed.");
	response.sendRedirect("login.jsp?invaliduser");
}
else
{
%> 
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
	<form method="get" action="FacultyController">
		<center>
		<h1>Welcome, Faculty: <label for="uname" id="uname" name="uname">${uname}</h1></label>
		<p>What would you like to do today?</p>
		
		<!-- <button type="submit" value="mod" name="action">View Teaching Modules </button>
		&nbsp;&nbsp; -->
	    <button type="submit" value="stu" name="action">View Modules & Grade Students </button>
	    &nbsp;&nbsp;
	    <button type="submit" value="cha" name="action">Change Password </button>
		&nbsp;&nbsp;
	</form>
	</br></br>
	<hr width="50%">
	
		
<%-- 	    <h4>Search for students</h4>
	    <form action="process_facultysearchstudents.jsp" method="POST">
	    	<input type="hidden" name="foreignKey" value="<%= session.getAttribute("fk_enroll_acc") %>" />
  			<input type="text" name="studentName" size="50" placeholder="Search by Student ID, Student Name">
        	<input type="submit" value="Search">
		</form>
 --%>
 
 <h4>Search for students enrolled in your module</h4>
	    <form action="process_facultysearchstudents.jsp" method="POST">
	    <input type="hidden" name = "foreignKey" value="<%= session.getAttribute("fk_enroll_acc") %>" />
  		<input type="text" name="studentName" size="50" placeholder="Search by Student ID, Student Name" required aria-required="true" pattern="[A-Za-z0-9]+">
        <input type="submit" value="Search">
		</form>
	    </br>
	    
	    
	    <% 		
	    final boolean isPosted = (null != request.getAttribute("studentObject")?(boolean) request.getAttribute("IsPosted"): false);
	    
	    if(isPosted) {
	    	ArrayList<Object[]> name = (ArrayList<Object[]>) request.getAttribute("studentObject"); 
	    	
	    	if(name.size() != 0) { %>
		    	<table border = "1">
					<tr>
					<th>Username</th>
					<th>Name</th>
					<th>Module</th>
					</tr>
		
					<%  for(int i = 0; i < name.size(); i++) {%>
					<tr>
						<td><%= name.get(i)[0] %></td>
			 			<td><%= name.get(i)[1] %></td>
			 			<td><%= name.get(i)[2] %></td>
					</tr>
					<%} %>
				</table>
			<%} 
	 		else { %>
				<h3>No results found. Please try again</h3>
		<% 
			}
	 	} %>   
 
 
	</br></br></br></br>
	
	
	
	<form method="get" action="AccountController">
	   <p> I am done for the day. <button type="submit" value="out" name="action">Logout</button> </p>
	</form>
	</center>
	   
</body></html>
<%}%>
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
//Retrieve lecturer username and role
session = request.getSession();
String username= (String)session.getAttribute("uname");
Integer urole = (Integer)session.getAttribute("urole");

if (username==null || urole !=1 || username == null && urole != 1) {
	request.setAttribute("message", "Please login! - Test");
    request.getRequestDispatcher("/login.jsp").forward(request, response);
    return;
	//response.sendRedirect("login.jsp?invaliduser");
}
else
{
%> 
	<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Student Grading System</title>
	<!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="css/modern-business.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    
	<link href="css/default.css" rel="stylesheet">
	</head>
	<body>
		<!-- Navigation -->
	    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
	        <div class="container">
	            <!-- Brand and toggle get grouped for better mobile display -->
	            <div class="navbar-header">
	                <!-- button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
	                    <span class="sr-only">Toggle navigation</span>
	                    <span class="icon-bar"></span>
	                    <span class="icon-bar"></span>
	                    <span class="icon-bar"></span>
	                </button-->
	                <span class="navbar-brand">Student Grading System</span>
	           </div>
	           <!-- Collect the nav links, forms, and other content for toggling -->
	           <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
	           		<ul class="nav navbar-nav navbar-right">
	           			<li>
		                    	<form method="post" action="FacultyController">
		                        	<button type="submit" value="search" name="action" class="submitLink">Home</button>
		                        </form>
		                    </li>
		                	<li>
		                    	<form method="post" action="FacultyController">
		                        	<button type="submit" value="stu" name="action" class="submitLink">View Modules & Grade Students</button>
		                        </form>
		                    </li>
	
		            		<li class="dropdown">
	                        	<a href="#" class="dropdown-toggle" data-toggle="dropdown">Faculty&nbsp;<span>${uname}</span><b class="caret"></b></a>
	                        		<ul class="dropdown-menu">
	                            		<li>
	                            			<form method="post" action="FacultyController">
	                                			<button type="submit" value="change" name="action" class="accountLink">Change Password</button>
	                                		</form>
	                            		</li>
	                            		<li>
	                            			<form method="get" action="AccountController">
	                                			<button type="submit" value="out" name="action" class="accountLink">Logout</button>
	                                		</form>
	                            		</li>
	                        		</ul>
	                    	</li>
	                    	
	             		</ul>
	           </div>
	      </div>
		<!-- /.container -->
		</nav>
	
			<div class="container">
			<div class="row">
				<div class="col-md-12">
					 <center>
            			<h1 class="page-header">Students Enrolled in Your Module</h1>
						  <table class="table table-hover table-condensed" width="60%">
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
								
								<td><center>
								<form name="" method="post" action="AddMarksController">
								<input type="hidden" name="stID" value="<c:out value="${studentModule.getUsername()}" />">
								<input type="hidden" name="stName" value="<c:out value="${studentModule.getName()}" />">
								<input type="hidden" name="stModID" value="<c:out value="${studentModule.getIdMod()}" />">
								<input type="hidden" name="stModName" value="<c:out value="${studentModule.getModName()}" />">
								<c:choose>
									<c:when test="${studentModule.getGrade() != 'Not Graded' }">
										<c:out value="${studentModule.getGrade()}" />
									</c:when>
									<c:otherwise>
										<input type="submit" value="Add" name="action" />
									</c:otherwise>
								</c:choose>
								</form>
								</center></td>
							</tr>
						</c:forEach>
						 </table>
						 </br>
						 <form method="get">
					  		<button type="submit" formaction="faculty_home.jsp">Back to Home</button>
					 	</form>
					</center>
				</div>
			</div>
		</div>
           
	 
		<!-- jQuery -->
	    <script src="js/jquery.bootstrap.js"></script>
	
	    <!-- Bootstrap Core JavaScript -->
	    <script src="js/bootstrap.min.js"></script>	 
	</body>
	</html>
	<%}%>
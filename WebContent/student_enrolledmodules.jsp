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
	                    	<form method="post" action="StudentController">
	                        	<button type="submit" value="search" name="action" class="submitLink">Home</button>
	                        </form>
	                    </li>
	                	<li>
	                    	<form method="post" action="StudentController">
	                        	<button type="submit" value="modules" name="action" class="submitLink">My Modules</button>
	                        </form>
	                    </li>
		                <li>
		                    <form method="post" action="StudentController">
		                        <button type="submit" value="grades" name="action" class="submitLink">My Grades</button>
		                    </form>
		               </li>

	            		<li class="dropdown">
                        	<a href="#" class="dropdown-toggle" data-toggle="dropdown">Student&nbsp;<span>${uname}</span><b class="caret"></b></a>
                        		<ul class="dropdown-menu">
                            		<li>
                            			<form method="post" action="StudentController">
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
					<h1 class="page-header">Enrolled Modules</h1>
					<center>
					  <table class="table table-hover table-bordered table-condensed" width="60%">
						  <tr>
						  	<th><font color='#663300'>ID</font></th>
						  	<th><font color='#663300'>Module Name</font></th>
						  	<th><font color='#663300'>Description</font></th>
						  </tr>
						  <c:forEach items="${results}" var="module">
						  	<tr>
								<td><c:out value="${module.getModId()}" /></td>
								<td><c:out value="${module.getModName()}" /></td>
								<td><c:out value="${module.getModDesc()}" /></td>
							</tr>
						</c:forEach>
					 </table>
					 <br/>
					<form method="get">
					  		<button type="submit" formaction="student_home.jsp">Back to Home</button>
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
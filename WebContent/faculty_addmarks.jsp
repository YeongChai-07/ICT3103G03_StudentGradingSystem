<!-- 
This page will allow faculty to add marks to students taking their module.
Values will be passed to the AddMarksController and store into database. 

Student ID, Student Name, Module ID, Module Name values are passed from each row of
faculty_liststudent.jsp table. 

 -->

<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% 
session = request.getSession();
String username= (String)session.getAttribute("uname");
Integer urole = (Integer)session.getAttribute("urole");
System.out.println(username);
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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Add marks</title>
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
                <span class="navbar-brand">Student Grading System</span>
           </div>
           <!-- Collect the nav links, forms, and other content for toggling -->
           <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
           		<ul class="nav navbar-nav navbar-right">
           			<li>
	                    	<form method="get" action="FacultyController">
	                        	<button type="submit" value="search" name="action" class="submitLink">Home</button>
	                        </form>
	                    </li>
	                	<li>
	                    	<form method="get" action="FacultyController">
	                        	<button type="submit" value="stu" name="action" class="submitLink">View Modules & Grade Students</button>
	                        </form>
	                    </li>

	            		<li class="dropdown">
                        	<a href="#" class="dropdown-toggle" data-toggle="dropdown">Faculty&nbsp;<span>${uname}</span><b class="caret"></b></a>
                        		<ul class="dropdown-menu">
                            		<li>
                            			<form method="get" action="FacultyController">
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

	<div class="container-fluid">
		<div class="row">
			<div class="col-md-4">&nbsp;</div>
			<h1 class="col-md-4 page-header text-center">Add Student Marks</h1>
			<div class="col-md-4">&nbsp;</div>
			
		</div>
		<div class="row">
			<div class="col-md-4">&nbsp;</div>
			<div class="col-md-4">
				<form method="post" class="form-horizontal" action="AddMarksController">
		            <div class="panel panel-default">
		            	<div class="panel-heading form-horizontal"><b>Please enter student marks</b></div>
		            	<div class="panel-body form-horizontal">
			            	<!-- modID means module ID; stID and stName means studentID and studentName respectively. -->
				        	<c:forEach items="${results}" var="studentModule">
					        	<div class="form-group">
					        		<label class="col-sm-3">Module ID</label>
					        		<div class="col-sm-9">
					        			<input type="text" class="form-control" name="modID" value="<c:out value="${studentModule.getIdMod()}" />" readonly>
					        		</div>
					        	</div>
					        	<div class="form-group">
					            	<label class="col-sm-3">Module Name </label>
					                <div class="col-sm-9">
					                	<input type="text" class="form-control" name="moduleName" value="<c:out value="${studentModule.getModName()}" />" readonly>
					               	</div>
					            </div>
					            <div class="form-group">
					               	<label class="col-sm-3">Student ID </label>
					                <div class="col-sm-9">
					                	<input type="text" class="form-control" name="stID" value="<c:out value="${studentModule.getUsername()}" />" readonly>
					                </div>
					            </div>
					            <div class="form-group">
					                <label class="col-sm-3">Student Name: </label>
					                <div class="col-sm-9">
					                	<input type="text" class="form-control" name="stName" value="<c:out value="${studentModule.getName()}" />" readonly>
					                </div>
					            </div>       
					            <div class="form-group">
					                <!-- users are allowed to input grades up to 1decimal place. pattern d+ in this case is for browser such as
					                 Firefox who does not read type="number" in their browser -->
					                <label class="col-sm-3">Input Grades: </label>
					                <div class="col-sm-9">
					                	<input type="number" class="form-control" id="grades" name="grades" min="0" max="100" step="0.1" pattern="[\d+]{1,3}"/>
					            	</div>
					            </div>
					            <div class="form-group">
					            	<center>
						            	<input type="submit" value="Submit" name="action" />
						                            &nbsp;&nbsp;
						                <input type="submit" value="Cancel" name="action" onclick='alert("Inputs will not be saved.")'/>
						                            &nbsp;&nbsp;
					                </center>
					            </div>
					        </c:forEach>
				        </div>
		            </div>

			</form>
			<div class="col-md-4">&nbsp;</div>
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
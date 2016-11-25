<!-- 
This page is faculty's home page after logging in. 
There are 3 functionalities for faculty.
1. View enrolled students and grades
2. Change Password
3. Search for students taking their module via student ID or student Name.
 -->

<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
		<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.util.*" %>

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
				<h1 class="page-header text-center">Welcome, Faculty: <label for="uname" id="uname" name="uname">${uname}</h1></label>
				<br/>
				<center>
					<i><p><b>Home : </b>Search list of enrolled student by keywords</p></i>
						<i><p><b>View Modules & Grade Students : </b>View list of modules & grade student</p></i>
						<br/>
					<!-- Faculty able to search students by student ID e.g "16SIC001A" or module "Azlan" -->
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
				    
				    <div>
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
			 		</div>
			 
				</br></br></br></br>
					
				</center>
			</div>
		</div>
	</div>

	<!-- jQuery -->
    <script src="js/jquery.bootstrap.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>	   
</body></html>

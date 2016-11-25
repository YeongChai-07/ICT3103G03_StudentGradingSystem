<!-- 
This page is student's home page after logging in. 
There are 4 functionality for student.
1. View grades
2. View modules
3. Change Password
4. Search for modules via module ID or module name.

 -->

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
<%
session = request.getSession();
String username= (String)session.getAttribute("uname");
System.out.println(username);
if (username==null){
	response.sendRedirect("login.jsp?invaliduser");
}

%> 
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
				<h1 class="page-header text-center">Welcome Student: <label for="uname" id="uname" name="uname">${uname}</label></h1>
					<br/>
					<center>
						<i><p><b>Home : </b>Search list of modules by keywords</p></i>
						<i><p><b>My Modules : </b>View my list of enrolled modules</p></i>	
						<i><p><b>My Grades : </b>View my module grades</p></i>		
						<br/>
						<!-- Student able to search their modules by module ID e.g "1001" or module Name "ICT" -->
					   	<h4> Search for Modules</h4>
						<form action="process_searchmoduleinfo.jsp" method="POST">
							<input type="text" name="searchModuleTerms" size="50" placeholder="Search module by ID, or name" required aria-required="true" pattern="[A-Za-z0-9]+" title="Make sure that the input does not contain any special characters." />
							<input type="submit" value="Search" /><br/>
						</form>
						
						<div>
							<%
							final boolean isPosted = (null != request.getAttribute("IsPosted")?(boolean) request.getAttribute("IsPosted"): false);
							
							if(isPosted)
							{
								final int[] moduleCode = (int[]) request.getAttribute("moduleCode");
								final String[] moduleName = (String[]) request.getAttribute("moduleName");
								final String[] moduleDesc = (String[]) request.getAttribute("moduleDesc");
								
								if(moduleCode != null)
								{
									System.out.println("LENGTH: " + moduleCode.length);
							%>
									<br/>
									<table border="1" width="60%">
										<tr>
											<th>Module Code</th>
											<th>Module Name</th>
											<th>Module Description</th>
										</tr>
							<%
									for(int i=0; i<moduleCode.length;i++)
									{
							
							%>
										<tr>
											<td><%=moduleCode[i] %></td>
											<td><%=moduleName[i] %></td>
											<td><%=moduleDesc[i] %></td>
										</tr>
							<%
									}//End For-Loop
							%>
									</table>
							<%
								}
								else
								{
							%>
									<h3>No results found.</h3>
							<%
								}
							}
							%>
						
						</div>
						
						</br></br></br>
					
					
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
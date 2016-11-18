<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Student Grading System</title>
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
<style>
table, th, td {
    border: 1px solid black;
    border-collapse: collapse;
    padding: 5px;
}
</style>
	<form method="get" action="StudentController">
	<center>
	<h1>Hi Student: <label for="uname" id="uname" name="uname">${uname}</label></h1>
	<p>What would you like to do today?</p>
	
	<button type="submit" value="modules" name="action">My Modules </button>
	&nbsp;&nbsp;
    
    <button type="submit" value="grades" name="action">My Grades </button>
    &nbsp;&nbsp;
    
    <button type="submit" value="change" name="action">Change Password </button>
	&nbsp;&nbsp;
	</form>
	
	</br></br>
	<hr width="50%">
		
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
	
<form method="get" action="AccountController">
	   <p> I am done for the day. <button type="submit" value="out" name="action">Logout</button> </p>
	</form>
	
	</center>
	
</body>
</html>
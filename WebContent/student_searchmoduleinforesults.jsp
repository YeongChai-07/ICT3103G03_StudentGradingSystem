<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
session = request.getSession();
String username= (String)session.getAttribute("uname");
Integer urole = (Integer)session.getAttribute("urole");
System.out.println(username);
if (username==null || urole !=2 || username == null && urole != 2 ){
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
<title>Search Modules Results</title>
</head>
<body>
	<table border="1">
		<tr>
			<th>Module Code</th>
			<th>Module Name</th>
			<th>Module Description</th>
		</tr>
		
		<%
		final int[] moduleCode = (int[]) request.getAttribute("moduleCode");
		final String[] moduleName = (String[]) request.getAttribute("moduleName");
		final String[] moduleDesc = (String[]) request.getAttribute("moduleDesc");
		
		if(moduleCode != null)
		{
			System.out.println("LENGTH: " + moduleCode.length);
			for(int i=0; i<moduleCode.length;i++)
			{
		
		%>
			<tr>
				<td><%=moduleCode[i] %></td>
				<td><%=moduleName[i] %></td>
				<td><%=moduleDesc[i] %></td>
			</tr>
		<%
			}
		}
		else
		{
		%>
				<tr>
					<td colspan="3">NO RESULTS FOUND FOR THIS SEARCH QUERY!!!</td>
				</tr>
		<%
		}
		%>
	
	</table>


</body>
</html>

<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
//Retrieve lecturer username and role
session = request.getSession();
String username= (String)session.getAttribute("uname");
Integer urole = (Integer)session.getAttribute("urole");

if (username==null || urole !=1 || username == null && urole != 1) {
	response.sendRedirect("login.jsp?invaliduser");
}
else
{
%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Add marks</title>
</head>
<body>

	<form method="post" action="AddMarksController">
            <center>
            <h1>Add Student Marks</h1>
            <table border="0" cellpadding="5" cellspacing="2">
                <thead>
                    <tr>
                        <th colspan="2">Please enter student marks</th>
                    </tr>
                </thead>
                <tbody>
                <c:forEach items="${results}" var="studentModule">
                    <tr>
                     <td>Module ID </td>
                     <td><input type="text" name="modID" value="<c:out value="${studentModule.getIdMod()}" />" readonly="readonly"></td>
                    </tr>
                    <tr>
                     <td>Module Name </td>
                     <td><input type="text" name="moduleName" value="<c:out value="${studentModule.getModName()}" />" readonly="readonly"></td>
                    </tr>
                    <tr>
                        <td>Student ID </td>
                        <td><input type="text" name="stID" value="<c:out value="${studentModule.getUsername()}" />" readonly="readonly"></td>
                    </tr>
                    <tr>
                        <td>Student Name: </td>
                        <td><input type="text" name="stName" value="<c:out value="${studentModule.getName()}" />" readonly="readonly"></td>
                    </tr>
                    
                    <tr>
                    	<!-- users are allowed to input grades up to 1decimal place. pattern in this case is for browser such as
                    	Firefox who does not read "number" in their browser -->
                   		<td>Input Grades: </td>
                   		<td><input type="number" id="grades" name="grades" min="0" max="100" step="0.1" pattern="[\d+]{1,3}" required aria-required="true"/></td>
                    <tr>
                        <td colspan="2" align="center">
                        
                        	<input type="submit" value="Submit" name="action" />
                            &nbsp;&nbsp;
                           
                       
                            <input type="submit" value="Cancel" name="action" onclick='alert("Inputs will not be saved.")'/>
                            &nbsp;&nbsp;
                        
                        </td>                        
                    </tr>  
                    </c:forEach>                  
                </tbody>
            </table>
            </center>
	</form>
</body>
</html>
<%
}%>
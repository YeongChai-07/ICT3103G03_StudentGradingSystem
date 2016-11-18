<!--

 This program is the backend process of faculty searching students
where all the database queries and setting of variables with data
retrieved from the database will be done.

@author Winnie Lew
@version 1.0
@since 2016-11-01 

-->

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%> 
  <%@page import="java.sql.*" %>
  <%@page import = "javax.servlet.*" %>
 <%@page import= "com.sgs.util.DbUtil" %>
<%@page import="java.util.*" %>


<!-- 
This is the retrieval of the parameters from the faculty_searchstudents.jsp file
where the student name and the faculty's ID will be passed in. -->
  <%
  String student_name = request.getParameter("studentName"); 
  int foreign_key = Integer.parseInt(request.getParameter("foreignKey"));
  //int fkkk = Integer.parseInt(foreign_key);
  
  Connection con = DbUtil.getConnection();
  
  
  ArrayList<Object[]> studentList = new ArrayList<Object[]>();
  if(student_name != null && student_name.length() > 0) {
	  PreparedStatement preparedStatement = con.prepareStatement("SELECT sgs.account.username, sgs.particulars.name, sgs.module.idMod, sgs.module.modName FROM sgs.module "
				+ "JOIN sgs.enroll ON sgs.enroll.fk_enroll_mod = sgs.module.idMod " +
				"JOIN sgs.account ON sgs.enroll.fk_enroll_acc = sgs.account.idAcc " +
				"JOIN sgs.particulars ON sgs.particulars.fk_part_acc = sgs.account.idAcc " +
				" WHERE sgs.account.fk_acc_role = 2 AND sgs.enroll.fk_enroll_mod IN (" + 
				  " SELECT sgs.enroll.fk_enroll_mod FROM sgs.account JOIN sgs.enroll ON sgs.enroll.fk_enroll_acc = sgs.account.idAcc "
				  + "WHERE sgs.enroll.fk_enroll_acc = ?) and (sgs.particulars.name like ? or sgs.account.username like ?)  ORDER BY idMod"); 

      preparedStatement.setInt(1,foreign_key);
	  preparedStatement.setString(2, "%" +student_name+ "%");
	  preparedStatement.setString(3, "%" +student_name+ "%");
	  //preparedStatement.setInt(2, foreign_key);
	  ResultSet resultSet = preparedStatement.executeQuery();
	  
	  while (resultSet.next()) {
		  String username = resultSet.getString("username");
		  String name = resultSet.getString("name");
		  String modname = resultSet.getString("modname");
		  
		  Object[] student = {username,name,modname};
		  studentList.add(student);
	  }
	  //session.setAttribute("studentObject",studentList);
	  request.setAttribute("studentObject", studentList);
	  request.setAttribute("IsPosted",true);
	  request.getRequestDispatcher("faculty_home.jsp").forward(request,response);
	  //dispatcher.forward(request,response); 

	  response.sendRedirect("faculty_home.jsp");
  }
  
  else {
	
	  response.sendRedirect("login.jsp");
  }
  
  %>
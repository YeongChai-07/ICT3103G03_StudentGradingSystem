<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@page import= "com.sgs.util.DbUtil" %>
  <%@page import="java.sql.*" %>
  
  <%
  session = request.getSession();
  String username= (String)session.getAttribute("uname");
  Integer urole = (Integer)session.getAttribute("urole");
  System.out.println(username);
  if (username==null || urole !=2 || username == null && urole != 2 ){
  	request.setAttribute("message", "Please login! - Test");
      request.getRequestDispatcher("/login.jsp").forward(request, response);
      return;
  	//response.sendRedirect("login.jsp?invaliduser");
  }
  	/* Description: The below block of codes uses the input from the user (Search terms) that was sanitized and executes it a WHERE condition
  	* 				for the SQL query for retrieving the matching module information/details
  	*   INPUT: Search terms (from the Search Module Info page)
  	*	RETURNS: The module information from the Module table that matches the entered search terms (input) which will be passed to
  	*		     the Search Module Info page to display the details.
  	*/
  	//String variable that stores the sanitized value of the search terms to query the module for 
  	final String searchModuleTerms = sanitizeInput(request.getParameter("searchModuleTerms"));
  	//Getting an instance of the database connection from the DBUtil class
  	Connection con = DbUtil.getConnection();
  
  	//Arrays to store the details from the ResultSet which later (and initialized to null)
	String[] moduleName = null;
	int[] moduleCode = null;
	String[] moduleDesc = null;
  	
  	if(searchModuleTerms !=null && searchModuleTerms.trim().length() > 0)
  	{	//Does the following processing if the searchModuleTerms string isn't null or empty (with whitespaces omitted)
  		
  		//Declaring the PreparedStatement and ResultSet variable (and initialized to null)
  		PreparedStatement ps = null;
  		ResultSet rs = null;
  		
  		//Constant array of SQL query such as counting number of rows and receiving the module information, which later
  		//will be used for the PreparedStatement
 	  	final String[] rowCountQuery = {"SELECT COUNT(*) FROM module WHERE idMod LIKE ?;",
										"SELECT COUNT(*) FROM module WHERE modName LIKE ?;",
										"SELECT COUNT(*) FROM module WHERE modDesc LIKE ?;"};

		final String[] moduleRecordQuery = {"SELECT * FROM module WHERE idMod LIKE ?;",
											"SELECT * FROM module WHERE modName LIKE ?;",
											"SELECT * FROM module WHERE modDesc LIKE ?;"};
		
		final String[] querySearchPattern = {searchModuleTerms + "%", "%" + searchModuleTerms + "%"};
		
		//Constant value for the number of items in the rowCountQuery and moduleRecordQuery array size
		final int arrSize = 3;
		
		int countWithHighestRecord = 0;	//Used to store the index of the SQL query from the rowCountQuery array that has the most number of record matches
		int highestRecord = 0;	//Used to store the most number of record matches after executing the 3 SQL queries from the rowCountQuery array.
		
		for(int i=0;i<arrSize;i++)
		{
			//Create a new instance of PreparedStatement object.
			ps = con.prepareStatement(rowCountQuery[i]);
			//Setting the corresponding String query pattern (wildcards) as the String parameter 
			//to the PreparedStatement.
			ps.setString(1, (0 == i)?querySearchPattern[0]:querySearchPattern[1]);
			
			//Executes the current SQL query and returns the ResultSet from the executed SQL query.
			rs = ps.executeQuery();
			
			System.out.println("Executing SQL Statement: " + ps.toString());
			
			if(rs != null && rs.next())
  	  		{	//Declares a rowCounts variable to store the number of records (rows) that matches the entered search terms.
  	  			int rowCounts = rs.getInt(1);
  	  			
  	  			System.out.println("COUNT: " + rowCounts);
  	  			
  	  			if(rowCounts > 0 && rowCounts > highestRecord)
  	  			{
  	  				highestRecord = rowCounts;
  	  				countWithHighestRecord = i;
  	  			}
  	  		}//end of IF
		}// End of For-Loop
  	  		
			
			
		//Closes the current instance of the PreparedStatement object to release it from memory
		//as the ResultSet for the rowCount query is no longer needed.
  	  	ps.close();
  	  	rs.close();    //Closes the ResultSet
  	  		
  	  	if(highestRecord > 0)
 	  	{
 	  		moduleName = new String[highestRecord];
 	  	  	moduleCode = new int[highestRecord];
 	  	  	moduleDesc = new String[highestRecord];
 	  	  		
 	  	  	//Create a new instance of PreparedStatement object.
 	  		ps = con.prepareStatement(moduleRecordQuery[countWithHighestRecord]);
 	  		//Setting the corresponding String query pattern (wildcards) as the String parameter 
 			//to the PreparedStatement.
 	  		ps.setString(1, (0 == countWithHighestRecord)?querySearchPattern[0]:querySearchPattern[1]);
 	  		rs = ps.executeQuery();
 	  		System.out.println("Executing SQL Statement: " + ps.toString());
 	  			
 	  		for(int j=0;j<highestRecord;j++)
 	  		{
 	  			rs.next();
 	  				
 	  			moduleCode[j] = rs.getInt(1);
 	  			moduleName[j] = rs.getString(2);
 	  			moduleDesc[j] = rs.getString(3);
 	  				
 	  			System.out.println("Module Code: " + moduleCode[j]);
 	  	  		System.out.println("Module Name: " + moduleName[j]);
 	  	  		System.out.println("Module Description: " + moduleDesc[j]);
 	  		}//Inner For-Loop
 	  				
 	  		//Closes the current instance of the PreparedStatement object to release it from memory
 	  		//at the end of each loop iteration.
  	  		ps.close();
  	  				
 	  		rs.close();    //Closes the ResultSet
 	  			
 	  	}
  		
		//Finally closes the Connections object as there isn't any further database queries to execute.
		//con.close();
  		
  	}
		request.setAttribute("moduleCode", moduleCode);
		request.setAttribute("moduleName", moduleName);
		request.setAttribute("moduleDesc", moduleDesc);
		request.setAttribute("IsPosted", true);
		request.getRequestDispatcher("student_home.jsp").forward(request, response);
 
%>
  <%!
	/* Description: This function does the Server-Side input sanization from the user's input (Search terms) and returns the sanitized copy of
	*				it.
	*   INPUT: Search terms (from the Search Module Info page)
	*	RETURNS: Sanitized copy of the search terms string.
	*		   
	*/
	private String sanitizeInput(final String inputToSanitize)
	{
	  	String sanitizedStr = "";
	  	final String[] patternsForFilter = {"<", ">", "!", "[", "]", "\"", "%", "{", "}"};
	  	final String[] filteredValue = {"lt", "gt", "!!", "![", "!]", "quot", "!%", "opcurbrace", "clocurbrace"};
		if(inputToSanitize != null && inputToSanitize.trim().length() > 0)
		{
			sanitizedStr = inputToSanitize.substring(0);
			
			for(int i=0;i<patternsForFilter.length;i++)
			{
				sanitizedStr = sanitizedStr.replace(patternsForFilter[i], filteredValue[i]);
			}
		}
		
		return sanitizedStr;
	}
	
  %>

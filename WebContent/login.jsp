<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="net.tanesha.recaptcha.ReCaptcha" %>
<%@ page import="net.tanesha.recaptcha.ReCaptchaFactory" %>
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
</head>
<body>

        <form method="post" action="AccountController">
        	<br/>
        	<div class="container-fluid">
	            <div class="row">
	            	<div class="col-lg-4">&nbsp;</div>
	            	<div class="col-lg-4">
	            		<div class="panel panel-default">
	            			<div class="panel-heading"><b>Welcome to SGS</b></div>
	            			<div class="panel-body form-horizontal">
	            			
	            				<div class="form-group">
	            					<!-- This section is meant for user to input their username details -->
	                        		<label for="txtUsername" class="col-sm-2 control-label">Username</label>
	                        		<div class="col-sm-9">
	                        			<input type="text" class="form-control" name="username" id="txtUsername" pattern="[A-Za-z0-9_]{1,15}" title="Please input your username e.g 19SIC001A or A123456" required/>
	                        		</div>
	                        		
	            				</div>
	            				<div class="form-group">
	                    			<!-- This section is meant for user to input their password details -->
	                        		<label for="txtPassword" class="col-sm-2 control-label">Password</label>
	                        		<div class="col-sm-9">
	                        			<input type="password" class="form-control" name="password" id="txtPassword" required/>
	                        		</div>
	                        		
	            				</div>
	            				
	            				<center>
	            				<input type="submit" value="Login" />
	                            &nbsp;&nbsp;
	                            <input type="reset" value="Reset" />
	                            <br/>
	                            <br/>
	                            <!-- To display the Recaptcha widget -->
	                    		<%
	          						ReCaptcha c = ReCaptchaFactory.newReCaptcha("6Lc-_gsUAAAAAJsn56sk_M_RoA2QXqpgjR9Aklq_", "6Lc-_gsUAAAAAGI9i3bvbiiESKpp58q683T-Am7T", false);
	          						out.print(c.createRecaptchaHtml(null, null));
	        					%>
	        					</center>     
	            		
	            		</div>
	            	</div>
	            </div>
	            
	            <div class="col-lg-4">&nbsp;</div>
	        </div>
	       </div>
	        		 
               
        </form>
    </body>
</html>
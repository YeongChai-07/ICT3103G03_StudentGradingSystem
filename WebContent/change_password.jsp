<%
session = request.getSession();
String uname= (String)session.getAttribute("uname");
Integer urole = (Integer)session.getAttribute("urole");
if (uname==null) {
	response.sendRedirect("login.jsp?invaliduser");
}
else
{
%>
<html>
<head>
<title>Student Grading System</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"></head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Bootstrap Core CSS -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<!-- Custom CSS -->
<link href="css/modern-business.css" rel="stylesheet">
<!-- Custom Fonts -->
<link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<link href="css/default.css" rel="stylesheet">
<h2 align="center">Change password</h2>
<body>
<script language="javascript">
function scorePassword(pass) {
    var score = 0;
    if (!pass)
        return score;

    // award every unique letter until 5 repetitions
    var letters = new Object();
    for (var i=0; i<pass.length; i++) {
        letters[pass[i]] = (letters[pass[i]] || 0) + 1;
        score += 5.0 / letters[pass[i]];
    }

    // bonus points for mixing it up
    var variations = {
        digits: /\d/.test(pass),
        lower: /[a-z]/.test(pass),
        upper: /[A-Z]/.test(pass),
        nonWords: /\W/.test(pass),
    }

    variationCount = 0;
    for (var check in variations) {
        variationCount += (variations[check] == true) ? 1 : 0;
    }
    score += (variationCount - 1) * 10;

    return parseInt(score);
}

function fncSubmit()
{

if(document.ChangePasswordForm.OldPassword.value == "")
{
alert('Please input old password');
document.ChangePasswordForm.OldPassword.focus();
return false;
} 

if(document.ChangePasswordForm.newpassword.value == "")
{
//set password with at least 1 char, lenght of 8
alert('Please input password');
document.ChangePasswordForm.newpassword.focus(); 
return false;
} 

if(document.ChangePasswordForm.conpassword.value == "")
{
alert('Please input confirm password');
document.ChangePasswordForm.conpassword.focus(); 
return false;
} 

if(document.ChangePasswordForm.newpassword.value != document.ChangePasswordForm.conpassword.value)
{
alert('confirm password not match');
document.ChangePasswordForm.conpassword.focus(); 
return false;
}
//check for password strength
var score = scorePassword(document.ChangePasswordForm.newpassword.value);
	    
if (score > 70)
{
document.ChangePasswordForm.Submit();
}
 else if (score > 50)
{
alert('Password is moderate. Please enter a strong password.');
document.ChangePasswordForm.newpassword.focus(); 
return false;
}
else if (score >= 30)
{
alert('Password is weak. Please enter a strong password.');
document.ChangePasswordForm.newpassword.focus(); 
return false;
}
else
{
alert('Please is very weak. Please enter a strong password.');
document.ChangePasswordForm.newpassword.focus(); 
return false;
}
}
</script>
<!-- Navigation -->
	    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
	        <div class="container">
	            <!-- Brand and toggle get grouped for better mobile display -->
	            <div class="navbar-header">
	                <!--   a class="navbar-brand" href="index.html">Start Bootstrap</a-->
	                <span class="navbar-brand">Student Grading System</span]>
	            </div>
	            <!-- Collect the nav links, forms, and other content for toggling -->
	            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
	                <ul class="nav navbar-nav navbar-right">
	                    <li>
	                        <a href="#">${uname}</a>
	                    </li>
	                </ul>
	            </div>
	            <!-- /.navbar-collapse -->
	        </div>
	        <!-- /.container -->
	    </nav>

<form name="ChangePasswordForm" method="post" action="PasswordController" OnSubmit="return fncSubmit();">
        	<br/>
        	<div class="container-fluid">
	            <div class="row">
	            	<div class="col-md-4">&nbsp;</div>
	            	<div class="col-md-4">
	            		<div class="panel panel-default">
	            			<div class="panel-heading"><b>Change password</b></div>
	            			<div class="panel-body form-horizontal">
	            			
	            				<div class="form-group">
	                        		<label class="col-sm-4 control-label">Username</label>
	                        		<div class="col-sm-6">
	                        			<span class="form-control-static">${uname}</span>
	                        		</div>
	            				</div>
	            				<div class="form-group">
	                        		<label for="OLDpwd" class="col-sm-4 control-label">Previous Password</label>
	                        		<div class="col-sm-6">
	                        			<input name="OldPassword" class="form-control" type="password" id="OLDpwd" size="20">
	                        		</div>
	            				</div>
	            				<div class="form-group">
	                        		<label for="newpassword" class="col-sm-4 control-label">New Password</label>
	                        		<div class="col-sm-6">
	                        			<input name="newpassword" class="form-control" type="password" id="newpassword">
	                        		</div>
	            				</div>
	            				<div class="form-group">
	                        		<label for="conpassword" class="col-sm-4 control-label">Confirm Password</label>
	                        		<div class="col-sm-6">
	                        			<input name="conpassword" class="form-control" type="password" id="conpassword">
	                        		</div>
	            				</div>
	            				<br/>
	            				<center>
	            					<input type="submit" name="Submit" value="Save">&nbsp;&nbsp; <input type="reset" name="clear" value="Clear"><br/>
	            					<input type="hidden" name="hide" value="${uname}">
	        					</center>     
	            		
	            		</div>
	            	</div>
	            </div>
	            
	            <div class="col-md-4">&nbsp;</div>
	        </div>
	      </div>
	<center>
		</br></br>
		</form>
			
			<!-- Check if user is student or faculty and direct back to home page.  -->
			<% if (urole==2){%>
					<form method="get" name="student home">
					<button type="submit" formaction="student_home.jsp">Back to home page</button>
					</form>
				<%} else { %>
					<form method="get" name="faculty home">
					<button type="submit" formaction="faculty_home.jsp">Back to home page</button>
					</form>
			<%	}%>
			
		 		
		 	
		 </center>
</body>
</html>
<%
}%>
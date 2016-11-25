package com.sgs.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sgs.dao.AccountDao;
import com.sgs.dao.LogDao;

import java.security.*;
import java.sql.SQLException;

import net.tanesha.recaptcha.ReCaptchaImpl;
import net.tanesha.recaptcha.ReCaptchaResponse;

public class AccountController extends HttpServlet implements java.io.Serializable {

    /**
	 * 
	 */
	private static final long serialVersionUID = -8594459315365231886L;
	private String STUDENT = "./student_home.jsp";
    private String FACULTY = "./faculty_home.jsp";
    private String ERROR = "./login.jsp?error";
    private String ERRORATTEMPT = "./login.jsp?errorattempt";
    private String ACCOUNTLOCKED = "./login.jsp?locked";
    private String LOGOUT = "./logout.jsp";
    
    public AccountController() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	System.out.println("AccountController doGet");

        String forward="";
        String result ="";
        
	    result = request.getParameter("action");
	    if (result.equals("out"))
	    {
	    	forward = LOGOUT;
	    }
	    request.getSession().invalidate();
        response.sendRedirect(forward);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

         AccountDao dao = new AccountDao();
    	 HttpSession hs = request.getSession();
    	 System.out.println("AccountController doPost");
    	 
    	 //Validating CAPTCHA from login page
    	 String remoteAddr = request.getRemoteAddr();
    	 ReCaptchaImpl reCaptcha = new ReCaptchaImpl();
    	 reCaptcha.setPrivateKey("6Lc-_gsUAAAAAGI9i3bvbiiESKpp58q683T-Am7T");

    	 String challenge = request.getParameter("recaptcha_challenge_field");
    	 String uresponse = request.getParameter("recaptcha_response_field");
    	 ReCaptchaResponse reCaptchaResponse = reCaptcha.checkAnswer(remoteAddr, challenge, uresponse);
    	 
    	 //Proceed if CAPTCHA is valid
    	 if (reCaptchaResponse.isValid()){
    		 System.out.println("CAPTCHA pass");
    		 
	     	 StringBuffer sbToCheck = new StringBuffer();
	         String checkPassw, salt, username, passw ="";
	         String forward = "";
	         Integer attempt = null;
	         Integer role = null;
	         Integer fk_part_acc = null;
	         
	         username  = request.getParameter("username");
	         passw = request.getParameter("password");
	         
	         System.out.println(username);
	         
	         //Get security code from user name

	         try{
	         salt= dao.getSalt(username);
	         if(!salt.equals(""))
	         {
	        	sbToCheck.append(salt);
	 			sbToCheck.append(passw);
	
			 	Encrypt en = new Encrypt();
			    checkPassw = en.encryptPass(sbToCheck.toString());
			    
			    //Check if password match with db password
			    role = dao.checkPassword(username, checkPassw);
			    fk_part_acc = dao.getAccountId(username, checkPassw);
			    hs.setAttribute("uname", username);
		    	hs.setAttribute("urole", role);
		    	System.out.println(fk_part_acc);
		    	hs.setAttribute("fk_enroll_acc", fk_part_acc);
		    	attempt = dao.checkLoginAttempt(username);
		    	
		    	LogDao logDao = new LogDao();
		    	
		    	if (role != null && attempt > 0){
		    		
		    		//log student login activity
		    		logDao.logLogin(username);
		    		//password correct
		    		dao.updateLoginAttempt(username);
				    if(role==1){
						System.out.println("AccountController role = FACULTY");
						forward = FACULTY;
				     }
					 else if (role==2){
						System.out.println("AccountController role = STUDENT");
				        forward = STUDENT;
					 }
		    	} 
		    	else {
		    		attempt = dao.checkLoginAttempt(username);
		    		
		    		//log student failed login activity
		    		logDao.logFailLogin(username);
		    		
		     		if(attempt<=0)
		    		{
						 System.out.println("AccountController LOCKED");
						 forward = ACCOUNTLOCKED;
		    		}
		     		else{
			    		 dao.reduceLoginAttempt(username);
						 System.out.println("AccountController ERROR ATTEMPT");
						 forward = ERRORATTEMPT;
		    		}
				 }
	         } 
	         else 
	         {
	        	 System.out.println("Invalid login credentials");
	        	 forward = ERROR;
	        	// JOptionPane.showMessageDialog(null, "Invalid CAPTCHA.", "Error",
                  //  JOptionPane.ERROR_MESSAGE);
	        	
	         }
	        
	         response.sendRedirect(forward);
	
	    	 }catch(SQLException e){} catch (NoSuchAlgorithmException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
    	 } else {
    		 System.out.println("Invalid CAPTCHA");
    		 //request.setAttribute("message", "Invalid Captcha - Test");
	        // request.getRequestDispatcher("/login.jsp").forward(request, response);
	        // return;
    		 response.sendRedirect(ERROR);
    	 }
    }
    
    protected static class Encrypt {
        StringBuffer hexString = new StringBuffer();
	    public String encryptPass(String str) throws NoSuchAlgorithmException, UnsupportedEncodingException {
	    	
		  //hashing method
    	  MessageDigest md = MessageDigest.getInstance("SHA-256");
    	  byte[] hash = md.digest(str.getBytes("UTF-8"));

          for (int i = 0; i < hash.length; i++) {
              String hex = Integer.toHexString(0xff & hash[i]);
              if(hex.length() == 1) hexString.append('0');
              hexString.append(hex);
          	}
	      return hexString.toString();
	    }
	  }
}
package com.sgs.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.JOptionPane;

import com.sgs.dao.AccountDao;
import com.sgs.dao.LogDao;

import java.security.*;
import net.tanesha.recaptcha.ReCaptchaImpl;
import net.tanesha.recaptcha.ReCaptchaResponse;

public class AccountController extends HttpServlet {

    private String STUDENT = "./student_home.jsp";
    private String FACULTY = "./faculty_home.jsp";
    private String ERROR = "./login.jsp?error";
    private String ERRORATTEMPT = "./login.jsp?errorattempt";
    private String ACCOUNTLOCKED = "./login.jsp?locked";
    private String LOGOUT = "./logout.jsp";
    private AccountDao dao;
    private HttpSession hs; 
    
    public AccountController() {
        super();
        dao = new AccountDao();
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

    	 hs = request.getSession();
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
	         salt= dao.getSalt(username);
	         if(!salt.equals(""))
	         {
	        	sbToCheck.append(salt);
	 			sbToCheck.append(passw);
	
			 	Encrypt en = new Encrypt();
			    checkPassw = en.EncryptPass(sbToCheck.toString());
			    
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
	         
    	 } else {
    		 System.out.println("Invalid CAPTCHA");
    		 //request.setAttribute("message", "Invalid Captcha - Test");
	        // request.getRequestDispatcher("/login.jsp").forward(request, response);
	        // return;
    		 response.sendRedirect(ERROR);
    	 }
    }
    
    protected static class Encrypt {
		StringBuffer sb = new StringBuffer();
	    public String EncryptPass(String str) {
	    	try{
		    	//hashing method
		    	MessageDigest md = MessageDigest.getInstance("SHA-256");
		    	md.update(str.getBytes());
		
		    	byte byteData[] = md.digest();
		
		    	//convert the byte to hex format method 1
		    	for (int i = 0; i < byteData.length; i++) {
		    	 sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
		    	}
	    	}catch(Exception e){
	    		
	    	}
	      return sb.toString();
	    }
	  }
}
package com.sgs.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sgs.controller.AccountController.Encrypt;
import com.sgs.dao.AccountDao;
import com.sgs.model.Account;

import java.security.*;
import java.util.UUID;

public class PasswordController extends HttpServlet {

	private static final long serialVersionUID = 2L;
    private static String ERROR = "/login.jsp?error";
    private static String LOGOUT = "./logout.jsp";
    private static String CHANGEPASS = "./change_password.jsp";
    private AccountDao dao;
    private HttpSession hs; 
    
    public PasswordController() {
        super();
        dao = new AccountDao();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	System.out.println("PasswordController doGet");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    	 Account acc = new Account();
    	 hs = request.getSession();
    	 System.out.println("PasswordController doPost");

		 StringBuffer sbToCheckOldPassw = new StringBuffer();
    	 String OldPassword, Newpass, conpass = "";
    	 String username, checkPassw ="";
     	
		 OldPassword = request.getParameter("OldPassword");
		 Newpass = request.getParameter("newpassword");
		 conpass = request.getParameter("conpassword");
		 username = request.getParameter("hide");
		 
		 acc = dao.getPasswordSecurity(username);
		 
		 if(acc!=null){
			 sbToCheckOldPassw.append(acc.getSecurityCode());
			 sbToCheckOldPassw.append(OldPassword);
			 
			 Encrypt en = new Encrypt();

			 checkPassw = en.EncryptPass(sbToCheckOldPassw.toString());
			 
			 if(Newpass.equals(conpass))
			 {
				if (acc.getPassword().equals(checkPassw)) {
				
				StringBuffer sbToSave = new StringBuffer();
				String uuid = UUID.randomUUID().toString().replaceAll("-", "");
				sbToSave.append(uuid);
				sbToSave.append(Newpass);
				String saltANDpassw = sbToSave.toString();
				
				System.out.println(uuid);
				
				Encrypt en2 = new Encrypt();
				String toUpdatePassword = en2.EncryptPass(saltANDpassw);
				
				Account accUpdate = new Account();
				accUpdate.setUsername(username);
				accUpdate.setSecurityCode(uuid);
				accUpdate.setPassword(toUpdatePassword);
			
				dao.updatePassword(accUpdate);
				
				System.out.println("Password changed successfully");
		        response.sendRedirect(LOGOUT);
			    }
				else {
				System.out.println("Old Password doesn't match");
				response.sendRedirect(CHANGEPASS);
				
				}
			}
			else{

				System.out.println("New/Confirm Password doesn't match");
				response.sendRedirect(CHANGEPASS);
			}
		 }
    }
    
    protected class Encrypt {
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
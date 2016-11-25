package com.sgs.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sgs.dao.AccountDao;
import com.sgs.dao.LogDao;
import com.sgs.model.Account;

public class PasswordController extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1719251291926184057L;
	 private String ERROR = "/login.jsp?error";
     private String LOGOUT = "./logout.jsp";
     private String CHANGEPASS = "./change_password.jsp";
     
     public PasswordController() {
         super();
     }
     protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    	 AccountDao dao = new AccountDao();
    	 Account acc = new Account();
    	 System.out.println("PasswordController doPost");

		 StringBuffer sbToCheckOldPassw = new StringBuffer();
    	 String OldPassword, Newpass, conpass = "";
    	 String username, checkPassw ="";
     	
		 OldPassword = request.getParameter("OldPassword");
		 Newpass = request.getParameter("newpassword");
		 conpass = request.getParameter("conpassword");
		 username = request.getParameter("hide");
		 
		 try {
			acc = dao.getPasswordSecurity(username);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 
		 if(acc!=null){
			 sbToCheckOldPassw.append(acc.getSecurityCode());
			 sbToCheckOldPassw.append(OldPassword);
			 
			 Encrypt en = new Encrypt();

			 try {
				checkPassw = en.encryptPass(sbToCheckOldPassw.toString());
			} catch (NoSuchAlgorithmException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			 
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
				try{
				String toUpdatePassword = en2.encryptPass(saltANDpassw);
				
				Account accUpdate = new Account();
				accUpdate.setUsername(username);
				accUpdate.setSecurityCode(uuid);
				accUpdate.setPassword(toUpdatePassword);
			
				dao.updatePassword(accUpdate);
				
				LogDao logDao = new LogDao();
				logDao.logChangePassword(username);
				
				}catch (NoSuchAlgorithmException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
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


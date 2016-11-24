package com.sgs.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.sgs.model.Account;
import com.sgs.util.DbUtil;

public class AccountDao {

	private Connection connection;

	public AccountDao() {
		connection = DbUtil.getConnection();
	}
	
	public String getSalt(String username){
		String salt= "";
		try {
			PreparedStatement preparedStatement = connection
					.prepareStatement("select security from account where username=?");
			preparedStatement.setString(1, username);
			ResultSet rs = preparedStatement.executeQuery();   
			
			if(rs.next()){
				 //check id
				  salt = rs.getString("security");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return salt;
	}
	public Integer checkPassword(String uname, String passw)
	{
		Account acc = new Account();
		String salt= "";
		Integer role= null;
		try {
			PreparedStatement preparedStatement = connection
					.prepareStatement("Select * from account where username=? AND password=?");
			preparedStatement.setString(1, uname);
			preparedStatement.setString(2, passw);
			ResultSet rs = preparedStatement.executeQuery();   
			
			if(rs.next()){
				 //check id
				 role = rs.getInt("fk_acc_role");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return role;
	}
	
	public Integer getAccountId(String uname, String passw)
	{
		Account acc = new Account();
		String salt= "";
		Integer fk_part_acc= null;
		try {
			PreparedStatement preparedStatement = connection
					.prepareStatement("Select * from account where username=? AND password=?");
			preparedStatement.setString(1, uname);
			preparedStatement.setString(2, passw);
			ResultSet rs = preparedStatement.executeQuery();   
			
			if(rs.next()){
				 //check id
				 fk_part_acc = rs.getInt("fk_part_acc");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return fk_part_acc;
	}
	
	public Account getPasswordSecurity(String uname){

		Account acc = new Account();
		try{
			PreparedStatement preparedStatement = connection.prepareStatement("Select * from account where username=?");
			preparedStatement.setString(1, uname);
			ResultSet rs = preparedStatement.executeQuery(); 
			
			if (rs.next()) { 
			acc.setPassword(rs.getString("password"));
			acc.setSecurityCode(rs.getString("security"));
			}
		}
		catch(Exception e){}

		return acc;
	}
	
	public void updatePassword(Account acc)
	{
		try{
			PreparedStatement preparedStatement = connection.prepareStatement("update account set security=?,password=? where username=?");
			preparedStatement.setString(1, acc.getSecurityCode());
			preparedStatement.setString(2, acc.getPassword());
			preparedStatement.setString(3, acc.getUsername());
			int i = preparedStatement.executeUpdate();
		}
		catch(Exception e){}
	}
	
	public Integer checkLoginAttempt(String uname){
		Integer attempt = 0;
		
		try{
			PreparedStatement preparedStatement = connection.prepareStatement("Select login_attempt from account where username=?");
			preparedStatement.setString(1, uname);
			ResultSet rs = preparedStatement.executeQuery(); 
			
			if (rs.next()) { 
				attempt = rs.getInt("login_attempt");
			}
		}
		catch(Exception e){}

		return attempt;
	}
	
	
	public void reduceLoginAttempt(String uname){

		try{
			PreparedStatement preparedStatement = connection.prepareStatement("Update account set login_attempt=login_attempt-1 where username=?");
			preparedStatement.setString(1, uname);
			int i = preparedStatement.executeUpdate();
			
		}
		catch(Exception e){}

	}
	public void updateLoginAttempt(String uname){
		
		try{
			PreparedStatement preparedStatement = connection.prepareStatement("Update account set login_attempt = 4 where username=?");
			preparedStatement.setString(1, uname);
			int i = preparedStatement.executeUpdate();
		}
		catch(Exception e){}
	}

}

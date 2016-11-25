package com.sgs.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.sgs.model.Account;
import com.sgs.util.DbUtil;

public class AccountDao {

	private Connection connection;

	public AccountDao() {
		connection = DbUtil.getConnection();
	}
	
	public String getSalt(String username) throws SQLException{
		String salt= "";
		PreparedStatement preparedStatement = connection
				.prepareStatement("select security from account where username=?");
		try {
			
			preparedStatement.setString(1, username);
			ResultSet rs = preparedStatement.executeQuery();   
			
			if(rs.next()){
				 //check id
				  salt = rs.getString("security");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			preparedStatement.close();
		}
		return salt;
		
	}
	public Integer checkPassword(String uname, String passw) throws SQLException
	{
		//Account acc = new Account();
		Integer role= null;
		PreparedStatement preparedStatement = connection
				.prepareStatement("Select * from account where username=? AND password=?");
		try {
			preparedStatement.setString(1, uname);
			preparedStatement.setString(2, passw);
			ResultSet rs = preparedStatement.executeQuery();   
			
			if(rs.next()){
				 //check id
				 role = rs.getInt("fk_acc_role");
			}
			rs.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			preparedStatement.close();
		}
		
		return role;
	}
	
	public Integer getAccountId(String uname, String passw) throws SQLException
	{
		//Account acc = new Account();
		Integer fk_part_acc= null;

		PreparedStatement preparedStatement = connection
				.prepareStatement("Select * from account where username=? AND password=?");
		try {
			preparedStatement.setString(1, uname);
			preparedStatement.setString(2, passw);
			ResultSet rs = preparedStatement.executeQuery();   
			
			if(rs.next()){
				 //check id
				 fk_part_acc = rs.getInt("fk_part_acc");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			preparedStatement.close();
		}
		
		return fk_part_acc;
	}
	
	public Account getPasswordSecurity(String uname) throws SQLException{

		Account acc = new Account();
		PreparedStatement preparedStatement = connection.prepareStatement("Select * from account where username=?");
		try{
			preparedStatement.setString(1, uname);
			ResultSet rs = preparedStatement.executeQuery(); 
			
			if (rs.next()) { 
			acc.setPassword(rs.getString("password"));
			acc.setSecurityCode(rs.getString("security"));
			}
		}
		catch(Exception e){}
		finally{
			preparedStatement.close();
		}
		return acc;
		
	}
	
	public void updatePassword(Account acc) throws SQLException
	{
		PreparedStatement preparedStatement = connection.prepareStatement("update account set security=?,password=? where username=?");
		try{
			preparedStatement.setString(1, acc.getSecurityCode());
			preparedStatement.setString(2, acc.getPassword());
			preparedStatement.setString(3, acc.getUsername());
			preparedStatement.executeUpdate();
		}
		catch(Exception e){}
		finally{
			preparedStatement.close();
		}
	
	}
	
	public Integer checkLoginAttempt(String uname) throws SQLException{
		Integer attempt = 0;
		PreparedStatement preparedStatement = connection.prepareStatement("Select login_attempt from account where username=?");
		try{
			preparedStatement.setString(1, uname);
			ResultSet rs = preparedStatement.executeQuery(); 
			
			if (rs.next()) { 
				attempt = rs.getInt("login_attempt");
			}
		}
		catch(Exception e){}
		finally{
			preparedStatement.close();
		}
		
		return attempt;
	
	}
	
	
	public void reduceLoginAttempt(String uname) throws SQLException{

		PreparedStatement preparedStatement = connection.prepareStatement("Update account set login_attempt=login_attempt-1 where username=?");
		try{
			preparedStatement.setString(1, uname);
			preparedStatement.executeUpdate();
			
		}
		catch(Exception e){}
		finally{
			preparedStatement.close();
		}
		
	}
	public void updateLoginAttempt(String uname) throws SQLException{
		
		PreparedStatement preparedStatement = connection.prepareStatement("Update account set login_attempt = 5 where username=?");
		try{
			preparedStatement.setString(1, uname);
			preparedStatement.executeUpdate();
			
		}
		catch(Exception e){}
		finally{
			preparedStatement.close();
		}
		
	} 
	
}

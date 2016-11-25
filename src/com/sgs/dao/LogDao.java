package com.sgs.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Date;

import com.sgs.util.DbUtil;

public class LogDao {
	
	private Connection connection;
	
	public LogDao() {
		connection = DbUtil.getConnection();
	}
	
	public void logLogin(String username) throws SQLException{
		Date dt = new Date();
		PreparedStatement preparedStatement = connection
				.prepareStatement("INSERT INTO log (timestamp,action,username) "
						+ "VALUES(?,?,?)");
		try {
			preparedStatement.setTime(1, new java.sql.Time(dt.getTime()));
			preparedStatement.setString(2, "User has logged in.");
			preparedStatement.setString(3, username);
			preparedStatement.executeUpdate();
			System.out.println("DONE");
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			preparedStatement.close();
		}
	}
	public void logLogOut(String username) throws SQLException{
		Date dt = new Date();
		PreparedStatement preparedStatement = connection
				.prepareStatement("INSERT INTO log (timestamp,action,username) "
						+ "VALUES(?,?,?)");
		try {
			preparedStatement.setTime(1, new java.sql.Time(dt.getTime()));
			preparedStatement.setString(2, "User has logged out");
			preparedStatement.setString(3, username);
			preparedStatement.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			preparedStatement.close();
		}
	}
	
	public void logFailLogin(String username) throws SQLException{
		Date dt = new Date();
		PreparedStatement preparedStatement = connection
				.prepareStatement("INSERT INTO log (timestamp,action,username) "
						+ "VALUES(?,?,?)");
		try {
			preparedStatement.setTime(1, new java.sql.Time(dt.getTime()));
			preparedStatement.setString(2, "User has failed to log in.");
			preparedStatement.setString(3, username);
			preparedStatement.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			preparedStatement.close();
		}
	}
	
	public void logChangePassword(String username) throws SQLException{
		
		Date dt = new Date();
		PreparedStatement preparedStatement = connection
				.prepareStatement("INSERT INTO log (timestamp,action,username) "
						+ "VALUES(?,?,?)");
		try {
			preparedStatement.setTime(1, new java.sql.Time(dt.getTime()));
			preparedStatement.setString(2, "User has changed the password.");
			preparedStatement.setString(3, username);
			preparedStatement.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			preparedStatement.close();
		}
		
	}
	
	public void logAddMarks(String faculty, String student, String module) throws SQLException{
		
		System.out.println(faculty);
		System.out.println(student);
		System.out.println(module);
		
		Date dt = new Date();
		PreparedStatement preparedStatement = connection
				.prepareStatement("INSERT INTO log (timestamp,action,username) "
						+ "VALUES(?,?,?)");
		try {
			preparedStatement.setTime(1, new java.sql.Time(dt.getTime()));
			preparedStatement.setString(2, "Faculty " + faculty 
										+ " graded student " + student 
										+ " on " + module + " module.");
			preparedStatement.setString(3, faculty);

			preparedStatement.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			preparedStatement.close();
		}
		
	}
	
}
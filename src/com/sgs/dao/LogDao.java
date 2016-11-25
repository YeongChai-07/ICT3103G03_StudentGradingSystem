package com.sgs.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.sgs.util.DbUtil;

public class LogDao {
	
	private Connection connection;
	
	public LogDao() {
		connection = DbUtil.getConnection();
	}
	
	public void logLogin(String username){
		
		try {
			PreparedStatement preparedStatement = connection
					.prepareStatement("INSERT INTO log (action) "
							+ "VALUES(?)");
			preparedStatement.setString(1, "User " + username + " has logged in.");
			preparedStatement.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void logFailLogin(String username){
		
		try {
			PreparedStatement preparedStatement = connection
					.prepareStatement("INSERT INTO log (action) "
							+ "VALUES(?)");
			preparedStatement.setString(1, "User " + username + " has failed to log in.");
			preparedStatement.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void logChangePassword(String username){
		
		try {
			PreparedStatement preparedStatement = connection
					.prepareStatement("INSERT INTO log (action) "
							+ "VALUES(?)");
			preparedStatement.setString(1, "User " + username + " has changed the password.");
			preparedStatement.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}
	
	public void logAddMarks(String faculty, String student, String module){
		
		System.out.println(faculty);
		System.out.println(student);
		System.out.println(module);
		
		try {
			PreparedStatement preparedStatement = connection
					.prepareStatement("INSERT INTO log (action) "
							+ "VALUES(?)");
			preparedStatement.setString(1, "Faculty " + faculty 
					+ " graded student " + student 
					+ " on " + module + " module.");
			preparedStatement.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}
	
}

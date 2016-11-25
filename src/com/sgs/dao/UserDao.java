package com.sgs.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.sgs.model.User;
import com.sgs.util.DbUtil;

public class UserDao {

	private Connection connection;

	public UserDao() {
		connection = DbUtil.getConnection();
	}

	public void addUser(User user) throws SQLException {
		
		PreparedStatement preparedStatement = connection.prepareStatement("insert into users(firstname,lastname,dob,email) values (?, ?, ?, ? )");
		try {

			// Parameters start with 1
			preparedStatement.setString(1, user.getFirstName());
			preparedStatement.setString(2, user.getLastName());
			preparedStatement.setDate(3, new java.sql.Date(user.getDob().getTime()));
			preparedStatement.setString(4, user.getEmail());
			preparedStatement.executeUpdate();
			

		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			preparedStatement.close();
		}
	}
	
	public void deleteUser(int userId) throws SQLException {

		PreparedStatement preparedStatement = connection.prepareStatement("delete from users where userid=?");
		try {
			// Parameters start with 1
			preparedStatement.setInt(1, userId);
			preparedStatement.executeUpdate();
			

		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			preparedStatement.close();
		}
	}
	
	public void updateUser(User user) throws SQLException {
		PreparedStatement preparedStatement = connection
				.prepareStatement("update users set firstname=?, lastname=?, dob=?, email=?" +
						"where userid=?");
		try {
	
			// Parameters start with 1
			preparedStatement.setString(1, user.getFirstName());
			preparedStatement.setString(2, user.getLastName());
			preparedStatement.setDate(3, new java.sql.Date(user.getDob().getTime()));
			preparedStatement.setString(4, user.getEmail());
			preparedStatement.setInt(5, user.getUserid());
			preparedStatement.executeUpdate();
			

		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			preparedStatement.close();
		}
	}

	public List<User> getAllUsers() throws SQLException {
		List<User> users = new ArrayList<User>();
		Statement statement=connection.createStatement();
		try {
			ResultSet rs = statement.executeQuery("select * from users");
			while (rs.next()) {
				User user = new User();
				user.setUserid(rs.getInt("userid"));
				user.setFirstName(rs.getString("firstname"));
				user.setLastName(rs.getString("lastname"));
				user.setDob(rs.getDate("dob"));
				user.setEmail(rs.getString("email"));
				users.add(user);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		statement.close();

		return users;
	}
	
	public User getUserById(int userId) throws SQLException {
		User user = new User();

		PreparedStatement preparedStatement = connection.prepareStatement("select * from users where userid=?");
		try {
			preparedStatement.setInt(1, userId);
			ResultSet rs = preparedStatement.executeQuery();
			
			if (rs.next()) {
				user.setUserid(rs.getInt("userid"));
				user.setFirstName(rs.getString("firstname"));
				user.setLastName(rs.getString("lastname"));
				user.setDob(rs.getDate("dob"));
				user.setEmail(rs.getString("email"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			preparedStatement.close();
		}

		return user;
	}
}

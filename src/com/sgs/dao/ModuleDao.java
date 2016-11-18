package com.sgs.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.sgs.model.Module;
import com.sgs.model.StudentGrade;
import com.sgs.util.DbUtil;

public class ModuleDao {

	private static Connection connection;
	
	public ModuleDao(){
		connection = DbUtil.getConnection();
	}
	
	public List<Module> listModules(String username){
		System.out.println("ModuleDAO - listModule");
		System.out.println(username);
		List<Module> results = new ArrayList<Module>();
		
		try{
			//Query for database
			PreparedStatement preparedStatement = connection
					.prepareStatement("SELECT * FROM sgs.module WHERE idMod IN ("
							+ "SELECT fk_enroll_mod FROM sgs.enroll WHERE fk_enroll_acc = ("
							+ "SELECT idAcc FROM sgs.account WHERE username = ?))"); 
			preparedStatement.setString(1, username);
			
			//Perform query and get result
			ResultSet resultSet = preparedStatement.executeQuery();
			
			//Loop through and add each result into list
			while(resultSet.next()){
				Module module = new Module();
				module.setModId(resultSet.getString("idMod"));
				module.setModName(resultSet.getString("modName"));
				module.setModDesc(resultSet.getString("modDesc"));
				
				System.out.println(module.getModName());
				results.add(module);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return results;
	}
	
	public List<StudentGrade> listGrades(String username){
		System.out.println("ModuleDAO - listModule");
		System.out.println(username);
		List<StudentGrade> results = new ArrayList<StudentGrade>();
		
		try{
			//Query for database
			PreparedStatement preparedStatement = connection
					.prepareStatement("SELECT sgs.module.idMod, sgs.module.modName, sgs.enroll.grade "
							+ "FROM sgs.module "
							+ "JOIN sgs.enroll ON sgs.enroll.fk_enroll_mod = sgs.module.idMod "
							+ "JOIN sgs.account ON sgs.enroll.fk_enroll_acc = sgs.account.idAcc "
							+ "WHERE sgs.account.username = ?"); 
			preparedStatement.setString(1, username);
			
			//Perform query and get result
			ResultSet resultSet = preparedStatement.executeQuery();
			
			//Loop through and add each result into list
			while(resultSet.next()){
				StudentGrade studentGrade = new StudentGrade();
				studentGrade.setIdMod(resultSet.getString("idMod"));
				studentGrade.setModName(resultSet.getString("modName"));
				String grade = (resultSet.getString("grade"));
				if (grade == null){
					studentGrade.setGrade("Not Graded");
				} else {
					studentGrade.setGrade(resultSet.getString("grade"));
				}
				
				System.out.println(studentGrade.getModName());
				results.add(studentGrade);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return results;
	}
	
	public void addMarks(float marks, String modId, String username) throws Exception{
		System.out.println("ModuleDAO - addMarks");
		System.out.println(modId + ", " + username);
		
		try{
			//Query for update database
			PreparedStatement preparedStatement = connection
					.prepareStatement("UPDATE Enroll SET grade = ? WHERE fk_enroll_mod = ? "
							+ "AND fk_enroll_acc in "
							+ "(SELECT idAcc FROM account WHERE username = ?)"); 
			preparedStatement.setFloat(1, marks);
			preparedStatement.setString(2, modId);
			preparedStatement.setString(3, username);
			
			//Perform query and get result
			preparedStatement.executeUpdate();
		} catch (Exception e){
			throw e;
		}
	}
	
}

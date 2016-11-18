package com.sgs.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.sgs.model.StudentModule;
import com.sgs.util.DbUtil;

public class FacultyDao {
	
	private static Connection connection;
	
	public FacultyDao(){
		connection = DbUtil.getConnection();
	}
	
	/*listStudents will display students taking the module of the lecturer logged in.*/
	public List<StudentModule> listStudents(String username){
		System.out.println("FacultyDAO - listStudents");
		System.out.println(username);
		List<StudentModule> results = new ArrayList<StudentModule>();
		try{
			//Query for database
			PreparedStatement preparedStatement = connection
					.prepareStatement("SELECT sgs.account.username, sgs.particulars.name, sgs.module.idMod, sgs.module.modName, sgs.enroll.grade FROM sgs.module "
							+ "JOIN sgs.enroll ON sgs.enroll.fk_enroll_mod = sgs.module.idMod " +
							"JOIN sgs.account ON sgs.enroll.fk_enroll_acc = sgs.account.idAcc " +
							"JOIN sgs.particulars ON sgs.particulars.fk_part_acc = sgs.account.idAcc " +
							" WHERE sgs.account.fk_acc_role = 2 AND sgs.enroll.fk_enroll_mod IN (" + 
							" SELECT sgs.enroll.fk_enroll_mod FROM sgs.account JOIN sgs.enroll ON sgs.enroll.fk_enroll_acc = sgs.account.idAcc "
							+ "WHERE sgs.account.username = ? ) ORDER BY idMod"); 
			preparedStatement.setString(1, username);
			
			//Perform query and get result
			ResultSet resultSet = preparedStatement.executeQuery();
			
			//Loop through and add each result into list
			while(resultSet.next()){
//			      String Username= resultSet.getString("username");
//			      String Name=resultSet.getString("name");
//			      String Module=resultSet.getString("idMod");
//			      String ModName=resultSet.getString("modName");
				
				StudentModule studentModule = new StudentModule();
				studentModule.setUsername(resultSet.getString("username"));
			    studentModule.setName(resultSet.getString("name"));
			    studentModule.setIdMod(resultSet.getString("idMod"));
			    studentModule.setModName(resultSet.getString("modName"));
			    if (resultSet.getFloat("grade") != 0.0f){
			    	studentModule.setGrade(Float.toString(resultSet.getFloat("grade")));
			    } else {
			    	studentModule.setGrade("Not Graded");
			    }
			    
			    System.out.println(studentModule.getUsername());
			    results.add(studentModule);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return results;
	}

}

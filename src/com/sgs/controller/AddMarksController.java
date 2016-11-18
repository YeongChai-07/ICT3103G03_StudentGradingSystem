package com.sgs.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sgs.dao.FacultyDao;
import com.sgs.dao.ModuleDao;
import com.sgs.model.StudentModule;

public class AddMarksController extends HttpServlet {
	
	private static final long serialVersionUID = 3L;
	private static String ADD_MARKS = "/faculty_addmarks.jsp";
    private static String FACULTY_LISTSTU = "./faculty_liststudent.jsp";
	private static String CANCEL = "/FacultyController";
	private ModuleDao dao;
	private HttpSession hs; 
	
	public AddMarksController() {
		super();
		dao = new ModuleDao();
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		hs = request.getSession();
		System.out.println("AddMarksController doGet");
		
		String forward = "";
		
		List<StudentModule> results = new ArrayList<StudentModule>();
		
		//Retrieve values from from data
		StudentModule studentModule = new StudentModule();
		String[] stID = request.getParameterValues("stID");
		String[] stName = request.getParameterValues("stName");
		String[] stModID = request.getParameterValues("stModID");
		String[] stModName = request.getParameterValues("stModName");
		
		studentModule.setUsername(stID[0]);
		studentModule.setName(stName[0]);
		studentModule.setIdMod(stModID[0]);
		studentModule.setModName(stModName[0]);
		results.add(studentModule);
		
		forward = ADD_MARKS;
		request.setAttribute("results", results);
		
		RequestDispatcher view = request.getRequestDispatcher(forward);
		view.forward(request, response);
		
	}
	
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    	hs = request.getSession();
    	System.out.println("AddMarksController doPost");
    	
    	String forward = "";
    	String result = "";
    	
    	result = request.getParameter("action");
    	
    	if (result.equals("Submit")){
    		System.out.println("Submit button triggered");
    		String modId = request.getParameter("modID");
    		String stId = request.getParameter("stID");
    		float marks = Float.parseFloat(request.getParameter("grades"));
    		
    		System.out.println(marks);
    		System.out.println(modId + " " + stId);
    		
    		try {
				dao.addMarks(marks, modId, stId);
				FacultyDao facultyDao = new FacultyDao();
				forward = FACULTY_LISTSTU;
	        	request.setAttribute("results", facultyDao.listStudents((String)hs.getAttribute("uname")));
	        	request.setAttribute("getAlert", "Yes");
	        	
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
    		
    	} else {
    		System.out.println("Cancel button triggered");
    		request.setAttribute("action", "stu");
    		forward = CANCEL;
    	}

        RequestDispatcher view = request.getRequestDispatcher(forward);
        view.forward(request, response);
    }
}

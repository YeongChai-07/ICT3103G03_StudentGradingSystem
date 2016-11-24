package com.sgs.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sgs.dao.ModuleDao;

import java.security.*;

public class StudentController extends HttpServlet {
    private String STUDENT_SEARCH = "./student_home.jsp";
    private String STUDENT_VIEWMODULES = "./student_enrolledmodules.jsp";
    private String STUDENT_VIEWGRADES = "./student_viewgrades.jsp";
    private String CHANGE_PASS = "./change_password.jsp";
    private String ERROR = "/login.jsp?invaliduser";
    private ModuleDao dao;
    private HttpSession hs; 
    
    public StudentController() {
    	super();
    	dao = new ModuleDao();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    	hs = request.getSession();
    	System.out.println("StudentController doGet");
    	
        String forward="";
        String result ="";
        
	    result = request.getParameter("action");
	    
	    if (result.equals("search")){
	    	forward = STUDENT_SEARCH;
	    }else if (result.equals("modules")){
	    	forward = STUDENT_VIEWMODULES;
	    	request.setAttribute("results", dao.listModules((String)hs.getAttribute("uname")));
	    } else if (result.equals("grades")){
	    	forward = STUDENT_VIEWGRADES;
	    	request.setAttribute("results", dao.listGrades((String)hs.getAttribute("uname")));
	    } else if (result.equals("change")){
	    	forward = CHANGE_PASS;
	    	
	    } else {
	    	forward = ERROR;
	    	
	    }
	    
	    System.out.println(forward);
	    RequestDispatcher view = request.getRequestDispatcher(forward);
	    view.forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	System.out.println("StudentController doPost");
    }
}

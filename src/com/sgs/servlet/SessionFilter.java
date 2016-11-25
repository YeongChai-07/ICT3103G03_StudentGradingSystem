package com.sgs.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.StringTokenizer;

import javax.servlet.*;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class SessionFilter implements Filter {
	private ArrayList<String> urlList;
	
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) res;
		String url = request.getServletPath();
		boolean allowedRequest = false;
		
		if(urlList.contains(url)){
			allowedRequest = true;
		}
		
//		if(url.startsWith("/css/") || url.startsWith("/js/") || url.startsWith("/font-awesome/") || url.startsWith("/images/")){ //url.startsWith("/css/") ||
//			allowedRequest = true;
//		}
		
		if(!allowedRequest){
			HttpSession session = request.getSession(false);
			if (session == null || session.getAttribute("user") == null) {
				System.out.println(url + "denied");
				response.sendRedirect("/");
				return;
			}
		}else{
			System.out.println("allowed "+url);
		}
		
		chain.doFilter(req, res);
	}
	
	public void init(FilterConfig config) throws ServletException {
		String urls = config.getInitParameter("avoid-urls");
		StringTokenizer token = new StringTokenizer(urls, ",");
		urlList = new ArrayList<>();
		
		while (token.hasMoreTokens()){
			urlList.add(token.nextToken());
			
		}
	}
	

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}
}

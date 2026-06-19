package com.vibeshop.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.regex.*;

@WebServlet("/CheckEmail")
 public class CheckEmail extends HttpServlet {
	public void doPost (HttpServletRequest request , HttpServletResponse response)throws ServletException, IOException{
		
		String email = request.getParameter("email");
		Pattern regex =Pattern.compile("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$");// serve per crea la regex 
		Matcher controllo = regex.matcher(email);// applichi la regex all'email , controllo contiene il risultato della regex
		
		if(controllo.matches()){
			response.getWriter().println("Email valida");
		}else {
			response.getWriter().println("Email non valida");
		}
	}
}

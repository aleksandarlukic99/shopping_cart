package com.aleksandar.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.JOptionPane;

import com.aleksandar.connection.DbConn;
import com.aleksandar.dao.UserDao;
import com.aleksandar.model.User;


@WebServlet("/user-login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.sendRedirect("login.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		try (PrintWriter out = response.getWriter()) {
			String email = request.getParameter("login-email");
			String password = request.getParameter("login-password");
			
			try {
				UserDao userdao = new UserDao(DbConn.getConnection());
				User user = userdao.userLogin(email, password);
				
				if(user !=null) {
					out.print("user login");
					request.getSession().setAttribute("auth",user);
					response.sendRedirect("index.jsp");
				} else {
					JOptionPane.showMessageDialog(null, "Please check your user credentials", "Wrong password or email.", JOptionPane.INFORMATION_MESSAGE);
					response.sendRedirect("login.jsp");
				}
				
			} catch (ClassNotFoundException | SQLException e) {
				e.printStackTrace();
			}
			
		}
	}

}

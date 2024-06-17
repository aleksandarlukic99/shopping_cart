package com.aleksandar.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.aleksandar.model.User;

public class UserDao {
	private Connection con;
	private String query;
	private PreparedStatement pstat;
	private ResultSet resSet;
	
	public UserDao(Connection con) {
		super();
		this.con = con;
	}
	
	public User userLogin(String email, String password) {
		User user = null;
		try {
			query = "select * from users where email=? and password=?";
			pstat = this.con.prepareStatement(query);
			pstat.setString(1, email);
			pstat.setString(2, password);
			resSet = pstat.executeQuery();
			
			if(resSet.next()) {
				user = new User();
				user.setId(resSet.getInt("id"));
				user.setName(resSet.getString("name"));
				user.setEmail(resSet.getString("email"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.print(e.getMessage());
		}
		return user;
	}
}

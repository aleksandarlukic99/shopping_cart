package com.aleksandar.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;
import com.aleksandar.model.*;

public class ProductDao {

	private Connection con;
	private String query;
	private PreparedStatement pstat;
	private ResultSet resSet;

	public ProductDao(Connection con) {
		this.con = con;
	}

	public List<Product> getAllProducts() {
		List<Product> products = new ArrayList<Product>();

		try {
			query = "select * from products";
			pstat = this.con.prepareStatement(query);
			resSet = pstat.executeQuery();
			while (resSet.next()) {
				Product row = new Product();
				row.setId(resSet.getInt("id"));
				row.setName(resSet.getString("name"));
				row.setCategory(resSet.getString("category"));
				row.setPrice(resSet.getDouble("price"));
				row.setImage(resSet.getString("image"));

				products.add(row);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return products;
	}

	public List<Cart> getCartProducts(ArrayList<Cart> cartList) {
		List<Cart> products = new ArrayList<Cart>();

		try {
			if (cartList.size() > 0) {
				for (Cart item : cartList) {
					query = "SELECT * FROM products WHERE id=?";
					pstat = this.con.prepareStatement(query);
					pstat.setInt(1, item.getId());
					resSet = pstat.executeQuery();
					while (resSet.next()) {
						Cart row = new Cart();
						row.setId(resSet.getInt("id"));
						row.setName(resSet.getString("name"));
						row.setCategory(resSet.getString("category"));
						row.setPrice(resSet.getDouble("price") * item.getQuantity());
						row.setImage(resSet.getString("image"));
						row.setQuantity(item.getQuantity());
						products.add(row);
					}
				}
			}

		} catch (Exception e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
		return products;
	}

	public double getTotalCartPrice(ArrayList<Cart> cartList) {
		double sum = 0;
				
		try {
			if(cartList.size()>0) {
				for(Cart item: cartList) {
					query = "select price from products where id=?";
					pstat = this.con.prepareStatement(query);
					pstat.setInt(1, item.getId());
					resSet = pstat.executeQuery();
					
					while(resSet.next()) {
						sum+= resSet.getDouble("price")*item.getQuantity();
					}
				}
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return sum;
	}
	
	public Product getSingleProduct(int id) {
		Product row = null;
		
		try {
			query = "select * from products where id=?";
			pstat = this.con.prepareStatement(query);
			pstat.setInt(1, id);
			resSet = pstat.executeQuery();
			
			while (resSet.next()) {
				row = new Product();
				row.setId(resSet.getInt("id"));
				row.setName(resSet.getString("name"));
				row.setCategory(resSet.getString("category"));
				row.setPrice(resSet.getDouble("price"));
				row.setImage(resSet.getString("image"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return row;
	}

}

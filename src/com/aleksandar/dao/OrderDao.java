package com.aleksandar.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

import com.aleksandar.model.Order;
import com.aleksandar.model.Product;

public class OrderDao {
	private Connection con;
	private String query;
	private PreparedStatement pstat;
	private ResultSet resSet;

	public OrderDao(Connection con) {
		this.con = con;
	}

	public boolean insertOrder(Order model) {
		boolean result = false;

		try {
			query = "insert into orders (p_id, u_id, o_quantity, o_date) values(?,?,?,?)";
			pstat = this.con.prepareStatement(query);
			pstat.setInt(1, model.getId());
			pstat.setInt(2, model.getUserId());
			pstat.setInt(3, model.getQuantity());
			pstat.setString(4, model.getDate());
			pstat.executeUpdate();
			result = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public List<Order> userOrders(int id) {
		List<Order> list = new ArrayList();

		try {
			query = "select * from orders where u_id=? order by orders.o_id desc";
			pstat = this.con.prepareStatement(query);
			pstat.setInt(1, id);
			resSet = pstat.executeQuery();

			while (resSet.next()) {
				Order order = new Order();
				ProductDao productDao = new ProductDao(this.con);
				int productId = resSet.getInt("p_id");
				
				Product product = productDao.getSingleProduct(productId);
				order.setOrderId(resSet.getInt("o_id"));
				order.setId(productId);
				order.setName(product.getName());
				order.setCategory(product.getCategory());
				order.setPrice(product.getPrice()*resSet.getInt("o_quantity"));
				order.setQuantity(resSet.getInt("o_quantity"));
				order.setDate(resSet.getString("o_date"));
				list.add(order);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}

		return list;
	}
	
	public void cancelOrder(int id) {
		try {
			query = "delete from orders where o_id=?";
			pstat = this.con.prepareStatement(query);
			pstat.setInt(1, id);
			pstat.execute();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}

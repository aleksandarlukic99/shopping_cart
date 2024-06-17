<%@ page import="com.aleksandar.connection.DbConn"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="com.aleksandar.model.*"%>
<%@ page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="com.aleksandar.dao.*"%>
<%
DecimalFormat decForm = new DecimalFormat("#.##");
request.setAttribute("decForm", decForm);

User auth = (User) request.getSession().getAttribute("auth");
List<Order> orders = null;
if (auth != null) {
	request.setAttribute("auth", auth);
	OrderDao orderDao = new OrderDao(DbConn.getConnection());
	orders = orderDao.userOrders(auth.getId());
} else {
	response.sendRedirect("login.jsp");
}
ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
if (cart_list != null) {
	request.setAttribute("cart_list", cart_list);
}
%>
<!DOCTYPE html>
<html>
<head>
<title>Orders</title>
<%@include file="includes/head.jsp"%>
<style type="text/css">
.table tbody td {
	vertical-align: middle;
}

.table-container {
	margin: 0 auto;
	max-width: 80%;
}
.table thead th {
    background-color: #82E0AA;
}

.table tbody td:nth-child(even) {
    background-color: #EAFAF1;
}
</style>
</head>
<body>
	<%@include file="includes/navbar.jsp"%>

	<div class="container my-3">
		<div class="table container">
			<div class="d-flex py-3">
				<h3>All orders</h3>
			</div>
			<table class="table table-light">
				<thead>
					<tr>
						<th scope="col">Date</th>
						<th scope="col">Name</th>
						<th scope="col">Category</th>
						<th scope="col">Quantity</th>
						<th scope="col">Price</th>
						<th scope="col">Cancel</th>
					</tr>
				</thead>
				<tbody>
				<%
				if(orders != null) {
					for (Order o:orders) { %>
					<tr>
						<td><%=o.getDate()%> </td>
						<td><%=o.getName()%> </td>
						<td><%=o.getCategory()%> </td>
						<td><%=o.getQuantity()%> </td>
						<td><%=decForm.format(o.getPrice()) + "$"%> </td>
						<td><a class="btn btn-sm btn-danger"
						href="cancel-order?id=<%=o.getOrderId()%>">Cancel</a></td>
						</tr>
					<%}
				}
				%>
				</tbody>
			</table>
		</div>
	</div>

	<%@include file="includes/footer.jsp"%>
</body>
</html>
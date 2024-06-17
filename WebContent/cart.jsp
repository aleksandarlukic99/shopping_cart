<%@ page import="com.aleksandar.connection.DbConn"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="com.aleksandar.model.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.aleksandar.dao.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.text.DecimalFormat"%>

<%
DecimalFormat decForm = new DecimalFormat("#.##");
request.setAttribute("decForm", decForm);

User auth = (User) request.getSession().getAttribute("auth");
if (auth != null) {
	request.setAttribute("auth", auth);
}

ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
List<Cart> cartProduct = null;
if (cart_list != null) {
	ProductDao proDao = new ProductDao(DbConn.getConnection());
	cartProduct = proDao.getCartProducts(cart_list);
	double total = proDao.getTotalCartPrice(cart_list);
	request.setAttribute("cart_list", cart_list);
	request.setAttribute("total", total);
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Cart</title>
<%@include file="includes/head.jsp"%>
<style>
.table tbody td {
	vertical-align: middle;
}

.btn-incre, .btn-decre {
	box-shadow: none;
	font-size: 25px;
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
		<div class="d-flex py-3">
			<h3>Total price: $ ${ (total>0)?decForm.format(total):0 }</h3>
			<a class="mx-3 btn btn-success" href="cart-check-out">Check out</a>
		</div>
		<table class="table table-light">
			<thead>
				<tr>
					<th scope="col">Name</th>
					<th scope="col">Category</th>
					<th scope="col">Price</th>
					<th scope="col">Buy now</th>
					<th scope="col">Cancel</th>
				</tr>
			</thead>
			<tbody>
				<%
				if (cart_list != null) {
					for (Cart c : cartProduct) {
				%>
				<tr>
					<td><%=c.getName()%></td>
					<td><%=c.getCategory()%></td>
					<td><%=decForm.format(c.getPrice()) + "$"%></td>
					<td>
						<form action="order-now" method="post" class="form-inline">
							<input type="hidden" name="id" value="<%=c.getId()%>"
								class="form-input">
							<div class="form-group d-flex justify-content-between w-50">
								<a class="btn btn-sm btn-decre"
									href="quantity-inc-dec?action=dec&id=<%=c.getId()%>">
								<i class="fas fa-minus-square"></i>
								</a>
								 <input type="text" name="quantity" class="form-control" value="<%=c.getQuantity()%>" readonly> <a
									class="btn btn-sm btn-incre"
									href="quantity-inc-dec?action=inc&id=<%=c.getId()%>"> <i
									class="fas fa-plus-square href="></i></a>
									<button type="submit" class="btn btn-success btn-sm">Buy</button>
							</div>
						</form>
					</td>
					<td><a class="btn btn-sm btn-danger"
						href="remove-from-cart?id=<%=c.getId()%>">Remove</a></td>
				</tr>
				<%
				}
				}
				%>

			</tbody>
		</table>
	</div>

	<%@include file="includes/footer.jsp"%>
</body>
</html>
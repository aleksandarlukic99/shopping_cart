<%@ page import="java.util.*"%>
<%@ page import="com.aleksandar.connection.DbConn"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="com.aleksandar.model.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.aleksandar.model.*"%>
<%@page import="com.aleksandar.dao.*"%>
<%
User auth = (User) request.getSession().getAttribute("auth");
if (auth != null) {
	request.setAttribute("auth", auth);
}

ProductDao pd = new ProductDao(DbConn.getConnection());
List<Product> products = pd.getAllProducts();

ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
if (cart_list != null) {
	request.setAttribute("cart_list", cart_list);
}
%>
<!DOCTYPE html>
<html>
<head>
<title>Shopping cart</title>
<%@include file="includes/head.jsp"%>
<style>
.card-img-top {
	height: 200px;
	object-fit: cover;
}

.custom-card-margin {
	margin-left: 10px;
	margin-right: 10px;
}

.card-title {
	display: -webkit-box;
	-webkit-box-orient: vertical;
	-webkit-line-clamp: 2;
	overflow: hidden;
	text-overflow: ellipsis;
	height: 3em;
}

.card-bg {
	background-color: #EAFAF1
}
</style>
</head>
<body>
	<%@include file="includes/navbar.jsp"%>
	<div class="container">
		<div class="card-header my-3">
			<h3>All products</h3>
		</div>
		<div class="row">
			<%
			if (!products.isEmpty()) {
				for (Product p : products) {
			%>
			<div class="col-md-3 my-3 ml-3">
				<div class="card w-100" style="width: 18rem;">
					<img class="card-img-top" src="images/<%=p.getImage()%>"
						alt="Card image cap">
					<div class="card-bg">
						<div class="card-body">
							<h5 class="card-title"><%=p.getName()%></h5>
							<h6 class="price">
								Price:<%=p.getPrice()%>$
							</h6>
							<h6 class="category">
								Category:
								<%=p.getCategory()%></h6>
							<div class="mt-3 d-flex justify-content-between">
								<a href="add-to-cart?id=<%=p.getId()%>" class="btn btn-dark">Add
									to cart</a> <a href="order-now?quantity=1&id=<%=p.getId()%>"
									class="btn btn-success">Buy now</a>
							</div>
						</div>
					</div>
				</div>
			</div>
			<%
			}
			}
			%>
		</div>
	</div>
	<%@include file="includes/footer.jsp"%>
</body>
</html>
<!DOCTYPE html>
<html>
<head>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <style>
        .navbar-custom {
            background-color: #239B56;
            font-family: 'Roboto', sans-serif; 
        }
        .navbar-custom .navbar-brand,
        .navbar-custom .nav-link {
            color: white; 
        }
        .navbar-custom .nav-link.active {
            font-weight: bold;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-custom">
        <div class="container">
            <a class="navbar-brand" href="index.jsp"><h3>Shopping cart</h3></a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent" aria-expanded="false"
                aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse justify-content-end"
                id="navbarSupportedContent">
                <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                    <li class="nav-item"><a class="nav-link active"
                        aria-current="page" href="index.jsp">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="cart.jsp">Cart<span class="badge bg-danger px-1">${ cart_list != null ? cart_list.size() : 0 }</span></a>
                    </li>
                    <%
                    if (auth != null) {%>
                        <li class="nav-item">
                            <a class="nav-link" href="orders.jsp">Orders</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="log-out">Logout</a>
                        </li>
                    <%
                    } else { %>
                        <li class="nav-item">
                            <a class="nav-link" href="login.jsp">Login</a>
                        </li>
                    <%
                    }
                    %>
                </ul>
            </div>
        </div>
    </nav>
</body>
</html>

<%@page import="javax.persistence.*" %> 
<%@page import="java.io.*" %> 
<%@page import="com.customer.Customer" %> 

<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="styles.css">
  <title>Home - Welcome Operator</title>
</head>
<body>
	<div class="main">
		<button onclick="location.href='AddCustomer.html'" >Add Customer</button>
		<button onclick="location.href='Bookings.jsp'" >Show Bookings</button>
	</div>
</body>
</html>
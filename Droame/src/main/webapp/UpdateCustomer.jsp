<%@page import="javax.persistence.*" %> 
<%@page import="java.io.*" %> 
<%@page import="com.customer.Customer" %> 
<%
	EntityManagerFactory emf = Persistence.createEntityManagerFactory("AnyName");
	EntityManager em = emf.createEntityManager();
	EntityTransaction et = em.getTransaction();
	String cid = request.getParameter("cid");
	if(cid == "" || cid == null) {
		RequestDispatcher rd = request.getRequestDispatcher("UpdateCustomer.jsp");
		out.print("<div class='msg' style='color:red;padding:10px;font-size:15px;'>No Customer found!</div>");
		rd.include(request, response);
	}
	int id = Integer.parseInt(cid);
	Customer cust = (Customer) em.find(Customer.class, id);
%>
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
		<form action="cust1" method="get">
			<input type="text" name="cid" placeholder="<%= cust.getId() %>" disabled>
			<input type="text" name="cname" placeholder="Customer Name" value="<%= cust.getCname() %>" >
			<input type="email" name="email" placeholder="Email" value="<%= cust.getEmail() %>" >
			<input type="text" name="phone" placeholder="Phone" value="<%= cust.getPhone() %>" >
			<input type="date" name="dob" placeholder="Date of Booking" value="<%= cust.getBdate() %>" >
			<input type="submit" value="Update" class="button">
		</form>
		<input onclick="location.href='index.jsp'" value="Back" style="text-align:center" class="button">
	</div>
</body>
</html>

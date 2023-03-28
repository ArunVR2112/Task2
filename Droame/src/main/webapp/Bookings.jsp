<%@page import="javax.persistence.*" %> 
<%@page import="java.io.*" %> 
<%@page import="java.util.*" %> 
<%@page import="com.customer.Customer" %>

<%!
	
	
	EntityManagerFactory emf = Persistence.createEntityManagerFactory("AnyName");
	EntityManager em = emf.createEntityManager();
	EntityTransaction et = em.getTransaction();		

	public int approve(int cid){
		Customer cust = (Customer) em.find(Customer.class, cid);
		if(cust.getStatus().equals("Approved")) cust.setStatus("Pending");
		else cust.setStatus("Approved");
		et.begin();
		em.merge(cust);
		et.commit();
		return cid;
	}
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
		<% 
		
		// java code to fetch data from database.
		// i.e. All the bookings present inside database table.
		String id = request.getParameter("cid");
		if(id != null && !id.equals("Approved") && id != "")
			approve(Integer.parseInt(request.getParameter("cid")));
		
		EntityManagerFactory emf = Persistence.createEntityManagerFactory("AnyName");
		EntityManager em = emf.createEntityManager();
		EntityTransaction et = em.getTransaction();		
		
		Query query = em.createQuery("select a from Customer a");
		List<Customer> cli = query.getResultList();
		
		
		// Java Code to delete the customer
		
		String btn = request.getParameter("del_button");
		if(!(btn == null || btn == "")){
		
			String del_id = request.getParameter("del");
			
			if(!(del_id == "" || del_id == null)){

				int did = Integer.parseInt(del_id);
				Customer customer = (Customer) em.find(Customer.class, did);
				et.begin();
				em.remove(customer);
				et.commit();

				RequestDispatcher rd = request.getRequestDispatcher("Bookings.jsp");
				out.print("<div class='msg' style='color:green;padding:10px;font-size:15px;'>Customer removed!</div>");
				rd.include(request, response);
			} else {
				out.print("<div class='msg' style='color:red;padding:10px;font-size:15px;'>No Customer found!</div>");
			}
		}
		%>
		
		<table border="1">
		
		<tr style="backgound-color:white;padding:10px">
			<th>ID</th>
			<th>Name</th>
			<th>Email</th>
			<th>Phone</th>
			<th>Date</th>
			<th>Status</th>
		</tr>
		<%
		for(Customer c : cli){
		%>
		<tr style="backgound-color:black;color:white;">
			<td style="padding:20px"><%= c.getId() %></td>
			<td><%= c.getCname() %></td>
			<td><%= c.getEmail() %></td>
			<td><%= c.getPhone() %></td>
			<td><%= c.getBdate() %></td>
			<td>
				<form action="Bookings.jsp">
					<input type="submit" onclick="this.value='Approved'" value="<%= c.getStatus() %>" id="button">
					<input style="display:none" value="<%= c.getId() %>" name="cid">
				</form>
			</td>
		</tr>
		<% } %>
		</table>
		<div class="menu">

		<form action="UpdateCustomer.jsp" style="display:flex">
			<input name="cid" style="width:50px;" placeholder="ID">
			<input type="submit" value="Update" style="text-align:center" class="button">
		</form>

		<form action="Bookings.jsp" style="display:flex">
			<input name="del" style="width:50px;" placeholder="ID">
			<input type="submit" value="Delete" name="del_button" style="text-align:center" class="button">
		</form>

		<input onclick="location.href='index.jsp'" value="Back" style="text-align:center" class="button" ></div>
	</div>
</body>
</html>

package com.customer;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/cust1")
public class CustomerController extends HttpServlet {
	EntityManagerFactory emf = Persistence.createEntityManagerFactory("AnyName");
	EntityManager em = emf.createEntityManager();
	EntityTransaction et = em.getTransaction();

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String id = req.getParameter("cid");
		if (id == "" || id == null) {
			PrintWriter out = resp.getWriter();

			RequestDispatcher rd = req.getRequestDispatcher("AddCustomer.html");
			out.print("<div class='msg' style='color:red;padding:10px;font-size:15px;'>Fill the form!</div>");
			rd.include(req, resp);
			return;
		}

		try {
			int cid = Integer.parseInt(id);
			String cname = req.getParameter("cname");
			String email = req.getParameter("email");
			long phone = Long.parseLong(req.getParameter("phone"));

			Customer cust = new Customer();
			cust.setId(cid);
			cust.setCname(cname);
			cust.setEmail(email);
			cust.setPhone(phone);

			java.util.Date local_date = new java.util.Date();
			java.sql.Date sql_date = new java.sql.Date(local_date.getDate());
			

			cust.setBdate(sql_date);
			cust.setStatus("Pending");

			et.begin();
			em.persist(cust);
			et.commit();
			PrintWriter out = resp.getWriter();
			RequestDispatcher rd = req.getRequestDispatcher("AddCustomer.html");
			out.print("<div class='msg' style='color:green;padding:10px;font-size:15px;'>Customer Added!</div>");
			rd.include(req, resp);

		} catch (Exception e) {
			System.out.println("catch");
			PrintWriter out = resp.getWriter();
			RequestDispatcher rd = req.getRequestDispatcher("AddCustomer.html");
			out.print("<div class='msg' style='color:red;padding:10px;font-size:15px;'>Error Occured!</div>");
			rd.include(req, resp);
		}
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String id = req.getParameter("cid");
		if (id == "" || id == null) {
			PrintWriter out = resp.getWriter();
			RequestDispatcher rd = req.getRequestDispatcher("UpdateCustomer.jsp");
			out.print("<div class='msg' style='color:red;padding:10px;font-size:15px;'>No Customer found!</div>");
			rd.include(req, resp);
			return;
		}
		try {
			int cid = Integer.parseInt(id);
			String cname = req.getParameter("cname");
			String email = req.getParameter("email");
			long phone = Long.parseLong(req.getParameter("phone"));
			String date = req.getParameter("dob");
	
			Customer cust = new Customer();
			cust.setId(cid);
			cust.setCname(cname);
			cust.setEmail(email);
			cust.setPhone(phone);
	
			et.begin();
			em.merge(cust);
			et.commit();
			PrintWriter out = resp.getWriter();
			RequestDispatcher rd = req.getRequestDispatcher("Bookings.jsp");
			out.print("<div class='msg' style='color:green;padding:10px;font-size:15px;'>Data has been updated!</div>");
			rd.include(req, resp);

		}catch(Exception e) {
			PrintWriter out = resp.getWriter();
			RequestDispatcher rd = req.getRequestDispatcher("UpdateCustomer.jsp");
			out.print("<div class='msg' style='color:red;padding:10px;font-size:15px;'>Error Occured!</div>");
			rd.include(req, resp);
		}
	}
}
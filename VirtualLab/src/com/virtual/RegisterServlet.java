package com.virtual;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String password = request.getParameter("password");

		try {
			Connection conn = DBConnection.getConnection();

			String sql = "INSERT INTO users(name, email, password) VALUES (?, ?, ?)";
			PreparedStatement ps = conn.prepareStatement(sql);

			ps.setString(1, name);
			ps.setString(2, email);
			ps.setString(3, password);

			int rows = ps.executeUpdate();

			if (rows > 0) {
				response.sendRedirect("index.jsp");
			} else {
				response.getWriter().println("Registration Failed!");
			}

			conn.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
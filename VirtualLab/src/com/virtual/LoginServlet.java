package com.virtual;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username").trim();
        String password = request.getParameter("password").trim();
        String loginType = request.getParameter("loginType"); // user or admin

        try {
            Connection conn = DBConnection.getConnection();
            System.out.println("LoginServlet DB connection called");
String sql = "";

if(loginType.equals("admin")) {
    sql = "SELECT * FROM admin WHERE username=? AND password=?";
} else {
    sql = "SELECT * FROM users WHERE name=? AND password=?";
}

PreparedStatement ps = conn.prepareStatement(sql);
ps.setString(1, username);
ps.setString(2, password);

ResultSet rs = ps.executeQuery();

if(rs.next()) {
    HttpSession session = request.getSession();

    if(loginType.equals("admin")) {
        session.setAttribute("admin", username);
        response.sendRedirect("adminDashboard.jsp");
    } else {
        session.setAttribute("username", rs.getString("name"));
        session.setAttribute("userId", rs.getInt("id"));
        response.sendRedirect("userDashboard.jsp");
    }
}
            else {
                response.getWriter().println("Invalid Username or Password");
            }

            conn.close();

        } catch(Exception e) {
            e.printStackTrace();
            response.getWriter().println("Internal Server Error");
        }
    }
}

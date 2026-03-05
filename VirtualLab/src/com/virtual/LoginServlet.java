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

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String loginType = request.getParameter("loginType"); // user or admin

        try {
            Connection conn = DBConnection.getConnection();
            System.out.println("LoginServlet DB connection called");

            String sql = "SELECT * FROM users WHERE name=? AND password=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if(rs.next()) {
                String role = rs.getString("role");

                HttpSession session = request.getSession();
                session.setAttribute("username", username);
                session.setAttribute("role", role);
                session.setAttribute("userId", rs.getInt("id"));

                if(role.equals("admin") && loginType.equals("admin")) {
                    response.sendRedirect("adminDashboard.jsp");
                } else if(role.equals("user") && loginType.equals("user")) {
                    response.sendRedirect("userDashboard.jsp");
                } else {
                    session.invalidate();
                    response.getWriter().println("You are not authorized to login as " + loginType);
                }
            } else {
                response.getWriter().println("Invalid Username or Password");
            }

            conn.close();

        } catch(Exception e) {
            e.printStackTrace();
            response.getWriter().println("Internal Server Error");
        }
    }
}
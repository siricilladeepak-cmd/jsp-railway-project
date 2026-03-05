package com.virtual;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DeleteUserServlet")
public class DeleteUserServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int userId = Integer.parseInt(request.getParameter("id"));

        try(Connection conn = DBConnection.getConnection()) {

            // Delete quiz results first (important if foreign key exists)
            PreparedStatement ps1 = conn.prepareStatement(
                "DELETE FROM quiz_results WHERE user_id=?"
            );
            ps1.setInt(1, userId);
            ps1.executeUpdate();

            // Then delete user
            PreparedStatement ps2 = conn.prepareStatement(
                "DELETE FROM users WHERE id=?"
            );
            ps2.setInt(1, userId);
            ps2.executeUpdate();

        } catch(Exception e){
            e.printStackTrace();
        }

        response.sendRedirect("viewUsers.jsp");
    }
}
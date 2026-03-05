package com.virtual;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AddSubjectServlet")
public class AddSubjectServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String subjects = request.getParameter("subject_names");

        if (subjects == null || subjects.trim().isEmpty()) {
            response.getWriter().println("Error: Subject name(s) not provided!");
            return;
        }

        try {
            Connection conn = DBConnection.getConnection();
            String sql = "INSERT INTO subjects(name) VALUES (?)";
            PreparedStatement ps = conn.prepareStatement(sql);

            String[] subjectArray = subjects.split(",");

            for (String sub : subjectArray) {

                String trimmed = sub.trim();

                if (!trimmed.isEmpty()) {
                    ps.setString(1, trimmed);
                    ps.executeUpdate();
                }
            }

            conn.close();

            response.sendRedirect("adminDashboard.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error adding subject: " + e.getMessage());
        }
    }
}
package com.virtual;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/LoadSubTopicsServlet")
public class LoadSubTopicsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        PrintWriter out = response.getWriter();

        String subjectId = request.getParameter("subject_id");  // MUST match JS parameter

        // Safety check
        if (subjectId == null || subjectId.trim().isEmpty()) {
            out.println("<option value=''>Select Subtopic</option>");
            return;
        }

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(
                     "SELECT id, name FROM sub_topics WHERE subject_id = ?")) {

            ps.setInt(1, Integer.parseInt(subjectId));

            ResultSet rs = ps.executeQuery();

            // Default option
            out.println("<option value=''>Select Subtopic</option>");

            boolean hasData = false;

            while (rs.next()) {
                hasData = true;
                out.println("<option value='" + rs.getInt("id") + "'>"
                        + rs.getString("name") +
                        "</option>");
            }

            if (!hasData) {
                out.println("<option value=''>No Subtopics Found</option>");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<option value=''>Error Loading Subtopics</option>");
        }
    }
}
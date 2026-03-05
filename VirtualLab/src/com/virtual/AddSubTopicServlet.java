package com.virtual;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AddSubTopicServlet")
public class AddSubTopicServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String subtopics = request.getParameter("subtopic_names");  // textarea name
        String subjectIdStr = request.getParameter("subject_id");

        // Validation
        if (subtopics == null || subtopics.trim().isEmpty() ||
            subjectIdStr == null || subjectIdStr.trim().isEmpty()) {

            response.getWriter().println("Error: SubTopic(s) or Subject not provided!");
            return;
        }

        try {
            int subjectId = Integer.parseInt(subjectIdStr);

            Connection conn = DBConnection.getConnection();
            String sql = "INSERT INTO sub_topics(name, subject_id) VALUES (?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);

            // Split by comma for multiple entries
            String[] subtopicArray = subtopics.split(",");

            for (String sub : subtopicArray) {

                String trimmedSub = sub.trim();

                if (!trimmedSub.isEmpty()) {
                    ps.setString(1, trimmedSub);
                    ps.setInt(2, subjectId);
                    ps.executeUpdate();
                }
            }

            conn.close();

            response.sendRedirect("adminDashboard.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error adding sub-topic: " + e.getMessage());
        }
    }
}
package com.virtual;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/UpdateTimerServlet")
public class UpdateTimerServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String subTopicIdStr = request.getParameter("sub_topic_id");
        String timeStr = request.getParameter("time_per_question");

        if(subTopicIdStr == null || timeStr == null){
            response.getWriter().println("Invalid Input");
            return;
        }

        try {
            int subTopicId = Integer.parseInt(subTopicIdStr);
            int timePerQuestion = Integer.parseInt(timeStr);

            Connection conn = DBConnection.getConnection();

            PreparedStatement ps = conn.prepareStatement(
                "UPDATE sub_topics SET time_per_question=? WHERE id=?"
            );

            ps.setInt(1, timePerQuestion);
            ps.setInt(2, subTopicId);

            ps.executeUpdate();
            conn.close();

            response.sendRedirect("adminDashboard.jsp");

        } catch(Exception e){
            e.printStackTrace();
        }
    }
}
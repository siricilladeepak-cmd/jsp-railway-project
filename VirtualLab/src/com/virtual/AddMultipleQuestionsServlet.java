package com.virtual;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/AddMultipleQuestionsServlet")
public class AddMultipleQuestionsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1️⃣ Get sub-topic ID and parameters
        String subTopicIdStr = request.getParameter("sub_topic_id");
        if (subTopicIdStr == null) {
            response.getWriter().println("Sub-topic not selected!");
            return;
        }

        int subTopicId = Integer.parseInt(subTopicIdStr);

        String[] questions = request.getParameterValues("question[]");
        String[] option1 = request.getParameterValues("option1[]");
        String[] option2 = request.getParameterValues("option2[]");
        String[] option3 = request.getParameterValues("option3[]");
        String[] option4 = request.getParameterValues("option4[]");
        String[] correctStr = request.getParameterValues("correct[]"); // now it returns "1", "2", "3", or "4"
        if (correctStr == null) {
            response.getWriter().println("Correct answers not selected!");
            return;
        }
        int[] correct = new int[correctStr.length];
        for (int i = 0; i < correctStr.length; i++) {
            correct[i] = Integer.parseInt(correctStr[i]); // converts string to int
        }

        if (questions == null || option1 == null || option2 == null ||
            option3 == null || option4 == null || correct == null) {
            response.getWriter().println("Please fill all fields for questions and options!");
            return;
        }

        try {
            // 2️⃣ Connect to database
            Connection conn = DBConnection.getConnection();
            String sql = "INSERT INTO questions(sub_topic_id, question, option1, option2, option3, option4, correct_answer) "
                       + "VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);

            // 3️⃣ Loop through all questions and insert
            for (int i = 0; i < questions.length; i++) {
                if (!questions[i].trim().isEmpty()) {
                    ps.setInt(1, subTopicId);
                    ps.setString(2, questions[i].trim());
                    ps.setString(3, option1[i].trim());
                    ps.setString(4, option2[i].trim());
                    ps.setString(5, option3[i].trim());
                    ps.setString(6, option4[i].trim());
                    ps.setInt(7, correct[i]);
                    ps.executeUpdate();
                }
            }

            conn.close();

            // 4️⃣ Redirect back with success
            response.sendRedirect("addMultipleQuestions.jsp?success=1");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error adding questions: " + e.getMessage());
        }
    }
}
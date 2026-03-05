package com.virtual;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AddQuestionServlet")
public class AddQuestionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {

            String question = request.getParameter("question");
            String option1 = request.getParameter("option1");
            String option2 = request.getParameter("option2");
            String option3 = request.getParameter("option3");
            String option4 = request.getParameter("option4");
            String correctAnswer = request.getParameter("correct_answer");

            int subjectId = Integer.parseInt(request.getParameter("subject_id"));
            int subTopicId = Integer.parseInt(request.getParameter("sub_topic_id"));

            Connection conn = DBConnection.getConnection();

            String sql = "INSERT INTO questions(question,option1,option2,option3,option4,correct_answer,subject_id,sub_topic_id) VALUES(?,?,?,?,?,?,?,?)";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, question);
            ps.setString(2, option1);
            ps.setString(3, option2);
            ps.setString(4, option3);
            ps.setString(5, option4);
            ps.setString(6, correctAnswer);
            ps.setInt(7, subjectId);
            ps.setInt(8, subTopicId);

            ps.executeUpdate();

            conn.close();

            response.sendRedirect("addQuestion.jsp?success=1");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
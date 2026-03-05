package com.virtual;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/QuizServlet")
public class QuizServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // =========================
    // START QUIZ (CALCULATE TIMER)
    // =========================
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        String subTopicIdStr = request.getParameter("subTopicId");

        if (subTopicIdStr == null || subTopicIdStr.trim().isEmpty()) {
            response.getWriter().println("SubTopic ID Missing!");
            return;
        }

        int subTopicId = Integer.parseInt(subTopicIdStr);

        int questionCount = 0;
        int timePerQuestion = 30; // default time

        try (Connection conn = DBConnection.getConnection()) {

            // Count total questions
            PreparedStatement psCount = conn.prepareStatement(
                    "SELECT COUNT(*) FROM questions WHERE sub_topic_id=?");
            psCount.setInt(1, subTopicId);
            ResultSet rsCount = psCount.executeQuery();

            if (rsCount.next()) {
                questionCount = rsCount.getInt(1);
            }

            // Get admin set time per question
            PreparedStatement psTime = conn.prepareStatement(
                    "SELECT time_per_question FROM sub_topics WHERE id=?");
            psTime.setInt(1, subTopicId);
            ResultSet rsTime = psTime.executeQuery();

            if (rsTime.next()) {
                int dbTime = rsTime.getInt("time_per_question");
                if (!rsTime.wasNull()) {
                    timePerQuestion = dbTime;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        int totalTime = questionCount * timePerQuestion;
        System.out.println("Questions: " + questionCount);
        System.out.println("Time per question: " + timePerQuestion);
        System.out.println("Total time: " + totalTime);

        session.setAttribute("quizTime", totalTime);
        session.setAttribute("currentSubTopicId", subTopicId);

        session.setAttribute("quizTime", totalTime);
        session.setAttribute("currentSubTopicId", subTopicId);

        response.sendRedirect("quiz.jsp?subTopicId=" + subTopicId);
    }

    // =========================
    // SUBMIT QUIZ
    // =========================
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        String subTopicIdStr = request.getParameter("subTopicId");

        if (subTopicIdStr == null || subTopicIdStr.trim().isEmpty()) {
            response.getWriter().println("SubTopic ID missing during submission!");
            return;
        }

        int subTopicId = Integer.parseInt(subTopicIdStr);
        int userId = (Integer) session.getAttribute("userId");

        int score = 0;
        int total = 0;

        try (Connection conn = DBConnection.getConnection()) {

            PreparedStatement ps = conn.prepareStatement(
                    "SELECT id, correct_answer FROM questions WHERE sub_topic_id=? ORDER BY id ASC");
            ps.setInt(1, subTopicId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int questionId = rs.getInt("id");
                String correctAnswer = rs.getString("correct_answer").trim();
                String userAnswer = request.getParameter("q" + questionId);

                total++;

                if (userAnswer != null && userAnswer.trim().equals(correctAnswer)) {
                    score++;
                }
            }

            double percentage = (total > 0) ? (score * 100.0 / total) : 0;

            PreparedStatement psInsert = conn.prepareStatement(
                    "INSERT INTO quiz_results(user_id, sub_topic_id, score, percentage) VALUES(?, ?, ?, ?)");
            psInsert.setInt(1, userId);
            psInsert.setInt(2, subTopicId);
            psInsert.setInt(3, score);
            psInsert.setDouble(4, percentage);
            psInsert.executeUpdate();

            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().println("<h2>Quiz Completed!</h2>");
            response.getWriter().println("<p>Score: " + score + " / " + total + "</p>");
            response.getWriter().println(String.format("<p>Percentage: %.2f%%</p>", percentage));
            response.getWriter().println("<br><a href='userDashboard.jsp'>Back to Dashboard</a>");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
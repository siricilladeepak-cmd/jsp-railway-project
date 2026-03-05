package com.virtual;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/DeleteQuestionServlet")
public class DeleteQuestionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
protected void doGet(HttpServletRequest request,
HttpServletResponse response)
throws ServletException, IOException {

    int id = Integer.parseInt(request.getParameter("id"));

    try{

        Connection conn = DBConnection.getConnection();

        PreparedStatement ps =
        conn.prepareStatement("DELETE FROM questions WHERE id=?");

        ps.setInt(1,id);
        ps.executeUpdate();

        conn.close();

        response.sendRedirect("viewQuestions.jsp");

    }catch(Exception e){
        e.printStackTrace();
    }
}
}
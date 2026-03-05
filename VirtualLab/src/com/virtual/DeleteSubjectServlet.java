package com.virtual;

import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/DeleteSubjectServlet")
public class DeleteSubjectServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) {

        int id = Integer.parseInt(request.getParameter("id"));

        try {
            Connection conn = DBConnection.getConnection();

            PreparedStatement ps =
                    conn.prepareStatement("DELETE FROM subjects WHERE id=?");

            ps.setInt(1, id);
            ps.executeUpdate();

            conn.close();

            response.sendRedirect("viewSubjects.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
<%@ page import="java.sql.*" %>
<%@ page import="com.virtual.DBConnection" %>

<h2>All Questions</h2>

<table border="1" cellpadding="8">
<tr>
    <th>ID</th>
    <th>Subject</th>
    <th>Sub-Topic</th>
    <th>Question</th>
    <th>Option 1</th>
    <th>Option 2</th>
    <th>Option 3</th>
    <th>Option 4</th>
    <th>Correct Answer</th>
    <th>Action</th>
</tr>

<%
try {
    Connection conn = DBConnection.getConnection();

    String sql = "SELECT q.id, q.question, q.option1, q.option2, q.option3, q.option4, q.correct_answer, " +
                 "s.name AS subject_name, st.name AS subtopic_name " +
                 "FROM questions q " +
                 "JOIN sub_topics st ON q.sub_topic_id = st.id " +
                 "JOIN subjects s ON st.subject_id = s.id " +
                 "ORDER BY s.name, st.name, q.id";

    PreparedStatement ps = conn.prepareStatement(sql);
    ResultSet rs = ps.executeQuery();

    while(rs.next()){
%>
<tr>
    <td><%= rs.getInt("id") %></td>
    <td><%= rs.getString("subject_name") %></td>
    <td><%= rs.getString("subtopic_name") %></td>
    <td><%= rs.getString("question") %></td>
    <td><%= rs.getString("option1") %></td>
    <td><%= rs.getString("option2") %></td>
    <td><%= rs.getString("option3") %></td>
    <td><%= rs.getString("option4") %></td>
    <td><%= rs.getString("correct_answer") %></td>
    <td>
        <a href="<%=request.getContextPath()%>/DeleteQuestionServlet?id=<%= rs.getInt("id") %>" 
           onclick="return confirm('Delete this question?')">Delete</a>
    </td>
</tr>
<%
    }

    conn.close();
} catch(Exception e){
    e.printStackTrace();
}
%>

</table>

<br>
<a href="<%=request.getContextPath()%>/adminDashboard.jsp">Back to Dashboard</a>
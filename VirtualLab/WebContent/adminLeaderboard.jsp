<%@ page import="java.sql.*" %>
<%@ page import="com.virtual.DBConnection" %>

<h2>Admin Leaderboard</h2>

<table border="1" cellpadding="8">
<tr>
    <th>Rank</th>
    <th>Name</th>
    <th>Average Percentage</th>
</tr>

<%
int rank = 1;

try{
    Connection conn = DBConnection.getConnection();

    PreparedStatement ps = conn.prepareStatement(
        "SELECT u.name, AVG(qr.percentage) AS avgPercentage " +
        "FROM users u " +
        "JOIN quiz_results qr ON u.id = qr.user_id " +
        "GROUP BY u.id " +
        "ORDER BY avgPercentage DESC"
    );

    ResultSet rs = ps.executeQuery();

    while(rs.next()){
%>
<tr>
    <td><%= rank++ %></td>
    <td><%= rs.getString("name") %></td>
    <td><%= String.format("%.2f", rs.getDouble("avgPercentage")) %>%</td>
</tr>
<%
    }

    conn.close();
}catch(Exception e){
    e.printStackTrace();
}
%>

</table>

<br>
<a href="adminDashboard.jsp">Back</a>
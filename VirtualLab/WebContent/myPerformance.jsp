<%@ page import="java.sql.*" %>
<%@ page import="com.virtual.DBConnection" %>

<%
Integer userId = (Integer) session.getAttribute("userId");
String username = (String) session.getAttribute("username");

if(userId == null || username == null){
    response.sendRedirect("index.jsp");
    return;
}

Connection conn = DBConnection.getConnection();

String sql =
"SELECT s.name AS subjectName, " +
"st.name AS subTopicName, " +
"AVG(qr.percentage) AS avgPercentage " +
"FROM quiz_results qr " +
"JOIN sub_topics st ON qr.sub_topic_id = st.id " +
"JOIN subjects s ON st.subject_id = s.id " +
"WHERE qr.user_id=? " +
"GROUP BY s.name, st.name";

PreparedStatement ps = conn.prepareStatement(sql);
ps.setInt(1,userId);
ResultSet rs = ps.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
<title>My Performance</title>

<style>
body{
    margin:0;
    font-family:'Segoe UI',sans-serif;
    background:#f4f6f9;
}

.header{
    background:#1f2937;
    color:white;
    padding:20px;
    text-align:center;
}

.container{
    width:85%;
    margin:30px auto;
}

table{
    width:100%;
    border-collapse:collapse;
    background:white;
    box-shadow:0 6px 15px rgba(0,0,0,0.08);
}

th,td{
    padding:12px;
    text-align:center;
}

th{
    background:#3b82f6;
    color:white;
}

tr:nth-child(even){
    background:#f2f2f2;
}

.weak{
    color:red;
    font-weight:bold;
}

.strong{
    color:green;
    font-weight:bold;
}

.back{
    margin-top:20px;
    display:inline-block;
    padding:10px 20px;
    background:#1f2937;
    color:white;
    text-decoration:none;
    border-radius:20px;
}
</style>
</head>

<body>

<div class="header">
    <h2>My Performance</h2>
</div>

<div class="container">

<table>
<tr>
    <th>Subject</th>
    <th>Sub Topic</th>
    <th>Average %</th>
    <th>Status</th>
</tr>

<%
while(rs.next()){
    String subject = rs.getString("subjectName");
    String subtopic = rs.getString("subTopicName");
    double avg = rs.getDouble("avgPercentage");
    boolean weak = avg < 50;
%>

<tr>
    <td><%= subject %></td>
    <td><%= subtopic %></td>
    <td><%= String.format("%.2f",avg) %>%</td>
    <td class="<%= weak ? "weak" : "strong" %>">
        <%= weak ? "Weak" : "Strong" %>
    </td>
</tr>

<%
}
rs.close();
ps.close();
conn.close();
%>

</table>

<br>
<a class="back" href="userDashboard.jsp">Back to Dashboard</a>

</div>

</body>
</html>
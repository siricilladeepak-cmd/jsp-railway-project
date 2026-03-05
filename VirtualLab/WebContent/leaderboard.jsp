<%@ page import="java.sql.*" %>
<%@ page import="com.virtual.DBConnection" %>

<%
Integer userId = (Integer) session.getAttribute("userId");
String loggedName = (String) session.getAttribute("username");  // assuming session stores name

if(userId == null){
    response.sendRedirect("index.jsp");
    return;
}

Connection conn = DBConnection.getConnection();

PreparedStatement ps = conn.prepareStatement(
    "SELECT u.id, u.name, AVG(qr.percentage) AS avgPercentage " +
    "FROM users u " +
    "JOIN quiz_results qr ON u.id = qr.user_id " +
    "GROUP BY u.id, u.name " +
    "ORDER BY avgPercentage DESC"
);

ResultSet rs = ps.executeQuery();

int rank = 1;
%>

<!DOCTYPE html>
<html>
<head>
<title>Leaderboard</title>

<style>
body{
    margin:0;
    font-family:'Segoe UI',sans-serif;
    background:#f4f6f9;
}

.header{
    background:#111827;
    color:white;
    padding:20px;
    text-align:center;
}

.container{
    width:70%;
    margin:40px auto;
}

table{
    width:100%;
    border-collapse:collapse;
    background:white;
    box-shadow:0 8px 20px rgba(0,0,0,0.08);
    border-radius:10px;
    overflow:hidden;
}

th,td{
    padding:14px;
    text-align:center;
}

th{
    background:#2563eb;
    color:white;
}

tr:nth-child(even){
    background:#f9fafb;
}

.highlight{
    background:#dbeafe !important;
    font-weight:bold;
}

.badge{
    padding:4px 10px;
    border-radius:20px;
    font-size:12px;
    font-weight:bold;
}

.gold{ background:#facc15; }
.silver{ background:#d1d5db; }
.bronze{ background:#fb923c; }

.back{
    display:inline-block;
    margin-top:25px;
    padding:10px 20px;
    background:#111827;
    color:white;
    text-decoration:none;
    border-radius:25px;
    font-weight:600;
}
</style>
</head>

<body>

<div class="header">
    <h2>Leaderboard</h2>
</div>

<div class="container">

<table>
<tr>
    <th>Rank</th>
    <th>Name</th>
    <th>Average %</th>
    <th>Status</th>
</tr>

<%
while(rs.next()){

    int currentUserId = rs.getInt("id");
    String name = rs.getString("name");
    double avg = rs.getDouble("avgPercentage");

    String rowClass = (currentUserId == userId) ? "highlight" : "";
    String medalClass = "";

    if(rank == 1) medalClass = "gold";
    else if(rank == 2) medalClass = "silver";
    else if(rank == 3) medalClass = "bronze";
%>

<tr class="<%= rowClass %>">
    <td>
        <span class="badge <%= medalClass %>"><%= rank %></span>
    </td>
    <td><%= name %></td>
    <td><%= String.format("%.2f", avg) %>%</td>
    <td><%= avg >= 50 ? "Strong" : "Needs Improvement" %></td>
</tr>

<%
    rank++;
}

rs.close();
ps.close();
conn.close();
%>

</table>

<a class="back" href="userDashboard.jsp">Back to Dashboard</a>

</div>

</body>
</html>
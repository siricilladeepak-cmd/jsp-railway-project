<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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

/* ================= RECOMMENDATION SYSTEM ================= */

String weakSubject = null;
String weakSubtopic = null;
int weakSubtopicId = 0;
double lowestAvg = 101;

String subjectQuery =
"SELECT s.id, s.name, AVG(qr.percentage) AS avgPercent " +
"FROM subjects s " +
"LEFT JOIN sub_topics st ON s.id = st.subject_id " +
"LEFT JOIN quiz_results qr ON st.id = qr.sub_topic_id AND qr.user_id=? " +
"GROUP BY s.id, s.name";

PreparedStatement psSubject = conn.prepareStatement(subjectQuery);
psSubject.setInt(1, userId);
ResultSet rsSubject = psSubject.executeQuery();

while(rsSubject.next()){
    double avg = rsSubject.getDouble("avgPercent");

    // ignore subjects not attempted
    if(!rsSubject.wasNull() && avg < lowestAvg){
        lowestAvg = avg;
        weakSubject = rsSubject.getString("name");
    }
}

if(weakSubject != null && lowestAvg < 60){
    String subQuery =
"SELECT st.id, st.name, AVG(qr.percentage) AS avgPercent " +
"FROM sub_topics st " +
"JOIN subjects s ON st.subject_id = s.id " +
"JOIN quiz_results qr ON st.id = qr.sub_topic_id " +
"WHERE qr.user_id=? AND s.name=? " +
"GROUP BY st.id, st.name " +
"ORDER BY avgPercent ASC LIMIT 1";
    PreparedStatement psSub = conn.prepareStatement(subQuery);
    psSub.setInt(1,userId);
    psSub.setString(2,weakSubject);
    ResultSet rsSub = psSub.executeQuery();

    if(rsSub.next()){
        weakSubtopic = rsSub.getString("name");
        weakSubtopicId = rsSub.getInt("id");
    }

    rsSub.close();
    psSub.close();
}else{
    weakSubject = null;
}

rsSubject.close();
psSubject.close();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Dashboard</title>

<style>
body{
    margin:0;
    font-family:'Segoe UI',sans-serif;
    background:#f4f6f9;
}

.header{
    background:#1f2937;
    color:white;
    padding:25px;
    text-align:center;
}

.container{
    width:85%;
    margin:30px auto;
}

.recommend{
    background:white;
    padding:25px;
    border-radius:12px;
    margin-bottom:30px;
    box-shadow:0 8px 20px rgba(0,0,0,0.08);
    border-left:6px solid #3b82f6;
}

.recommend h3{
    margin-top:0;
    color:#1f2937;
}

.recommend p{
    color:#555;
}

.recommend a{
    display:inline-block;
    margin-top:12px;
    padding:10px 22px;
    background:#3b82f6;
    color:white;
    text-decoration:none;
    border-radius:25px;
    font-weight:600;
    transition:0.3s;
}

.recommend a:hover{
    background:#2563eb;
}

.card{
    background:white;
    border-radius:12px;
    margin-bottom:20px;
    padding:20px;
    box-shadow:0 6px 15px rgba(0,0,0,0.05);
    transition:0.3s;
}

.card:hover{
    transform:translateY(-4px);
}

.card-title{
    font-size:18px;
    font-weight:600;
    margin-bottom:12px;
    color:#1f2937;
}

.subtopics a{
    display:block;
    padding:8px 0;
    text-decoration:none;
    color:#3b82f6;
    font-weight:500;
    transition:0.2s;
}

.subtopics a:hover{
    padding-left:10px;
}

.menu{
    text-align:center;
    margin:40px 0;
}

.menu a{
    margin:0 10px;
    padding:10px 20px;
    background:#1f2937;
    color:white;
    text-decoration:none;
    border-radius:25px;
    font-weight:600;
    transition:0.3s;
}

.menu a:hover{
    background:#374151;
}
</style>
</head>

<body>

<div class="header">
    <h2>Welcome, <%= username %></h2>
</div>

<div class="container">

<%
if(weakSubtopic != null){
%>

<div class="recommend">
    <h3>Recommended Practice</h3>
    <p>Your lowest performing area:</p>
    <strong><%= weakSubject %> → <%= weakSubtopic %></strong>
    <br>
    <a href="quiz.jsp?subTopicId=<%= weakSubtopicId %>">
        Start Practice
    </a>
</div>

<%
}else{
%>

<div class="recommend">
    <h3>No Recommendations Yet</h3>
    <p>Attempt more quizzes to receive personalized recommendations.</p>
</div>

<%
}
%>

<%
String subjectSql = "SELECT * FROM subjects";
PreparedStatement psAll = conn.prepareStatement(subjectSql);
ResultSet rsAll = psAll.executeQuery();

while(rsAll.next()){
    int subjectId = rsAll.getInt("id");
%>

<div class="card">
    <div class="card-title">
        <%= rsAll.getString("name") %>
    </div>

    <div class="subtopics">
    <%
        String subSql = "SELECT * FROM sub_topics WHERE subject_id=?";
        PreparedStatement psSubAll = conn.prepareStatement(subSql);
        psSubAll.setInt(1, subjectId);
        ResultSet rsSubAll = psSubAll.executeQuery();

        while(rsSubAll.next()){
    %>

        <a href="<%=request.getContextPath()%>/QuizServlet?subTopicId=<%= rsSubAll.getInt("id") %>">
            <%= rsSubAll.getString("name") %>
        </a>

    <%
        }
        rsSubAll.close();
        psSubAll.close();
    %>
    </div>
</div>

<%
}
rsAll.close();
psAll.close();
conn.close();
%>

<div class="menu">
    <a href="myPerformance.jsp">Performance</a>
    <a href="leaderboard.jsp">Leaderboard</a>
    <a href="logout.jsp">Logout</a>
</div>

</div>

</body>
</html>

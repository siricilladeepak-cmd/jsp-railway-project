<%@ page import="java.sql.*" %>
<%@ page import="com.virtual.DBConnection" %>

<html>
<head>
<title>Add Question</title>
</head>

<body>

<h2>Add Question</h2>

<form action="AddQuestionServlet" method="post">

<!-- SUBJECT DROPDOWN -->
Subject:
<select name="subject_id" required>

<%
try{
Connection conn=DBConnection.getConnection();
PreparedStatement ps=conn.prepareStatement("SELECT * FROM subjects");
ResultSet rs=ps.executeQuery();

while(rs.next()){
%>

<option value="<%=rs.getInt("id")%>">
<%=rs.getString("name")%>
</option>

<%
}
conn.close();
}catch(Exception e){e.printStackTrace();}
%>

</select>

<br><br>

<!-- SUBTOPIC DROPDOWN -->
Sub Topic:
<select name="sub_topic_id" required>

<%
try{
Connection conn=DBConnection.getConnection();
PreparedStatement ps=conn.prepareStatement("SELECT * FROM sub_topics");
ResultSet rs=ps.executeQuery();

while(rs.next()){
%>

<option value="<%=rs.getInt("id")%>">
<%=rs.getString("name")%>
</option>

<%
}
conn.close();
}catch(Exception e){e.printStackTrace();}
%>

</select>

<br><br>

Question:<br>
<textarea name="question" required></textarea>

<br><br>
Option1:<input name="option1" required><br>
Option2:<input name="option2" required><br>
Option3:<input name="option3" required><br>
Option4:<input name="option4" required><br>

<br>
Correct Answer:<br>

<input type="radio" name="correct_answer" value="1" required> Option 1<br>
<input type="radio" name="correct_answer" value="2"> Option 2<br>
<input type="radio" name="correct_answer" value="3"> Option 3<br>
<input type="radio" name="correct_answer" value="4"> Option 4<br>

<br><br>

<input type="submit" value="Add Question">

</form>

<br>
<a href="adminDashboard.jsp">Back</a>

</body>
</html>
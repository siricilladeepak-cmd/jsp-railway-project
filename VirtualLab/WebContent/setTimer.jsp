<%@ page import="java.sql.*" %>
<%@ page import="com.virtual.DBConnection" %>

<html>
<head>
<title>Set Time Per Question</title>
</head>

<body>
<h2>Set Time Per Question</h2>

<form action="UpdateTimerServlet" method="post">

<label>Select Subject:</label><br>
<select name="subject_id" onchange="loadSubTopics(this.value)" required>
<option value="">Select Subject</option>

<%
Connection conn = DBConnection.getConnection();
PreparedStatement ps = conn.prepareStatement("SELECT * FROM subjects");
ResultSet rs = ps.executeQuery();
while(rs.next()){
%>
<option value="<%=rs.getInt("id")%>">
<%=rs.getString("name")%>
</option>
<%
}
conn.close();
%>

</select>
<br><br>

<label>Select Subtopic:</label><br>
<select name="sub_topic_id" id="subTopicDropdown" required>
<option value="">Select Subtopic</option>
</select>
<br><br>

<label>Seconds Per Question:</label><br>
<input type="number" name="time_per_question" min="5" required>
<br><br>

<button type="submit">Update Timer</button>

</form>

<script>
function loadSubTopics(subjectId){
    var xhr = new XMLHttpRequest();
    xhr.open("GET",
        "<%=request.getContextPath()%>/LoadSubTopicsServlet?subject_id=" + subjectId,
        true);

    xhr.onload = function(){
        document.getElementById("subTopicDropdown").innerHTML = this.responseText;
    };
    xhr.send();
}
</script>

</body>
</html>
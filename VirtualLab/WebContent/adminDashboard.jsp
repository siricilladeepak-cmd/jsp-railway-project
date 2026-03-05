<%@ page import="java.sql.*" %>
<%@ page import="com.virtual.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<html>
<head>
<title>Admin Dashboard</title>

<style>
body{
    font-family: Arial;
    background:#f4f6f9;
    text-align:center;
}

.box{
    background:white;
    width:450px;
    margin:40px auto;
    padding:25px;
    border-radius:10px;
    box-shadow:0px 0px 10px #ccc;
}

a{
    display:block;
    padding:12px;
    margin:10px;
    background:#2d89ef;
    color:white;
    text-decoration:none;
    border-radius:6px;
    font-weight:bold;
}

a:hover{
    background:#1b5fbf;
}

select, input[type="number"]{
    width:90%;
    padding:8px;
    margin:8px 0;
}

button{
    padding:10px;
    width:95%;
    background:#27ae60;
    color:white;
    border:none;
    border-radius:6px;
    font-weight:bold;
    cursor:pointer;
}

button:hover{
    background:#1e8449;
}
</style>

<script>
function loadSubTopics(subjectId){
    if(subjectId==""){
        document.getElementById("subTopicDropdown").innerHTML="<option>Select Subtopic</option>";
        return;
    }

    var xhr = new XMLHttpRequest();
    xhr.open("GET","LoadSubTopicsServlet?subject_id="+subjectId,true);

    xhr.onload=function(){
        document.getElementById("subTopicDropdown").innerHTML=this.responseText;
    };

    xhr.send();
}
</script>

</head>

<body>

<div class="box">

<h2>Admin Control Panel</h2>

<h3>Subjects</h3>
<a href="<%=request.getContextPath()%>/addSubject.jsp">Add Subject</a>
<a href="<%=request.getContextPath()%>/viewSubjects.jsp">View / Delete Subjects</a>

<h3>Sub Topics</h3>
<a href="<%=request.getContextPath()%>/addSubTopic.jsp">Add Subtopic</a>
<a href="<%=request.getContextPath()%>/viewSubTopics.jsp">View / Delete Subtopics</a>

<h3>Questions</h3>
<a href="<%=request.getContextPath()%>/addQuestion.jsp">Add Question</a>
<a href="<%=request.getContextPath()%>/viewQuestions.jsp">View / Delete Questions</a>

<h3>Bulk Upload</h3>
<a href="<%=request.getContextPath()%>/addMultipleQuestions.jsp">
Add Multiple Questions
</a>

<!-- ================= TIMER SECTION ================= -->

<h3>Set Timer For Subtopic</h3>

<form action="UpdateTimerServlet" method="post">

<select name="subject_id" onchange="loadSubTopics(this.value)" required>
<option value="">Select Subject</option>

<%
try(Connection conn = DBConnection.getConnection()){
    PreparedStatement ps = conn.prepareStatement("SELECT * FROM subjects");
    ResultSet rs = ps.executeQuery();
    while(rs.next()){
%>
<option value="<%=rs.getInt("id")%>">
<%=rs.getString("name")%>
</option>
<%
    }
}
%>

</select>

<select name="sub_topic_id" id="subTopicDropdown" required>
<option value="">Select Subtopic</option>
</select>

<input type="number" name="time_per_question" min="10" placeholder="Enter Time In Seconds" required>

<button type="submit">Set Timer</button>

</form>

<!-- ================= END TIMER SECTION ================= -->

<h3>User Management</h3>
<a href="adminLeaderboard.jsp">View Leaderboard</a>
<a href="viewUsers.jsp">Manage Users (Delete Users)</a>

<a href="LogoutServlet" style="background:#e74c3c;">
Logout
</a>

</div>

</body>
</html>
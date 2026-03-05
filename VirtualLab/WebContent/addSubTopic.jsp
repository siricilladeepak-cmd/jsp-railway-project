<%@ page import="java.sql.*" %>
<%@ page import="com.virtual.DBConnection" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add SubTopic</title>

<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">

<style>
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Inter',sans-serif;
}

body{
    background:#f4f6f9;
    padding:40px;
}

.container{
    width:500px;
    background:#ffffff;
    padding:30px;
    border-radius:12px;
    box-shadow:0 10px 25px rgba(0,0,0,0.08);
}

h2{
    margin-bottom:20px;
    color:#111827;
}

label{
    display:block;
    margin-top:15px;
    font-weight:500;
    color:#374151;
}

input, select, textarea{
    width:100%;
    padding:10px;
    margin-top:5px;
    border-radius:8px;
    border:1px solid #d1d5db;
    font-size:14px;
    outline:none;
}

input:focus, select:focus, textarea:focus{
    border-color:#2563eb;
    box-shadow:0 0 0 3px rgba(37,99,235,0.15);
}

textarea{
    resize:none;
    height:100px;
}

button{
    margin-top:20px;
    width:100%;
    padding:12px;
    border:none;
    border-radius:8px;
    background:#2563eb;
    color:white;
    font-weight:500;
    cursor:pointer;
}

button:hover{
    background:#1e40af;
}

.note{
    font-size:12px;
    color:#6b7280;
    margin-top:5px;
}

.back{
    margin-top:20px;
    display:inline-block;
    text-decoration:none;
    color:#2563eb;
}
</style>
</head>
<body>

<div class="container">

<h2>Add SubTopics</h2>

<form action="AddSubTopicServlet" method="post">

    <label>SubTopic Name(s)</label>
    <textarea name="subtopic_names" 
        placeholder="Enter single subtopic OR multiple separated by comma&#10;Example: AM Basics, DSB-SC, SSB, FM"></textarea>
    <div class="note">
        You can add one or multiple subtopics separated by comma (,)
    </div>

    <label>Select Subject</label>
    <select name="subject_id" required>
        <option value="">--Select Subject--</option>
        <%
            try {
                Connection conn = DBConnection.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT id, name FROM subjects");

                while(rs.next()){
        %>
            <option value="<%= rs.getInt("id") %>">
                <%= rs.getString("name") %>
            </option>
        <%
                }
                conn.close();
            } catch(Exception e){
                out.println("<option disabled>Error loading subjects</option>");
            }
        %>
    </select>

    <button type="submit">Add SubTopic(s)</button>

</form>

<a href="adminDashboard.jsp" class="back">← Back to Dashboard</a>

</div>

</body>
</html>
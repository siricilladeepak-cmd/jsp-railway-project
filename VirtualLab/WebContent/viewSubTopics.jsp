<%@ page import="java.sql.*" %>
<%@ page import="com.virtual.DBConnection" %>

<html>
<head>
<title>View Sub Topics</title>
</head>

<body>

<h2>All Sub Topics</h2>

<table border="1">

<tr>
<th>ID</th>
<th>Sub Topic Name</th>
<th>Subject ID</th>
<th>Delete</th>
</tr>

<%
try{

Connection conn = DBConnection.getConnection();

Statement st = conn.createStatement();

/* change table name if yours different */
ResultSet rs = st.executeQuery("SELECT * FROM sub_topics");

while(rs.next()){
%>

<tr>

<td><%=rs.getInt("id")%></td>

<td><%=rs.getString("name")%></td>

<td><%=rs.getInt("subject_id")%></td>

<td>
<a href="DeleteSubTopicServlet?id=<%=rs.getInt("id")%>">
Delete
</a>
</td>

</tr>

<%
}

conn.close();

}catch(Exception e){
e.printStackTrace();
}
%>

</table>

<br><br>

<a href="adminDashboard.jsp">Back to Dashboard</a>

</body>
</html>
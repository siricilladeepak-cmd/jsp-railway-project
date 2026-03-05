<%@ page import="java.sql.*" %>
<%@ page import="com.virtual.DBConnection" %>

<html>
<head>
<title>View Subjects</title>
</head>

<body>

<h2>All Subjects</h2>

<table border="1">

<tr>
<th>ID</th>
<th>Subject Name</th>
<th>Delete</th>
</tr>

<%
try{

Connection conn = DBConnection.getConnection();

Statement st = conn.createStatement();

ResultSet rs = st.executeQuery("SELECT * FROM subjects");

while(rs.next()){
%>

<tr>

<td><%=rs.getInt("id")%></td>

<td><%=rs.getString("name")%></td>

<td>
<a href="DeleteSubjectServlet?id=<%=rs.getInt("id")%>">
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
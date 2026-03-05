<%@ page import="java.sql.*" %>
<%@ page import="com.virtual.DBConnection" %>

<h2>All Registered Users</h2>

<table border="1" cellpadding="8">
<tr>
    <th>ID</th>
    <th>Username</th>
    <th>Action</th>
</tr>

<%
try{
    Connection conn = DBConnection.getConnection();
    PreparedStatement ps = conn.prepareStatement("SELECT id, name FROM users");
    ResultSet rs = ps.executeQuery();

    while(rs.next()){
%>
<tr>
    <td><%= rs.getInt("id") %></td>
    <td><%= rs.getString("name") %></td>
    <td>
        <a href="DeleteUserServlet?id=<%= rs.getInt("id") %>"
           onclick="return confirm('Are you sure to delete this user?')">
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

<br>
<a href="adminDashboard.jsp">Back</a>
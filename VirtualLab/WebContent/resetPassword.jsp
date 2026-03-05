<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Reset Password - Virtual Lab</title>

<style>
body{
    font-family:Arial, sans-serif;
    background:#f4f6f9;
    display:flex;
    justify-content:center;
    align-items:center;
    height:100vh;
}
.card{
    width:350px;
    background:white;
    padding:30px;
    border-radius:10px;
    box-shadow:0 5px 20px rgba(0,0,0,0.1);
}
h2{
    margin-bottom:20px;
}
input{
    width:100%;
    padding:10px;
    margin-bottom:15px;
    border:1px solid #ccc;
    border-radius:5px;
}
button{
    width:100%;
    padding:10px;
    background:#2563eb;
    color:white;
    border:none;
    border-radius:5px;
    cursor:pointer;
}
button:hover{
    background:#1e40af;
}
.msg{
    margin-top:10px;
    font-size:14px;
}
.success{
    color:green;
}
.error{
    color:red;
}
</style>
</head>
<body>

<div class="card">
<h2>Reset Password</h2>

<form method="post">
<input type="hidden" name="username" value="<%=request.getParameter("username")%>">
<input type="password" name="newPassword" placeholder="New Password" required>
<button type="submit">Update Password</button>
</form>

<div class="msg">
<%
if(request.getMethod().equals("POST")){
    String username = request.getParameter("username");
    String newPassword = request.getParameter("newPassword");

    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/virtual_lab","root","root123");

        PreparedStatement ps = con.prepareStatement(
            "UPDATE users SET password=? WHERE name=? AND role='user'");
        ps.setString(1, newPassword);
        ps.setString(2, username);

        int i = ps.executeUpdate();

        if(i>0){
            out.println("<span class='success'>Password updated successfully!</span>");
        } else {
            out.println("<span class='error'>Failed to update password!</span>");
        }

        con.close();
    }catch(Exception e){
        out.println("<span class='error'>Error: "+e.getMessage()+"</span>");
    }
}
%>
</div>

</div>

</body>
</html>
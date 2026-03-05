<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Forgot Password - Virtual Lab</title>

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
    color:red;
    font-size:14px;
}
</style>
</head>
<body>

<div class="card">
<h2>Forgot Password</h2>

<form method="post">
<input type="text" name="username" placeholder="Enter Username" required>
<button type="submit">Verify</button>
</form>

<div class="msg">
<%
if(request.getMethod().equals("POST")){
    String username = request.getParameter("username");

    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/virtual_lab","root","root123");

        PreparedStatement ps = con.prepareStatement(
            "SELECT * FROM users WHERE name=? AND role='user'");
        ps.setString(1, username);
        ResultSet rs = ps.executeQuery();

        if(rs.next()){
            response.sendRedirect("resetPassword.jsp?username=" + username);
        } else {
            out.println("User not found!");
        }

        con.close();
    }catch(Exception e){
        out.println("Error: " + e.getMessage());
    }
}
%>
</div>

</div>

</body>
</html>
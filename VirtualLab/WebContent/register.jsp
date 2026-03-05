<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register - Virtual Lab</title>

<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">

<style>
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Inter',sans-serif;
}

body{
    height:100vh;
    display:flex;
    justify-content:center;
    align-items:center;
    background:#f4f6f9;
}

.card{
    width:380px;
    background:#ffffff;
    padding:40px;
    border-radius:12px;
    box-shadow:0 10px 30px rgba(0,0,0,0.08);
}

.card h2{
    margin-bottom:25px;
    font-weight:600;
    color:#111827;
}

.input-group{
    margin-bottom:18px;
}

.input-group label{
    display:block;
    margin-bottom:6px;
    font-size:14px;
    color:#374151;
    font-weight:500;
}

.input-group input{
    width:100%;
    padding:12px;
    border-radius:8px;
    border:1px solid #d1d5db;
    font-size:14px;
    outline:none;
    transition:0.2s;
}

.input-group input:focus{
    border-color:#2563eb;
    box-shadow:0 0 0 3px rgba(37,99,235,0.15);
}

button{
    width:100%;
    padding:12px;
    border:none;
    border-radius:8px;
    background:#2563eb;
    color:white;
    font-size:14px;
    font-weight:500;
    cursor:pointer;
    transition:0.2s;
}

button:hover{
    background:#1e40af;
}

.footer{
    text-align:center;
    margin-top:18px;
    font-size:13px;
}

.footer a{
    color:#2563eb;
    text-decoration:none;
}

.footer a:hover{
    text-decoration:underline;
}
</style>
</head>
<body>

<div class="card">
    <h2>Create Account</h2>

    <form action="<%=request.getContextPath()%>/RegisterServlet" method="post">

        <div class="input-group">
            <label>Full Name</label>
            <input type="text" name="name" required>
        </div>

        <div class="input-group">
            <label>Email Address</label>
            <input type="email" name="email" required>
        </div>

        <div class="input-group">
            <label>Password</label>
            <input type="password" name="password" required>
        </div>

        <button type="submit">Create Account</button>

    </form>

    <div class="footer">
        Already have an account?
        <a href="index.jsp">Sign in</a>
    </div>
</div>

</body>
</html>
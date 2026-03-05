<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Virtual Lab - Login</title>

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
    background:#f4f6f9;
}

/* LEFT SIDE PANEL */
.left-panel{
    flex:1;
    background:linear-gradient(135deg,#1f2937,#111827);
    color:white;
    display:flex;
    flex-direction:column;
    justify-content:center;
    padding:80px;
}

.left-panel h1{
    font-size:36px;
    margin-bottom:20px;
    font-weight:600;
}

.left-panel p{
    font-size:16px;
    opacity:0.8;
    line-height:1.6;
}

/* RIGHT LOGIN SECTION */
.right-panel{
    width:420px;
    background:white;
    display:flex;
    justify-content:center;
    align-items:center;
    box-shadow:-5px 0 25px rgba(0,0,0,0.05);
}

.login-box{
    width:320px;
}

.login-box h2{
    font-size:24px;
    margin-bottom:30px;
    font-weight:600;
    color:#111827;
}

/* INPUT GROUP */
.input-group{
    margin-bottom:20px;
}

.input-group label{
    display:block;
    margin-bottom:6px;
    font-size:14px;
    color:#374151;
    font-weight:500;
}

.input-group input,
.input-group select{
    width:100%;
    padding:12px;
    border-radius:8px;
    border:1px solid #d1d5db;
    font-size:14px;
    outline:none;
    transition:0.2s;
}

.input-group input:focus,
.input-group select:focus{
    border-color:#2563eb;
    box-shadow:0 0 0 3px rgba(37,99,235,0.15);
}

/* BUTTON */
button{
    width:100%;
    padding:12px;
    border:none;
    border-radius:8px;
    background:#2563eb;
    color:white;
    font-weight:500;
    font-size:14px;
    cursor:pointer;
    transition:0.2s;
}

button:hover{
    background:#1e40af;
}

/* LINKS */
.links{
    text-align:center;
    margin-top:20px;
    font-size:13px;
}

.links a{
    color:#2563eb;
    text-decoration:none;
    margin:0 5px;
}

.links a:hover{
    text-decoration:underline;
}
</style>
</head>

<body>

<div class="left-panel">
    <h1>Virtual Lab</h1>
    <p>
        Access experiments, manage assessments, and explore interactive simulations.
        A secure and professional platform for students and administrators.
    </p>
</div>

<div class="right-panel">
    <div class="login-box">
        <h2>Sign in to your account</h2>

        <form action="<%=request.getContextPath()%>/LoginServlet" method="post">

            <div class="input-group">
                <label>Select Role</label>
                <select name="loginType" required>
                    <option value="">Choose role</option>
                    <option value="user">User</option>
                    <option value="admin">Admin</option>
                </select>
            </div>

            <div class="input-group">
                <label>Username</label>
                <input type="text" name="username" required>
            </div>

            <div class="input-group">
                <label>Password</label>
                <input type="password" name="password" required>
            </div>

            <button type="submit">Sign In</button>

        </form>

        <div class="links">
            <a href="register.jsp">Register</a> |
            <a href="forgotPassword.jsp">Forgot Password?</a>
        </div>

    </div>
</div>

</body>
</html>
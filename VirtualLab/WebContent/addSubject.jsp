<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Subjects</title>

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
    display:flex;
    justify-content:center;
    align-items:center;
    height:100vh;
}

.card{
    width:450px;
    background:#ffffff;
    padding:35px;
    border-radius:12px;
    box-shadow:0 10px 25px rgba(0,0,0,0.08);
}

h2{
    margin-bottom:20px;
    color:#111827;
}

label{
    font-weight:500;
    color:#374151;
}

textarea{
    width:100%;
    padding:12px;
    margin-top:8px;
    border-radius:8px;
    border:1px solid #d1d5db;
    font-size:14px;
    resize:none;
    height:100px;
    outline:none;
}

textarea:focus{
    border-color:#2563eb;
    box-shadow:0 0 0 3px rgba(37,99,235,0.15);
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
    transition:0.2s;
}

button:hover{
    background:#1e40af;
}

.note{
    font-size:12px;
    color:#6b7280;
    margin-top:6px;
}

.back{
    display:block;
    margin-top:20px;
    text-align:center;
    text-decoration:none;
    color:#2563eb;
}
</style>
</head>
<body>

<div class="card">
    <h2>Add Subject(s)</h2>

    <form action="<%=request.getContextPath()%>/AddSubjectServlet" method="post">

        <label>Subject Name(s)</label>
        <textarea name="subject_names"
        placeholder="Enter single subject OR multiple separated by comma&#10;Example: Analog Communication, Digital Communication, DSP"
        required></textarea>

        <div class="note">
            You can enter one or multiple subjects separated by comma (,)
        </div>

        <button type="submit">Add Subject(s)</button>
    </form>

    <a href="adminDashboard.jsp" class="back">← Back to Dashboard</a>
</div>

</body>
</html>
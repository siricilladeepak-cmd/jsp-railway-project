<%@ page import="java.sql.*" %>
<%@ page import="com.virtual.DBConnection" %>

<%
    HttpSession sessionObj = request.getSession(false);
    if(sessionObj == null || sessionObj.getAttribute("userId") == null){
        response.sendRedirect("index.jsp");
        return;
    }

    // Get SubTopicId safely
    String subTopicIdStr = request.getParameter("subTopicId");
    if(subTopicIdStr == null || subTopicIdStr.trim().isEmpty()){
        response.sendRedirect("userDashboard.jsp");
        return;
    }

    int subTopicId = Integer.parseInt(subTopicIdStr);

    // Get total quiz time from session (set by servlet)
    int totalTime = 30; // fallback default
    Object timeObj = sessionObj.getAttribute("quizTime");
    if(timeObj != null){
        totalTime = (Integer) timeObj;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Quiz</title>

    <script>
        var timeLeft = <%= totalTime %>;

        function startTimer() {
            var timer = setInterval(function() {
                if (timeLeft <= 0) {
                    clearInterval(timer);
                    document.getElementById("quizForm").submit();
                }
                document.getElementById("timer").innerHTML = 
                    "Time Left: " + timeLeft + " seconds";
                timeLeft--;
            }, 1000);
        }

        window.onload = startTimer;
    </script>
</head>

<body>

<h2>Quiz</h2>
<h3 id="timer" style="color:red;"></h3>

<form id="quizForm" action="<%=request.getContextPath()%>/QuizServlet" method="post">
<input type="hidden" name="subTopicId" value="<%= subTopicId %>">

<%
    try(Connection conn = DBConnection.getConnection()){

        PreparedStatement ps = conn.prepareStatement(
            "SELECT * FROM questions WHERE sub_topic_id=? ORDER BY id ASC"
        );
        ps.setInt(1, subTopicId);
        ResultSet rs = ps.executeQuery();

        int qNo = 1;

        while(rs.next()){
            int questionId = rs.getInt("id");
%>

<p><b><%= qNo %>. <%= rs.getString("question") %></b></p>

<input type="radio" name="q<%= questionId %>" value="1" required>
<%= rs.getString("option1") %><br>

<input type="radio" name="q<%= questionId %>" value="2">
<%= rs.getString("option2") %><br>

<input type="radio" name="q<%= questionId %>" value="3">
<%= rs.getString("option3") %><br>

<input type="radio" name="q<%= questionId %>" value="4">
<%= rs.getString("option4") %><br><br>

<%
            qNo++;
        }

    } catch(Exception e){
        out.println("Error loading questions.");
    }
%>

<input type="submit" value="Submit Quiz">
<a href="userDashboard.jsp">Back to Dashboard</a>

</form>

</body>
</html>
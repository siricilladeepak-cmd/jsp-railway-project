<%@ page import="java.sql.*" %>
<%@ page import="com.virtual.DBConnection" %>

<h2>Add Multiple Questions with Options</h2>

<form action="<%=request.getContextPath()%>/AddMultipleQuestionsServlet" method="post">

    <!-- SUBJECT DROPDOWN -->
    Select Subject:
    <select id="subject" required>
        <option value="">-- Select Subject --</option>
        <%
            try {
                Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement("SELECT * FROM subjects");
                ResultSet rs = ps.executeQuery();
                while(rs.next()){
        %>
            <option value="<%= rs.getInt("id") %>"><%= rs.getString("name") %></option>
        <%
                }
                conn.close();
            } catch(Exception e){ e.printStackTrace(); }
        %>
    </select>

    <br><br>

    <!-- SUBTOPIC DROPDOWN -->
    Select SubTopic:
    <select name="sub_topic_id" id="subtopic" required>
        <option value="">-- Select Subtopic --</option>
    </select>

    <br><br>

    <!-- Questions Table -->
    <table id="questionsTable" border="1" cellpadding="5">
        <tr>
            <th>Question</th>
            <th>Option 1</th>
            <th>Option 2</th>
            <th>Option 3</th>
            <th>Option 4</th>
            <th>Correct Option (1-4)</th>
        </tr>
        <tr>
            <td><input type="text" name="question[]" required></td>
            <td><input type="text" name="option1[]" required></td>
            <td><input type="text" name="option2[]" required></td>
            <td><input type="text" name="option3[]" required></td>
            <td><input type="text" name="option4[]" required></td>
            <td><input type="number" name="correct[]" min="1" max="4" required></td>
        </tr>
    </table>

    <br>
    <button type="button" onclick="addRow()">Add Another Question</button>
    <br><br>
    <input type="submit" value="Save Questions">

</form>

<br>
<a href="adminDashboard.jsp">Back</a>

<script>
function loadSubTopics(){
    var subjectId = document.getElementById("subject").value;

    if(subjectId === "") {
        document.getElementById("subtopic").innerHTML =
            "<option value=''>-- Select Subtopic --</option>";
        return;
    }

    var xhr = new XMLHttpRequest();
    xhr.open("GET", "LoadSubTopicsServlet?subject_id=" + subjectId, true);

    xhr.onload = function(){
        document.getElementById("subtopic").innerHTML =
            "<option value=''>-- Select Subtopic --</option>" + this.responseText;
    };

    xhr.send();
}


    // Add a new row to questions table
    function addRow(){
    var table = document.getElementById("questionsTable");
    var row = table.insertRow(-1);

    for(var i=0; i<7; i++){
        var cell = row.insertCell(i);

        if(i == 5){
            cell.innerHTML = '<input type="number" name="correct[]" min="1" max="4" required>';
        }
        else if(i == 6){
            cell.innerHTML = '<button type="button" onclick="deleteRow(this)">Delete</button>';
        }
        else{
            cell.innerHTML = '<input type="text" name="'+ (i==0?'question[]':'option'+i+'[]') +'" required>';
        }
    }
}
    function deleteRow(button){
        var row = button.parentNode.parentNode;
        row.parentNode.removeChild(row);
    }

    document.getElementById("subject").addEventListener("change", loadSubTopics);
</script>
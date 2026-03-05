<%@ page language="java" %>

<%
    // Prevent caching
    response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
    response.setHeader("Pragma","no-cache");
    response.setDateHeader("Expires", 0);

    // Destroy session
    if(session != null){
        session.invalidate();
    }

    // Redirect to login page
    response.sendRedirect("index.jsp");
%>
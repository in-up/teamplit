<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page language="java" %>

<%
    String sessionId = (String) session.getAttribute("sessionId");
    if (sessionId == null || sessionId.isEmpty()) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<html>
<head>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<script type="text/javascript" src="./resources/js/validation.js"></script>
<title>Team Create</title>
</head>
<body>
<fmt:setLocale value='<%= request.getParameter("language") %>'/>
<fmt:bundle basename="bundle.message">
<div class="container">
   <%@ include file="/resources/header.jsp"%>   

   <div class="p-5 mb-4 bg-body-tertiary rounded-3">
      <div class="container-fluid py-5">
        <h1 class="display-5 fw-bold"><fmt:message key="title" /></h1>
        <p class="col-md-8 fs-4">Team Creating</p>      
      </div>
    </div>
  
  <div class="row align-items-md-stretch">    
        <div class="text-end"> 
            <a href="?language=ko" >Korean</a> | <a href="?language=en" >English</a>
        </div>    
        <form name="newTeam" action="./team_create_process.jsp" method="post" enctype="multipart/form-data">        
            <div class="mb-3 row">
                <label class="col-sm-2"><fmt:message key="teamName" /></label>
                <div class="col-sm-3">
                    <input type="text" name="teamName" id="teamName" class="form-control" required>
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2"><fmt:message key="teamCapacity" /></label>
                <div class="col-sm-3">
                    <input type="number" name="teamCapacity" id="teamCapacity" class="form-control" required min="1">
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2"><fmt:message key="teamManagerId" /></label>
                <div class="col-sm-3">
                    <input type="text" name="teamManagerId" id="teamManagerId" class="form-control" 
                        value="<%= session.getAttribute("sessionId") %>" readonly>
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2"><fmt:message key="teamDescription" /></label>
                <div class="col-sm-5">
                    <textarea name="teamDescription" id="teamDescription" cols="50" rows="2" class="form-control" placeholder="" required></textarea>
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2"><fmt:message key="teamInviteCode" /></label>
                <div class="col-sm-3">
                    <input type="text" name="teamInviteCode" id="teamInviteCode" class="form-control">
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2"><fmt:message key="teamDate" /></label>
                <div class="col-sm-3">
                    <input type="text" name="teamDate" id="teamDate" class="form-control" value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>" readonly>
                </div>
            </div>

            <div class="mb-3 row">
                <label class="col-sm-2"><fmt:message key="teamImage" /></label>
                <div class="col-sm-5">
                    <input type="file" name="teamImage" class="form-control">
                </div>
            </div>

            <div class="mb-3 row">
                <div class="col-sm-offset-2 col-sm-10">
                    <input type="button" class="btn btn-primary" value="<fmt:message key='button' />" onclick="CheckAddTeam()">
                </div>
            </div>
        </form>
    </div>
    <%@ include file="/resources/footer.jsp"%>
</div>    
</fmt:bundle>
</body>
</html>

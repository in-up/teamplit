<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<html>
<head>
 <link href = "./resources/css/bootstrap.min.css" rel="stylesheet">

<title>팀 찾기</title>
</head>
<body>
<div class="container">
   <%@ include file="/resources/header.jsp"%>
   
   <div class="p-5 mb-4 bg-body-tertiary rounded-3">
      <div class="container-fluid py-5">
        <h1 class="display-5 fw-bold">팀 목록</h1>
        <p class="col-md-8 fs-4">원하는 팀을 찾아 참여하세요.</p>      
      </div>
    </div>
	 <%@ include file="dbconn.jsp" %>
	 
	 <div class="row align-items-md-stretch   text-center">	 	
	 <%
	    PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "select * from team";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		while (rs.next()) {
	  %>
     	<div class="col-md-4">
       		<div class="h-100 p-2">	
       			<img src="./resources/images/<%=rs.getString("t_filename")%>" style="width: 200; height:200" />		
				<h5><b><%=rs.getString("t_name")%></b></h5>
				<p><%= rs.getString("t_description").length() > 60 ? rs.getString("t_description").substring(0, 60) : rs.getString("t_description") %>....
				</p>
				<p>최대 <%=rs.getString("t_capacity")%>명
				<p><a href="./team_info.jsp?id=<%=rs.getString("t_id")%>" class="btn btn-secondary" role="button"> 참여하기 &raquo;</a>	</div>
		</div>			
		<%
			}
		if (rs != null) 
			rs.close();
		if (pstmt != null)
			pstmt.close();
		if (conn != null)
			conn.close();
		%>	
		</div>
		<a href="./team_create.jsp" class="btn btn-primary">팀 만들기 &raquo;</a>
		<%@ include file="/resources/footer.jsp"%>  
  </div>
</body>
</html>

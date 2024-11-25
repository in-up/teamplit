<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<html>
<head>
 <link href = "./resources/css/bootstrap.min.css" rel="stylesheet">

<title>팀플릿 | 팀 찾기</title>
</head>
<body>
<div class="container">
   <%@ include file="/resources/header.jsp"%>
   
   <div class="px-5 py-2 mb-5" style="background-color: #3B82F6; color: #ffffff; box-shadow: 0 4px 12px rgba(29, 78, 216, 0.1); border-radius: 2.25rem;">
	<div class="container-fluid py-5">
		<h1 class="display-5" style="font-weight: 800;">팀 찾기</h1>
		<p class="col-md-8 fs-5 fw-bold" style="color: #ffffff;">새로운 팀에 참여할 수 있어요.</p>      
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

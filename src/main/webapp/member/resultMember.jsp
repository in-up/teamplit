<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<link rel="stylesheet" href="../resources/css/bootstrap.min.css" />
<title>팀플릿 | 회원 정보</title>
</head>
<body>

<div class="container">
   <jsp:include page="./../resources/header.jsp" />

	<div class="px-5 py-2 mb-5" style="background-color: #3B82F6; color: #ffffff; box-shadow: 0 4px 12px rgba(29, 78, 216, 0.1); border-radius: 2.25rem;">
		<div class="container-fluid py-5">
			<%
			String msg = request.getParameter("msg");
      		if (msg.equals("0")||msg.equals("2")){
      %>
	  <h1 class="display-5" style="font-weight: 800;">회원정보</h1>
			<p class="col-md-8 fs-5 fw-bold" style="color: #ffffff;">Membership Info</p>
        <% }
      		else if (msg.equals("1")){
        %>  
		<h1 class="display-5" style="font-weight: 800;">회원가입</h1>
			<p class="col-md-8 fs-5 fw-bold" style="color: #ffffff;">Membership Joining</p>
         <% }%>   
		</div>
	   </div>
	

	 <div class="row align-items-md-stretch text-center">
		<%
			

			if (msg != null) {
				if (msg.equals("0"))
					out.println(" <h2 class='alert alert-danger'>회원정보가 수정되었습니다.</h2>");
				else if (msg.equals("1"))
					out.println(" <h2 class='alert alert-success'>회원가입을 축하드립니다.</h2>");
				else if (msg.equals("2")) {
					String loginId = (String) session.getAttribute("sessionId");
					out.println(" <h2 class='alert alert-success'>" + loginId + "님 환영합니다</h2>");
				}				
			} else {
				out.println("<h2 class='alert alert-danger'>회원정보가 삭제되었습니다.</h2>");
			}
		%>
	</div>	
</div>	
</body>
</html>
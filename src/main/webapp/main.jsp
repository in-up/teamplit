<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.Date"%>
<html>
<head>
	<link rel ="stylesheet" href ="./resources/css/bootstrap.min.css" />
	<link rel="stylesheet" href="./resources/css/global.css">
	<link rel="stylesheet" href="./resources/css/page.main.css">
<title>팀플릿 | 홈</title>
</head>
<body>
	<div class="container">
		<%@ include file="/resources/header.jsp"%>
				<!-- 메시지 표시 영역 추가 -->
		<div class="row align-items-md-stretch text-center">
			<%
				// msg 파라미터를 받아옵니다.
				String msg = request.getParameter("msg");

				// msg가 "1"일 때 경고 메시지를 출력합니다.
				if ("1".equals(msg)) {
					out.println("<h2 class='alert alert-danger'>잘못된 접근입니다.</h2>");
				}
			%>
		</div>

		<div
			class="button-container d-flex justify-content-center align-items-center my-5">
			<form action="createTeam.jsp" method="get" class="mx-3">
				<button type="submit" class="btn btn-lg btn-custom">팀 만들기</button>
			</form>
			<form action="joinTeam.jsp" method="get" class="mx-3">
				<button type="submit" class="btn btn-lg btn-custom">팀 참여하기</button>
			</form>
		</div>

		<%!String greeting = "팀플을 더 쉽게, <br>팀플릿!"; 
			String tagline = "쉬운 발표자 정하기"; %>

		<div class="p-5 mb-4 bg-body-tertiary rounded-3">
			<div class="container-fluid py-5">
				<h1 class="display-5 fw-bold"><%=greeting%></h1>
				<p class="col-md-8 fs-4">Teamplit</p>
			</div>
		</div>

		<div class="row align-items-md-stretch text-center">
			<div class="col-md-12">
				<div class="h-100 p-5">
					<h3><%=tagline%></h3>
				</div>
			</div>
		</div>

		<%@ include file="/resources/footer.jsp"%>
	</div>
</body>
</html>

<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.Date"%>
<html>
<head>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet" href="style.css">
<title>팀플릿 | 홈</title>
</head>
<body>
	<div class="container">
		<%@ include file="/components/header.jsp"%>

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
	String tagline = "쉬운 발표자 정하기";%>
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
					<%
					%>
				</div>
			</div>
		</div>


		<%@ include file="/components/footer.jsp"%>
	</div>
</body>
</html>

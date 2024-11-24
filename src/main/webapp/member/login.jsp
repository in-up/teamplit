<%@ page contentType="text/html; charset=utf-8"%>
<html>
<head>
<link rel="stylesheet" href="../resources/css/bootstrap.min.css" />
<title>Login</title>
</head>
<body>

<div class="container">
   <jsp:include page="./../resources/header.jsp" />

 <div class="p-5 mb-4 bg-body-tertiary rounded-3">
      <div class="container-fluid py-5">
        <h1 class="display-5 fw-bold">회원 로그인</h1>
        <p class="col-md-8 fs-4">Membership Login</p>      
      </div>
    </div>
	
	<div class="container" align="center">
		<div class="col-md-4 col-md-offset-4">
			<h3 class="form-signin-heading">Please sign in</h3>
			<%
				String error = request.getParameter("error");
				if (error != null) {
					out.println("<div class='alert alert-danger'>");
					out.println("아이디와 비밀번호를 확인해 주세요");
					out.println("</div>");
				}
			%>
  			<form class="form-signin" action="processLoginMember.jsp" method="post">
  
    			<div class="form-floating mb-3 row">     
      				<input type="text" class="form-control" name='id' id="floatingInput" placeholder="ID" required autofocus>
      				<label for="floatingInput">ID</label>      
    			</div>
    			<div class="form-floating  mb-3 row">     
     	 			<input type="password" class="form-control" name='password' placeholder="Password">
    				 <label for="floatingPassword">Password</label>
			</div>

  				<button class="btn btn-lg btn-success btn-block" type="submit">로그인</button>
   				
  			</form>

			<!-- 회원가입 링크 추가 -->
			<p class="mt-3">
				팀플릿이 처음이신가요? <a href="./addMember.jsp">회원가입</a>
			</p>

		</div>
	</div>

	<jsp:include page="./../resources/footer.jsp" />  
</div>	
</body>			
</html>

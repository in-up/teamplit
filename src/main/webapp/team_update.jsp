<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<html>
<head>
<link rel ="stylesheet" href ="./resources/css/bootstrap.min.css" />

<title>팀플릿 | 팀 정보 수정</title>
    <script>
        function confirmDelete() {
            if (confirm("팀을 영구적으로 삭제할까요?")) {
                window.location.href = "team_delete.jsp?id=" + document.getElementById('t_id').value;
            } else {
                return false;
            }
        }
    </script>
</head>
<body>
<div class="container">
   <%@ include file="/resources/header.jsp"%>	

   <div class="px-5 py-2 mb-5" style="background-color: #3B82F6; color: #ffffff; box-shadow: 0 4px 12px rgba(29, 78, 216, 0.1); border-radius: 2.25rem;">
	<div class="container-fluid py-5">
		<h1 class="display-5" style="font-weight: 800;">팀 정보 수정</h1>
		<p class="col-md-8 fs-5 fw-bold" style="color: #ffffff;">팀 정보를 수정하세요. 이 정보는 다른 사용자도 볼 수 있습니다.</p>      
	</div>
   </div>
  <%@ include file="dbconn.jsp"%>
  <%
		String teamId = request.getParameter("id");

		PreparedStatement pstmt = null;
		ResultSet rs = null;
	
		String sql = "select * from team where t_id = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, teamId);
		rs = pstmt.executeQuery();
		if (rs.next()) {
	%>		
	 <div class="row align-items-md-stretch">	  	
		
		<div class="col-md-5 text-center">
				<img src="./resources/images/<%=rs.getString("t_filename")%>" alt="image" style="width: 70%" />
			</div>
		<div class="col-md-7">	
		<form name="newTeam" action="./team_update_process.jsp" method="post" enctype ="multipart/form-data">
		
			
			<div class="mb-3 row">
				<label class="col-sm-2">팀ID</label>
				<div class="col-sm-5">
					<input type="text" name="t_id" id="t_id" class="form-control" value='<%=rs.getString("t_id")%>' readonly>
				</div>
			</div>
			<div class="mb-3 row">
				<label class="col-sm-2">팀명</label>
				<div class="col-sm-5">
					<input type="text" name="t_name" id="t_name" class="form-control" value='<%=rs.getString("t_name")%>'>
				</div>
			</div>
				<div class="mb-3 row">
				<label class="col-sm-2">최대 인원</label>
				<div class="col-sm-5">
					<input type="text" name="t_capacity"  id="t_capacity" class="form-control" value='<%=rs.getString("t_capacity")%>'>
				</div>
			</div>
			<div class="mb-3 row">
				<label class="col-sm-2">팀장</label>
				<div class="col-sm-5">
					<input type="text" name="t_manager_id" class="form-control" value='<%=rs.getString("t_manager_id")%>' readonly>
				</div>
			</div>
			<div class="mb-3 row">
				<label class="col-sm-2">생성일</label>
				<div class="col-sm-5">
					<input type="text" name="t_date" class="form-control" value='<%=rs.getString("t_date")%>' readonly>
				</div>
			</div>
	
			<div class="mb-3 row">
				<label class="col-sm-2">팀 설명</label>
				<div class="col-sm-8">
					<textarea  name="t_description" id="t_description" cols="50" rows="2"
						class="form-control" placeholder="60자 이상 작성해야 합니다."><%=rs.getString("t_description")%></textarea>
				</div>
			</div>
			<div class="mb-3 row">
				<label class="col-sm-2">대표 이미지</label>
				<div class="col-sm-8">
					<input type="file" name="t_filename" class="form-control">
				</div>
			</div>
			
			<div class="mb-3 row">
				<div class="col-sm-offset-2 col-sm-10 ">
					<input type="submit" class="btn btn-primary" value="수정하기" >
				</div>
			</div>
		</form>
		            <!-- 삭제 버튼 -->
            <div class="mt-3">
                <button type="button" class="btn btn-danger" onclick="confirmDelete()">삭제하기</button>
            </div>
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
	<%@ include file="/resources/footer.jsp"%>
</div>	
</div>

</body>
</html>

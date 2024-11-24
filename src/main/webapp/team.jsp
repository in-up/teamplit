<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="dto.Team"%>
<%@ page import="dao.TeamRepository"%>
<%@ page import="java.sql.*"%>
<%@ page errorPage = "exceptionNoBookId.jsp"%>
<html>
   <head>
      <link href = "./resources/css/bootstrap.min.css" rel="stylesheet">
      <title>팀플릿 | 팀 살펴보기</title>
      <script type="text/javascript">
         function addToCart() {
         	if (confirm("상품을 장바구니에 추가하시겠습니까?")) {
         		document.addForm.submit();
         	} else {		
         		document.addForm.reset();
         	}
         }
      </script>
   </head>
   <body>
      <div class="container py-4">
         <%@ include file="/resources/header.jsp"%>
         <div class="p-5 mb-4 bg-body-tertiary rounded-3">
            <div class="container-fluid py-5">
               <h1 class="display-5 fw-bold">팀 정보</h1>
               <p class="col-md-8 fs-4">Team Info</p>
            </div>
         </div>
         <%
            String id = request.getParameter("id");
            TeamRepository dao = TeamRepository.getInstance();
            Team team = dao.getTeamById(id);
            
            // 팀장 학번으로 이름을 조회하기 위한 DB 연결
            String managerName = "";
            String managerId = team.getT_manager_id();  // 팀장 학번 가져오기
            
            // DB 연결을 위한 코드
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;
            
            try {
            	String url = "jdbc:mysql://localhost:3306/TeamplitDB";
            	String user = "root";
            	String password = "1234";
            	Class.forName("com.mysql.jdbc.Driver");
            	conn = DriverManager.getConnection(url, user, password);
            	
            	// 팀장 학번으로 이름을 조회
            	String sql = "SELECT m_name FROM MEMBER WHERE M_ID = ?";
            	stmt = conn.prepareStatement(sql);
            	stmt.setString(1, managerId);  // 학번을 파라미터로 설정
            	rs = stmt.executeQuery();
            	
            	if (rs.next()) {
            		managerName = rs.getString("m_name");  // 팀장 이름
            	}
            } catch (SQLException e) {
            	e.printStackTrace();
            } finally {
            	// 자원 정리
            	try {
            		if (rs != null) rs.close();
            		if (stmt != null) stmt.close();
            		if (conn != null) conn.close();
            	} catch (SQLException e) {
            		e.printStackTrace();
            	}
            }
            %>
         <div class="row align-items-md-stretch">
            <div class="col-md-5">
               <img src="./resources/images/<%=team.getT_filename()%>" style="width: 70%">
            </div>
            <div class="col-md-6">
               <h3><b><%=team.getT_name()%></b></h3>
               <p><%=team.getT_description()%></p>
               <p><b>팀번호</b> : <span class="badge text-bg-danger"> <%=team.getT_id()%></span></p>
               <p><b>팀장 학번</b> : <%=team.getT_manager_id()%></p>
               <p><b>팀장</b> : <%=managerName%></p>
               <!-- 팀장 이름 표시 -->
               <p><b>현재 정원</b> : </p>
               <p><b>최대 정원</b> : <%=team.getT_capacity()%></p>
               <p><b>생성일</b> : <%=team.getT_date()%></p>
               <p>
               <form name="joinForm" action="./team_join.jsp?id=<%=team.getT_id()%>" method="post">
                  <input type="hidden" name="teamId" value="<%=team.getT_id()%>">
                  <!-- 초대 코드 입력란 추가 -->
                  <div class="mb-3">
                     <label for="inviteCode" class="form-label">초대 코드</label>
                     <input type="text" class="form-control" id="inviteCode" name="inviteCode" placeholder="초대 코드를 입력하세요" required>
                  </div>
                  <!-- 참여하기 버튼 -->
                  <button type="submit" class="btn btn-success">참여하기 &raquo;</button> 
                  <a href="./teams.jsp" class="btn btn-secondary"> 다른 팀 찾기 &raquo;</a>
               </form>
               </p>
            </div>
         </div>
         <%@ include file="/resources/footer.jsp"%>  
      </div>
   </body>
</html>
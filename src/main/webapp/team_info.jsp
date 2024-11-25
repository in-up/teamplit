<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="dto.Team"%>
<%@ page import="dao.TeamRepository"%>
<%@ page import="java.sql.*"%>
<%@ page errorPage = "exceptionNoTeamId.jsp"%>
<html>
   <head>
      <link href = "./resources/css/bootstrap.min.css" rel="stylesheet">
      <title>팀플릿 | 팀 살펴보기</title>
   </head>
   <body>
      <div class="container py-4">
         <%@ include file="/resources/header.jsp"%>
         <div class="px-5 py-2 mb-5" style="background-color: #3B82F6; color: #ffffff; box-shadow: 0 4px 12px rgba(29, 78, 216, 0.1); border-radius: 2.25rem;">
            <div class="container-fluid py-5">
                <h1 class="display-5" style="font-weight: 800;">팀 정보</h1>
                <p class="col-md-8 fs-5 fw-bold" style="color: #ffffff;">새로운 팀에 참여할 수 있어요.</p>      
            </div>
           </div>
         <%
            String id = request.getParameter("id");
            String code = request.getParameter("code");  // URL에서 code 파라미터를 받음
            TeamRepository dao = TeamRepository.getInstance();
            Team team = dao.getTeamById(id);
            
            // 팀장 학번으로 이름을 조회하기 위한 DB 연결
            String managerName = "";
            String managerId = team.getT_manager_id();  // 팀장 학번 가져오기
            
            // DB 연결을 위한 코드
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;
            int currentMembers = 0;  // 현재 정원
            
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
            	
            	// 현재 정원 (현재 팀의 멤버 수) 조회
            	sql = "SELECT COUNT(*) AS member_count FROM TeamMember WHERE tm_t_id = ?";
            	stmt = conn.prepareStatement(sql);
            	stmt.setInt(1, team.getT_id());
            	rs = stmt.executeQuery();
            	
            	if (rs.next()) {
            		currentMembers = rs.getInt("member_count");  // 현재 정원
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
               <p><b>참여 인원</b> : <%=currentMembers%>명 / <%=team.getT_capacity()%>명</p>
               <p><b>입장 가능 여부</b> : <%= (currentMembers >= team.getT_capacity()) ? "입장 불가" : "입장 가능" %></p>
               <p><b>생성일</b> : <%=team.getT_date()%></p>
               <p>
               <form name="joinForm" action="./team_join.jsp?id=<%=team.getT_id()%>" method="post">
                  <input type="hidden" name="teamId" value="<%=team.getT_id()%>">
                  <!-- 초대 코드 입력란 추가 -->
                  <div class="mb-3">
                     <label for="inviteCode" class="form-label">초대 코드</label>
                     <input type="text" class="form-control" id="inviteCode" name="inviteCode" placeholder="초대 코드를 입력하세요"
                        value="<%= (code != null) ? code : "" %>" required>
                  </div>
                  <!-- 참여하기 버튼 -->
                  <button type="submit" class="btn btn-success" 
    				<%= (currentMembers >= team.getT_capacity()) ? "disabled" : "" %>>참여하기 &raquo;</button>
                  <a href="./teams.jsp" class="btn btn-secondary"> 다른 팀 찾기 &raquo;</a>
               </form>
               </p>
            </div>
         </div>
         <%@ include file="/resources/footer.jsp"%>  
      </div>
   </body>
</html>

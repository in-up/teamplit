<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page errorPage="exceptionNoBookId.jsp"%>
<!DOCTYPE html>
<html>
   <head>
      <link href="./resources/css/bootstrap.min.css" rel="stylesheet">
      <title>팀플릿 | 팀스페이스</title>
   </head>
   <body>
      <%
         // 1. 로그인 체크
         String sessionId = (String) session.getAttribute("sessionId");
         String teamId = request.getParameter("id");

         if (sessionId == null || teamId == null) {
             response.sendRedirect("login.jsp");
             return;
         }

         // 2. 세션 ID로 TeamMember에 포함 여부 확인
         boolean isTeamMember = false;
         String teamName = "";
         String teamImage = "";

         Connection conn = null;
         PreparedStatement stmt = null;
         ResultSet rs = null;

         try {
             String url = "jdbc:mysql://localhost:3306/TeamplitDB";
             String user = "root";
             String password = "1234";
             Class.forName("com.mysql.jdbc.Driver");
             conn = DriverManager.getConnection(url, user, password);

             // 팀 멤버 확인 쿼리
             String memberCheckSql = "SELECT 1 FROM TeamMember WHERE tm_t_id = ? AND tm_m_id = ?";
             stmt = conn.prepareStatement(memberCheckSql);
             stmt.setString(1, teamId);
             stmt.setString(2, sessionId);
             rs = stmt.executeQuery();

             if (rs.next()) {
                 isTeamMember = true;
             }

             // 팀 정보 가져오기
             if (isTeamMember) {
                 String teamInfoSql = "SELECT t_name, t_filename FROM Team WHERE t_id = ?";
                 stmt = conn.prepareStatement(teamInfoSql);
                 stmt.setString(1, teamId);
                 rs = stmt.executeQuery();

                 if (rs.next()) {
                     teamName = rs.getString("t_name");
                     teamImage = rs.getString("t_filename");
                 }
             }
         } catch (Exception e) {
             e.printStackTrace();
         } finally {
             try {
                 if (rs != null) rs.close();
                 if (stmt != null) stmt.close();
                 if (conn != null) conn.close();
             } catch (SQLException e) {
                 e.printStackTrace();
             }
         }

         // 팀 멤버가 아닐 경우
         if (!isTeamMember) {
             out.println("<script>alert('팀에 포함되어 있지 않습니다. 메인 페이지로 이동합니다.');</script>");
             response.sendRedirect("main.jsp");
             return;
         }
      %>
      <div class="container">
         <%@ include file="/resources/header.jsp" %>
         <div class="p-5 mb-4 bg-body-tertiary rounded-3">
            <div class="container-fluid py-5">
               <h1 class="display-5 fw-bold">팀 스페이스</h1>
               <p class="col-md-8 fs-4">팀 활동을 위한 공간입니다.</p>
            </div>
         </div>
         <div class="row align-items-md-stretch">
            <!-- 팀 이미지와 이름 -->
            <div class="col-md-6 text-center">
               <img src="./resources/images/<%=teamImage%>" style="width: 50%; border-radius: 10px;">
               <h3 class="mt-3"><b><%= teamName %></b></h3>
            </div>
            <!-- 버튼 섹션 -->
            <div class="col-md-6">
               <h4 class="mb-4">팀 메뉴</h4>
               <div class="d-grid gap-3">
                  <a href="role_assign.jsp?teamId=<%=teamId%>" class="btn btn-primary">역할 분배</a>
                  <a href="team_edit.jsp?teamId=<%=teamId%>" class="btn btn-secondary">팀 정보 수정</a>
                  <a href="team_members.jsp?teamId=<%=teamId%>" class="btn btn-success">팀원 관리</a>
                  <a href="team_board.jsp?teamId=<%=teamId%>" class="btn btn-warning">팀 게시판</a>
               </div>
            </div>
         </div>
         <%@ include file="/resources/footer.jsp" %>
      </div>
   </body>
</html>

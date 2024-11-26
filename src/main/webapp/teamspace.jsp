<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page errorPage = "exceptionNoTeamId.jsp"%>
<!DOCTYPE html>
<html>
   <head>
      <link href="./resources/css/bootstrap.min.css" rel="stylesheet">
      <title>팀플릿 | 팀스페이스</title>
   </head>
   <body>
      <%
         String sessionId = (String) session.getAttribute("sessionId");
         String teamId = request.getParameter("id");

         if (sessionId == null || teamId == null) {
             response.sendRedirect("login.jsp");
             return;
         }

         boolean isTeamMember = false;
         String teamName = "";
         String teamImage = "";
         String teamManagerId = "";

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
                 String teamInfoSql = "SELECT t_name, t_filename, t_manager_id FROM Team WHERE t_id = ?";
                 stmt = conn.prepareStatement(teamInfoSql);
                 stmt.setString(1, teamId);
                 rs = stmt.executeQuery();

                 if (rs.next()) {
                     teamName = rs.getString("t_name");
                     teamImage = rs.getString("t_filename");
                     teamManagerId = rs.getString("t_manager_id"); // 팀장 ID
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
             response.sendRedirect("main.jsp?msg=1");
             return;
         }
      %>
      <div class="container">
         <%@ include file="/resources/header.jsp" %>
         <div class="px-5 py-2 mb-5" style="background-color: #3B82F6; color: #ffffff; box-shadow: 0 4px 12px rgba(29, 78, 216, 0.1); border-radius: 2.25rem;">
            <div class="container-fluid py-5">
                <h1 class="display-5" style="font-weight: 800;">팀 스페이스</h1>
                <p class="col-md-8 fs-5 fw-bold" style="color: #ffffff;">팀 프로젝트를 수행하는 팀 스페이스입니다.</p>      
            </div>
           </div>
         <div class="row align-items-md-stretch">
            <div class="col-md-6 text-center">
               <img src="./resources/images/<%=teamImage%>" style="width: 50%; border-radius: 10px;">
               <h3 class="mt-3"><b><%= teamName %></b></h3>
            </div>
            <div class="col-md-6">
               <h4 class="mb-4">팀 메뉴</h4>
               <div class="d-grid gap-3">
               <%
                     if (sessionId != null && sessionId.equals(teamManagerId)) {
                  %>
                     <a href="team_assign.jsp?id=<%=teamId%>" class="btn btn-success">역할 분배</a>
                  <%
                     }
                  %>
                  <a href="team_members.jsp?id=<%=teamId%>" class="btn btn-secondary">팀원 목록</a>
                  <a href="board.jsp?id=<%=teamId%>" class="btn btn-secondary">팀 게시판</a>
                  <a href="team_invite.jsp?id=<%=teamId%>" class="btn btn-warning">팀스페이스 초대하기</a>
                  <!-- 팀장 전용 -->
                  <%
                     if (sessionId != null && sessionId.equals(teamManagerId)) {
                  %>
                     <a href="team_update.jsp?id=<%=teamId%>" class="btn btn-danger">팀 정보 수정</a>
                  <%
                     }
                  %>
               </div>
            </div>
         </div>
         <%@ include file="/resources/footer.jsp" %>
      </div>
   </body>
</html>

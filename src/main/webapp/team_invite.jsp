<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page errorPage = "exceptionNoTeamId.jsp"%>
<html>
   <head>
      <link href="./resources/css/bootstrap.min.css" rel="stylesheet">
      <title>팀플릿 | 팀스페이스 초대하기</title>
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
         String inviteCode = "";

         Connection conn = null;
         PreparedStatement stmt = null;
         ResultSet rs = null;

         try {
             String url = "jdbc:mysql://localhost:3306/TeamplitDB";
             String user = "root";
             String password = "1234";
             Class.forName("com.mysql.jdbc.Driver");
             conn = DriverManager.getConnection(url, user, password);

             String memberCheckSql = "SELECT 1 FROM TeamMember WHERE tm_t_id = ? AND tm_m_id = ?";
             stmt = conn.prepareStatement(memberCheckSql);
             stmt.setString(1, teamId);
             stmt.setString(2, sessionId);
             rs = stmt.executeQuery();

             if (rs.next()) {
                 isTeamMember = true;
             }

             if (isTeamMember) {
                 String teamInfoSql = "SELECT t_name, t_filename, t_manager_id, t_invite_code FROM Team WHERE t_id = ?";
                 stmt = conn.prepareStatement(teamInfoSql);
                 stmt.setString(1, teamId);
                 rs = stmt.executeQuery();

                 if (rs.next()) {
                     teamName = rs.getString("t_name");
                     teamImage = rs.getString("t_filename");
                     teamManagerId = rs.getString("t_manager_id");
                     inviteCode = rs.getString("t_invite_code"); 
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

         // 팀원이 아닌 경우 리다이렉트
         if (!isTeamMember) {
             out.println("<script>alert('팀에 포함되어 있지 않습니다. 메인 페이지로 이동합니다.');</script>");
             response.sendRedirect("main.jsp?msg=1");
             return;
         }
      %>
      <div class="container py-4">
         <%@ include file="/resources/header.jsp"%>
         <!-- 페이지 상단 정보 -->
         <div class="px-5 py-2 mb-5" style="background-color: #3B82F6; color: #ffffff; box-shadow: 0 4px 12px rgba(29, 78, 216, 0.1); border-radius: 2.25rem;">
            <div class="container-fluid py-5">
                <h1 class="display-5" style="font-weight: 800;">초대하기</h1>
                <p class="col-md-8 fs-5 fw-bold" style="color: #ffffff;">QR코드를 이용해 새로운 인원을 쉽게 초대하세요.</p>      
            </div>
           </div>

         <!-- QR 코드 출력 영역 -->
         <div class="row justify-content-center">
            <div class="col-md-4 text-center">
               <img src="https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=http://teamplit.cafe24.com/team_info.jsp?id=<%= teamId %>%26code=<%= inviteCode %>" alt="팀 초대 QR 코드">
               <p class="mt-3">QR 코드를 스캔하여 팀에 참여하세요!</p>
            </div>
         </div>
         <a href="./teamspace.jsp?id=<%= teamId %>" class="btn btn-primary">팀스페이스로 돌아가기 &raquo;</a>
         <%@ include file="/resources/footer.jsp"%>
      </div>
   </body>
</html>

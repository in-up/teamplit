<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page errorPage = "exceptionNoTeamId.jsp"%>
<html>
   <head>
      <link href="./resources/css/bootstrap.min.css" rel="stylesheet">
      <title>팀플릿 | 팀원 내보내기</title>
   </head>
   <body>
      <%
         String sessionId = (String) session.getAttribute("sessionId");
         String teamId = request.getParameter("teamId");
         String memberId = request.getParameter("memberId");

         if (sessionId == null || teamId == null || memberId == null) {
             response.sendRedirect("login.jsp");
             return;
         }

         boolean isTeamManager = false;
         Connection conn = null;
         PreparedStatement stmt = null;
         ResultSet rs = null;

         try {
             String url = "jdbc:mysql://localhost:3306/TeamplitDB";
             String user = "root";
             String password = "1234";
             Class.forName("com.mysql.jdbc.Driver");
             conn = DriverManager.getConnection(url, user, password);

             String teamInfoSql = "SELECT t_manager_id FROM Team WHERE t_id = ?";
             stmt = conn.prepareStatement(teamInfoSql);
             stmt.setString(1, teamId);
             rs = stmt.executeQuery();

             if (rs.next() && rs.getString("t_manager_id").equals(sessionId)) {
                 isTeamManager = true;
             }

             if (!isTeamManager) {
                 response.sendRedirect("main.jsp");
                 return;
             }

             String deleteMemberSql = "DELETE FROM TeamMember WHERE tm_t_id = ? AND tm_m_id = ?";
             stmt = conn.prepareStatement(deleteMemberSql);
             stmt.setString(1, teamId);
             stmt.setString(2, memberId);
             stmt.executeUpdate();

             response.sendRedirect("team_members.jsp?id=" + teamId);
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
      %>
   </body>
</html>

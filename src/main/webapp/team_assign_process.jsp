<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<html>
   <head>
      <link href="./resources/css/bootstrap.min.css" rel="stylesheet">
      <title>팀플릿 | 역할 분배</title>
   </head>
   <body>
      <%
         // 로그인 체크
         String sessionId = (String) session.getAttribute("sessionId");
         String teamId = request.getParameter("teamId");

         if (sessionId == null || teamId == null) {
             response.sendRedirect("login.jsp");
             return;
         }

         Connection conn = null;
         PreparedStatement stmt = null;
         ResultSet rs = null;

         List<String> roles = new ArrayList<>();
         List<String> memberIds = new ArrayList<>();

         try {
             String url = "jdbc:mysql://localhost:3306/TeamplitDB";
             String user = "root";
             String password = "1234";
             Class.forName("com.mysql.jdbc.Driver");
             conn = DriverManager.getConnection(url, user, password);

             String memberSql = "SELECT tm_m_id FROM TeamMember WHERE tm_t_id = ?";
             stmt = conn.prepareStatement(memberSql);
             stmt.setString(1, teamId);
             rs = stmt.executeQuery();

             while (rs.next()) {
                 memberIds.add(rs.getString("tm_m_id"));
             }

             for (int i = 1; i <= memberIds.size(); i++) {
                 String role = request.getParameter("role_" + i);
                 if (role != null && !role.trim().isEmpty()) {
                     roles.add(role);
                 }
             }

             Collections.shuffle(roles);

             for (int i = 0; i < memberIds.size(); i++) {
                 String memberId = memberIds.get(i);
                 String role = (i < roles.size()) ? roles.get(i) : "";

                 String updateRoleSql = "UPDATE TeamMember SET tm_role = ? WHERE tm_t_id = ? AND tm_m_id = ?";
                 stmt = conn.prepareStatement(updateRoleSql);
                 stmt.setString(1, role);
                 stmt.setString(2, teamId);
                 stmt.setString(3, memberId);
                 stmt.executeUpdate();
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

      %>

      <div class="container py-4">
         <%@ include file="/resources/header.jsp"%>

         <div class="row align-items-md-stretch text-center">
            <h2 class="alert alert-success">팀원들에게 역할이 성공적으로 분배되었습니다.</h2>
         </div>

         <div class="text-center">
            <a href="./team_members.jsp?id=<%= teamId %>" class="btn btn-primary">결과 확인 &raquo;</a>
         </div>

         <%@ include file="/resources/footer.jsp"%>
      </div>
   </body>
</html>

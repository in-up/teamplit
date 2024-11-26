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
         String teamId = request.getParameter("id");

         if (sessionId == null || teamId == null) {
             response.sendRedirect("login.jsp");
             return;
         }

         int teamSize = 0;
         Connection conn = null;
         PreparedStatement stmt = null;
         ResultSet rs = null;

         try {
             String url = "jdbc:mysql://localhost:3306/TeamplitDB";
             String user = "root";
             String password = "1234";
             Class.forName("com.mysql.jdbc.Driver");
             conn = DriverManager.getConnection(url, user, password);

             String memberCountSql = "SELECT COUNT(*) FROM TeamMember WHERE tm_t_id = ?";
             stmt = conn.prepareStatement(memberCountSql);
             stmt.setString(1, teamId);
             rs = stmt.executeQuery();

             if (rs.next()) {
                 teamSize = rs.getInt(1);
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

         <h1 class="display-5 fw-bold">역할 분배</h1>
         <p>팀원들에게 역할을 분배해주세요.</p>

         <form action="team_assign_process.jsp" method="POST">
            <input type="hidden" name="teamId" value="<%= teamId %>"/>

            <% 
               for (int i = 1; i <= teamSize; i++) {
            %>
            <div class="mb-3">
               <label for="role_<%= i %>" class="form-label">역할 <%= i %>:</label>
               <input type="text" class="form-control" id="role_<%= i %>" name="role_<%= i %>" required>
            </div>
            <% } %>

            <button type="submit" class="btn btn-primary">분배하기</button>
         </form>

         <%@ include file="/resources/footer.jsp"%>
      </div>
   </body>
</html>

<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page errorPage="exceptionNoBookId.jsp"%>
<%@ page import="java.util.*" %>
<html>
   <head>
      <link href="./resources/css/bootstrap.min.css" rel="stylesheet">
      <title>팀플릿 | 팀원 목록</title>
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

         boolean isTeamManager = false;
         String teamName = "";
         Connection conn = null;
         PreparedStatement stmt = null;
         ResultSet rs = null;

         List<Map<String, String>> teamMembers = new ArrayList<>();  // teamMembers 리스트 초기화
         boolean isMember = false; // 사용자가 팀원 목록에 포함되어 있는지 체크

         try {
             String url = "jdbc:mysql://localhost:3306/TeamplitDB";
             String user = "root";
             String password = "1234";
             Class.forName("com.mysql.jdbc.Driver");
             conn = DriverManager.getConnection(url, user, password);

             // 2. 팀 정보 가져오기 (팀장 확인)
             String teamInfoSql = "SELECT t_name, t_manager_id FROM Team WHERE t_id = ?";
             stmt = conn.prepareStatement(teamInfoSql);
             stmt.setString(1, teamId);
             rs = stmt.executeQuery();

             if (rs.next()) {
                 teamName = rs.getString("t_name");
                 if (rs.getString("t_manager_id").equals(sessionId)) {
                     isTeamManager = true;
                 }
             }

             // 3. 팀원의 목록을 가져오기
             String teamMembersSql = "SELECT tm.tm_m_id, tm.tm_role, m.m_name, m.m_email, m.m_phone FROM TeamMember tm " +
                                      "JOIN Member m ON tm.tm_m_id = m.m_id WHERE tm.tm_t_id = ?";
             stmt = conn.prepareStatement(teamMembersSql);
             stmt.setString(1, teamId);
             rs = stmt.executeQuery();

             // 4. 팀원 목록을 표시하기 위한 리스트에 데이터 추가
             while (rs.next()) {
                 Map<String, String> member = new HashMap<>();
                 member.put("m_id", rs.getString("tm_m_id"));
                 member.put("m_name", rs.getString("m_name"));
                 member.put("m_role", rs.getString("tm_role"));
                 member.put("m_email", rs.getString("m_email"));
                 member.put("m_phone", rs.getString("m_phone"));
                 teamMembers.add(member);  // teamMembers 리스트에 추가
                 
                 // 사용자가 팀에 포함되어 있으면 isMember를 true로 설정
                 if (sessionId.equals(rs.getString("tm_m_id"))) {
                     isMember = true;
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

         // 팀 멤버가 아니면 메인으로 리다이렉트
         if (!isMember) {
             response.sendRedirect("main.jsp?msg=1");
             return;
         }

         // 팀 멤버가 없다면 메인으로 리다이렉트
         if (teamMembers.isEmpty()) {
             out.println("<script>alert('팀에 속한 멤버가 없습니다.');</script>");
             response.sendRedirect("main.jsp?msg=1");
             return;
         }
      %>
      
      <div class="container py-4">
         <%@ include file="/resources/header.jsp"%>

         <!-- 페이지 상단 정보 -->
         <div class="p-5 mb-4 bg-body-tertiary rounded-3">
            <div class="container-fluid py-5">
               <h1 class="display-5 fw-bold">팀원 목록</h1>
               <p class="col-md-8 fs-4">최고의 동료들을 확인하세요.</p>
            </div>
         </div>

         <!-- 팀원 목록 테이블 -->
         <table class="table table-hover text-center">
            <thead>
               <tr>
                  <th>학번</th>
                  <th>이름</th>
                  <th>역할</th>
                  <th>이메일</th>
                  <th>전화번호</th>
                  <th>Action</th>
               </tr>
            </thead>
            <tbody>
               <% 
                  // teamMembers 리스트를 순회하며 테이블에 데이터 출력
                  for (Map<String, String> member : teamMembers) {
               %>
               <tr>
                  <td><%= member.get("m_id") %></td>
                  <td>
                     <%= member.get("m_name") %>
                     <% if (sessionId.equals(member.get("m_id"))) { %> 
                        (나)
                     <% } %>
                  </td>
                  <td>
   					<%= (member.get("m_role") == null || member.get("m_role").isEmpty()) ? "미정" : member.get("m_role") %>
				</td>
                  <td><%= member.get("m_email") %></td>
                  <td><%= member.get("m_phone") %></td>
                  <td>
                     <% if (isTeamManager && !sessionId.equals(member.get("m_id"))) { %>
                        <!-- 팀장이면서 본인이 아니면 내보내기 버튼 표시 -->
                        <a href="team_members_remove.jsp?teamId=<%= teamId %>&memberId=<%= member.get("m_id") %>" class="btn btn-danger">내보내기</a>
                     <% } %>
                  </td>
               </tr>
               <% } %>
            </tbody>
         </table>
         
         <%@ include file="/resources/footer.jsp"%>
      </div>
   </body>
</html>

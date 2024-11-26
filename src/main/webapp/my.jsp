<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
   String sessionId = (String) session.getAttribute("sessionId");
   String message = "";
   Connection conn = null;
   PreparedStatement stmt = null;
   ResultSet rs = null;
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
   
   if (sessionId == null) {
       message = "로그인 후 이용 가능합니다.";
   } else {
       List<Map<String, String>> teams = new ArrayList<>();
       try {
           String url = "jdbc:mysql://localhost:3306/TeamplitDB";
           String user = "root";
           String password = "1234";
           Class.forName("com.mysql.jdbc.Driver");
           conn = DriverManager.getConnection(url, user, password);
   
           String sql = "SELECT t.t_id, t.t_name, t.t_capacity, t.t_manager_id, t.t_date " +
                        "FROM TeamMember tm " +
                        "JOIN Team t ON tm.tm_t_id = t.t_id " +
                        "WHERE tm.tm_m_id = ?";
           stmt = conn.prepareStatement(sql);
           stmt.setString(1, sessionId);
           rs = stmt.executeQuery();
   
           while (rs.next()) {
               Map<String, String> team = new HashMap<>();
               team.put("t_id", rs.getString("t_id"));
               team.put("t_name", rs.getString("t_name"));
               team.put("t_capacity", rs.getString("t_capacity"));
               team.put("t_manager_id", rs.getString("t_manager_id"));
               team.put("t_date", rs.getString("t_date"));
               teams.add(team);
           }
   
           if (teams.isEmpty()) {
               message = "가입한 팀이 없습니다.";
           }
   
           Cookie[] cookies = request.getCookies();
           Set<String> favorites = new HashSet<>();
           if (cookies != null) {
               for (Cookie cookie : cookies) {
                   if ("favorites".equals(cookie.getName())) {
                       String[] favoriteTeams = cookie.getValue().split("|");
                       favorites.addAll(Arrays.asList(favoriteTeams));
                   }
               }
           }
   
           request.setAttribute("teams", teams);
           request.setAttribute("favorites", favorites); 
       } catch (Exception e) {
           message = "오류가 발생했습니다: " + e.getMessage();
       } finally {
           try {
               if (rs != null) rs.close();
               if (stmt != null) stmt.close();
               if (conn != null) conn.close();
           } catch (SQLException e) {
               message = "자원 정리 중 오류 발생: " + e.getMessage();
           }
       }
   }
   %>
<!DOCTYPE html>
<html>
   <head>
      <link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
      <title>팀플릿 | 나의 팀</title>
   </head>
   <body>
      <div class="container">
         <jsp:include page="./resources/header.jsp" />
         <div class="px-5 py-2 mb-5" style="background-color: #3B82F6; color: #ffffff; box-shadow: 0 4px 12px rgba(29, 78, 216, 0.1); border-radius: 2.25rem;">
            <div class="container-fluid py-5">
               <h1 class="display-5" style="font-weight: 800;">나의 팀</h1>
               <p class="col-md-8 fs-5 fw-bold" style="color: #ffffff;">현재 참여중인 팀을 확인할 수 있어요.</p>
            </div>
         </div>
         <div class="row align-items-md-stretch text-center">
            <% if (message != null && !message.isEmpty()) { %>
            <h2 class="alert alert-info"><%= message %></h2>
            <% } %>
         </div>
         <div class="row">
            <h3>즐겨찾기한 팀</h3>
            <% 
               List<Map<String, String>> teams = (List<Map<String, String>>) request.getAttribute("teams");
               Set<String> favorites = (Set<String>) request.getAttribute("favorites");
               
               boolean hasFavorites = false;
               
               if (teams != null && !teams.isEmpty()) {
                   for (Map<String, String> team : teams) { 
                       String managerId = team.get("t_manager_id");
                       String position = sessionId.equals(managerId) ? "팀장" : "팀원";
                       String teamId = team.get("t_id");
               
                       if (favorites.contains(teamId)) {
                           hasFavorites = true;
               %>
            <div class="col-md-6 mb-4">
               <div class="card">
                  <div class="card-body">
                     <a href="teamspace.jsp?id=<%= team.get("t_id") %>" class="card-title">
                        <h5><%= team.get("t_name") %></h5>
                     </a>
                     <p class="card-text">
                        <b>직책:</b> <%= position %><br>
                        <b>최대 인원:</b> <%= team.get("t_capacity") %><br>
                        <b>팀 생성일:</b> <%= team.get("t_date") %>
                     </p>
                     <form method="POST" action="favorite_process.jsp">
                        <input type="hidden" name="teamId" value="<%= teamId %>" />
                        <button type="submit" class="btn btn-warning">☆</button>
                     </form>
                  </div>
               </div>
            </div>
            <% 
               }
               }
               
               if (!hasFavorites) {
               %>
            <div class="col-12 text-center">
               <h4>즐겨찾기한 팀이 없습니다.</h4>
            </div>
            <% 
               }
               }
               %>
         </div>
         <div class="row">
            <h3>참여중인 팀</h3>
            <% 
               if (teams != null && !teams.isEmpty()) {
                   for (Map<String, String> team : teams) { 
                       String managerId = team.get("t_manager_id");
                       String position = sessionId.equals(managerId) ? "팀장" : "팀원";
               %>
            <div class="col-md-6 mb-4">
               <div class="card">
                  <div class="card-body">
                     <a href="teamspace.jsp?id=<%= team.get("t_id") %>" class="card-title">
                        <h5><%= team.get("t_name") %></h5>
                     </a>
                     <p class="card-text">
                        <b>직책:</b> <%= position %><br>
                        <b>최대 인원:</b> <%= team.get("t_capacity") %><br>
                        <b>팀 생성일:</b> <%= team.get("t_date") %>
                     </p>
                     <form method="POST" action="favorite_process.jsp">
                        <input type="hidden" name="teamId" value="<%= team.get("t_id") %>" />
                        <button type="submit" class="btn btn-outline-warning">☆</button>
                     </form>
                  </div>
               </div>
            </div>
            <% 
               }
               } 
               %>
         </div>
         <a href="./teams.jsp" class="btn btn-primary">팀 목록으로 돌아가기 &raquo;</a>
      </div>
   </body>
</html>
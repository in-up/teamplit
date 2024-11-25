<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page errorPage="exceptionNoBoardId.jsp"%>
<%@ page import="java.util.*"%>
<html>
   <head>
      <link href="./resources/css/bootstrap.min.css" rel="stylesheet">
      <title>팀플릿 | 팀 게시판</title>
   </head>
   <body>
      <%
         // 1. 팀 ID 가져오기
         String teamId = request.getParameter("id");
         if (teamId == null) {
             response.sendRedirect("main.jsp?msg=1");
             return;
         }

         Connection conn = null;
         PreparedStatement stmt = null;
         ResultSet rs = null;
         List<Map<String, String>> boardPosts = new ArrayList<>();

         try {
             String url = "jdbc:mysql://localhost:3306/TeamplitDB";
             String user = "root";
             String password = "1234";
             Class.forName("com.mysql.jdbc.Driver");
             conn = DriverManager.getConnection(url, user, password);

             // 2. 해당 팀의 게시글 목록 조회
             String sql = "SELECT b_num, b_title, b_m_name, b_date, b_hit FROM Board WHERE b_t_id = ? ORDER BY b_num DESC";
             stmt = conn.prepareStatement(sql);
             stmt.setString(1, teamId);
             rs = stmt.executeQuery();

             // 3. 결과를 리스트에 담기
             while (rs.next()) {
                 Map<String, String> post = new HashMap<>();
                 post.put("b_num", rs.getString("b_num"));
                 post.put("b_title", rs.getString("b_title"));
                 post.put("b_m_name", rs.getString("b_m_name"));
                 post.put("b_date", rs.getString("b_date"));
                 post.put("b_hit", rs.getString("b_hit"));
                 boardPosts.add(post);
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

         <!-- 페이지 상단 정보 -->
         <div class="p-5 mb-4 bg-body-tertiary rounded-3">
            <div class="container-fluid py-5">
               <h1 class="display-5 fw-bold">팀 게시판</h1>
               <p class="col-md-8 fs-4">정보를 공유하고, 친목을 도모하세요.</p>
            </div>
         </div>

         <!-- 게시글 목록 테이블 -->
         <table class="table table-hover text-center">
            <thead>
               <tr>
                  <th>번호</th>
                  <th>제목</th>
                  <th>작성자</th>
                  <th>작성일</th>
                  <th>조회수</th>
               </tr>
            </thead>
            <tbody>
               <% 
                  // 게시글 목록을 순회하여 테이블에 출력
                  for (Map<String, String> post : boardPosts) {
               %>
               <tr>
                  <td><%= post.get("b_num") %></td>
                  <td><a href="board_article.jsp?id=<%= teamId %>&num=<%= post.get("b_num") %>"><%= post.get("b_title") %></a></td>
                  <td><%= post.get("b_m_name") %></td>
                  <td><%= post.get("b_date") %></td>
                  <td><%= post.get("b_hit") %></td>
               </tr>
               <% } %>
            </tbody>
         </table>

         <!-- 글 작성 버튼 -->
         <div class="text-center mt-4">
            <a href="board_write.jsp?id=<%= teamId %>" class="btn btn-primary">글 작성</a>
         </div>

         <%@ include file="/resources/footer.jsp"%>
      </div>
   </body>
</html>

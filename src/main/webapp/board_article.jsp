<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<%@ page errorPage="exceptionBoardArticle.jsp" %>
<html>
   <head>
      <link href="./resources/css/bootstrap.min.css" rel="stylesheet">
      <title>팀플릿 | 게시글</title>
   </head>
   <body>
      <%
         // 로그인 체크
         String sessionId = (String) session.getAttribute("sessionId");
         String teamId = request.getParameter("id");
         String bNum = request.getParameter("num");
         
         if (sessionId == null || teamId == null || bNum == null) {
             response.sendRedirect("login.jsp");
             return;
         }
         
         String bTitle = "";
         String bContent = "";
         String bDate = "";
         String bMId = "";
         String bMName = "";
         int bHit = 0;
         
         try {
             // DB 연결
             String url = "jdbc:mysql://localhost:3306/TeamplitDB";
             String user = "root";
             String password = "1234";
             Class.forName("com.mysql.jdbc.Driver");
             Connection conn = DriverManager.getConnection(url, user, password);
         
             String sql = "SELECT b_title, b_content, b_date, b_m_id, b_m_name, b_hit FROM Board WHERE b_num = ? AND b_t_id = ?";
             PreparedStatement stmt = conn.prepareStatement(sql);
             stmt.setInt(1, Integer.parseInt(bNum));
             stmt.setInt(2, Integer.parseInt(teamId));
         
             ResultSet rs = stmt.executeQuery();
         
             if (rs.next()) {
                 bTitle = rs.getString("b_title");
                 bContent = rs.getString("b_content");
                 bDate = rs.getString("b_date");
                 bMId = rs.getString("b_m_id");
                 bMName = rs.getString("b_m_name");
                 bHit = rs.getInt("b_hit");
         
                 String hitUpdateSql = "UPDATE Board SET b_hit = ? WHERE b_num = ?";
                 PreparedStatement hitStmt = conn.prepareStatement(hitUpdateSql);
                 hitStmt.setInt(1, bHit + 1);  // 조회수 증가
                 hitStmt.setInt(2, Integer.parseInt(bNum));
                 hitStmt.executeUpdate();
                 hitStmt.close();
             }
             rs.close();
             stmt.close();
             conn.close();
         } catch (Exception e) {
             e.printStackTrace();
         }
         %>
      <div class="container py-4">
         <%@ include file="/resources/header.jsp" %>
         <!-- 페이지 상단 정보 -->
         <div class="px-5 py-2 mb-5" style="background-color: #3B82F6; color: #ffffff; box-shadow: 0 4px 12px rgba(29, 78, 216, 0.1); border-radius: 2.25rem;">
            <div class="container-fluid py-5">
               <h1 class="display-5" style="font-weight: 800;">팀 게시판</h1>
               <p class="col-md-8 fs-5 fw-bold" style="color: #ffffff;">최고의 프로젝트를 위해 협동하세요!</p>
            </div>
         </div>
         <!-- 게시글 내용 -->
         <div class="card">
            <div class="card-header">
               <h2><%= bTitle %></h2>
            </div>
            <div class="card-body">
               <p><strong>작성자:</strong> <%= bMName %> (학번: <%= bMId %>)</p>
               <p><strong>작성일:</strong> <%= bDate %></p>
               <p><strong>조회수:</strong> <%= bHit %></p>
               <hr>
               <p><%= bContent %></p>
            </div>
         </div>
         <!-- 페이지 하단 버튼 -->
         <div class="mt-4">
            <a href="board.jsp?id=<%= teamId %>" class="btn btn-primary">게시판으로 돌아가기</a>
            <% if (sessionId != null && sessionId.equals(bMId)) { %>
            <a href="board_edit.jsp?id=<%= teamId %>&num=<%= bNum %>" class="btn btn-warning">수정</a>
            <a href="board_remove.jsp?id=<%= teamId %>&num=<%= bNum %>" class="btn btn-danger">삭제</a>
            <% } %>
         </div>
         <%@ include file="/resources/footer.jsp" %>
      </div>
   </body>
</html>
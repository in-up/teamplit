<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<%@ page errorPage="exceptionNoBoardId.jsp" %>
<html>
   <head>
      <link href="./resources/css/bootstrap.min.css" rel="stylesheet">
      <title>팀플릿 | 글 작성</title>
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

         String memberName = "";
         try {
             // DB 연결
             String url = "jdbc:mysql://localhost:3306/TeamplitDB";
             String user = "root";
             String password = "1234";
             Class.forName("com.mysql.jdbc.Driver");
             Connection conn = DriverManager.getConnection(url, user, password);

             // 작성자 이름 조회
             String sql = "SELECT m_name FROM Member WHERE m_id = ?";
             PreparedStatement stmt = conn.prepareStatement(sql);
             stmt.setString(1, sessionId);
             ResultSet rs = stmt.executeQuery();

             if (rs.next()) {
                 memberName = rs.getString("m_name");
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
                <h1 class="display-5" style="font-weight: 800;">글 작성하기</h1>
                <p class="col-md-8 fs-5 fw-bold" style="color: #ffffff;">팀 게시판에 글을 작성할 수 있어요.</p>      
            </div>
           </div>

         <!-- 글 작성 폼 -->
         <form action="board_write_process.jsp" method="post">
            <input type="hidden" name="teamId" value="<%= teamId %>">
            <input type="hidden" name="m_id" value="<%= sessionId %>">
            <input type="hidden" name="m_name" value="<%= memberName %>">
            <input type="hidden" name="b_hit" value="0">
            <input type="hidden" name="b_date" value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>">
            
            <!-- 제목 -->
            <div class="mb-3">
               <label for="b_title" class="form-label">제목</label>
               <input type="text" class="form-control" id="b_title" name="b_title" required>
            </div>

            <!-- 내용 -->
            <div class="mb-3">
               <label for="b_content" class="form-label">내용</label>
               <textarea class="form-control" id="b_content" name="b_content" rows="5" required></textarea>
            </div>

            <!-- 게시 버튼 -->
            <button type="submit" class="btn btn-primary">게시</button>
         </form>

         <%@ include file="/resources/footer.jsp" %>
      </div>
   </body>
</html>

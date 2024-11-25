<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<%@ page errorPage="exceptionBoardEdit.jsp" %>
<html>
   <head>
      <link href="./resources/css/bootstrap.min.css" rel="stylesheet">
      <title>팀플릿 | 게시글 수정</title>
   </head>
   <body>
      <%
         String sessionId = (String) session.getAttribute("sessionId");
         String teamId = request.getParameter("id");
         String bNum = request.getParameter("num");

         if (sessionId == null || teamId == null || bNum == null) {
             response.sendRedirect("login.jsp");
             return;
         }

         String bTitle = "";
         String bContent = "";

         try {
             // DB 연결
             String url = "jdbc:mysql://localhost:3306/TeamplitDB";
             String user = "root";
             String password = "1234";
             Class.forName("com.mysql.jdbc.Driver");
             Connection conn = DriverManager.getConnection(url, user, password);

             // 게시글 조회 쿼리
             String sql = "SELECT b_title, b_content FROM Board WHERE b_num = ? AND b_t_id = ?";
             PreparedStatement stmt = conn.prepareStatement(sql);
             stmt.setInt(1, Integer.parseInt(bNum));
             stmt.setInt(2, Integer.parseInt(teamId));

             ResultSet rs = stmt.executeQuery();

             if (rs.next()) {
                 bTitle = rs.getString("b_title");
                 bContent = rs.getString("b_content");
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
					<h1 class="display-5" style="font-weight: 800;">게시글 수정</h1>
					<p class="col-md-8 fs-5 fw-bold" style="color: #ffffff;">팀 게시판의 게시글을 수정할 수 있어요.</p>      
				</div>
			   </div>

         <!-- 글 수정 폼 -->
         <form action="board_edit_process.jsp" method="post">
            <input type="hidden" name="teamId" value="<%= teamId %>">
            <input type="hidden" name="bNum" value="<%= bNum %>">
            
            <!-- 제목 -->
            <div class="mb-3">
               <label for="b_title" class="form-label">제목</label>
               <input type="text" class="form-control" id="b_title" name="b_title" value="<%= bTitle %>" required>
            </div>

            <!-- 내용 -->
            <div class="mb-3">
               <label for="b_content" class="form-label">내용</label>
               <textarea class="form-control" id="b_content" name="b_content" rows="5" required><%= bContent %></textarea>
            </div>

            <!-- 수정 버튼 -->
            <button type="submit" class="btn btn-primary">수정</button>
         </form>

         <%@ include file="/resources/footer.jsp" %>
      </div>
   </body>
</html>

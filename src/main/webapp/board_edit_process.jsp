<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<%@ page errorPage="exceptionBoardEditProcess.jsp" %>
<html>
   <head>
      <link href="./resources/css/bootstrap.min.css" rel="stylesheet">
      <title>팀플릿 | 게시글 수정 처리</title>
   </head>
   <body>
      <%
         String sessionId = (String) session.getAttribute("sessionId");
         String teamId = request.getParameter("teamId");
         String bNum = request.getParameter("bNum");
         String bTitle = request.getParameter("b_title");
         String bContent = request.getParameter("b_content");

         if (sessionId == null || teamId == null || bNum == null || bTitle == null || bContent == null) {
             response.sendRedirect("login.jsp");
             return;
         }

         boolean updateSuccess = false;

         try {
             // DB 연결
             String url = "jdbc:mysql://localhost:3306/TeamplitDB";
             String user = "root";
             String password = "1234";
             Class.forName("com.mysql.jdbc.Driver");
             Connection conn = DriverManager.getConnection(url, user, password);

             // 게시글 수정 쿼리
             String sql = "UPDATE Board SET b_title = ?, b_content = ? WHERE b_num = ? AND b_t_id = ?";
             PreparedStatement stmt = conn.prepareStatement(sql);
             stmt.setString(1, bTitle);
             stmt.setString(2, bContent);
             stmt.setInt(3, Integer.parseInt(bNum));
             stmt.setInt(4, Integer.parseInt(teamId));

             int result = stmt.executeUpdate();
             if (result > 0) {
                 updateSuccess = true;
             }

             stmt.close();
             conn.close();
         } catch (Exception e) {
             e.printStackTrace();
         }

         if (updateSuccess) {
             // 수정 성공
             response.sendRedirect("board_article.jsp?id=" + teamId + "&num=" + bNum + "&msg=1");
         } else {
             // 수정 실패
             response.sendRedirect("board_edit.jsp?id=" + teamId + "&num=" + bNum + "&msg=0");
         }
      %>
   </body>
</html>

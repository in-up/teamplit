<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<%@ page errorPage="exceptionBoardRemove.jsp" %>
<html>
   <head>
      <link href="./resources/css/bootstrap.min.css" rel="stylesheet">
      <title>팀플릿 | 게시글 삭제</title>
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

         try {
             // DB 연결
             String url = "jdbc:mysql://localhost:3306/TeamplitDB";
             String user = "root";
             String password = "1234";
             Class.forName("com.mysql.jdbc.Driver");
             Connection conn = DriverManager.getConnection(url, user, password);

             // 게시글 삭제 쿼리
             String sql = "DELETE FROM Board WHERE b_num = ? AND b_t_id = ?";
             PreparedStatement stmt = conn.prepareStatement(sql);
             stmt.setInt(1, Integer.parseInt(bNum));
             stmt.setInt(2, Integer.parseInt(teamId));

             int result = stmt.executeUpdate();

             if (result > 0) {
                 response.sendRedirect("board.jsp?id=" + teamId);
             } else {
                 response.sendRedirect("board.jsp?id=" + teamId);
             }

             stmt.close();
             conn.close();
         } catch (Exception e) {
             e.printStackTrace();
         }
      %>
   </body>
</html>

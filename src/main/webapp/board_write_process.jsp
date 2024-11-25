<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<%@ page errorPage="exceptionBoardWriteProcess.jsp" %>
<html>
   <head>
      <link href="./resources/css/bootstrap.min.css" rel="stylesheet">
      <title>팀플릿 | 글 작성 결과</title>
   </head>
   <body>
      <%
         String teamId = request.getParameter("teamId");
         String mId = request.getParameter("m_id");
         String mName = request.getParameter("m_name");
         String bTitle = request.getParameter("b_title");
         String bContent = request.getParameter("b_content");
         String bDate = request.getParameter("b_date");
         int bHit = Integer.parseInt(request.getParameter("b_hit"));

         Connection conn = null;
         PreparedStatement stmt = null;

         try {
             // DB 연결
             String url = "jdbc:mysql://localhost:3306/TeamplitDB";
             String user = "root";
             String password = "1234";
             Class.forName("com.mysql.jdbc.Driver");
             conn = DriverManager.getConnection(url, user, password);

             // 게시글 삽입
             String sql = "INSERT INTO Board (b_m_id, b_m_name, b_t_id, b_title, b_content, b_date, b_hit) VALUES (?, ?, ?, ?, ?, ?, ?)";
             stmt = conn.prepareStatement(sql);
             stmt.setString(1, mId);
             stmt.setString(2, mName);
             stmt.setInt(3, Integer.parseInt(teamId));
             stmt.setString(4, bTitle);
             stmt.setString(5, bContent);
             stmt.setString(6, bDate);
             stmt.setInt(7, bHit);

             int result = stmt.executeUpdate();

             if (result > 0) {
                 response.sendRedirect("board.jsp?id=" + teamId + "&msg=1");
             } else {
                 response.sendRedirect("board.jsp?id=" + teamId + "&msg=0");
             }
         } catch (Exception e) {
             e.printStackTrace();
             response.sendRedirect("board.jsp?id=" + teamId + "&msg=0");
         } finally {
             try {
                 if (stmt != null) stmt.close();
                 if (conn != null) conn.close();
             } catch (SQLException e) {
                 e.printStackTrace();
             }
         }
      %>
   </body>
</html>

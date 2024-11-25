<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%@ include file="dbconn.jsp"%>
<%
    String teamId = request.getParameter("id");

    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // 팀 삭제 쿼리
        String sql = "SELECT * FROM team WHERE t_id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, teamId);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            // 팀 삭제
            sql = "DELETE FROM team WHERE t_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, teamId);
            pstmt.executeUpdate();
            response.sendRedirect("teams.jsp");
        } else {
            out.println("일치하는 팀이 없습니다.");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("팀 삭제 중 오류가 발생했습니다.");
    } finally {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>

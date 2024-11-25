<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
    String teamId = request.getParameter("teamId");
    String inviteCode = request.getParameter("inviteCode");
    String sessionId = (String) session.getAttribute("sessionId");
    String message = "";
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    String currentDate = sdf.format(new java.util.Date());

    if (sessionId == null) {
        message = "로그인 후 참여 가능합니다.";
    } else {
        try {
            String url = "jdbc:mysql://localhost:3306/TeamplitDB";
            String user = "root";
            String password = "1234";
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, password);

            String sql = "SELECT * FROM Team WHERE t_id = ? AND t_invite_code = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, teamId);
            stmt.setString(2, inviteCode);
            rs = stmt.executeQuery();

            if (rs.next()) {
                String checkMemberSql = "SELECT * FROM TeamMember WHERE tm_t_id = ? AND tm_m_id = ?";
                stmt = conn.prepareStatement(checkMemberSql);
                stmt.setString(1, teamId);
                stmt.setString(2, sessionId);
                rs = stmt.executeQuery();

                if (rs.next()) {
                    message = "이미 해당 팀에 가입되어 있습니다.";
                } else {
                    String insertSql = "INSERT INTO TeamMember (tm_t_id, tm_m_id, tm_role, tm_date) VALUES (?, ?, '', ?)";
                    stmt = conn.prepareStatement(insertSql);
                    stmt.setString(1, teamId);
                    stmt.setString(2, sessionId);
                    stmt.setString(3, currentDate);
                    int result = stmt.executeUpdate();

                    if (result > 0) {
                        message = "팀 참여가 성공적으로 완료되었습니다!";
                    } else {
                        message = "팀 참여에 실패했습니다. 다시 시도해 주세요.";
                    }
                }
            } else {
                message = "초대 코드가 일치하지 않습니다. 다시 확인해주세요.";
            }
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
    <title>팀플릿 | 팀 참여하기</title>
</head>
<body>
    <div class="container">
        <jsp:include page="./resources/header.jsp" />
        
        <div class="px-5 py-2 mb-5" style="background-color: #3B82F6; color: #ffffff; box-shadow: 0 4px 12px rgba(29, 78, 216, 0.1); border-radius: 2.25rem;">
            <div class="container-fluid py-5">
                <h1 class="display-5" style="font-weight: 800;">참여 결과</h1>
                <p class="col-md-8 fs-5 fw-bold" style="color: #ffffff;">참여 결과를 확인하세요.</p>      
            </div>
           </div>

        <!-- 메시지 출력 -->
        <div class="row align-items-md-stretch text-center">
            <h2 class="alert alert-info"><%= message %></h2>
        </div>

        <a href="./teams.jsp" class="btn btn-primary">팀 목록으로 돌아가기 &raquo;</a>
    </div>
</body>
</html>

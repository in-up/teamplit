<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.oreilly.servlet.multipart.*"%>
<%@ page import="java.util.*"%>
<%@ include file="dbconn.jsp" %>
<%@ page import="dao.TeamRepository"%>
<%@ page import="dto.Team"%>
<%
    request.setCharacterEncoding("UTF-8");

    String filename = "";

    String realFolder = "C:\\Users\\Ahn\\eclipse-workspace\\teamplit\\src\\main\\webapp\\resources\\images"; 
    int maxSize = 5 * 1024 * 1024;
    String encType = "utf-8";

    MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());

    String teamName = multi.getParameter("teamName");
    String teamCapacity = multi.getParameter("teamCapacity");
    String teamManagerId = multi.getParameter("teamManagerId");
    String teamDescription = multi.getParameter("teamDescription");
    String teamInviteCode = multi.getParameter("teamInviteCode");
    String teamDate = multi.getParameter("teamDate");

    Enumeration<String> files = multi.getFileNames();
    String fname = (String) files.nextElement();
    String fileName = multi.getFilesystemName(fname); // 업로드된 파일 이름

    int capacity = 0;
    if (!teamCapacity.isEmpty()) {
        capacity = Integer.parseInt(teamCapacity);
    }

    PreparedStatement pstmt = null;
    String sql = "INSERT INTO Team (t_name, t_capacity, t_manager_id, t_description, t_invite_code, t_date, t_filename) "
               + "VALUES (?, ?, ?, ?, ?, ?, ?)";

    try {
        // SQL 데이터 삽입
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, teamName);
        pstmt.setInt(2, capacity);
        pstmt.setString(3, teamManagerId);
        pstmt.setString(4, teamDescription);
        pstmt.setString(5, teamInviteCode);
        pstmt.setString(6, teamDate);
        pstmt.setString(7, fileName);
        pstmt.executeUpdate();

        Team newTeam = new Team(4, teamName, capacity, teamInviteCode);
        newTeam.setT_manager_id(teamManagerId);
        newTeam.setT_description(teamDescription);
        newTeam.setT_date(teamDate);
        newTeam.setT_filename("4.png"); //야매코드 (fileName으로 고치기)

        TeamRepository teamRepo = TeamRepository.getInstance();
        teamRepo.addTeam(newTeam); // 메모리에 팀 데이터 추가

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // 리소스 해제
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }

    response.sendRedirect("teams.jsp");
%>

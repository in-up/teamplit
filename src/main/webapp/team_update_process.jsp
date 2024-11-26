<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.oreilly.servlet.multipart.*"%>
<%@ page import="java.sql.*"%>
<%@ include file="dbconn.jsp" %>

<%
    request.setCharacterEncoding("UTF-8");

    // 업로드 경로 설정
    String realFolder = "C:\\Users\\Ahn\\eclipse-workspace\\teamplit\\src\\main\\webapp\\resources\\images"; 
    String encType = "utf-8";  // 인코딩 타입
    int maxSize = 5 * 1024 * 1024;  // 최대 업로드 파일 크기 5Mb

    // MultipartRequest 생성 (파일 업로드 처리)
    MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());

    // 폼에서 받은 파라미터 값
    String t_id = multi.getParameter("t_id");
    String t_name = multi.getParameter("t_name");
    String t_capacity = multi.getParameter("t_capacity");
    String t_manager_id = multi.getParameter("t_manager_id");
    String t_date = multi.getParameter("t_date");
    String t_description = multi.getParameter("t_description");
    String t_filename = multi.getParameter("t_filename");

    // 파일 업로드된 이름 가져오기
    Enumeration files = multi.getFileNames();
    String fname = (String) files.nextElement();
    String fileName = multi.getFilesystemName(fname);

    // 팀 정보 업데이트 처리
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    // 팀 ID로 팀 정보 조회
    String sql = "SELECT * FROM Team WHERE t_id = ?";
    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, t_id);  // 팀 ID를 파라미터로 설정
    rs = pstmt.executeQuery();

    if (rs.next()) {
        if (fileName != null) {
            sql = "UPDATE Team SET t_name=?, t_capacity=?, t_manager_id=?, t_description=?, t_date=?, t_filename=? WHERE t_id=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, t_name);
            pstmt.setInt(2, Integer.parseInt(t_capacity));
            pstmt.setString(3, t_manager_id);
            pstmt.setString(4, t_description);
            pstmt.setString(5, t_date);
            pstmt.setString(6, fileName);  // 파일 이름 업데이트
            pstmt.setInt(7, Integer.parseInt(t_id)); 
            pstmt.executeUpdate();
        } else {
            // 파일이 업로드 되지 않은 경우: 파일 이름을 업데이트하지 않음
            sql = "UPDATE Team SET t_name=?, t_capacity=?, t_manager_id=?, t_description=?, t_date=? WHERE t_id=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, t_name);
            pstmt.setInt(2, Integer.parseInt(t_capacity));
            pstmt.setString(3, t_manager_id);
            pstmt.setString(4, t_description);
            pstmt.setString(5, t_date);
            pstmt.setInt(6, Integer.parseInt(t_id));  
            pstmt.executeUpdate();
        }
    }

    if (pstmt != null) pstmt.close();
    if (conn != null) conn.close();

    response.sendRedirect("teamspace.jsp?id=" + t_id);

%>

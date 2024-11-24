<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.HashSet"%>
<%@ page import="java.util.Arrays"%>
<%@ page import="java.util.Set"%>
<%
    String teamId = request.getParameter("teamId");
    Cookie[] cookies = request.getCookies();
    Set<String> favorites = new HashSet<String>();
    boolean found = false;

    // 기존의 즐겨찾기 쿠키 읽기
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("favorites".equals(cookie.getName())) {
                // 콤마(,)를 |로 대체하여 읽기
                String[] favoriteTeams = cookie.getValue().split("\\|");
                favorites.addAll(Arrays.asList(favoriteTeams));
                found = true;
            }
        }
    }

    // 팀 ID 추가 또는 삭제
    if (favorites.contains(teamId)) {
        favorites.remove(teamId);
    } else {
        favorites.add(teamId);
    }

    // 쿠키로 즐겨찾기 저장 (|로 구분)
    Cookie favoriteCookie = new Cookie("favorites", String.join("|", favorites));
    favoriteCookie.setMaxAge(60 * 60 * 24 * 30);  // 쿠키 30일 유지
    response.addCookie(favoriteCookie);

    // 페이지 새로고침
    response.sendRedirect("./my.jsp");
%>

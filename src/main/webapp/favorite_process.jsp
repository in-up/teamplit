<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.HashSet"%>
<%@ page import="java.util.Arrays"%>
<%@ page import="java.util.Set"%>
<%
    String teamId = request.getParameter("teamId");
    Cookie[] cookies = request.getCookies();
    Set<String> favorites = new HashSet<String>();
    boolean found = false;

    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("favorites".equals(cookie.getName())) {
                String[] favoriteTeams = cookie.getValue().split("\\|");
                favorites.addAll(Arrays.asList(favoriteTeams));
                found = true;
            }
        }
    }

    if (favorites.contains(teamId)) {
        favorites.remove(teamId);
    } else {
        favorites.add(teamId);
    }

    Cookie favoriteCookie = new Cookie("favorites", String.join("|", favorites));
    favoriteCookie.setMaxAge(60 * 60 * 24 * 30);
    response.addCookie(favoriteCookie);

    // 페이지 새로고침
    response.sendRedirect("./my.jsp");
%>

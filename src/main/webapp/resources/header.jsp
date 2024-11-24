<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<html>
   <head>
      <link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css' />" />
      <link rel="stylesheet" href="<c:url value='/resources/css/global.css' />">
   </head>
   <body>
      <header class="header py-3">
         <div class="container d-flex justify-content-between align-items-center">
            <!-- Logo Section -->
            <a href="<c:url value='/main.jsp' />" class="logo d-flex align-items-center text-decoration-none">
               <svg width="40" height="40" viewBox="0 0 90 90" fill="none"
                  xmlns="http://www.w3.org/2000/svg">
                  <rect width="90" height="90" rx="26" fill="url(#paint0_linear_0_1)" />
                  <g filter="url(#filter0_d_0_1)">
                     <path
                        d="M26.1429 42.2857C29.1371 42.2857 31.5714 39.8513 31.5714 36.8571C31.5714 33.8629 29.1371 31.4286 26.1429 31.4286C23.1487 31.4286 20.7143 33.8629 20.7143 36.8571C20.7143 39.8513 23.1487 42.2857 26.1429 42.2857ZM64.1429 42.2857C67.1371 42.2857 69.5714 39.8513 69.5714 36.8571C69.5714 33.8629 67.1371 31.4286 64.1429 31.4286C61.1487 31.4286 58.7143 33.8629 58.7143 36.8571C58.7143 39.8513 61.1487 42.2857 64.1429 42.2857ZM66.8571 45H61.4286C59.9357 45 58.5871 45.6022 57.6031 46.5777C61.0214 48.4522 63.4473 51.8366 63.9732 55.8571H69.5714C71.0728 55.8571 72.2857 54.6442 72.2857 53.1429V50.4286C72.2857 47.4344 69.8513 45 66.8571 45ZM45.1429 45C50.3933 45 54.6429 40.7504 54.6429 35.5C54.6429 30.2496 50.3933 26 45.1429 26C39.8924 26 35.6429 30.2496 35.6429 35.5C35.6429 40.7504 39.8924 45 45.1429 45ZM51.6571 47.7143H50.9531C49.1888 48.5625 47.2295 49.0714 45.1429 49.0714C43.0563 49.0714 41.1054 48.5625 39.3326 47.7143H38.6286C33.2339 47.7143 28.8571 52.0911 28.8571 57.4857V59.9286C28.8571 62.1763 30.6808 64 32.9286 64H57.3571C59.6049 64 61.4286 62.1763 61.4286 59.9286V57.4857C61.4286 52.0911 57.0518 47.7143 51.6571 47.7143ZM32.6826 46.5777C31.6987 45.6022 30.35 45 28.8571 45H23.4286C20.4344 45 18 47.4344 18 50.4286V53.1429C18 54.6442 19.2129 55.8571 20.7143 55.8571H26.304C26.8384 51.8366 29.2643 48.4522 32.6826 46.5777Z"
                        fill="white" />
                  </g>
                  <defs>
                     <filter id="filter0_d_0_1" x="11.7" y="21.7" width="66.8856"
                        height="50.6" filterUnits="userSpaceOnUse"
                        color-interpolation-filters="sRGB">
                        <feFlood flood-opacity="0" result="BackgroundImageFix" />
                        <feColorMatrix in="SourceAlpha" type="matrix"
                           values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"
                           result="hardAlpha" />
                        <feOffset dy="2" />
                        <feGaussianBlur stdDeviation="3.15" />
                        <feComposite in2="hardAlpha" operator="out" />
                        <feColorMatrix type="matrix"
                           values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.1 0" />
                        <feBlend mode="normal" in2="BackgroundImageFix"
                           result="effect1_dropShadow_0_1" />
                        <feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow_0_1"
                           result="shape" />
                     </filter>
                     <linearGradient id="paint0_linear_0_1" x1="45" y1="0" x2="45" y2="90"
                        gradientUnits="userSpaceOnUse">
                        <stop stop-color="#0090FF" />
                        <stop offset="0.52" stop-color="#0588F0" />
                     </linearGradient>
                  </defs>
               </svg>
               <span class="fs-4 ms-2 text-black">팀플릿</span>
            </a>
            <nav class="navbar navbar-expand-md justify-content-center">
               <ul class="navbar-nav d-flex align-items-center gap-4">
                  <li class="nav-item">
                     <a href="<c:url value='/main.jsp' />" class="nav-link fw-bold fs-6">홈</a>
                  </li>
                  <li class="nav-item">
                     <a href="<c:url value='/teams.jsp' />" class="nav-link fw-bold fs-6">팀 찾기</a>
                  </li>
                  <li class="nav-item">
                     <a href="<c:url value='/team_create.jsp' />" class="nav-link fw-bold fs-6">팀 만들기</a>
                  </li>
               </ul>
            </nav>
            <c:choose>
               <c:when test="${not empty sessionScope.sessionId}">
                  <sql:setDataSource var="dataSource" url="jdbc:mysql://localhost:3306/TeamplitDB" driver="com.mysql.jdbc.Driver" user="root" password="1234" />
                  <sql:query dataSource="${dataSource}" var="userInfo">
                     SELECT m_name FROM MEMBER WHERE M_ID = ?
                     <sql:param value="${sessionScope.sessionId}" />
                  </sql:query>
                  <c:forEach var="user" items="${userInfo.rows}">
                     <div class="d-flex justify-content-end gap-3">
                        <form action="<c:url value='/member/updateMember.jsp' />" method="get" class="d-inline">
                           <button type="submit" class="btn btn-link text-black text-decoration-none fs-6">
                           ${user.m_name}님
                           </button>
                        </form>
                        <form action="<c:url value='/member/logoutMember.jsp' />" method="post" class="d-inline">
                           <button type="submit" class="btn btn-danger text-white" style="background-color: #dc3545">로그아웃</button>
                        </form>
                     </div>
                  </c:forEach>
               </c:when>
               <c:otherwise>
                  <form action="<c:url value='/login.jsp' />" method="get">
                     <button type="submit" class="btn btn-primary text-white" style="background-color: #0090FF">로그인</button>
                  </form>
               </c:otherwise>
            </c:choose>
         </div>
      </header>
   </body>
</html>
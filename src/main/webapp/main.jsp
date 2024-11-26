<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.Date"%>
<html>
   <head>
      <link rel ="stylesheet" href ="./resources/css/bootstrap.min.css" />
      <link rel="stylesheet" href="./resources/css/global.css">
      <link rel="stylesheet" href="./resources/css/page.main.css">
      <title>팀플릿 | 홈</title>
   </head>
   <body>
      <div class="container">
         <%@ include file="/resources/header.jsp"%>
         <div class="row align-items-md-stretch text-center">
            <%
               String msg = request.getParameter("msg");
               if ("1".equals(msg)) {
               	out.println("<h2 class='alert alert-danger'>잘못된 접근입니다.</h2>");
               }
               %>
         </div>
         <div class="button-container d-flex justify-content-center align-items-center my-5">
            <form action="team_create.jsp" method="get" class="mx-3">
               <button type="submit" class="btn-custom d-flex flex-column align-items-center p-4" style="">
                  <svg style="color: #3B82F6;" width="150px" height="150px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                     <g id="Edit / Add_To_Queue">
                        <path id="Vector" d="M3 9V19.4C3 19.9601 3 20.2399 3.10899 20.4538C3.20487 20.642 3.35774 20.7952 3.5459 20.8911C3.7596 21 4.0395 21 4.59846 21H15.0001M14 13V10M14 10V7M14 10H11M14 10H17M7 13.8002V6.2002C7 5.08009 7 4.51962 7.21799 4.0918C7.40973 3.71547 7.71547 3.40973 8.0918 3.21799C8.51962 3 9.08009 3 10.2002 3H17.8002C18.9203 3 19.4801 3 19.9079 3.21799C20.2842 3.40973 20.5905 3.71547 20.7822 4.0918C21.0002 4.51962 21.0002 5.07969 21.0002 6.19978L21.0002 13.7998C21.0002 14.9199 21.0002 15.48 20.7822 15.9078C20.5905 16.2841 20.2842 16.5905 19.9079 16.7822C19.4805 17 18.9215 17 17.8036 17H10.1969C9.07899 17 8.5192 17 8.0918 16.7822C7.71547 16.5905 7.40973 16.2842 7.21799 15.9079C7 15.4801 7 14.9203 7 13.8002Z" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                     </g>
                  </svg>
                  <span class="mt-2" style="font-weight: 600;">팀 만들기</span>
               </button>
            </form>
            <form action="teams.jsp" method="get" class="mx-3">
               <button type="submit" class="btn-custom d-flex flex-column align-items-center p-4">
                  <svg style="color: #34D399;" width="150px" height="150px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                     <path d="M11 6C13.7614 6 16 8.23858 16 11M16.6588 16.6549L21 21M19 11C19 15.4183 15.4183 19 11 19C6.58172 19 3 15.4183 3 11C3 6.58172 6.58172 3 11 3C15.4183 3 19 6.58172 19 11Z" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                  </svg>
                  <span class="mt-2" style="font-weight: 600;">팀 참여하기</span>
               </button>
            </form>
            <form action="my.jsp" method="get" class="mx-3">
               <button type="submit" class="btn-custom d-flex flex-column align-items-center p-4">
                  <svg style="color: #FBBF24;" width="150px" height="150px" viewBox="0 0 20 20" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                     <title>profile_round [#1342]</title>
                     <desc>Created with Sketch.</desc>
                     <defs>
                     </defs>
                     <g id="Page-1" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                        <g id="Dribbble-Light-Preview" transform="translate(-140.000000, -2159.000000)" fill="#000000">
                           <g id="icons" transform="translate(56.000000, 160.000000)">
                              <path d="M100.562548,2016.99998 L87.4381713,2016.99998 C86.7317804,2016.99998 86.2101535,2016.30298 86.4765813,2015.66198 C87.7127655,2012.69798 90.6169306,2010.99998 93.9998492,2010.99998 C97.3837885,2010.99998 100.287954,2012.69798 101.524138,2015.66198 C101.790566,2016.30298 101.268939,2016.99998 100.562548,2016.99998 M89.9166645,2004.99998 C89.9166645,2002.79398 91.7489936,2000.99998 93.9998492,2000.99998 C96.2517256,2000.99998 98.0830339,2002.79398 98.0830339,2004.99998 C98.0830339,2007.20598 96.2517256,2008.99998 93.9998492,2008.99998 C91.7489936,2008.99998 89.9166645,2007.20598 89.9166645,2004.99998 M103.955674,2016.63598 C103.213556,2013.27698 100.892265,2010.79798 97.837022,2009.67298 C99.4560048,2008.39598 100.400241,2006.33098 100.053171,2004.06998 C99.6509769,2001.44698 97.4235996,1999.34798 94.7348224,1999.04198 C91.0232075,1998.61898 87.8750721,2001.44898 87.8750721,2004.99998 C87.8750721,2006.88998 88.7692896,2008.57398 90.1636971,2009.67298 C87.1074334,2010.79798 84.7871636,2013.27698 84.044024,2016.63598 C83.7745338,2017.85698 84.7789973,2018.99998 86.0539717,2018.99998 L101.945727,2018.99998 C103.221722,2018.99998 104.226185,2017.85698 103.955674,2016.63598" id="profile_round-[#1342]">
                              </path>
                           </g>
                        </g>
                     </g>
                  </svg>
                  <span class="mt-2" style="font-weight: 600;">참여중인 팀</span>
               </button>
            </form>
         </div>
         <div class="px-5 py-2 mb-5" style="background-color: #3B82F6; color: #ffffff; box-shadow: 0 4px 12px rgba(29, 78, 216, 0.1); border-radius: 2.25rem;">
            <div class="container-fluid py-5">
               <h1 class="display-5" style="font-weight: 800;">팀플을 더 쉽게, <br>팀플릿!</h1>
               <p class="col-md-8 fs-5 fw-bold" style="color: #ffffff;">팀플릿으로 작업 속도를 높이고, <br>최고의 프로젝트를 위해 노력해보세요.</p>
            </div>
         </div>
         <!-- 섹터 1 -->
         <div class="my-5 p-4" style="background-color: #F1F5F9; border-radius: 1.5rem;">
            <h2 class="text-center mb-4" style="font-weight: 800; color: #3B82F6;">팀을 만들고, 가입하고, 활동하세요.</h2>
            <p class="text-center fs-5" style="color: #555555;">최고의 팀 프로젝트를 위해 팀플릿을 활용해보세요.</p>
         </div>
         <!-- 섹터 2 -->
         <div class="my-5 p-4" style="background-color: #F1F5F9; border-radius: 1.5rem;">
            <h2 class="text-center mb-4" style="font-weight: 800; color: #34D399;">발표는 누가 해? 빠른 역할분담 기능!</h2>
            <p class="text-center fs-5" style="color: #555555;">모든 참여자의 역할을 한 번에 분담할 수 있어요.</p>
         </div>
         <!-- 섹터 3 -->
         <div class="my-5 p-4" style="background-color: #F1F5F9; border-radius: 1.5rem;">
            <h2 class="text-center mb-4" style="font-weight: 800; color: #FBBF24;">빠르게 모여! QR코드 초대</h2>
            <p class="text-center fs-5" style="color: #555555;">이제 바쁘게 전화번호를 나누지 않아도 돼요. QR코드로 팀원을 모으고, 오직 프로젝트에 집중하세요.</p>
         </div>
         <%@ include file="/resources/footer.jsp"%>
      </div>
   </body>
</html>
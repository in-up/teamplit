<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%
	request.setCharacterEncoding("UTF-8");

	String m_id = request.getParameter("id");
	String m_password = request.getParameter("password");
	String m_name = request.getParameter("name");
	String year = request.getParameter("birthyy");
	String month = request.getParameterValues("birthmm")[0];
	String day = request.getParameter("birthdd");
	String m_date = year + "-" + month + "-" + day;
	String mail1 = request.getParameter("mail1");
	String mail2 = request.getParameterValues("mail2")[0];
	String m_email = mail1 + "@" + mail2;
	String m_phone = request.getParameter("phone");
%>

<sql:setDataSource var="dataSource"
	url="jdbc:mysql://localhost:3306/TeamplitDB"
	driver="com.mysql.cj.jdbc.Driver" user="root" password="1234" />

<sql:update dataSource="${dataSource}" var="resultSet">
   INSERT INTO member (m_id, m_password, m_name, m_date, m_email, m_phone) 
   VALUES (?, ?, ?, ?, ?, ?)
   <sql:param value="<%=m_id%>" />
   <sql:param value="<%=m_password%>" />
   <sql:param value="<%=m_name%>" />
   <sql:param value="<%=m_date%>" />
   <sql:param value="<%=m_email%>" />
   <sql:param value="<%=m_phone%>" />
</sql:update>

<c:if test="${resultSet >= 1}">
	<c:redirect url="resultMember.jsp?msg=1" />
</c:if>

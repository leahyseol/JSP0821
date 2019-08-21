<%@page import="com.exam.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		// bring session value
		MemberVO loginMember=(MemberVO) session.getAttribute("loginMember");
		// session value is not exist => move to loginFrom.jsp
		if (loginMember == null) {
			response.sendRedirect("loginForm.jsp");
			return;
		}
	%>

	<h1>Main page</h1>

	<%=loginMember.getName() %>(<%=loginMember.getId() %>) login<br>
	<button type="button" onclick="location.href='logout.jsp';">log out</button>
	<br>
	<a href="info.jsp">Membership review</a><br>
	<a href="update.jsp">Membership revise</a><br>
	<a href="delete.jsp">Membership delete</a><br>
	<% 
	if (loginMember.getId().equals("admin")) {
		%>
		<a href="list.jsp">A whole list</a><br>
		<%
	}
	%>

</body>
</html>
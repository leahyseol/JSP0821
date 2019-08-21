<%@page import="java.util.List"%>
<%@page import="com.exam.dao.MemberDao"%>
<%@page import="com.exam.vo.MemberVO"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>membership list</title>
</head>
<body>

	<%
		//bring session
		//String id=(String)session.getAttribute("id");
		MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
		//session id is not exist (null) or not admin -> main.jsp
		if (loginMember == null || !loginMember.getId().equals("admin")) {
			response.sendRedirect("main.jsp");
			return;
		}
	%>


	<%
		//Dao prepare
		MemberDao memberDao = MemberDao.getInstance();
		//Bring a whole list of membership
		List<MemberVO> memberList = memberDao.getMembers();
	%>

	<h1>membership list</h1>

	<table border="1">
		<tr>
			<th>ID</th>
			<th>PW</th>
			<th>name</th>
			<th>gender</th>
			<th>age</th>
			<th>Email</th>
			<th>reg_date</th>
		</tr>

		<%
			if (memberList.size() > 0) {
				for (MemberVO member : memberList) {
		%>
		<tr>
			<td><%=member.getId()%></td>
			<td><%=member.getPasswd()%></td>
			<td><%=member.getName()%></td>
			<td><%=member.getGender()%></td>
			<td><%=member.getAge()%></td>
			<td><%=member.getEmail()%></td>
			<td><%=member.getRegDate()%></td>
		</tr>
		<%
			}
			} else { // memberList.size() == 0
		%>
		<tr>
			<td colspan="7">not found</td>
		</tr>

		<%
			} //while
		%>
	</table>

	<a href="main.jsp">go to main page</a>


</body>
</html>
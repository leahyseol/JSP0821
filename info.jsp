<%@page import="com.exam.vo.MemberVO"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>membership check</title>
</head>
<body>

<%
//Bring session value
MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
//without session => move to loginForm.jsp 
if(loginMember==null){
	response.sendRedirect("loginForm.jsp");
	return;
}
%>

<h1>membership check</h1>

ID: <%=loginMember.getId() %><br>
PW: <%=loginMember.getPasswd()  %><br>
name: <%=loginMember.getName() %><br>
age: <%=(loginMember.getAge() == null) ? "" : loginMember.getAge() %><br>
gender: <%=(loginMember.getGender() == null) ? "" : loginMember.getGender() %><br>
email: <%=(loginMember.getEmail() == null) ? "" : loginMember.getEmail() %><br>
reg_date: <%=loginMember.getRegDate() %><br>
<br>

<a href="main.jsp">go to main page</a>

</body>
</html>
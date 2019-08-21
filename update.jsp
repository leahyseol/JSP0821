<%@page import="com.exam.vo.MemberVO"%>
<%@page import="java.sql.*"%>
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
// 세션값 가져오기
MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");

// 세션값 없으면 loginForm.jsp 이동
if (loginMember == null) {
	response.sendRedirect("loginForm.jsp");
	return;
}
%>

<h1>revise membership</h1>

<form action="updateProcess.jsp" method="post">
ID: <input type="text" name="id" value="<%=loginMember.getId() %>" <%--readonly--%> disabled /><br>
PW: <input type="password" name="passwd" /><br>
name: <input type="text" name="name" value="<%=loginMember.getName() %>" /><br>
age: <input type="text" name="age" value="<%=(loginMember.getAge() == null) ? "" : loginMember.getAge() %>"/><br>
gender: <input type="radio" name="gender" value="male" 
	      <%=(loginMember.getGender() != null && loginMember.getGender().equals("남")) ? "checked" : "" %> />male
	      <input type="radio" name="gender" value="female"
	      <%=(loginMember.getGender() != null && loginMember.getGender().equals("여")) ? "checked" : "" %> />female<br>
email: <input type="email" name="email" value="<%=(loginMember.getEmail() == null) ? "" : loginMember.getEmail() %>"><br>
<button type="submit">revise</button>
</form>
<br>
<a href="main.jsp">go to main page</a>

</body>
</html>
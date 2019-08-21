<%@page import="com.exam.vo.MemberVO"%>
<%@page import="com.exam.dao.MemberDao"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	//Bring session
	MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
	// 세션값 없으면 loginForm.jsp 이동
	if (loginMember == null) {
		response.sendRedirect("loginForm.jsp");
		return;
	}
%>

<%
	// post 파라미터값 한글처리
	request.setCharacterEncoding("utf-8");
%>

<%-- 액션태그 userBean 자바빈 객체생성 --%>
<jsp:useBean id="memberVO" class="com.exam.vo.MemberVO" />

<%-- 액션태그 setProperty 폼 -> 자바빈 필드에 저장 --%>
<jsp:setProperty property="*" name="memberVO" />

<%
	// DB객체 준비
	MemberDao memberDao = MemberDao.getInstance();

	int result = memberDao.updateMember(memberVO);


if (result == 1) {
	MemberVO updatedMemberVO = memberDao.getMember(memberVO.getId());
	session.setAttribute("loginMember", updatedMemberVO);
	%>
<script>
	alert('회원정보가 수정되었습니다.');
	location.href = 'main.jsp';
</script>
<%
	} else {
%>
<script>
	alert('패스워드가 다릅니다.');
	history.back();
</script>
		<%
	}
%>



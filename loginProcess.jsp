<%@page import="com.exam.vo.MemberVO"%>
<%@page import="com.exam.dao.MemberDao"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	// post 파라미터값 한글처리
	request.setCharacterEncoding("utf-8");
	// 폼 id passwd 파라미터값 가져오기
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	// DB객체 준비
	MemberDao memberDao = MemberDao.getInstance();

	// 로그인 확인하는 메소드 호출
	// check == 1  로그인인증. main.jsp로 이동
	// check == 0  패스워드틀림. 뒤로이동
	// check == -1 아이디없음. 뒤로이동
	//int check = //MemberDao.userCheck(id, passwd);
	int check = memberDao.userCheck(id, passwd);
		
	if (check == 1) {// 로그인 성공일때
		// DB로부터 로그인사용자 레코드정보 가져오기
		MemberVO memberVO = memberDao.getMember(id);
		
		session.setAttribute("loginMember", memberVO);

		// main.jsp 로 이동
		response.sendRedirect("main.jsp");
	} else  {
%>
<script>
	alert('Either ID or password is wrong');
	history.back();
</script>
<%
	} 
%>


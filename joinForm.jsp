<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>register a new member</title>
<script>
function check() {
	// frm.id.value.length == 0
	if (/*document.*/frm.id.value == '') {
		alert('ID required');
		frm.id.focus();
		return false;
	}
	// 아이디가 3글자 이상 13글자 이하인지 검증
	if (!(frm.id.value.length >= 3 
			&& frm.id.value.length <= 13)) {
		alert('at least 3 characters and less than 13 characters|n write again');
		frm.id.select();
		return false;
	}
	
	if (frm.passwd.value == '') {
		alert('PW required');
		frm.passwd.focus();
		return false;
	}
	if (frm.name.value == '') {
		alert('name required');
		frm.name.focus();
		return false;
	}
	
	return true;
}
</script>
</head>
</head>
<body>

<h1>회원 가입</h1>

<form name="frm" action="joinProcess.jsp" method="post" onsubmit="return check();">
	<fieldset>
	<legend>required</legend>
	ID: <input type="text" name="id" <%--required--%> /><br>
	PW: <input type="password" name="passwd" /><br>
	name: <input type="text" name="name" /><br>
	</fieldset>
	
	<fieldset>
	<legend>option</legend>
	age: <input type="text" name="age" /><br>
	gender: <input type="radio" name="gender" value="male" />male
	      <input type="radio" name="gender" value="female" />female<br>
	email: <input type="email" name="email" /><br>
	</fieldset>
	<button type="submit">join</button>
</form>


</body>
</html>


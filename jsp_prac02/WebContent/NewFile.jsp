<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <!-- page 지시어. -->

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#loginFormArea {
	text-align: center;
	width: 280px;
	margin: auto;
	border: 1px solid red;
}

h1 {
	text-align: center;	
}
</style>
</head>
<body>
	<h1>로그인</h1>
	<section id="loginFormArea">
		<form action="login" method="post"> 
		<!-- method="get, post" 방식 2가지가 있는데 get은 주소창에 넘긴 주소가 표시되고, post방식은 주소에 표시가 되지 않음-->
			<!-- action 속성은 폼의 입력결과를 처리할 페이지를 지정. method는 전송 방식, post 방식도 있음 -->
			<label id="id">아이디 :</label>
			<input type="text" name="id" id="id" /><br>
			<label id="password">비밀번호 :</label>
			<input type="password" name="password" id="password" /><br><br>
			<input type="submit" value="로그인" />
		</form>
	</section>
</body>
</html>
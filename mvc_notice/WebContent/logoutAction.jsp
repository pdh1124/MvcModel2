<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="includes/header.jsp"%>

<% 
	session.invalidate(); 
	//현재 이페이지에 접속한 회원이 세션을 빼앗기도록해서 로그아웃시켜줌
%>

<script>
	location.href = 'main.jsp';
	//이 페이지에 접속한 회원은 메인페이지로 이동
</script>
	
<%@ include file="includes/footer.jsp"%>


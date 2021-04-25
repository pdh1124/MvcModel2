<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="includes/header.jsp"%>
<%@ page import="user.UserDAO"%><!-- userdao의클래스를 가져옴 -->
<%@ page import="java.io.PrintWriter"%><!-- 자바 클래스 사용 -->
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
	
<%@ include file="includes/footer.jsp"%>


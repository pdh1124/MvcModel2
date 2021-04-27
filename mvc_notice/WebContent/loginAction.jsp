<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%><!-- userdao의클래스를 가져옴 -->
<%@ page import="java.io.PrintWriter"%><!-- 자바 클래스 사용 -->
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />	
<%@ include file="includes/header.jsp"%>

<%
	String userID = null;
	if(session.getAttribute("userID") != null) { //세션을 확인해서 세션이 존재하는 회원들은 
		userID = (String) session.getAttribute("userID"); //String형태로 변환해서 세션에 userID를 담는다.
	}
	if (userID != null) { //세션값이 존재 할 경우(로그인이 된 경우)
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 로그인이 되어 있습니다.')");
		script.println("location.href = 'main.jsp'");
		script.println("</script>");
	}
	UserDAO userDAO = new UserDAO();
	int result = userDAO.login(user.getUserID(), user.getUserPassword());
	//login.jsp에서 받은 ID와 password를 받아 userDAO에 만든 login함수에 넣어서 실행해 값을 1~-2까지 int값으로 받는다.
	
	if(result == 1) { //로그인 성공
		session.setAttribute("userID", user.getUserID()); //해당 유저ID를 세션값으로 넣어줄 수 있도록 한다.
		PrintWriter script = response.getWriter(); 
		script.println("<script>");
		script.println("location.href = 'main.jsp'");
		script.println("</script>");
	} else if(result == 0) { //비밀번호가 틀릴때
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호가 틀립니다.')");
		script.println("history.back()"); //이전페이지로 돌아가라
		script.println("</script>");
	} else if(result == -1) { //아이디가 존재하지 않을때
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('존재하지 않는 아이디입니다.')");
		script.println("history.back()"); //이전페이지로 돌아가라
		script.println("</script>");
	} else if(result == -2) { //데이터베이스 오류
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('데이터베이스 오류가 발생했습니다.')");
		script.println("history.back()"); //이전페이지로 돌아가라
		script.println("</script>");
	}
%>

<%@ include file="includes/footer.jsp"%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%><!-- userdao의클래스를 가져옴 -->
<%@ page import="java.io.PrintWriter"%><!-- 자바 클래스 사용 -->
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userGender" />
<jsp:setProperty name="user" property="userEmail" />		
<%@ include file="includes/header.jsp"%>

<%
	
	//사용자가 입력 안했을 때의 모든 경우의 수를 체크해서
	if(user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null 
	|| user.getUserGender() == null || user.getUserEmail() == null) {
		PrintWriter script = response.getWriter(); 
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.')");
		script.println("history.back()");
		script.println("</script>");
	} else {
		UserDAO userDAO = new UserDAO();
		int result = userDAO.join(user);
		//login.jsp에서 받은 ID와 password를 받아 userDAO에 만든 login함수에 넣어서 실행해 값을 1~-2까지 int값으로 받는다.
		
		if(result == -1) { //데이터베이스 오류가 생기는 경우는 해당 아이디(primary key)가 중복될 수 없기 때문에
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 존재하는 아이디 입니다.')");
			script.println("history.back()"); //이전페이지로 돌아가라
			script.println("</script>");
		} else { //회원가입 성공
			session.setAttribute("userID", user.getUserID()); //해당 유저ID를 세션값으로 넣어줄 수 있도록 한다.
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'main.jsp'"); //회원가입 완료해서 메인페이지로 이동
			script.println("</script>");
		}  
	}
%>

<%@ include file="includes/footer.jsp"%>


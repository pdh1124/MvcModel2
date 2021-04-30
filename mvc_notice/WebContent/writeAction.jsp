
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO"%><!-- BbsDAO의 클래스를 가져옴 -->
<%@ page import="java.io.PrintWriter"%><!-- 자바 클래스 사용 -->
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />
<jsp:setProperty name="bbs" property="bbsTitle" />
<jsp:setProperty name="bbs" property="bbsContent" />	
<%@ include file="includes/header.jsp"%>

<%
	String userID = null;
	if(session.getAttribute("userID") != null) { //세션을 확인해서 세션이 존재하는 회원들은 
		userID = (String) session.getAttribute("userID"); //String형태로 변환해서 세션에 userID를 담는다.
	}
	if (userID == null) { //세션값이 존재 할 경우(로그인이 된 경우)
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요.')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
	} else {
		if(bbs.getBbsTitle() == null || bbs.getBbsContent() == null) { // 글 제목이나 글내용을 안쓸경우
			PrintWriter script = response.getWriter(); 
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else { // 제목과 내용이 잘 써진 경우
			//실제로 데이테베이스에 등록을 해준다.
			BbsDAO bbsDAO = new BbsDAO();
			int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());
			if(result == -1) { // -1인 경우 데이터베이스의 오류가 생길때
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글쓰기에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else if(result == -2) { // -1인 경우 데이터베이스의 오류가 생길때
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글쓰기에 실패')");
				script.println("history.back()");
				script.println("</script>");
			}   
			
			else { //정상적으로 등록 할떄
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'bbs.jsp'"); //글쓰기가 완료하고 리스트페이지로 이동
				script.println("</script>");
			}  
		}
	}
%>

<%@ include file="includes/footer.jsp"%>


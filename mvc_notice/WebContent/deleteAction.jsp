
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="bbs.BbsDAO"%><!-- BbsDAO의 클래스를 가져옴 -->
<%@ page import="java.io.PrintWriter"%><!-- 자바 클래스 사용 -->
<% request.setCharacterEncoding("UTF-8"); %>
<!-- 빈즈 삭제 -->
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
	} 
	int bbsID = 0;
	if (request.getParameter("bbsID") != null) { 
		//매개변수로 넘어온 bbsID라는 매개변수가 존재한다면		
		bbsID = Integer.parseInt(request.getParameter("bbsID"));
		//bbsID에 넘어온 페이지의 값을 int값으로 변환해서 담는다.
	}
	
	//bbs가 0이면 유효하지 않는 글이라 뜨고 다시 게시
	if (bbsID == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글입니다.')");
		script.println("location.href = 'bbs.jsp'");
		script.println("</script>");
	}
	
	//현재 작성된 글이 접속한 작성자 본인인지 확인할 필요가 있어서 세션관리가 필요함
	Bbs bbs = new BbsDAO().getBbs(bbsID);
	if (!userID.equals(bbs.getUserID())) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다.')");
		script.println("location.href = 'bbs.jsp'");
		script.println("</script>");
	} else { // 제목과 내용이 잘 써진 경우
		//실제로 데이테베이스에 등록을 해준다.
		BbsDAO bbsDAO = new BbsDAO();
		int result = bbsDAO.delete(bbsID);
		if(result == -1) { // -1인 경우 데이터베이스의 오류가 생길때
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글 삭제에 실패했습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else { //정상적으로 등록 할떄
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'bbs.jsp'");  
			script.println("</script>");
		}  
	}
%>

<%@ include file="includes/footer.jsp"%>


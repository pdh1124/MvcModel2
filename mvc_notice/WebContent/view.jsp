<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 스크립트 문장을 실행 할 수 있도록 -->
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>
<%@ include file="includes/header.jsp"%>

<%
	//로그인 정보를 담을 수 있도록 만듦
	String userID = null;
	if (session.getAttribute("userID") != null) { //현재 세션이 존재한다면 
		userID = (String) session.getAttribute("userID");//그 아이디값을 그대로 받아서 관리 할 수 있도록 만듦
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
	
	//해당글에 구체적인 내용을 가져온다.
	Bbs bbs = new BbsDAO().getBbs(bbsID);
%>
<!-- 네비게이션 구동 -->	
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed" 
			data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" 
			aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>	
			</button>
			<a class="navbar-brand" href="main.jsp">JSP 게시판 웹 사이트</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li class="active"><a href="bbs.jsp">게시판</a></li>
			</ul>
			<%
				if(userID == null) { //세션이 존재하지 않는다면(로그인이 안되어있다면)
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" 
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>				
			</ul>
			<%
				} else { //세션이 존재한다면(로그인이 되어있다면)
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" 
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>				
			</ul>
			<%			
				}
			%>
			
		</div>
	</nav>
	
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align:center; border: 1px solid #dddddd;">
				<thead>
					<tr>
						<th colspan="3" style="background-color: #eeeeee; text-align: center;">게시판 글 보기</th>					
				</thead>
				<tbody>
					<tr>
						<td style="width: 20%;">글 제목</td>
						<td colspan="2"><%= bbs.getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&rt;") %></td>
					</tr>
					<tr>
						<td>작성자</td>
						<td colspan="2"><%= bbs.getUserID() %></td>
					</tr>
					<tr>
						<td>작성일자</td>
						<td colspan="2"><%= bbs.getBbsDate() %></td>
					</tr>
					<tr>
						<td>글 내용</td>
						<td colspan="2" style="height: 200px; text-align: left;"><%= bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&rt;") %></td>
					</tr>
				</tbody>
			</table>
			<a href="bbs.jsp" class="btn btn-primary">목록</a>
			<%
				if(userID != null && userID.equals(bbs.getUserID())) {
					//userID가 존재하고 userID와 작성자가 동일 할 경우
					//수정과 삭제기능을 넣는다.
			%>
					<a href="update.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">수정</a>
					<a href="deleteAction.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">삭제</a>
			<%	
				}
			%>
		</div>
	</div>
<%@ include file="includes/footer.jsp"%>
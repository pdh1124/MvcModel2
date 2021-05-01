<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 스크립트 문장을 실행 할 수 있도록 -->
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.BbsDAO" %> <!-- BbsDAO.java 연동 -->
<%@ page import="bbs.Bbs" %> <!-- Bbs.java 연동 -->
<%@ page import="java.util.ArrayList" %> <!-- 게시판의 목록을 출력하기 위해 가져옴 -->
<%@ include file="includes/header.jsp"%>

<%
	//로그인 정보를 담을 수 있도록 만듦
	String userID = null;
	if (session.getAttribute("userID") != null) { //현재 세션이 존재한다면 
		userID = (String) session.getAttribute("userID");//그 아이디값을 그대로 받아서 관리 할 수 있도록 만듦
	}
	//현재 게시판이 몇번째 페이지인지 알기 위해서
	int pageNumber = 1; //기본페이지(1페이지)
	if (request.getParameter("pageNumber") != null) { // 파라미터로 pageNumber가 넘어 왔다면
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		//pageNumber에 넘어온 페이지의 값을 int값으로 변환해서 담는다.
	}
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
						<th style="background-color: #eeeeee; text-align: center;">번호</th>
						<th style="background-color: #eeeeee; text-align: center;">제목</th>
						<th style="background-color: #eeeeee; text-align: center;">작성자</th>
						<th style="background-color: #eeeeee; text-align: center;">작성일</th>
					</tr>
				</thead>
				<tbody>
				<%
					//게시물을 뽑아올 수 있도록 인스턴스 생성
					BbsDAO bbsDAO = new BbsDAO();
										
					//현재의 페이지에서 가져올 리스트
					ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
					
					//가져온 목록을 하나씩 출력
					for (int i = 0; i < list.size(); i++) {
				%>	
					<!-- 게시물의 정보를 하나하나 가져온다 -->
					<tr>
						<td><%= list.get(i).getBbsID() %></td>
						<td><a href="view.jsp/bbs=<%= list.get(i).getBbsID() %>"><%= list.get(i).getBbsTitle() %></a></td>
						<td><%= list.get(i).getUserID() %></td>
						<td><%= list.get(i).getBbsDate() %></td>		
					</tr>
				<%
					}
				%>		
				</tbody>
			</table>
			<%
				//다음페이지 버튼과 이전페이지 버튼을 만듦
				if (pageNumber != 1) { //2페이지 이상이라면
			%>
					<a href="bbs.jsp?pageNumber=<%=pageNumber-1%>" class="btn btn-success btn-arraw-left">이전</a>
			<%
				}
				if (bbsDAO.nextPage(pageNumber + 1)) { //다음페이지가 존재 한다면
			%>
					<a href="bbs.jsp?pageNumber=<%=pageNumber+1%>" class="btn btn-success btn-arraw-right">다음</a>
			<%
				}
			%>
			<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
		</div>
	</div>
<%@ include file="includes/footer.jsp"%>
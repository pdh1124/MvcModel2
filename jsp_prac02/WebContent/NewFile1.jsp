<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.sql.*" %>
<%
	Connection conn = null;
	try {
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		conn = ds.getConnection();
		out.print("<h3>연결 되었습니다.</h3>");
	}catch(Exception e) {
		out.print("<h3>연결 실패</h3>");
		e.printStackTrace();
	}
%>
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
		out.print("<h2>연결에 성공했습니다.</h2>");
	} catch (Exception e) {
		out.print("<h2>연결에 실패했습니다.</h2>");
		e.printStackTrace();
	}
%>
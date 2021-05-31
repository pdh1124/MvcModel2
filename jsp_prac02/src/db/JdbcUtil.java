package db;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class JdbcUtil {
	
	//디비 연결처리
	public static Connection getConnection() throws Exception {
		
		Connection conn = null;
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		
		conn = ds.getConnection();
		conn.setAutoCommit(false);
		
		return conn;
	}
	
	//데이터 베이스는 외부 자원으로 사용후, 자원 반납
	public static void close(Connection con) {
		try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	//Statement 실행 후 반납
	public static void close(Statement stmt) {
		try {
			stmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	//쿼리문 실행 완료(커밋)
	public static void commit(Connection con) {
		try {
			con.commit();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	//전달된 쿼리문의 실행 취소(롤백)
	public static void rollback(Connection con) {
		try {
			con.rollback();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}

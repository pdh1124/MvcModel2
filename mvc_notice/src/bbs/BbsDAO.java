package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class BbsDAO {
	
	private Connection conn; //Connection : 데이터베이스에 접근해주는 하나의 객체를 의미
	private ResultSet rs;//ResultSet : 어떠한 정보를 담을 수 있는 하나의 객체
	 
	public BbsDAO() {
		try {
			String driverName = "oracle.jdbc.driver.OracleDriver";
			String dbURL = "jdbc:oracle:thin:@localhost:1521:xe";
			String dbID = "admin";
			String dbPassword = "1234";
			
			Class.forName(driverName);
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace(); //오류 출력
		}
	}
	
	//게시판에 글을 작성할때 현재 시간을 가져오는 함수
	public String getDate() {
		String SQL = "SELECT SYSDATE FROM BBS";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery(); //실제결과를 가져와서
			if(rs.next()) { //결과가 있는 경우는
				return rs.getString(1); //현재 날짜를 그대로 반환
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; //데이터베이스 오류	
	}
	
	//bbsID 게시글 번호 가져오는 함수
	public int getNext() {
		String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC";
		// 내림차순을 해서 제일 마지막에 쓴 번호를 가져온다.
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery(); //실제결과를 가져와서
			if(rs.next()) { //결과가 있는 경우는
				return rs.getInt(1)+1; //현재 날짜를 그대로 반환
			}
			return 1; //아무 게시물이 없을때(첫 게시물인 경우)
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류	
	}
	
	//실제로 데이터베이스에 하나의 게시글 작성해서 등록하는 함수
	public int write(String bbsTitle, String userID, String bbsContent) {
		String SQL = "INSERT INTO BBS VALUES (?,?,?,?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, bbsContent);
			pstmt.setInt(6, 1);
			return pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
}

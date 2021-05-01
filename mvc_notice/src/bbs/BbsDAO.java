package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

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
	
	//특정 페이지일 때 보여주는 게시물의 수(가져올 페이지(보여줄 페이지))
	public ArrayList<Bbs> getList(int pageNumber) {
		String SQL = "SELECT * FROM (SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC) WHERE ROWNUM <= 10";
		//특정한 숫자 보다 작고 삭제처리가 되지 않은 게시물을 내림차순으로 10개까지 가져온다
		ArrayList<Bbs> list = new ArrayList<Bbs>(); 
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			// 예를 들어, 총게시물이 35개 현재 페이지가 2페이지 일때
			// 36-(2-1)*10 -> 36-10 -> 26
			// 2페이지에서는 bbsID가 26미만의 삭제처리가 안된 게시물 10개를 가져온다.
			// 2페이지는 25~16 까지의 게시물이 보여지게 됨
			rs = pstmt.executeQuery();
			while (rs.next()) { //결과가 나올때마다 
				Bbs bbs = new Bbs(); //bbs라는 인스턴스를 만들어서
				bbs.setBbsID(rs.getInt(1)); //id,
				bbs.setBbsTitle(rs.getString(2)); //타이틀,
				bbs.setUserID(rs.getString(3)); //유저아이디,
				bbs.setBbsDate(rs.getString(4)); //날짜,
				bbs.setBbsContent(rs.getString(5)); //내용,
				bbs.setBbsAvailable(rs.getInt(6)); //삭제여부를 bbs에 담아
				list.add(bbs); //결과를 list에 담는다.
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return list; //10개 뽑아온 게시물 리스트를 반환한다.
	}
	
	//다음페이지으로 넘어가는 기능의 유무(페이징 처리를 위해 존재하는 함수)
	//게시물이 10개인 겨우 nextPage는 없어야 하기 때문에
	//bbs.jsp에서 실행할 떄 pageNumber + 1로 if을 찾음
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();	
			if (rs.next()) { //결과가 하나라도 존재 한다면 
				return true; //다음페이지가 있고
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false; //없다면 다음페이지가 없다.
	}
}

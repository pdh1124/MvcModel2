package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.sql.DataSource;

import db.JdbcUtil;
import vo.BoardBean;

public class BoardDAO {
	
	DataSource ds;
	Connection con;
	private static BoardDAO boardDAO;
	
	//생성자
	private BoardDAO() {}
	
	//싱글톤 생성
	public static BoardDAO getInstance() {

		if(boardDAO == null) {
			boardDAO = new BoardDAO();
		}
		
		return boardDAO;
	}
	
	//Connection con 생성한것을 받아서 초기화
	public void setConnection(Connection con) {
		this.con = con;
	}
	
	//쿼리문을 글쓰기 작성
	public int insertArtcle(BoardBean article) {
		
		PreparedStatement pstmt = null;
		String sql = "insert into board values((select nvl(max(board_num),0)+1 from board), " 
				+ "?, ?, ?, ?, ?, (select nvl(max(board_num),0)+1 from board), " 
				+ "?, ?, ?, sysdate)";
		int insertCount = 0;
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, article.getBOARD_NAME());
			pstmt.setString(2, article.getBOARD_PASS());
			pstmt.setString(3, article.getBOARD_SUBJECT());
			pstmt.setString(4, article.getBOARD_CONTENT());
			pstmt.setString(5, " ");
			pstmt.setInt(6, 0);
			pstmt.setInt(7, 0);
			pstmt.setInt(8, 0);
			
			insertCount = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(pstmt);
		}
		
		return insertCount;
	}

}

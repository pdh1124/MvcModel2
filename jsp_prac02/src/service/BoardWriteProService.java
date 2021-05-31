package service;

import java.sql.Connection;

import dao.BoardDAO;
import db.JdbcUtil;
import vo.BoardBean;

public class BoardWriteProService {
	
	public boolean registArticle(BoardBean bo) throws Exception {
		
		boolean isWriteSuccess = false;
		Connection con = JdbcUtil.getConnection();
		BoardDAO bDAO = BoardDAO.getInstance();
		
		bDAO.setConnection(con);
		int insertCount = bDAO.insertArtcle(bo);
		
		if(insertCount > 0) {
			JdbcUtil.commit(con);
			isWriteSuccess = true;
		} else {
			JdbcUtil.rollback(con);
		}
		
		JdbcUtil.close(con);
		
		return isWriteSuccess;
	}
}

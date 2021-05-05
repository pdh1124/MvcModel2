package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import vo.ActionForward;
import vo.BoardBean;

public class BoardWriterProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
		ActionForward forward = null;
		BoardBean boardBean = null;
		
		boardBean = new BoardBean();
		boardBean.setBOARD_NAME("BOARD_NAME");
		boardBean.setBOARD_PASS("BOARD_PASS");
		boardBean.setBOARD_SUBJECT("BOARD_SUBJECT");
		boardBean.setBOARD_CONTENT("BOARD_CONTENT");
		
		boardWriteProService bo = new BoardWriteProService();
		boolean isWriterSiccess = bo.registArticle(boardBean);
		return null;
	}

}

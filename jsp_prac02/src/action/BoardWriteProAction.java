package action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.BoardWriteProService;
import vo.ActionForward;
import vo.BoardBean;

public class BoardWriteProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ActionForward forward = null;
		BoardBean boardBean = null;
		
		boardBean = new BoardBean();
		boardBean.setBOARD_NAME(request.getParameter("BOARD_NAME"));
		boardBean.setBOARD_PASS(request.getParameter("BOARD_PASS"));
		boardBean.setBOARD_SUBJECT(request.getParameter("BOARD_SUBJECT"));
		boardBean.setBOARD_CONTENT(request.getParameter("BOARD_CONTENT"));
		
		BoardWriteProService bo = new BoardWriteProService();
		boolean isWriteSuccess = bo.registArticle(boardBean);
		
		if(!isWriteSuccess) {
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print("<script>");
			out.print("alert('쓰기실패')");
			out.print("history.back()");
			out.print("</script>");
		} else {
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setPath("./boardList.bo");
		}
		 
		return forward;
	}

}

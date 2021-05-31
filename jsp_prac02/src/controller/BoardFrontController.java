package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.BoardWriteProAction;
import vo.ActionForward;


@WebServlet("*.bo")
public class BoardFrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public BoardFrontController() {
        super();
        
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		doProcess(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//doGet(request, response);
		doProcess(request, response);
	}

	private void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		String RequestURI = request.getRequestURI();
		String contextPath = request.getContextPath();
		String command = RequestURI.substring(contextPath.length());
		
		ActionForward forward = null;
		Action action = null;
		
		//게시물 등록
		if(command.equals("/boardWriteForm.bo")) {
			forward = new ActionForward();
			forward.setPath("/board/qna_board_write.jsp");
		}
		
		//게시물 쓰기 처리 (boardWritePro.bo)
		else if(command.equals("/boardWritePro.bo")) {
			action = new BoardWriteProAction();
			try {
				forward = action.execute(request, response);
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//
		if(forward != null) {
			if(forward.isRedirect()) {
				response.sendRedirect(forward.getPath());
			} else {
				RequestDispatcher dispatcher = request.getRequestDispatcher(forward.getPath());
				dispatcher.forward(request, response);
			}
		}		
	}
}

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="io.goorm.backend.*" %>
<%
// 3단계: DAO 패턴 사용
request.setCharacterEncoding("UTF-8");

String title = request.getParameter("title");
String content = request.getParameter("content");
String author = request.getParameter("author");

try {
    // DAO를 사용하여 게시글 등록
    Board board = new Board(title, content, author);
    BoardDAO dao = new BoardDAO();
    
    int result = dao.insertBoard(board);
    
    if (result > 0) {
        // 성공 시 목록 페이지로 리다이렉트
        response.sendRedirect("list.jsp");
    } else {
        // 실패 시 에러 메시지
        out.println("<script>alert('게시글 등록에 실패했습니다.'); history.back();</script>");
    }
    
} catch (Exception e) {
    // 오류 발생 시 에러 메시지
    out.println("<script>alert('오류 발생: " + e.getMessage() + "'); history.back();</script>");
}
%>

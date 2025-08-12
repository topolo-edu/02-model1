<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="io.goorm.backend.*" %>
<%
// 2단계: DAO 패턴 사용
String idParam = request.getParameter("id");
Long id = null;
Board board = null;

try {
    if (idParam != null && !idParam.trim().isEmpty()) {
        id = Long.parseLong(idParam);
        
        // DAO를 사용하여 게시글 조회
        BoardDAO dao = new BoardDAO();
        board = dao.getBoardById(id);
    }
} catch (Exception e) {
    out.println("<script>alert('오류 발생: " + e.getMessage() + "'); history.back();</script>");
}
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글 보기 - DAO 버전</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">
    <div class="container mx-auto px-4 py-8">
        <h1 class="text-3xl font-bold text-gray-800 mb-6">게시글 보기 (2단계: DAO)</h1>
        
        <div class="mb-4">
            <a href="list.jsp" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded mr-2">
                목록으로
            </a>
            <a href="../index.jsp" class="bg-gray-500 hover:bg-gray-700 text-white font-bold py-2 px-4 rounded">
                메인으로
            </a>
        </div>

        <div class="bg-white shadow-md rounded-lg p-6">
            <div class="space-y-4">
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">번호</label>
                    <div class="text-lg text-gray-900"><%= board != null ? board.getId() : "" %></div>
                </div>
                
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">제목</label>
                    <div class="text-lg text-gray-900"><%= board != null ? board.getTitle() : "" %></div>
                </div>
                
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">작성자</label>
                    <div class="text-lg text-gray-900"><%= board != null ? board.getAuthor() : "" %></div>
                </div>
                
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">작성일</label>
                    <div class="text-lg text-gray-900"><%= board != null ? board.getCreatedAt() : "" %></div>
                </div>
                
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">내용</label>
                    <div class="text-lg text-gray-900 whitespace-pre-wrap"><%= board != null ? board.getContent() : "" %></div>
                </div>
            </div>
        </div>
        
        <div class="mt-6 text-sm text-gray-600">
            <p>2단계: DAO 버전 - DAO 클래스를 사용하여 데이터 조회</p>
            <p>특징: JSP는 DAO 호출과 화면 출력에만 집중, 데이터 조회 로직은 DAO에서 처리</p>
        </div>
    </div>
</body>
</html>

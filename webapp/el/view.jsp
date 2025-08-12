<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="io.goorm.backend.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
// 3단계: DAO 사용 + EL + JSTL 출력
String idParam = request.getParameter("id");
Long id = null;
Board board = null;

try {
    if (idParam != null && !idParam.trim().isEmpty()) {
        id = Long.parseLong(idParam);
        
        // DAO를 사용하여 게시글 조회
        BoardDAO dao = new BoardDAO();
        board = dao.getBoardById(id);
        request.setAttribute("board", board);
    }
} catch (Exception e) {
    request.setAttribute("error", e.getMessage());
}
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글 보기 - EL + JSTL 버전</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">
    <div class="container mx-auto px-4 py-8">
        <h1 class="text-3xl font-bold text-gray-800 mb-6">게시글 보기 (3단계: EL + JSTL)</h1>
        
        <div class="mb-4">
            <a href="list.jsp" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded mr-2">
                목록으로
            </a>
            <a href="../index.jsp" class="bg-gray-500 hover:bg-gray-700 text-white font-bold py-2 px-4 rounded">
                메인으로
            </a>
        </div>

        <c:choose>
            <c:when test="${not empty error}">
                <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
                    오류 발생: ${error}
                </div>
            </c:when>
            <c:when test="${empty board}">
                <div class="bg-yellow-100 border border-yellow-400 text-yellow-700 px-4 py-3 rounded mb-4">
                    게시글을 찾을 수 없습니다.
                </div>
            </c:when>
            <c:otherwise>
                <div class="bg-white shadow-md rounded-lg p-6">
                    <div class="space-y-4">
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">번호</label>
                            <div class="text-lg text-gray-900">${board.id}</div>
                        </div>
                        
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">제목</label>
                            <div class="text-lg text-gray-900">${board.title}</div>
                        </div>
                        
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">작성자</label>
                            <div class="text-lg text-gray-900">${board.author}</div>
                        </div>
                        
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">작성일</label>
                            <div class="text-lg text-gray-900">${board.createdAt}</div>
                        </div>
                        
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">내용</label>
                            <div class="text-lg text-gray-900 whitespace-pre-wrap">${board.content}</div>
                        </div>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
        
        <div class="mt-6 text-sm text-gray-600">
            <p>3단계: EL + JSTL 버전 - DAO 사용 + EL + JSTL로 출력 단순화</p>
            <p>특징: JSP는 DAO 호출에만 집중, 출력은 EL + JSTL로 깔끔하게 처리</p>
        </div>
    </div>
</body>
</html>

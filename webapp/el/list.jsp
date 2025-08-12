<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="io.goorm.backend.*" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시판 목록 - EL + JSTL 버전</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">
    <div class="container mx-auto px-4 py-8">
        <h1 class="text-3xl font-bold text-gray-800 mb-6">게시판 목록 (3단계: EL + JSTL)</h1>
        
        <div class="mb-4">
            <a href="../index.jsp" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded mr-2">
                메인으로
            </a>
            <a href="write.jsp" class="bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded">
                글쓰기
            </a>
        </div>

        <div class="bg-white shadow-md rounded-lg overflow-hidden">
            <table class="min-w-full">
                <thead class="bg-gray-50">
                    <tr>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">번호</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">제목</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">작성자</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">작성일</th>
                    </tr>
                </thead>
                <tbody class="bg-white divide-y divide-gray-200">
                    <%
                    // 3단계: DAO 사용 + EL + JSTL 출력
                    try {
                        BoardDAO dao = new BoardDAO();
                        List<Board> boards = dao.getBoardList();
                        request.setAttribute("boards", boards);
                    } catch (Exception e) {
                        request.setAttribute("error", e.getMessage());
                    }
                    %>
                    
                    <c:choose>
                        <c:when test="${not empty error}">
                            <tr>
                                <td colspan="4" class="px-6 py-4 text-red-600">오류 발생: ${error}</td>
                            </tr>
                        </c:when>
                        <c:when test="${empty boards}">
                            <tr>
                                <td colspan="4" class="px-6 py-4 text-center text-gray-500">등록된 게시글이 없습니다.</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="board" items="${boards}">
                                <tr class="hover:bg-gray-50">
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">${board.id}</td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                        <a href="view.jsp?id=${board.id}" class="text-blue-600 hover:text-blue-900">${board.title}</a>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">${board.author}</td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">${board.createdAt}</td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
        
        <div class="mt-6 text-sm text-gray-600">
            <p>3단계: EL + JSTL 버전 - DAO 사용 + EL + JSTL로 출력 단순화</p>
            <p>특징: JSP는 DAO 호출에만 집중, 출력은 EL + JSTL로 깔끔하게 처리</p>
        </div>
    </div>
</body>
</html>

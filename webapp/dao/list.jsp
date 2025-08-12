<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="io.goorm.backend.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시판 목록 - DAO 버전</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">
    <div class="container mx-auto px-4 py-8">
        <h1 class="text-3xl font-bold text-gray-800 mb-6">게시판 목록 (2단계: DAO)</h1>
        
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
                    // 2단계: DAO 패턴 사용
                    List<Board> boards = null;
                    try {
                        BoardDAO dao = new BoardDAO();
                        boards = dao.getBoardList();
                        
                        if (boards != null && !boards.isEmpty()) {
                            for (Board board : boards) {
                    %>
                        <tr class="hover:bg-gray-50">
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900"><%= board.getId() %></td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                <a href="view.jsp?id=<%= board.getId() %>" class="text-blue-600 hover:text-blue-900"><%= board.getTitle() %></a>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900"><%= board.getAuthor() %></td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900"><%= board.getCreatedAt() %></td>
                        </tr>
                    <%
                            }
                        } else {
                    %>
                        <tr>
                            <td colspan="4" class="px-6 py-4 text-center text-gray-500">등록된 게시글이 없습니다.</td>
                        </tr>
                    <%
                        }
                    } catch (Exception e) {
                    %>
                        <tr>
                            <td colspan="4" class="px-6 py-4 text-red-600">오류 발생: <%= e.getMessage() %></td>
                        </tr>
                    <%
                    }
                    %>
                </tbody>
            </table>
        </div>
        
        <div class="mt-6 text-sm text-gray-600">
            <p>2단계: DAO 버전 - 비즈니스 로직을 DAO 클래스로 분리</p>
            <p>특징: JSP는 DAO 호출과 화면 출력에만 집중, 비즈니스 로직은 DAO에서 처리</p>
        </div>
    </div>
</body>
</html>

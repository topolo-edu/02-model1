<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시판 목록 - Scriptlet 버전</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">
    <div class="container mx-auto px-4 py-8">
        <h1 class="text-3xl font-bold text-gray-800 mb-6">게시판 목록 (1단계: Scriptlet)</h1>
        
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
                    // 2000년대 초반 스타일: JSP에 직접 JDBC 코드 작성
                    Connection conn = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;
                    
                    try {
                        // 데이터베이스 연결
                        Class.forName("org.h2.Driver");
                        conn = DriverManager.getConnection("jdbc:h2:./goorm_db", "sa", "");
                        
                        // 게시글 목록 조회
                        String sql = "SELECT * FROM board ORDER BY created_at DESC";
                        pstmt = conn.prepareStatement(sql);
                        rs = pstmt.executeQuery();
                        
                        while (rs.next()) {
                            Long id = rs.getLong("id");
                            String title = rs.getString("title");
                            String author = rs.getString("author");
                            Timestamp createdAt = rs.getTimestamp("created_at");
                    %>
                        <tr class="hover:bg-gray-50">
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900"><%= id %></td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                <a href="view.jsp?id=<%= id %>" class="text-blue-600 hover:text-blue-900"><%= title %></a>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900"><%= author %></td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900"><%= createdAt %></td>
                        </tr>
                    <%
                        }
                    } catch (Exception e) {
                        out.println("<tr><td colspan='4' class='px-6 py-4 text-red-600'>오류 발생: " + e.getMessage() + "</td></tr>");
                    } finally {
                        // 리소스 정리
                        try { if (rs != null) rs.close(); } catch (SQLException e) { }
                        try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { }
                        try { if (conn != null) conn.close(); } catch (SQLException e) { }
                    }
                    %>
                </tbody>
            </table>
        </div>
        
        <div class="mt-6 text-sm text-gray-600">
            <p>1단계: Scriptlet 버전 - JSP에 모든 로직을 직접 작성하는 2000년대 초반 스타일</p>
            <p>특징: JDBC 코드, HTML 출력, 비즈니스 로직이 모두 JSP에 섞여있음</p>
        </div>
    </div>
</body>
</html>

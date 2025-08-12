<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
// 2000년대 초반 스타일: JSP에 직접 JDBC 코드 작성
String idParam = request.getParameter("id");
Long id = null;
String title = "";
String content = "";
String author = "";
Timestamp createdAt = null;

Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

try {
    if (idParam != null && !idParam.trim().isEmpty()) {
        id = Long.parseLong(idParam);
        
        // 데이터베이스 연결
        Class.forName("org.h2.Driver");
        conn = DriverManager.getConnection("jdbc:h2:./goorm_db", "sa", "");
        
        // 게시글 조회
        String sql = "SELECT * FROM board WHERE id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setLong(1, id);
        rs = pstmt.executeQuery();
        
        if (rs.next()) {
            title = rs.getString("title");
            content = rs.getString("content");
            author = rs.getString("author");
            createdAt = rs.getTimestamp("created_at");
        }
    }
} catch (Exception e) {
    out.println("<script>alert('오류 발생: " + e.getMessage() + "'); history.back();</script>");
} finally {
    // 리소스 정리
    try { if (rs != null) rs.close(); } catch (SQLException e) { }
    try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { }
    try { if (conn != null) conn.close(); } catch (SQLException e) { }
}
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글 보기 - Scriptlet 버전</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">
    <div class="container mx-auto px-4 py-8">
        <h1 class="text-3xl font-bold text-gray-800 mb-6">게시글 보기 (1단계: Scriptlet)</h1>
        
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
                    <div class="text-lg text-gray-900"><%= id != null ? id : "" %></div>
                </div>
                
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">제목</label>
                    <div class="text-lg text-gray-900"><%= title %></div>
                </div>
                
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">작성자</label>
                    <div class="text-lg text-gray-900"><%= author %></div>
                </div>
                
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">작성일</label>
                    <div class="text-lg text-gray-900"><%= createdAt != null ? createdAt : "" %></div>
                </div>
                
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">내용</label>
                    <div class="text-lg text-gray-900 whitespace-pre-wrap"><%= content %></div>
                </div>
            </div>
        </div>
        
        <div class="mt-6 text-sm text-gray-600">
            <p>1단계: Scriptlet 버전 - JSP에 직접 JDBC 코드 작성</p>
            <p>특징: 데이터 조회, HTML 출력, 비즈니스 로직이 모두 JSP에 섞여있음</p>
        </div>
    </div>
</body>
</html>

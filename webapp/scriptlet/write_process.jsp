<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
// 2000년대 초반 스타일: JSP에 직접 JDBC 코드 작성
request.setCharacterEncoding("UTF-8");

String title = request.getParameter("title");
String content = request.getParameter("content");
String author = request.getParameter("author");

Connection conn = null;
PreparedStatement pstmt = null;

try {
    // 데이터베이스 연결
    Class.forName("org.h2.Driver");
    conn = DriverManager.getConnection("jdbc:h2:./goorm_db", "sa", "");
    
    // 게시글 등록
    String sql = "INSERT INTO board (title, content, author, created_at) VALUES (?, ?, ?, NOW())";
    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, title);
    pstmt.setString(2, content);
    pstmt.setString(3, author);
    
    int result = pstmt.executeUpdate();
    
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
} finally {
    // 리소스 정리
    try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { }
    try { if (conn != null) conn.close(); } catch (SQLException e) { }
}
%>

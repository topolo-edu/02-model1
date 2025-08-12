<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<%@ include file="../common/db_connection.jsp" %>

<%
// POST 요청이 아니면 목록으로 리다이렉트
if (!request.getMethod().equals("POST")) {
    response.sendRedirect("list.jsp");
    return;
}

request.setCharacterEncoding("UTF-8");

String title = request.getParameter("title");
String content = request.getParameter("content");
String author = request.getParameter("author");

// 입력값 검증
if (title == null || title.trim().isEmpty() || 
    content == null || content.trim().isEmpty() || 
    author == null || author.trim().isEmpty()) {
    out.println("<div style='color: red; padding: 20px; background-color: #ffe6e6; border: 1px solid #ff9999; border-radius: 3px;'>");
    out.println("<h3>입력 오류</h3>");
    out.println("<p>모든 필드를 입력해주세요.</p>");
    out.println("<a href='write.jsp' style='color: #0066cc;'>글쓰기 페이지로 돌아가기</a>");
    out.println("</div>");
    return;
}

Connection conn = null;
PreparedStatement pstmt = null;

try {
    conn = getConnection();
    
    // PreparedStatement 사용 - SQL 인젝션 방어
    // ? 바인딩으로 사용자 입력을 SQL 구조와 분리
    String sql = "INSERT INTO board (title, content, author, created_at) VALUES (?, ?, ?, NOW())";
    
    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, title);
    pstmt.setString(2, content);
    pstmt.setString(3, author);
    
    int result = pstmt.executeUpdate();
    
    if (result > 0) {
%>
        <div style="color: green; padding: 20px; background-color: #d4edda; border: 1px solid #c3e6cb; border-radius: 3px;">
            <h3>글쓰기 성공!</h3>
            <p>게시글이 성공적으로 등록되었습니다.</p>
            <p><strong>제목:</strong> <%= title %></p>
            <p><strong>내용:</strong> <%= content %></p>
            <p><strong>작성자:</strong> <%= author %></p>
            
            <div style="margin-top: 20px;">
                <a href="list.jsp" style="background-color: #4CAF50; color: white; padding: 10px 20px; text-decoration: none; border-radius: 3px;">목록으로</a>
                <a href="write.jsp" style="background-color: #0066cc; color: white; padding: 10px 20px; text-decoration: none; border-radius: 3px; margin-left: 10px;">글쓰기 계속</a>
            </div>
        </div>
        
        <div style="margin-top: 20px; padding: 15px; background-color: #d4edda; border: 1px solid #c3e6cb; border-radius: 3px;">
            <h4>✅ 보안 정보</h4>
            <p>이 페이지는 PreparedStatement를 사용하여 SQL 인젝션을 방어합니다.</p>
            <p><strong>실행된 SQL:</strong> <code><%= sql %></code></p>
            <p>사용자 입력이 ? 바인딩으로 안전하게 처리되어 악성 코드 실행이 불가능합니다.</p>
        </div>
<%
    } else {
        out.println("<div style='color: red; padding: 20px; background-color: #ffe6e6; border: 1px solid #ff9999; border-radius: 3px;'>");
        out.println("<h3>글쓰기 실패</h3>");
        out.println("<p>게시글 등록에 실패했습니다.</p>");
        out.println("<a href='write.jsp' style='color: #0066cc;'>글쓰기 페이지로 돌아가기</a>");
        out.println("</div>");
    }
    
} catch (Exception e) {
    out.println("<div style='color: red; padding: 20px; background-color: #ffe6e6; border: 1px solid #ff9999; border-radius: 3px;'>");
    out.println("<h3>오류 발생</h3>");
    out.println("<p>데이터베이스 연결 또는 쿼리 실행 중 오류가 발생했습니다.</p>");
    out.println("<p>오류 내용: " + e.getMessage() + "</p>");
    out.println("<a href='write.jsp' style='color: #0066cc;'>글쓰기 페이지로 돌아가기</a>");
    out.println("</div>");
    e.printStackTrace();
} finally {
    closeResources(conn, pstmt, null);
}
%>

<%@ include file="../common/footer.jsp" %>

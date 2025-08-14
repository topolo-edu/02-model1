<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<%@ include file="../common/db_connection.jsp" %>

<%
String id = request.getParameter("id");

if (id == null || id.trim().isEmpty()) {
    out.println("<div style='color: red; padding: 20px; background-color: #ffe6e6; border: 1px solid #ff9999; border-radius: 3px;'>");
    out.println("<h3>오류</h3>");
    out.println("<p>게시글 ID가 지정되지 않았습니다.</p>");
    out.println("<a href='list.jsp' style='color: #0066cc;'>목록으로 돌아가기</a>");
    out.println("</div>");
    return;
}

Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

try {
    conn = getConnection();
    
    // PreparedStatement 사용 - SQL 인젝션 방어
    // ? 바인딩으로 사용자 입력을 SQL 구조와 분리
    String sql = "SELECT * FROM board WHERE id = ?";
    
    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, id);
    rs = pstmt.executeQuery();
    
    if (rs.next()) {
        String title = rs.getString("title");
        String content = rs.getString("content");
        String author = rs.getString("author");
        Timestamp createdAt = rs.getTimestamp("created_at");
%>
        <h2>게시글 상세보기 (PreparedStatement 버전 - SQL 인젝션 방어)</h2>
        
        <div style="background-color: #d4edda; border: 1px solid #c3e6cb; padding: 15px; margin-bottom: 20px; border-radius: 3px;">
            <strong>✅ 보안 정보:</strong> 이 페이지는 PreparedStatement를 사용하여 SQL 인젝션을 방어합니다.
            <br>사용자 입력이 SQL 구조와 분리되어 악성 코드 실행이 불가능합니다.
        </div>
        
        <div style="border: 1px solid #ddd; padding: 20px; border-radius: 3px; margin-bottom: 20px;">
            <div style="margin-bottom: 15px;">
                <strong>번호:</strong> <%= id %>
            </div>
            <div style="margin-bottom: 15px;">
                <strong>제목:</strong> <%= title %>
            </div>
            <div style="margin-bottom: 15px;">
                <strong>내용:</strong>
                <div style="border: 1px solid #eee; padding: 15px; background-color: #f9f9f9; border-radius: 3px; margin-top: 5px;">
                    <%= content %>
                </div>
            </div>
            <div style="margin-bottom: 15px;">
                <strong>작성자:</strong> <%= author %>
            </div>
            <div style="margin-bottom: 15px;">
                <strong>작성일:</strong> <%= createdAt %>
            </div>
        </div>
        
        <div style="text-align: center;">
            <a href="list.jsp" style="background-color: #666; color: white; padding: 10px 20px; text-decoration: none; border-radius: 3px;">목록으로</a>
            <a href="write.jsp" style="background-color: #4CAF50; color: white; padding: 10px 20px; text-decoration: none; border-radius: 3px; margin-left: 10px;">글쓰기</a>
        </div>
        
        <div style="margin-top: 30px; padding: 15px; background-color: #d4edda; border: 1px solid #c3e6cb; border-radius: 3px;">
            <h4>✅ 보안 정보</h4>
            <p>이 페이지는 PreparedStatement를 사용하여 SQL 인젝션을 방어합니다.</p>
            <p><strong>실행된 SQL:</strong> <code><%= sql %></code></p>
            <p>사용자 입력이 ? 바인딩으로 안전하게 처리되어 악성 코드 실행이 불가능합니다.</p>
            
            <h5>보안 테스트:</h5>
            <p>다음과 같은 악성 입력을 시도해보세요:</p>
            <ul>
                <li><code>?id=1; DROP TABLE board; --</code> (안전하게 처리됨)</li>
                <li><code>?id=1 UNION SELECT 1,2,3,4 FROM information_schema.tables --</code> (안전하게 처리됨)</li>
                <li><code>?id=1 OR 1=1 --</code> (안전하게 처리됨)</li>
            </ul>
            <p>PreparedStatement는 이러한 입력을 데이터로만 처리하여 SQL 구조를 변경할 수 없습니다.</p>
        </div>
<%
    } else {
        out.println("<div style='color: red; padding: 20px; background-color: #ffe6e6; border: 1px solid #ff9999; border-radius: 3px;'>");
        out.println("<h3>게시글을 찾을 수 없습니다</h3>");
        out.println("<p>ID: " + id + "인 게시글이 존재하지 않습니다.</p>");
        out.println("<a href='list.jsp' style='color: #0066cc;'>목록으로 돌아가기</a>");
        out.println("</div>");
    }
    
} catch (Exception e) {
    out.println("<div style='color: red; padding: 20px; background-color: #ffe6e6; border: 1px solid #ff9999; border-radius: 3px;'>");
    out.println("<h3>오류 발생</h3>");
    out.println("<p>데이터베이스 연결 또는 쿼리 실행 중 오류가 발생했습니다.</p>");
    out.println("<p>오류 내용: " + e.getMessage() + "</p>");
    out.println("<a href='list.jsp' style='color: #0066cc;'>목록으로 돌아가기</a>");
    out.println("</div>");
    e.printStackTrace();
} finally {
    closeResources(conn, pstmt, rs);
}
%>

<%@ include file="../common/footer.jsp" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<%@ include file="../common/db_connection.jsp" %>

<%
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;

try {
    conn = getConnection();
    
    // Statement 사용 - SQL 인젝션 취약
    String sql = "SELECT id, title, author, created_at FROM board ORDER BY created_at DESC";
    stmt = conn.createStatement();
    rs = stmt.executeQuery(sql);
%>

<h2>게시판 목록 (Statement 버전 - SQL 인젝션 취약)</h2>

<div style="margin-bottom: 20px;">
    <a href="write.jsp" style="background-color: #4CAF50; color: white; padding: 10px 20px; text-decoration: none; border-radius: 3px;">글쓰기</a>
</div>

<table style="width: 100%; border-collapse: collapse; border: 1px solid #ddd;">
    <thead>
        <tr style="background-color: #f2f2f2;">
            <th style="border: 1px solid #ddd; padding: 12px; text-align: left;">번호</th>
            <th style="border: 1px solid #ddd; padding: 12px; text-align: left;">제목</th>
            <th style="border: 1px solid #ddd; padding: 12px; text-align: left;">작성자</th>
            <th style="border: 1px solid #ddd; padding: 12px; text-align: left;">작성일</th>
        </tr>
    </thead>
    <tbody>
        <%
        while (rs.next()) {
            int id = rs.getInt("id");
            String title = rs.getString("title");
            String author = rs.getString("author");
            Timestamp createdAt = rs.getTimestamp("created_at");
        %>
        <tr>
            <td style="border: 1px solid #ddd; padding: 12px;"><%= id %></td>
            <td style="border: 1px solid #ddd; padding: 12px;">
                <a href="view.jsp?id=<%= id %>" style="color: #0066cc; text-decoration: none;"><%= title %></a>
            </td>
            <td style="border: 1px solid #ddd; padding: 12px;"><%= author %></td>
            <td style="border: 1px solid #ddd; padding: 12px;"><%= createdAt %></td>
        </tr>
        <%
        }
        %>
    </tbody>
</table>

<%
} catch (Exception e) {
    out.println("<div style='color: red; padding: 20px; background-color: #ffe6e6; border: 1px solid #ff9999; border-radius: 3px;'>");
    out.println("<h3>오류 발생</h3>");
    out.println("<p>데이터베이스 연결 또는 쿼리 실행 중 오류가 발생했습니다.</p>");
    out.println("<p>오류 내용: " + e.getMessage() + "</p>");
    out.println("</div>");
    e.printStackTrace();
} finally {
    closeResources(conn, stmt, rs);
}
%>

<%@ include file="../common/footer.jsp" %>

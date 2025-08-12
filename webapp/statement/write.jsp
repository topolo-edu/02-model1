<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<h2>글쓰기 (Statement 버전 - SQL 인젝션 취약)</h2>

<div style="background-color: #fff3cd; border: 1px solid #ffeaa7; padding: 15px; margin-bottom: 20px; border-radius: 3px;">
    <strong>⚠️ 보안 경고:</strong> 이 페이지는 Statement를 사용하여 SQL 인젝션에 취약합니다.
    <br>테스트를 위해 악성 입력을 시도해보세요:
    <br><code>제목: '; DROP TABLE board; --</code>
</div>

<form action="write_process.jsp" method="post" style="max-width: 600px;">
    <div style="margin-bottom: 15px;">
        <label for="title" style="display: block; margin-bottom: 5px; font-weight: bold;">제목:</label>
        <input type="text" id="title" name="title" required 
               style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 3px; box-sizing: border-box;">
    </div>
    
    <div style="margin-bottom: 15px;">
        <label for="content" style="display: block; margin-bottom: 5px; font-weight: bold;">내용:</label>
        <textarea id="content" name="content" rows="10" required 
                  style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 3px; box-sizing: border-box; resize: vertical;"></textarea>
    </div>
    
    <div style="margin-bottom: 15px;">
        <label for="author" style="display: block; margin-bottom: 5px; font-weight: bold;">작성자:</label>
        <input type="text" id="author" name="author" required 
               style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 3px; box-sizing: border-box;">
    </div>
    
    <div style="text-align: center;">
        <button type="submit" style="background-color: #4CAF50; color: white; padding: 12px 30px; border: none; border-radius: 3px; cursor: pointer; font-size: 16px;">글쓰기</button>
        <a href="list.jsp" style="background-color: #666; color: white; padding: 12px 30px; text-decoration: none; border-radius: 3px; margin-left: 10px; display: inline-block;">목록으로</a>
    </div>
</form>

<div style="margin-top: 30px; padding: 15px; background-color: #f8f9fa; border-radius: 3px;">
    <h3>SQL 인젝션 테스트 예시</h3>
    <p><strong>제목:</strong> <code>'; DROP TABLE board; --</code></p>
    <p><strong>내용:</strong> <code>아무 내용</code></p>
    <p><strong>작성자:</strong> <code>해커</code></p>
    <p>이 입력을 제출하면 Statement 버전에서는 테이블이 삭제될 수 있습니다!</p>
</div>

<%@ include file="../common/footer.jsp" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%!
// 데이터베이스 연결 정보
private static final String DRIVER = "org.h2.Driver";
private static final String URL = "jdbc:h2:file:h2/data/goorm_db;AUTO_SERVER=TRUE";
private static final String USER = "sa";
private static final String PASSWORD = "";

// 데이터베이스 연결 메서드
public Connection getConnection() throws Exception {
    Class.forName(DRIVER);
    return DriverManager.getConnection(URL, USER, PASSWORD);
}

// 리소스 정리 메서드
public void closeResources(Connection conn, Statement stmt, ResultSet rs) {
    try {
        if (rs != null) rs.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }
    try {
        if (stmt != null) stmt.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }
    try {
        if (conn != null) conn.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}

// HTML 이스케이핑 메서드 (XSS 방어용)
public String htmlEscape(String input) {
    if (input == null) return "";
    return input.replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#39;");
}
%>

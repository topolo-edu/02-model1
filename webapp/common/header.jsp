<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Java Web History - Model 1</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .header {
            background-color: #333;
            color: white;
            padding: 15px;
            text-align: center;
            margin-bottom: 20px;
        }
        .nav {
            background-color: #444;
            padding: 10px;
            margin-bottom: 20px;
        }
        .nav a {
            color: white;
            text-decoration: none;
            margin: 0 15px;
            padding: 5px 10px;
        }
        .nav a:hover {
            background-color: #666;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .version-info {
            background-color: #e7f3ff;
            border: 1px solid #b3d9ff;
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 3px;
        }
        .current-time {
            color: #666;
            font-size: 12px;
            text-align: right;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>Java Web History - Model 1 아키텍처</h1>
        <p>Statement vs PreparedStatement 보안 비교 예제</p>
    </div>
    
    <div class="nav">
        <a href="<%= request.getContextPath() %>/statement/list.jsp">Statement 버전</a>
        <a href="<%= request.getContextPath() %>/prepared/list.jsp">PreparedStatement 버전</a>
        <a href="<%= request.getContextPath() %>/index.jsp">홈</a>
    </div>
    
    <div class="container">
        <div class="version-info">
            <strong>현재 접속 경로:</strong> 
            <span style="color: #0066cc;">
                <%= request.getRequestURI().contains("/statement/") ? "Statement 버전 (SQL 인젝션 취약)" : 
                    request.getRequestURI().contains("/prepared/") ? "PreparedStatement 버전 (SQL 인젝션 방어)" : "홈" %>
            </span>
        </div>
        
        <div class="current-time">
            현재 시간: <%= new java.util.Date() %>
        </div>

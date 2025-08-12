package io.goorm.backend;

import java.sql.*;
import java.util.*;

/**
 * Board Data Access Object
 * 2000년대 초반 J2EE 패턴 스타일
 */
public class BoardDAO {
  private static final String DRIVER = "org.h2.Driver";
  private static final String URL = "jdbc:h2:./goorm_db";
  private static final String USER = "sa";
  private static final String PASSWORD = "";

  /**
   * 게시글 목록 조회
   */
  public List<Board> getBoardList() throws Exception {
    List<Board> boards = new ArrayList<>();
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
      conn = getConnection();
      String sql = "SELECT * FROM board ORDER BY created_at DESC";
      pstmt = conn.prepareStatement(sql);
      rs = pstmt.executeQuery();

      while (rs.next()) {
        Board board = new Board();
        board.setId(rs.getLong("id"));
        board.setTitle(rs.getString("title"));
        board.setContent(rs.getString("content"));
        board.setAuthor(rs.getString("author"));
        board.setCreatedAt(rs.getTimestamp("created_at"));
        boards.add(board);
      }
    } finally {
      closeResources(conn, pstmt, rs);
    }
    return boards;
  }

  /**
   * 게시글 작성
   */
  public int insertBoard(Board board) throws Exception {
    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
      conn = getConnection();
      String sql = "INSERT INTO board (title, content, author, created_at) VALUES (?, ?, ?, NOW())";
      pstmt = conn.prepareStatement(sql);
      pstmt.setString(1, board.getTitle());
      pstmt.setString(2, board.getContent());
      pstmt.setString(3, board.getAuthor());

      return pstmt.executeUpdate();
    } finally {
      closeResources(conn, pstmt, null);
    }
  }

  /**
   * 게시글 상세 조회
   */
  public Board getBoardById(Long id) throws Exception {
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
      conn = getConnection();
      String sql = "SELECT * FROM board WHERE id = ?";
      pstmt = conn.prepareStatement(sql);
      pstmt.setLong(1, id);
      rs = pstmt.executeQuery();

      if (rs.next()) {
        Board board = new Board();
        board.setId(rs.getLong("id"));
        board.setTitle(rs.getString("title"));
        board.setContent(rs.getString("content"));
        board.setAuthor(rs.getString("author"));
        board.setCreatedAt(rs.getTimestamp("created_at"));
        return board;
      }
      return null;
    } finally {
      closeResources(conn, pstmt, rs);
    }
  }

  /**
   * 데이터베이스 연결
   */
  private Connection getConnection() throws Exception {
    try {
      // H2 드라이버 클래스 로드
      Class.forName(DRIVER);
    } catch (ClassNotFoundException e) {
      throw new Exception("H2 데이터베이스 드라이버를 찾을 수 없습니다: " + e.getMessage(), e);
    }

    try {
      return DriverManager.getConnection(URL, USER, PASSWORD);
    } catch (SQLException e) {
      throw new Exception("데이터베이스 연결에 실패했습니다: " + e.getMessage(), e);
    }
  }

  /**
   * 리소스 정리
   */
  private void closeResources(Connection conn, Statement stmt, ResultSet rs) {
    try {
      if (rs != null)
        rs.close();
    } catch (SQLException e) {
      e.printStackTrace();
    }
    try {
      if (stmt != null)
        stmt.close();
    } catch (SQLException e) {
      e.printStackTrace();
    }
    try {
      if (conn != null)
        conn.close();
    } catch (SQLException e) {
      e.printStackTrace();
    }
  }
}

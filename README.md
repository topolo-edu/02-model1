# Java Web History - Model 1

## 🎯 프로젝트 목적

2000년대 초반 Java 웹 개발의 진화 과정을 보여주는 **Model 1 아키텍처** 예제입니다. JSP 개발 방식이 어떻게 발전했는지 **세 단계**로 비교할 수 있습니다.

## 📁 프로젝트 구조

```
02-model1/
├── src/
│   └── io/goorm/backend/
│       ├── Board.java          # Board VO 클래스
│       └── BoardDAO.java       # Board DAO 클래스
├── webapp/
│   ├── scriptlet/              # 1단계: Scriptlet prepareStatement버전
│   │   ├── list.jsp
│   │   ├── write.jsp
│   │   ├── write_process.jsp
│   │   └── view.jsp
│   ├── statement/              # 1단계: Scriptlet statement 버전
│   │   ├── list.jsp
│   │   ├── write.jsp
│   │   ├── write_process.jsp
│   │   └── view.jsp
│   ├── dao/                    # 2단계: DAO 패턴 버전
│   │   ├── list.jsp
│   │   ├── write.jsp
│   │   ├── write_process.jsp
│   │   └── view.jsp
│   ├── el/                     # 3단계: EL + JSTL 버전
│   │   ├── list.jsp
│   │   ├── write.jsp
│   │   ├── write_process.jsp
│   │   └── view.jsp
│   ├── index.jsp               # 메인 페이지
│   └── WEB-INF/
│       ├── web.xml
│       └── lib/                # 필요한 라이브러리
└── build.md                    # 빌드 가이드
```



#### H2 JDBC 드라이버 복사

- `h2-2.1.214.jar` 파일을 `WEB-INF/lib/` 폴더에 복사

**참고**: H2 JDBC 드라이버는 [H2 Database 공식 사이트](http://www.h2database.com/)에서 다운로드 가능합니다.


## 🚀 세 단계 비교

### 1단계: Scriptlet (스크립틀릿)

  1-1. prepareStatement

- **특징**: JSP에 직접 JDBC 코드 작성
- **용도**: 2000년대 초반의 전형적인 개발 방식 이해
- **접근**: `http://localhost:8080/scriptlet/list.jsp`
- **코드 예시**:
  ```jsp
  <%
  // JSP에 직접 JDBC 코드 작성
  pstmt = conn.prepareStatement(sql);
  rs = pstmt.executeQuery();
  %>
  ```

    1-2. statement

- **특징**: JSP에 직접 JDBC 코드 작성
- **용도**: 2000년대 초반의 전형적인 개발 방식 이해
- **접근**: `http://localhost:8080/statement/list.jsp`
- **코드 예시**:
  ```jsp
  <%
  // JSP에 직접 JDBC 코드 작성
    String sql = "SELECT id, title, author, created_at FROM board ORDER BY created_at DESC";
    stmt = conn.createStatement();
    rs = stmt.executeQuery(sql);
  %>
  ```

```html
제목: '; DROP TABLE board; --
내용: 아무 내용
작성자: 해커
  ```

```html
  제목: <script>alert('XSS!')</script>
내용: <img src="x" onerror="alert('XSS!')">
작성자: <script>alert('XSS!')</script>
  ```

### 2단계: DAO 패턴

- **특징**: 비즈니스 로직을 DAO 클래스로 분리
- **용도**: 코드 구조화와 재사용성 향상
- **접근**: `http://localhost:8080/dao/list.jsp`
- **코드 예시**:
  ```jsp
  <%
  // DAO 클래스 사용
  BoardDAO dao = new BoardDAO();
  List<Board> boards = dao.getBoardList();
  for (Board board : boards) {
      out.println("<tr>");
      out.println("<td>" + board.getTitle() + "</td>");
      out.println("</tr>");
  }
  %>
  ```


#### Servlet API 라이브러리 클래스패스 설정

##### 방법 1: 환경변수로 클래스패스 설정 (권장)

터미널에서 한 번만 설정하면 반복 컴파일 시 편리합니다:

```bash
# Windows (톰캣 경로는 실제 설치 경로로 수정)
set CLASSPATH=C:\apache-tomcat-9.0.xx\lib\servlet-api.jar;C:\apache-tomcat-9.0.xx\lib\jsp-api.jar;

# Mac/Linux (톰캣 경로는 실제 설치 경로로 수정)
export CLASSPATH=/path/to/apache-tomcat-9.0.xx/lib/servlet-api.jar:/path/to/apache-tomcat-9.0.xx/lib/jsp-api.jar:
```

설정 후 간단하게 컴파일:

```cmd

javac -d "webapp/WEB-INF/classes" "src/io/goorm/backend/Board.java"
javac -d "webapp/WEB-INF/classes" "src/io/goorm/backend/BoardDAO.java"

```  

### 3단계: EL + JSTL

- **특징**: DAO 사용 + EL + JSTL로 출력 단순화
- **용도**: JSP에서 Java 코드 최소화
- **접근**: `http://localhost:8080/el/list.jsp`
- **코드 예시**:
  ```jsp
  <%
  // DAO 호출만 수행
  BoardDAO dao = new BoardDAO();
  List<Board> boards = dao.getBoardList();
  request.setAttribute("boards", boards);
  %>
  <!-- EL + JSTL로 출력 -->
  <c:forEach var="board" items="${boards}">
      <tr><td>${board.title}</td></tr>
  </c:forEach>
  ```

## 🛠️ 기술 스택

- **Java**: JDK 8-11
- **JSP**: JSP 2.0+
- **JSTL**: JSTL 1.2 (3단계용)
- **데이터베이스**: H2 Database
- **웹 서버**: Apache Tomcat 8.5+
- **UI**: Tailwind CSS

## 🔒 보안 특징

### SQL 인젝션 방어

- **모든 단계**: PreparedStatement 사용으로 SQL 인젝션 방어
- **1단계**: JSP에 직접 PreparedStatement 구현
- **2-3단계**: DAO 클래스에서 PreparedStatement 구현

### XSS 취약점

- **의도적 구현**: 비교 목적으로 XSS 취약점 유지
- **모든 단계**: 사용자 입력을 HTML에 직접 출력

## 📚 학습 포인트

### 아키텍처 진화

1. **Scriptlet**: 모든 로직을 JSP에 직접 작성
2. **DAO**: 비즈니스 로직을 DAO 클래스로 분리
3. **EL + JSTL**: 출력 로직을 EL + JSTL로 단순화

### 코드 품질 향상

- **재사용성**: DAO 클래스로 비즈니스 로직 재사용
- **유지보수성**: 로직 수정 시 DAO 클래스만 수정
- **가독성**: EL + JSTL로 JSP 코드 단순화

### 2000년대 초반 개발 방식

- **Model 1**: JSP 중심의 단순한 아키텍처
- **JDBC 직접 사용**: 프레임워크 없이 데이터베이스 접근
- **JSP 선언부**: `<%! %>`를 사용한 메서드 정의

## 🚀 실행 방법

### 1. 환경 준비

- Java 8-11 설치
- Apache Tomcat 8.5+ 설치
- H2 Database 실행

### 2. 빌드 및 배포

```bash
# Java 컴파일
cd src
javac -cp ".;../WEB-INF/lib/*" io/goorm/backend/*.java

# WAR 파일 생성
cd ../webapp
jar -cvf ../../02-model1.war .

# Tomcat 배포
cp ../../02-model1.war $TOMCAT_HOME/webapps/
```

### 3. 접속 테스트

- **메인 페이지**: `http://localhost:8080/`
- **1-1단계 Scriptlet**: `http://localhost:8080/scriptlet/list.jsp`
- **1-2단계 Scriptlet**: `http://localhost:8080/statement/list.jsp`
- **2단계 DAO**: `http://localhost:8080/02-model1/dao/list.jsp`
- **3단계 EL + JSTL**: `http://localhost:8080/02-model1/el/list.jsp`

## ⚠️ 주의사항

1. **교육 목적**: 이 프로젝트는 교육 목적으로만 사용하세요
2. **보안 취약**: 실제 프로덕션 환경에서는 절대 사용하지 마세요
3. **데이터베이스**: H2 데이터베이스와 `board` 테이블이 미리 준비되어 있어야 합니다
4. **라이브러리**: JSTL 라이브러리가 없으면 3단계 EL + JSTL 버전이 작동하지 않습니다

## 🔍 상세 가이드

- **빌드 가이드**: [build.md](build.md)
- **프로젝트 구조**: 위의 폴더 구조 참조
- **코드 예시**: 각 단계별 JSP 파일 참조

## 📖 참고 자료

- **JSP 2.0**: [Oracle JSP Tutorial](https://docs.oracle.com/javaee/5/tutorial/doc/bnagx.html)
- **JSTL**: [JSTL Documentation](https://jakarta.ee/specifications/tags/1.2/)
- **Model 1**: [Java Web Architecture](https://en.wikipedia.org/wiki/Model_1)
- **H2 Database**: [H2 Database](http://www.h2database.com/)


```
set CLASSPATH=%CLASSPATH%;.\webapp\WEB-INF\classes
```
# 02-model1 빌드 가이드

## 📁 프로젝트 구조

```
02-model1/
├── src/
│   └── io/goorm/backend/
│       ├── Board.java          # Board VO 클래스
│       └── BoardDAO.java       # Board DAO 클래스
├── webapp/
│   ├── scriptlet/              # 1단계: Scriptlet 버전
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
└── build.md
```

## 🎯 세 단계 구조

### 1단계: Scriptlet

- **특징**: JSP에 직접 JDBC 코드 작성
- **용도**: 2000년대 초반의 전형적인 개발 방식 이해
- **접근**: `http://localhost:8080/scriptlet/list.jsp`

### 2단계: DAO 패턴

- **특징**: 비즈니스 로직을 DAO 클래스로 분리
- **용도**: 코드 구조화와 재사용성 향상
- **접근**: `http://localhost:8080/dao/list.jsp`

### 3단계: EL + JSTL

- **특징**: DAO 사용 + EL + JSTL로 출력 단순화
- **용도**: JSP에서 Java 코드 최소화
- **접근**: `http://localhost:8080/el/list.jsp`

## 🛠️ 빌드 및 배포

### 1. Java 컴파일

```bash
# src 디렉토리로 이동
cd src

# Java 파일 컴파일 (클래스패스에 servlet-api.jar 필요)
javac -cp ".;../WEB-INF/lib/*" io/goorm/backend/*.java

# 컴파일된 .class 파일을 WEB-INF/classes로 복사
mkdir -p ../webapp/WEB-INF/classes
cp -r io ../webapp/WEB-INF/classes/
```

### 2. 필요한 라이브러리

`WEB-INF/lib/` 폴더에 다음 JAR 파일들을 복사:

- **H2 Database**: `h2-2.1.214.jar`
- **JSTL**: `jstl-1.2.jar` (3단계 EL + JSTL 버전용)
- **Standard Taglib**: `standard-1.1.2.jar` (3단계 EL + JSTL 버전용)

### 3. WAR 파일 생성

```bash
# webapp 디렉토리로 이동
cd webapp

# WAR 파일 생성
jar -cvf ../../02-model1.war .
```

### 4. Tomcat 배포

```bash
# WAR 파일을 Tomcat webapps에 복사
cp ../../02-model1.war $TOMCAT_HOME/webapps/

# 또는 ROOT에 직접 배포하려면
cp ../../02-model1.war $TOMCAT_HOME/webapps/ROOT.war
```

## 🌐 접근 URL

### ROOT 배포 시

- **메인 페이지**: `http://localhost:8080/`
- **1단계 Scriptlet**: `http://localhost:8080/scriptlet/list.jsp`
- **2단계 DAO**: `http://localhost:8080/dao/list.jsp`
- **3단계 EL + JSTL**: `http://localhost:8080/el/list.jsp`

### 일반 배포 시

- **메인 페이지**: `http://localhost:8080/02-model1/`
- **1단계 Scriptlet**: `http://localhost:8080/02-model1/scriptlet/list.jsp`
- **2단계 DAO**: `http://localhost:8080/02-model1/dao/list.jsp`
- **3단계 EL + JSTL**: `http://localhost:8080/02-model1/el/list.jsp`

## 📋 주요 특징

### 기술 스택

- **Java**: JDK 8-11
- **JSP**: JSP 2.0+
- **JSTL**: JSTL 1.2
- **데이터베이스**: H2 Database
- **웹 서버**: Apache Tomcat 8.5+

### 아키텍처

- **Model 1**: JSP 중심의 단순한 아키텍처
- **DAO 패턴**: 데이터 액세스 로직 분리
- **VO 패턴**: 데이터 전달 객체 사용

### 보안

- **PreparedStatement**: SQL 인젝션 방어
- **XSS**: 의도적으로 취약하게 구현 (비교 목적)

## ⚠️ 주의사항

1. **교육 목적**: 이 프로젝트는 교육 목적으로만 사용하세요
2. **보안 취약**: 실제 프로덕션 환경에서는 절대 사용하지 마세요
3. **데이터베이스**: H2 데이터베이스와 `board` 테이블이 미리 준비되어 있어야 합니다
4. **라이브러리**: JSTL 라이브러리가 없으면 3단계 EL + JSTL 버전이 작동하지 않습니다

## 🔍 문제 해결

### JSTL 오류 발생 시

- `WEB-INF/lib/`에 JSTL 관련 JAR 파일이 있는지 확인
- `web.xml`의 JSTL 설정이 올바른지 확인

### 컴파일 오류 발생 시

- `servlet-api.jar`가 클래스패스에 포함되어 있는지 확인
- Java 버전이 JDK 8-11인지 확인

### 데이터베이스 연결 오류 시

- H2 데이터베이스가 실행 중인지 확인
- 데이터베이스 파일 경로가 올바른지 확인

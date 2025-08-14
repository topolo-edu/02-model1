## JSTL JAR 2개에 대한 상세 설명

### 1. jakarta.servlet.jsp.jstl-api-3.0.2.jar (API)

**역할**: JSTL의 인터페이스와 추상 클래스 정의
```java
// 예시: API jar 안에 있는 내용들
public interface Tag {
    int doStartTag() throws JspException;
    int doEndTag() throws JspException;
}

public abstract class TagSupport implements Tag {
    // 기본 구현
}
```

**특징**:
- **컴파일 타임**에 필요
- JSTL 태그들의 **계약(Contract)** 정의
- **인터페이스, 추상클래스, 상수** 등 포함
- 실제 동작 로직은 없음

### 2. jstl-1.2.jar (Implementation)

**역할**: JSTL API의 실제 구현체
```java
// 예시: Implementation jar 안에 있는 내용들
public class ForEachTag extends TagSupport {
    public int doStartTag() throws JspException {
        // 실제 forEach 로직 구현
        Collection items = evaluateItems();
        for (Object item : items) {
            // 반복 처리 로직
        }
    }
}
```

**특징**:
- **런타임**에 필요
- JSTL 태그들의 **실제 동작** 구현
- `<c:forEach>`, `<c:if>`, `<c:out>` 등의 실제 처리 로직

## 왜 분리되어 있나?

### Java의 API-Implementation 패턴
```
[인터페이스] ← [구현체]
   API jar  ←  Impl jar
```

**장점**:
1. **버전 호환성**: API는 안정적, 구현체만 업데이트 가능
2. **확장성**: 다른 벤더가 다른 구현체 제공 가능
3. **의존성 관리**: 컴파일용/런타임용 분리

## 실제 동작 과정

```jsp
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:forEach var="item" items="${list}">
    ${item}
</c:forEach>
```

### 1단계 (컴파일 시)
- **API jar** 사용
- `<c:forEach>` 태그가 유효한지 확인
- 문법 검사

### 2단계 (실행 시)
- **Implementation jar** 사용
- `ForEachTag` 클래스가 실제 반복 로직 실행
- `${list}`에서 데이터 가져와서 반복 처리

## 둘 중 하나만 있으면?

### API만 있는 경우
```
컴파일: ✅ 성공
실행: ❌ ClassNotFoundException (구현체 없음)
```

### Implementation만 있는 경우
```
컴파일: ❌ 실패 (인터페이스 없음)
실행: 불가능
```

## 버전 관계

```
jakarta.servlet.jsp.jstl-api-3.0.2.jar  ← Jakarta EE 9+ (최신)
jstl-1.2.jar                            ← 구현체 (안정 버전)
```

**주의**: API는 Jakarta 버전, Implementation은 javax 버전이지만 **호환됩니다**.

## 결론

**API + Implementation = 완전한 JSTL**
- API: "무엇을 할지" 정의
- Implementation: "어떻게 할지" 구현
- 둘 다 있어야 JSTL이 정상 동작!


---

## Maven Central 다운로드 방법 (상세 설명)

### 1. Maven Central 접속

**웹사이트**: https://search.maven.org/

### 2. 첫 번째 JAR - JSTL API 다운로드

#### 단계 1: 검색
- 검색창에 `jakarta.servlet.jsp.jstl-api` 입력
- 검색 버튼 클릭

#### 단계 2: 선택
- **Group ID**: `jakarta.servlet.jsp.jstl`
- **Artifact ID**: `jakarta.servlet.jsp.jstl-api`
- 클릭하여 상세 페이지 이동

#### 단계 3: 버전 선택
- **3.0.2** 버전 클릭 (안정 버전)

#### 단계 4: 다운로드
- **Downloads** 섹션에서
- **jar** 링크 클릭
- `jakarta.servlet.jsp.jstl-api-3.0.2.jar` 다운로드

### 3. 두 번째 JAR - JSTL Implementation 다운로드

#### 단계 1: 새로 검색
- 다시 검색창에 `jstl` 입력
- 검색 버튼 클릭

#### 단계 2: 정확한 라이브러리 선택
- **Group ID**: `javax.servlet`
- **Artifact ID**: `jstl`
- **⚠️ 주의**: 다른 jstl 라이브러리들과 혼동 주의

#### 단계 3: 버전 선택
- **1.2** 버전 클릭 (가장 널리 사용되는 안정 버전)

#### 단계 4: 다운로드
- **Downloads** 섹션에서
- **jar** 링크 클릭
- `jstl-1.2.jar` 다운로드

### 4. 직접 링크 (빠른 다운로드)

**API JAR 직접 링크:**
```
https://repo1.maven.org/maven2/jakarta/servlet/jsp/jstl/jakarta.servlet.jsp.jstl-api/3.0.2/jakarta.servlet.jsp.jstl-api-3.0.2.jar
```

**Implementation JAR 직접 링크:**
```
https://repo1.maven.org/maven2/javax/servlet/jstl/1.2/jstl-1.2.jar
```

### 5. 다운로드 확인

```
다운로드 폴더/
├── jakarta.servlet.jsp.jstl-api-3.0.2.jar  (약 60KB)
└── jstl-1.2.jar                            (약 400KB)
```

### 6. 프로젝트에 적용

#### Eclipse/IntelliJ 프로젝트:
```
src/
└── main/
    └── webapp/
        └── WEB-INF/
            └── lib/
                ├── jakarta.servlet.jsp.jstl-api-3.0.2.jar  ← 여기에 복사
                └── jstl-1.2.jar                            ← 여기에 복사
```

#### 일반 웹 프로젝트:
```
WebContent/
└── WEB-INF/
    └── lib/
        ├── jakarta.servlet.jsp.jstl-api-3.0.2.jar
        └── jstl-1.2.jar
```

### 7. 적용 확인

```jsp
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 테스트 -->
<c:set var="test" value="JSTL 동작 확인!" />
<p>${test}</p>
```

**결과**: "JSTL 동작 확인!" 출력되면 성공!

### 8. 문제해결

**만약 에러가 발생하면:**
1. 두 JAR 파일 모두 `/WEB-INF/lib`에 있는지 확인
2. 톰캣 재시작
3. 프로젝트 Clean & Rebuild

이 방법으로 Maven Central에서 안전하게 다운로드할 수 있습니다!
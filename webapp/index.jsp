<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Java Web History - Model 1</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">
    <div class="container mx-auto px-4 py-8">
        <div class="text-center mb-12">
            <h1 class="text-4xl font-bold text-gray-800 mb-4">Java Web History - Model 1</h1>
            <p class="text-xl text-gray-600">2000년대 초반 JSP 개발 방식의 진화 과정</p>
        </div>

        <div class="grid md:grid-cols-3 gap-8 mb-12">
            <!-- 1단계: Scriptlet -->
            <div class="bg-white rounded-lg shadow-lg p-6 hover:shadow-xl transition-shadow">
                <div class="text-center mb-4">
                    <div class="bg-blue-100 rounded-full p-3 inline-block mb-3">
                        <span class="text-2xl font-bold text-blue-600">1</span>
                    </div>
                    <h2 class="text-2xl font-bold text-gray-800 mb-2">Scriptlet</h2>
                    <p class="text-gray-600 text-sm">JSP에 직접 JDBC 코드 작성</p>
                </div>
                
                <div class="space-y-3 mb-6">
                    <div class="flex items-center text-sm text-gray-600">
                        <span class="w-2 h-2 bg-blue-500 rounded-full mr-2"></span>
                        모든 로직을 JSP에 직접 구현
                    </div>
                    <div class="flex items-center text-sm text-gray-600">
                        <span class="w-2 h-2 bg-blue-500 rounded-full mr-2"></span>
                        JDBC 코드, HTML 출력, 비즈니스 로직 혼재
                    </div>
                    <div class="flex items-center text-sm text-gray-600">
                        <span class="w-2 h-2 bg-blue-500 rounded-full mr-2"></span>
                        2000년대 초반의 전형적인 개발 방식
                    </div>
                </div>
                
                <a href="scriptlet/list.jsp" class="block w-full bg-blue-500 hover:bg-blue-600 text-white text-center py-3 px-4 rounded-lg font-semibold transition-colors">
                    Scriptlet 버전 시작하기
                </a>
            </div>

            <!-- 2단계: DAO -->
            <div class="bg-white rounded-lg shadow-lg p-6 hover:shadow-xl transition-shadow">
                <div class="text-center mb-4">
                    <div class="bg-green-100 rounded-full p-3 inline-block mb-3">
                        <span class="text-2xl font-bold text-green-600">2</span>
                    </div>
                    <h2 class="text-2xl font-bold text-gray-800 mb-2">DAO 패턴</h2>
                    <p class="text-gray-600 text-sm">비즈니스 로직을 DAO 클래스로 분리</p>
                </div>
                
                <div class="space-y-3 mb-6">
                    <div class="flex items-center text-sm text-gray-600">
                        <span class="w-2 h-2 bg-green-500 rounded-full mr-2"></span>
                        비즈니스 로직을 DAO 클래스로 분리
                    </div>
                    <div class="flex items-center text-sm text-gray-600">
                        <span class="w-2 h-2 bg-green-500 rounded-full mr-2"></span>
                        JSP는 DAO 호출과 화면 출력에 집중
                    </div>
                    <div class="flex items-center text-sm text-gray-600">
                        <span class="w-2 h-2 bg-green-500 rounded-full mr-2"></span>
                        코드 재사용성과 유지보수성 향상
                    </div>
                </div>
                
                <a href="dao/list.jsp" class="block w-full bg-green-500 hover:bg-green-600 text-white text-center py-3 px-4 rounded-lg font-semibold transition-colors">
                    DAO 버전 시작하기
                </a>
            </div>

            <!-- 3단계: EL + JSTL -->
            <div class="bg-white rounded-lg shadow-lg p-6 hover:shadow-xl transition-shadow">
                <div class="text-center mb-4">
                    <div class="bg-purple-100 rounded-full p-3 inline-block mb-3">
                        <span class="text-2xl font-bold text-purple-600">3</span>
                    </div>
                    <h2 class="text-2xl font-bold text-gray-800 mb-2">EL + JSTL</h2>
                    <p class="text-gray-600 text-sm">DAO 사용 + EL + JSTL로 출력 단순화</p>
                </div>
                
                <div class="space-y-3 mb-6">
                    <div class="flex items-center text-sm text-gray-600">
                        <span class="w-2 h-2 bg-purple-500 rounded-full mr-2"></span>
                        DAO의 장점은 유지
                    </div>
                    <div class="flex items-center text-sm text-gray-600">
                        <span class="w-2 h-2 bg-purple-500 rounded-full mr-2"></span>
                        출력 로직을 EL + JSTL로 단순화
                    </div>
                    <div class="flex items-center text-sm text-gray-600">
                        <span class="w-2 h-2 bg-purple-500 rounded-full mr-2"></span>
                        JSP에서 Java 코드 최소화
                    </div>
                </div>
                
                <a href="el/list.jsp" class="block w-full bg-purple-500 hover:bg-purple-600 text-white text-center py-3 px-4 rounded-lg font-semibold transition-colors">
                    EL + JSTL 버전 시작하기
                </a>
            </div>
        </div>

        <div class="bg-white rounded-lg shadow-lg p-8">
            <h3 class="text-2xl font-bold text-gray-800 mb-4">프로젝트 개요</h3>
            <div class="space-y-4 text-gray-600">
                <p>이 프로젝트는 2000년대 초반 Java 웹 개발의 진화 과정을 보여줍니다.</p>
                <p>각 단계별로 JSP 개발 방식이 어떻게 발전했는지 비교해보세요:</p>
                <ul class="list-disc list-inside space-y-2 ml-4">
                    <li><strong>1단계 Scriptlet:</strong> 모든 로직을 JSP에 직접 작성하는 방식</li>
                    <li><strong>2단계 DAO:</strong> 비즈니스 로직을 DAO 클래스로 분리하는 방식</li>
                    <li><strong>3단계 EL + JSTL:</strong> DAO 사용 + EL + JSTL로 출력을 단순화하는 방식</li>
                </ul>
                <p class="mt-4 text-sm text-gray-500">각 버전은 동일한 기능을 제공하지만, 구현 방식과 코드 구조가 다릅니다.</p>
            </div>
        </div>
    </div>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인 페이지</title>
    <link rel="stylesheet" href="/resources/css/userlogin.css">
    <script>
        // 에러 메시지를 확인하고 알람창을 표시하는 함수
        function displayErrorMessage() {
            var errorMessage = "${errorMessage}";
            if (errorMessage) {
                alert(errorMessage);
            }
        }

        // 페이지가 로드될 때 에러 메시지를 표시하는 함수 호출
        window.onload = displayErrorMessage;
    </script>
</head>
<body>
  <%@ include file="header.jsp" %>
    <div id="login-form">
        <h2>로그인</h2>
        <form action="/log" method="post">
            <label for="userId">아이디:</label>
            <input type="text" id="userId" name="userId" required>
            <label for="userPassword">비밀번호:</label>
            <input type="password" id="userPassword" name="userPassword" required>
            <button type="submit">로그인</button>
        </form>
        <div id="signup-link">
            <a href="/finduser" class = "button">아이디/비밀번호 찾기</a>
            <a href="/sign" class = "button">회원가입</a>
        </div>
    </div>
     <c:if test="${param.error ne null}">
    </c:if>
</body>
</html>

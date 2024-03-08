<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>영화 정보 추가</title>
    <link rel="stylesheet" href="/resources/css/registraionmovie.css">

</head>
<body>
    <%@ include file="header.jsp" %>

        

        <!-- registration form area -->
        <div id="update-form">  
        <h3>영화 정보 추가</h3>     
            <form action="/insertMoive" method="POST">
                    <label for="movieImgUrl">영화 포스터</label>
                    <input type="text" id="movieImgUrl" name="movieImgUrl">           
                    <label for="movieName">영화 제목</label>
                    <input type="text" id="movieName" name="movieName" required>                           
                    <label for="directorName">영화 감독</label>
                    <input type="text" id="directorName" name="directorName" required>                              
                     <label for="movieStory">영화 줄거리</label>
					<textarea id="movieStory" name="movieStory" rows="20" cols="50" required></textarea>
					<label for="movieDate">개봉일</label>
                    <input type="date" id="movieDate" name="movieDate" required>
                    <input type="submit" value="추가 완료" class="Btn">                
            </form>       
        </div>
</body>
</html>
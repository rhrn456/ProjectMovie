<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화 정보 수정</title>
<link rel="stylesheet" href="/resources/css/updateMovie.css">
</head>
<body>
    <%@ include file="header.jsp" %>


        <!-- update form area -->
        
		        <div id="update-form">
		        <h3>영화 정보 수정</h3>
            <form action="/updateMovie/${movie.movieId}" method="post">
                
                    <label for="movieId">영화 ID</label>
                    <input type="text" id="movieId" name="movieId" value="${movie.movieId}" readonly>
               
              
                    <label for="movieName">영화 제목</label>
                    <input type="text" id="movieName" name="movieName" value="${movie.movieName}" required>           
                    <label for="directorName">영화 감독</label>
                    <input type="text" id="directorName" name="directorName" value="${movie.directorName}" required>
                    <label for="movieStory">영화 줄거리</label>
					<textarea id="movieStory" name="movieStory" rows="20" cols="50" required>${movie.movieStory}</textarea>
                    <label for="movieDate">개봉일</label>
                    <input type="date" id="movieDate" name="movieDate" value="${movie.movieDate}" required>
                    <label for="movieImgUrl">포스터</label>
                    <input type="text" id="movieImgUrl" name="movieImgUrl" value="${movie.movieImgUrl}" required>
                    <input type="submit" value="수정 완료" class="Btn">
            </form>
            </div>
  
</body>
</html>
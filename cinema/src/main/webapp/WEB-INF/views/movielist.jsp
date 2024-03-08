<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Movie List</title>
    <link rel="stylesheet" href="/resources/css/movielist.css">
</head>
<body>
 <%@ include file="header.jsp" %>
    <div class="container">
        <h2>Movie List</h2>
        <div class="movie-list">
            <%-- 영화 목록을 반복하여 출력합니다 --%>
            <c:forEach items="${movieList}" var="movie">
                <div class="movie-card" onclick="sendMovieName('${movie.movieName}')">
                    <div class="movie-image" style="background-image: url('${movie.movieImgUrl}')"></div>
                    <div class="movie-details">
                        <h3>${movie.movieName}</h3>
                        <p>${movie.movieStory}</p>
                        <p>개봉일: ${movie.movieDate} </p>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
    <script>
    function sendMovieName(movieName) {
        window.location.href = '/moviedetail?movieName=' + movieName;
    }
</script>
</body>
</html>
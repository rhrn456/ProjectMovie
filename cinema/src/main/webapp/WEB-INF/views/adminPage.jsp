<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<meta charset="UTF-8">
<title>관리자 페이지 - 영화 목록</title>
<link rel="stylesheet" href="/resources/css/adminpage.css">
</head>
<body>
    <%@ include file="header.jsp" %>
    <!-- main -->
    <main id="main">
        <h3>영화 정보 관리 페이지</h3>
        <!-- movie list area -->
        <div id="movie-list">
            <div class="container">
               <span style="font-size:12pt;" >
                <input type="button" value="영화 스케줄 관리" class="addBtn" onclick="location.href='/movieschedule'">
                <input type="button" value="영화 정보 추가" class="addBtn" onclick="location.href='/registration'">
            </span>
                <table class="movie-table">
                    <thead>
                        <tr>
                            <th scope="col" class="th-poster">포스터</th>
                            <th scope="col" class="th-title">제목</th>
                            <th scope="col" class="th-director">영화 감독</th>
                            <th scope="col" class="th-date">개봉일</th>
                        </tr>
                    </thead>
                    <c:forEach items="${movieList}" var="movie" varStatus="no">
                        <tbody>
                            <tr>
                                <td>
                                    <p align="center">
                                        <img src="${movie.movieImgUrl}" alt="포스터가  없습니다" class="poster">
                                    </p>
                                </td>
                                <td>
                                    <p align="center">
                                        <span style="font-size:12pt;">
                                            <b><a href="/moviedetail?movieName=${movie.movieName}">${movie.movieName}</a></b>
                                        </span>
                                    </p>
                                </td>
                                <td>
                                    <p align="center">
                                        <span style="font-size:12pt;">
                                            <b>${movie.directorName}</b>
                                        </span>
                                    </p>
                                </td>
                                <td>
                                    <p align="center">
                                        <span style="font-size:12pt;">
                                            <b>${movie.movieDate}</b>
                                        </span>
                                    </p>
                                </td>
                                <td>
								    <div style="display: flex; justify-content: space-between;">
								        <input type="button" value="수정" class="Btn updateBtn" onclick="location.href='/updateMovie?movieId=${movie.movieId}'">
								        <input type="button" value="삭제" class="Btn deleteBtn" onclick="deleteMovie(${movie.movieId})">
								    </div>
								</td>
                            </tr>
                        </tbody>
                    </c:forEach>
                </table>
            </div>
        </div>
    </main>
<script>
function deleteMovie(movieId) {
    console.log('Deleting movie with ID:', movieId);
    if (confirm("정말로 삭제하시겠습니까?")) {
        $.ajax({
            url: '/deleteMovie/' + movieId,
            type: 'POST',
            success: function(message) {
                console.log('Delete success:', message);
                alert(message);
                if (message === "complete remove movie") {
                    // 삭제 후에 해당 열을 DOM에서 제거
                    $("tr[data-movieId='" + movieId + "']").remove();
                    location.reload()
                }
            },
            error: function (error) {
                console.error('에러:', error.statusText);
            }
        });
    }
}
</script>
</body>
</html>
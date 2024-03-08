<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="/resources/css/addmovieschedule.css">
    <title>Add Movie Schedule</title>
</head>
<body>
	 <%@ include file="header.jsp" %>
	     <div id="update-form">
	    <h2>영화 스케줄 등록</h2>
		<form action="/addmovieschedule" method="post">
		    <label for="movie">영화:</label>
		    <select name="movieId">
		        <c:forEach items="${movieList}" var="movieItem">
		            <option value="${movieItem.movieId}">${movieItem.movieName}</option>
		        </c:forEach>
		    </select>
		    <br>
		    <label for="theater">극장:</label>
		    <select name="theaterId">
		        <c:forEach items="${teaterList}" var="theater">
		            <option value="${theater.theaterId}">${theater.theaterLoc}</option>
		        </c:forEach>
		    </select>
		    <br>
		    <label for="date">상영 날짜:</label>
		    <input type="date" name="movieInfoDate" required>
		    <br>
		    <label for="time">상영 시간:</label>
		    <input type="time" name="movieInfoTime" required>
		    <br>
		    <input type="submit" value="스케줄 등록하기">
		</form>
	 </div>
 </body>
 </html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<link rel="stylesheet" type="text/css" media="all" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" />
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js"></script>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5675f8f4dffbfd2b726b7b6393fd2b78"></script>
<script type="text/javascript">
    $(document).ready(function() {
        // 페이지가 로드될 때 showAllTheaters() 함수 호출
        showAllTheaters();   
        // 이전 맵 변수 선언
        var map = null;
		
        // 페이지 로드 시 전국의 영화관을 표시
        function showAllTheaters() {
            $.ajax({
                url: "map2",
                success: function(json_array) {
                    $('#result').html("전국의 영화관");
                    var mapContainer = document.getElementById('map');
                    var mapOption = {
                        center: new kakao.maps.LatLng(json_array[0].lat, json_array[0].lon),
                        level: 13
                    };

                    // 이전 맵 삭제
                    if (map != null) {
                        map = null;
                    }

                    // 새로운 맵 생성
                    map = new kakao.maps.Map(mapContainer, mapOption);

                    var positions = [];
                    $(json_array).each(function(i, json) {
                        positions.push({
                            title: json.location,
                            latlng: new kakao.maps.LatLng(json.lat, json.lon)
                        });
                    });

                    for (let i = 0; i < positions.length; i++) {
                        let marker = new kakao.maps.Marker({
                            map: map,
                            position: positions[i].latlng,
                            title: positions[i].title,
                        });
                    }
                }
            });
        }

        // 전체보기 버튼 클릭 시 전체 지도 다시 표시
        $('#all').click(function() {
            showAllTheaters();
        });

        // 각 버튼 클릭 시 해당 지역의 영화관 표시
        $('#b1, #b2, #b3, #b4, #b5, #b6').click(function() {
            var location = $(this).text(); // 버튼의 텍스트를 지역명으로 사용
            var adress = $(this).val();
         // 테이블 리셋
            $('#theaterTableBody').empty();
            $.ajax({
                url: "map1",
                data: {
                    location: location
                },
                success: function(json) {
                    $('#result').html(json.theaterLoc);
                    var mapContainer = document.getElementById('map');
                    var mapOption = {
                        center: new kakao.maps.LatLng(json.lat, json.lon),
                        level: 3
                    };

                    // 이전 맵 삭제
                    if (map != null) {
                        map = null;
                    }

                    // 새로운 맵 생성
                    map = new kakao.maps.Map(mapContainer, mapOption);

                    var markerPosition = new kakao.maps.LatLng(json.lat, json.lon);
                    var marker = new kakao.maps.Marker({
                        position: markerPosition
                    });

                    marker.setMap(map);

                    var infowindow = new kakao.maps.InfoWindow({
                        content: '<div style="padding:5px;">' + adress + '</div>', // 버튼의 value 값을 마커 위에 출력
                    });

                    kakao.maps.event.addListener(marker, 'click', function() {
                        infowindow.open(map, marker);
                    });
                }
            });
            console.log("성공");
            // /gettheater 로의 요청
            $.ajax({
                url: "/gettheater",
                data: {
                    location: location
                },
                success: function(response) {
                    // 성공적으로 받은 데이터를 처리합니다.
                    console.log("gettheater 요청 결과:", response);
                    $('#theaterTableBody').empty(); // 테이블 내용 초기화
                      // theaterscheduleList를 순회하며 각 TheaterSchedule의 정보를 테이블에 추가
                    $.each(response, function(index, theaterSchedule) {
                    	var backgroundColor = (index % 2 == 0) ? '#f0f0f0' : '#dddddd';
                    	var newRow = '<tr style="background-color: ' + backgroundColor + ';">' +
                        '<td style="font-size: 12px; text-align: center;">' + theaterSchedule.theaterLoc + '</td>' +
                        '<td style="font-size: 12px; text-align: center;">' + theaterSchedule.movieName + '</td>' +
                        '<td style="font-size: 12px; text-align: center;">' + formatDate(theaterSchedule.movieInfoDate) + '</td>' +
                        '<td style="font-size: 12px; text-align: center;">' + theaterSchedule.movieInfoTime.substring(0, 5) + '</td>' +
                        '</tr>';

                    // 날짜를 포맷하는 함수
                    function formatDate(date) {
                        var d = new Date(date);
                        var year = d.getFullYear();
                        var month = ('0' + (d.getMonth() + 1)).slice(-2);
                        var day = ('0' + d.getDate()).slice(-2);
                        return year + '-' + month + '-' + day;
                    }
                        
                        $('#theaterTableBody').append(newRow);
                    });
                },
                error: function(xhr, status, error) {
                    // 오류 처리
                    console.error("gettheater 요청 실패:", status, error);
                }
            });
        });
    });
</script>
<style>
    .button-group {
        display: flex;
        justify-content: center;
        margin-top: 20px;
    }

    .button-group button {
        margin: 0 5px;
        background: red;
    }

   table {
        width: 600px; /* 테이블 너비 설정 */
        margin: 50px auto; /* 가운데 정렬 및 위아래 여백 추가 */
    }
</style>
</style>
</head>
<body>
<%@ include file="header.jsp" %>
<div id="map" style="width: 50%; height: 550px; margin: 0 auto; text-align: center;"></div>
<br>
<div id="result" style="margin: 0 auto; text-align: center;"></div>
<hr>
<div class="button-group">
    <button id="b1" value="부산 특별시  영화관">부산</button>
    <button id="b2" value="대구 광역시  영화관">대구</button>
    <button id="b3" value="서울 특별시  영화관">강남</button>
    <button id="b4" value="서울 특별시 영화관">영등포</button>
    <button id="b5" value="경기도 부천 영화관">부천</button>
    <button id="b6" value="경기도 김포 영화관">김포</button>
    <button id="all">전체보기</button>
</div>


<table align="center" border="1" cellpadding="5" cellspacing="2">
 
    <thead>
    <tr>
        <!-- 첫 번째 행에 빈 셀 추가 -->
        <th colspan="5" style="background-color: skyblue;">Theater Information</th>
    </tr>
    <tr>
        <th style="font-size: 12px; text-align: center;">영화 이름</th>
        <th style="font-size: 12px; text-align: center;">극장 이름</th>
        <th style="font-size: 12px; text-align: center;">상영 날짜</th>
        <th style="font-size: 12px; text-align: center;">상영 시간</th>
    </tr>
    </thead>
    <!-- 각 예약에 대한 정보를 순회하며 표시 -->
		<tbody id="theaterTableBody">
		    <c:forEach items="${theaterscheduleList}" var="TheaterSchedule" varStatus="status">
		        <c:choose>
		            <c:when test="${status.index % 2 == 0}">
		                <tr style="background-color: #f0f0f0;">
		            </c:when>
		            <c:otherwise>
		                <tr style="background-color: #dddddd;">
		            </c:otherwise>
		        </c:choose>
		        <td style="font-size: 12px;">${TheaterSchedule.theaterLoc}</td>
		        <td style="font-size: 12px;">${TheaterSchedule.movieName}</td>
		        <td style="font-size: 12px;">${TheaterSchedule.movieInfoDate}</td>
		        <td style="font-size: 12px;">${fn:substring(TheaterSchedule.movieInfoTime, 0, 5)}</td>
		        </tr>
		    </c:forEach>
		</tbody>
    </div>
</table>
</body>
</html>
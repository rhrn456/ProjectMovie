<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="/resources/css/style.css">
<link rel="stylesheet" type="text/css" href="/resources/css/chatbot.css">
<script src="https://kit.fontawesome.com/37dd76a909.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script src="/resources/js/chatbot.js" defer></script> 
<div class="header-container">
<header>
	<%
		response.setHeader("Pragma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setDateHeader("Expires", 0L);
	%>
    <div class="logo">
        <a href="main"><img src="/resources/img/logo.png" style="width:100px;"></a>
    </div>
    <label for="toggle">&#8801;</label>

        <div class="nav_menu">
        	<div class="option">
           <a href="/movies">영화</a>
           <a href="/theaters">극장</a>
            <a href="/book">예매</a>
				<c:if test="${sessionScope.userAdmin eq true}">
			    <a href="/registration">영화 등록</a>
			</c:if>
            </div>
            <div class ="log">
            <c:if test="${empty sessionScope.userId}">
                <a href="/login">로그인</a>
                <a href="/sign">회원가입</a>
            </c:if>
            <c:if test="${not empty sessionScope.userId}">
            	<a href="/userinfo/${sessionScope.userId}" >회원 정보</a>
               <a href="/logout">로그아웃</a>
            </c:if>
            </div>
            </div>
</header>
</div>

<div class="chat-box">
  <div class="chat-box-header">
      <h3>Message Us</h3>
      <p>
        <i class="fa fa-times"></i> 
      </p>
  </div>
  <div id="chat-box" class="chat-box-body">
    <div class="chat-box-body-receive">
      <p>문의사항 번호를 입력해주세요.</p>
      <p>1)영화 예매 방법 2)회원 가입 방법 3)회원 가입 오류 4)고객 센터</p>
    </div>
  </div>
  <div class="chat-box-footer">
      <input id="msg" placeholder="Enter Your Message" type="text">
      <i class="send far fa-paper-plane" id="button-send"></i>
  </div>
</div>



<div class="chat-button">
  <span></span>
</div>




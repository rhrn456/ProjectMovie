/*
 * package com.spring.cinema.controller.user;
 * 
 * import org.springframework.beans.factory.annotation.Autowired; import
 * org.springframework.context.annotation.Configuration; import
 * org.springframework.scheduling.annotation.EnableScheduling; import
 * org.springframework.scheduling.annotation.Scheduled; import
 * org.springframework.stereotype.Component; import
 * javax.servlet.http.HttpSession; import java.util.Date;
 * 
 * @Configuration
 * 
 * @EnableScheduling public class ScheduleController {
 * 
 * @Autowired private HttpSession session;
 * 
 * // 스케줄러를 사용하여 세션 데이터를 클리어하는 메소드
 * 
 * @Scheduled(fixedRate = 60000) // 1분마다 실행 (밀리초 단위) public void
 * clearSessionData() { Date loginTime = (Date)
 * session.getAttribute("loginTime"); if (loginTime != null) { long currentTime
 * = new Date().getTime(); long elapsedTime = currentTime - loginTime.getTime();
 * 
 * // 로그인 후 1분이 지났으면 세션을 초기화합니다. if (elapsedTime >= 60000) {
 * session.invalidate(); // 세션 데이터 모두 제거 System.out.println("세션 초기화 완료"); } } }
 * }
 */
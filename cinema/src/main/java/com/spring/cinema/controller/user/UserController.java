package com.spring.cinema.controller.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.spring.cinema.model.User;
import com.spring.cinema.service.user.UserService;


@Controller
public class UserController {
	
	private final UserService userService;
	//서버 매핑
	@Autowired
	public UserController(UserService userService) {
		this.userService = userService;
	}
	//로그인
	@PostMapping("/log")
	public String login(@RequestParam("userId") String userId, @RequestParam("userPassword") String userPassword,
			HttpSession session) {
		User user = userService.getUserByuserId(userId);
		if (user != null && BCrypt.checkpw(userPassword, user.getUserPassword())) {
			
			session.setAttribute("userId", user.getUserId());
			session.setAttribute("userAdmin", user.getUserAdmin());
			if (user.getUserAdmin()) {
				return "redirect:/admin/dashboard";
			} else {
				return "redirect:/main";
			}
		} else {
			return "redirect:/login?error=true";
		}
	}
	//로그아웃
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/main";
	}

	//회원가입
	@PostMapping(value = "/signup")
	public String SingUp(@ModelAttribute User newUser)  {
		String hashedPassword = BCrypt.hashpw(newUser.getUserPassword(), BCrypt.gensalt());
		newUser.setUserPassword(hashedPassword);

		boolean result = userService.insertUser(newUser);
		if (result) {
			return "redirect:/login";
		} else {
			return "redirect:/register?error=true";
		}
	}
	//회원 정보 변경
	@PostMapping(value= "/userUpdate/{userId}")
	public String userUpdate(@PathVariable String userId,
								@RequestParam String userName,
								@RequestParam String userPassword,
								@RequestParam Integer userBirth,
								@RequestParam String  userGender) {
		
		User user = userService.getUserByuserId(userId);
		String hashedPassword = BCrypt.hashpw(userPassword, BCrypt.gensalt());
		user.setUserName(userName);
		user.setUserPassword(hashedPassword);
		user.setUserBirth(userBirth);
		user.setUserGender(userGender);
		boolean result = userService.updateUserById(user);
		if (result) {
			return "redirect:/main";
		} else {
			return "redirect:/error";
		}
	
	}
	//회원 정보 삭제
	@GetMapping(value="/userDelete/{userId}")
	public String userDelete(@PathVariable String userId) {
		System.out.println(userId);
		boolean result = userService.userDelete(userId);
		if(result) {
			System.out.println(result);
			return "redirect:/login";
		}else {
		return "redirect:/error";
		}
	}
	//회원 아이디 찾기
	@PostMapping(value="/findId")
	public String findId(@RequestParam String userName,
						@RequestParam Integer userBirth, Model model) {
		List<User> users= userService.getUserIdByNameAndBirth(userName);
		for (User user : users) {
		    if (user.getUserBirth().equals(userBirth)) {
		    	model.addAttribute("user",user);
		    	return "showId";
		    }
		}
		return "redirect:/error";
	}
	//회원 비밀번호 찾기
	@PostMapping(value="/findPw")
	public String findPw(@RequestParam String userId ,
						@RequestParam String userName, 
						@RequestParam Integer userBirth, 
						Model model) {
		List<User> users= userService.getUserIdByNameAndBirth(userName);
		for (User user : users) {
		    if (user.getUserBirth().equals(userBirth) && user.getUserId().equals(userId)
		    		&&user != null) {
		    	model.addAttribute("user",user);
		    	return "showPw";
		    }
		}
		return userName;
	}
	
	@PostMapping(value="/chagePw/{userId}")
	public String findPw(@PathVariable String userId,
						@RequestParam String userPassword) {
		User user = userService.getUserByuserId(userId);
		String hashedPassword = BCrypt.hashpw(userPassword, BCrypt.gensalt());
    	user.setUserPassword(hashedPassword);
    	boolean result = userService.updateUserById(user);
		if (result) {
			return "redirect:/login";
		} else {
			return "redirect:/error";
		}

    }
	}

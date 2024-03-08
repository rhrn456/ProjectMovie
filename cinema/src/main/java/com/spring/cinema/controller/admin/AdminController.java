package com.spring.cinema.controller.admin;

import java.sql.Time;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.cinema.model.Movie;
import com.spring.cinema.model.MovieInfo;
import com.spring.cinema.model.Theater;
import com.spring.cinema.service.admin.AdminService;
import com.spring.cinema.service.user.MovieInfoService;
import com.spring.cinema.service.user.TheaterService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class AdminController {
	
	private final AdminService adminService;
	private final TheaterService theaterService;
	private final MovieInfoService movieInfoService;
	
	
	
	// 영화 정보 리스트 불러오기
	@RequestMapping(value ="/adminPage", method = RequestMethod.GET)
	public String movieList(Model model) {
		List<Movie> movieList = adminService.getMovieList();
		System.out.println(movieList);
		model.addAttribute("movieList", movieList);
		return "adminPage";
	}
//	
//	// 영화 정보 추가폼
//	@RequestMapping(value = "/insertMovieForm", method = RequestMethod.POST)
//	public String insertMovieForm() {
//	 
//	    return "registrationMv";
//	}
	
	
	// 영화 정보 추가
	@RequestMapping(value = "/insertMoive", method = RequestMethod.POST)
	public String insertMoive(@ModelAttribute Movie movie, Model model, RedirectAttributes redirectAttributes ) {
		adminService.insertMovie(movie);
		addRedirectMessage(redirectAttributes, "영화 정보가 추가되었습니다.");
		System.out.println("추가 성공");
		return "redirect:/adminPage";
	}
	
	// 영화 정보 수정 폼
	 @GetMapping("/updateMovie")
	    public String updateMovieForm(@RequestParam("movieId") Long movieId, Model model) {
	        Movie movie = adminService.getMovieById(movieId);
	        model.addAttribute("movie", movie);
	        return "updateMovie";
	    }
	
	// 영화 정보 수정
	 @PostMapping("/updateMovie/{movieId}")
	 public String updateMovie(@PathVariable Long movieId, @ModelAttribute Movie updatedMovie, RedirectAttributes redirectAttributes) {
		 System.out.println(updatedMovie);
	     // 수정된 영화 정보를 저장합니다.
	     adminService.updateMovie(updatedMovie);

	     addRedirectMessage(redirectAttributes, "영화 정보가 수정되었습니다.");

	     return "redirect:/adminPage";
	 }
	
	
	// 영화 정보 삭제
	 @PostMapping("/deleteMovie/{movieId}")
	 @ResponseBody
	 public String deleteMovie(@PathVariable Long movieId, RedirectAttributes redirectAttributes) {
	     // movieId를 사용하여 해당 영화 정보를 가져옵니다.
	     Movie movieToDelete = adminService.getMovieById(movieId);

	     // 영화 정보를 삭제합니다.
	     adminService.deleteMovie(movieToDelete);

	     addRedirectMessage(redirectAttributes,"complete remove movie");
	     
	     return "complete remove movie";
	 }
	//영화 상영 날짜 설정 페이지
	 @GetMapping("/movieschedule")
	 public String addMovieSchedule(Model model) {
		 List<Movie> movieList = adminService.getMovieList();
		 List<Theater> teaterList = theaterService.getAllTheaters();
		 System.out.println(teaterList);
		 System.out.println(movieList);
		model.addAttribute("movieList", movieList);
		model.addAttribute("teaterList", teaterList);
		 return "addMovieSchedule";
	 }
	
	 @PostMapping("/addmovieschedule")
	 public String addShcedule(@ModelAttribute MovieInfo movieInfo) {
		 System.out.println(movieInfo);
		 boolean result = movieInfoService.insertMovieInfo(movieInfo);
		 if(result) {
			 return "/adminPage";
		 }
		 return "/main";
	 }
	//
	private void addRedirectMessage(RedirectAttributes attributes, String message) {
		attributes.addFlashAttribute("message", message);
	}

	
}
	
	
	
	
	
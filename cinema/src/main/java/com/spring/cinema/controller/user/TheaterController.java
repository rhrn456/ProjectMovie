package com.spring.cinema.controller.user;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.cinema.model.MovieInfo;
import com.spring.cinema.model.Theater;
import com.spring.cinema.model.TheaterSchedule;
import com.spring.cinema.service.impl.ReviewServiceImpl;
import com.spring.cinema.service.impl.UserServiceImpl;
import com.spring.cinema.service.user.MovieBookingService;
import com.spring.cinema.service.user.MovieInfoService;
import com.spring.cinema.service.user.TheaterService;

@Controller
public class TheaterController {
    

    private TheaterService theaterService;
    private MovieInfoService movieInfoService;
	
	//서버 매핑
	@Autowired
	public TheaterController(TheaterService theaterService, 
							MovieInfoService movieInfoService) {
		this.theaterService = theaterService;
		this.movieInfoService = movieInfoService;
	}  
    @GetMapping("/theaters")
    public String showTheaterList(Model model) {
        // 극장 목록 가져오기
        List<Theater> theaters = theaterService.getAllTheaters();
        model.addAttribute("theaters", theaters);
        return "theaters";
    }
    
	@RequestMapping("map1")
	@ResponseBody
	public Theater map1(String location) {
		return theaterService.one(location);
		//return이 dto인 경우 @ResponseBody로 설정해주면
		//JSON으로 만들어서 클라이언트에게 줌.
	}
	
	@RequestMapping("map2")
	@ResponseBody
	public List<Theater> map2() {
		return theaterService.all();
		//List<MapDTO> ==> [{}, {}]
	}
	
	@GetMapping("/gettheater")
	@ResponseBody
	public List<TheaterSchedule> getTheater(String location) {
	    Theater theater = theaterService.one(location);
	    int theaterId = theater.getTheaterId();
	    List<TheaterSchedule> theaterscheduleList = movieInfoService.getMovieInfoByTheaterId(theaterId);
	    System.out.println(theaterscheduleList);
	    return theaterscheduleList;
	}
}

package com.spring.cinema.service.user;

import java.util.List;

import com.spring.cinema.model.MovieInfo;
import com.spring.cinema.model.TheaterSchedule;

public interface MovieInfoService {

	boolean insertMovieInfo(MovieInfo movieInfo);

	List<TheaterSchedule> getMovieInfoByTheaterId(int theaterId);

}

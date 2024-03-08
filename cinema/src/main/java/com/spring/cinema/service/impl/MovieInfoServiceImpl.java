package com.spring.cinema.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.cinema.mapper.MovieInfoMapper;
import com.spring.cinema.model.MovieInfo;
import com.spring.cinema.model.TheaterSchedule;
import com.spring.cinema.service.user.MovieInfoService;


@Service
public class MovieInfoServiceImpl implements MovieInfoService{


	private final MovieInfoMapper movieInfoMapper;

	@Autowired
	public MovieInfoServiceImpl(MovieInfoMapper movieInfoMapper) {
		this.movieInfoMapper = movieInfoMapper;
	}

	public boolean insertMovieInfo(MovieInfo movieInfo) {
	System.out.println(movieInfo);
		try {
			 movieInfoMapper.insertMovieInfo(movieInfo);
			System.out.println("성공");
			return true; 
		} catch (Exception e) {
			e.printStackTrace();
			return false; 
		}
	}
	

	public List<TheaterSchedule> getMovieInfoByTheaterId(int theaterId){
		return movieInfoMapper.getMovieInfoByTheaterId(theaterId);
	}
}

package com.spring.cinema.service.user;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.cinema.mapper.MovieMapper;
import com.spring.cinema.mapper.UserMapper;
import com.spring.cinema.model.Movie;
import com.spring.cinema.model.User;

@Service
public class MovieService {

	private final MovieMapper movieMapper;

	@Autowired
	public MovieService(MovieMapper movieMapper) {
		this.movieMapper = movieMapper;
	}

	public Movie getTitleById(int movieid) {
		return movieMapper.getTitleById(movieid);
	}

	public ArrayList<Movie> getAllMovie() {
		return movieMapper.getAllMovie();
		
	}

	public boolean movieRegistration(String movieName, String movieStory, String movieDate, String movieImgUrl) {
		
		try {
			movieMapper.movieRegistration(movieName,movieStory, movieDate, movieImgUrl);
			return true; 
		} catch (Exception e) {
			e.printStackTrace();
			return false; 
		}
	}

	public Movie getMovieByName(String movieName) {
		System.out.println(movieName);
		return movieMapper.getMovieByName(movieName);
	}

}

package com.spring.cinema.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.cinema.model.MovieInfo;
import com.spring.cinema.model.TheaterSchedule;

public interface MovieInfoMapper {

	int insertMovieInfo(MovieInfo movieInfo);

	List<TheaterSchedule> getMovieInfoByTheaterId(@Param(value = "theaterId")int theaterId);

}

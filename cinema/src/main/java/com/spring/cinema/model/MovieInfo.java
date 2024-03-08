package com.spring.cinema.model;



import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class MovieInfo {
	private Integer movieInfoId;
	private int theaterId;
	private Date movieInfoDate;
	private String movieInfoTime;
	private int movieId;
	
	
}

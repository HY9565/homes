package com.homes.guest;

import java.sql.Date;

public class ReservationDTO {
	private int reserve_idx, member_idx, room_idx;
	private String state;
	private java.sql.Date reserve_date;
	private int price;
	private int reservation_detail_idx;
	private java.sql.Date check_in, check_out;
	private String request;
	private String room_name;
	private String image;
	private int count;
	private String member_id;
	
	public ReservationDTO() {
		
	}
	
	public ReservationDTO(int reserve_idx, String image, String room_name, String state, Date check_in, Date check_out, Date reserve_date) {
		super();
		this.reserve_idx = reserve_idx;
		this.image = image;
		this.room_name = room_name;
		this.state = state;
		this.check_in = check_in;
		this.check_out = check_out;
		this.reserve_date = reserve_date;
	}
	
	
	
	public ReservationDTO(int reserve_idx, int member_idx, int room_idx, String state, Date reserve_date, int price,
			int reservation_detail_idx, Date check_in, Date check_out, String request) {
		super();
		this.reserve_idx = reserve_idx;
		this.member_idx = member_idx;
		this.room_idx = room_idx;
		this.state = state;
		this.reserve_date = reserve_date;
		this.price = price;
		this.reservation_detail_idx = reservation_detail_idx;
		this.check_in = check_in;
		this.check_out = check_out;
		this.request = request;
	}
	
	

	public ReservationDTO(int reserve_idx, int member_idx, int room_idx, String state, Date reserve_date, int price,
			int reservation_detail_idx, Date check_in, Date check_out, String request, int count) {
		super();
		this.reserve_idx = reserve_idx;
		this.member_idx = member_idx;
		this.room_idx = room_idx;
		this.state = state;
		this.reserve_date = reserve_date;
		this.price = price;
		this.reservation_detail_idx = reservation_detail_idx;
		this.check_in = check_in;
		this.check_out = check_out;
		this.request = request;
		this.count = count;
	}
	
	
	
	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public int getReserve_idx() {
		return reserve_idx;
	}
	public void setReserve_idx(int reserve_idx) {
		this.reserve_idx = reserve_idx;
	}
	public int getMember_idx() {
		return member_idx;
	}
	public void setMember_idx(int member_idx) {
		this.member_idx = member_idx;
	}
	public int getRoom_idx() {
		return room_idx;
	}
	public void setRoom_idx(int room_idx) {
		this.room_idx = room_idx;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public java.sql.Date getReserve_date() {
		return reserve_date;
	}
	public void setReserve_date(java.sql.Date reserve_date) {
		this.reserve_date = reserve_date;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getReservation_detail_idx() {
		return reservation_detail_idx;
	}
	public void setReservation_detail_idx(int reservation_detail_idx) {
		this.reservation_detail_idx = reservation_detail_idx;
	}
	public java.sql.Date getCheck_in() {
		return check_in;
	}
	public void setCheck_in(java.sql.Date check_in) {
		this.check_in = check_in;
	}
	public java.sql.Date getCheck_out() {
		return check_out;
	}
	public void setCheck_out(java.sql.Date check_out) {
		this.check_out = check_out;
	}
	public String getRequest() {
		return request;
	}
	public void setRequest(String request) {
		this.request = request;
	}

	public String getRoom_name() {
		return room_name;
	}

	public void setRoom_name(String room_name) {
		this.room_name = room_name;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}
	
	
}

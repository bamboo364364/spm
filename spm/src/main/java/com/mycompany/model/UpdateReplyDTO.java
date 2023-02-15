package com.mycompany.model;

public class UpdateReplyDTO {

	private int goodId;
	
	private double ratingAvg;

	public int getGoodId() {
		return goodId;
	}

	public void setGoodId(int goodId) {
		this.goodId = goodId;
	}

	public double getRatingAvg() {
		return ratingAvg;
	}

	public void setRatingAvg(double ratingAvg) {
		this.ratingAvg = ratingAvg;
	}

	@Override
	public String toString() {
		return "UpdateReplyDTO [goodId=" + goodId + ", ratingAvg=" + ratingAvg + "]";
	}

	
	
}

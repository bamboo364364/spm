package com.mycompany.model;

import java.util.Date;
import java.util.List;

public class GoodVO {

	/* 상품 id */
	private int goodId;
	
	/* 상품 이름 */
	private String goodName;
	
	/* 카테고리 코드 */
	private String cateCode;
	
	/* 카테고리 이름 */
	private String cateName;
	
	/* 상품 가격 */
	private int goodPrice;
	
	/* 상품 재고 */
	private int goodStock;
	
	/* 상품 할인률(백분율) */
	private double goodDiscount;
	
	/* 상품 상세정보 */
	private String goodContents;
	
	/* 등록 날짜 */
	private Date regDate;
	
	/* 수정 날짜 */
	private Date modDate;
	
	/* 상품 메이커 */
	private String goodMaker;
	
	/* 주문상품수? */
	private int goodCount;
	
	public int getGoodCount() {
		return goodCount;
	}

	public void setGoodCount(int goodCount) {
		this.goodCount = goodCount;
	}

	/* 평점평균 */
	private double ratingAvg;
	
	public double getRatingAvg() {
		return ratingAvg;
	}

	public void setRatingAvg(double ratingAvg) {
		this.ratingAvg = ratingAvg;
	}

	public String getGoodMaker() {
		return goodMaker;
	}

	@Override
	public String toString() {
		return "GoodVO [goodId=" + goodId + ", goodName=" + goodName + ", cateCode=" + cateCode + ", cateName="
				+ cateName + ", goodPrice=" + goodPrice + ", goodStock=" + goodStock + ", goodDiscount=" + goodDiscount
				+ ", goodContents=" + goodContents + ", regDate=" + regDate + ", modDate=" + modDate + ", goodMaker="
				+ goodMaker + ", goodCount=" + goodCount + ", ratingAvg=" + ratingAvg + ", imageList=" + imageList
				+ "]";
	}

	public void setGoodMaker(String goodMaker) {
		this.goodMaker = goodMaker;
	}

	/* 이미지 정보 */
	private List<AttachImageVO> imageList;

	public int getGoodId() {
		return goodId;
	}

	public void setGoodId(int goodId) {
		this.goodId = goodId;
	}

	public String getGoodName() {
		return goodName;
	}

	public void setGoodName(String goodName) {
		this.goodName = goodName;
	}


	public String getCateCode() {
		return cateCode;
	}

	public void setCateCode(String cateCode) {
		this.cateCode = cateCode;
	}

	public String getCateName() {
		return cateName;
	}

	public void setCateName(String cateName) {
		this.cateName = cateName;
	}

	public int getGoodPrice() {
		return goodPrice;
	}

	public void setGoodPrice(int goodPrice) {
		this.goodPrice = goodPrice;
	}

	public int getGoodStock() {
		return goodStock;
	}

	public void setGoodStock(int goodStock) {
		this.goodStock = goodStock;
	}

	public double getGoodDiscount() {
		return goodDiscount;
	}

	public void setGoodDiscount(double goodDiscount) {
		this.goodDiscount = goodDiscount;
	}



	public String getGoodContents() {
		return goodContents;
	}

	public void setGoodContents(String goodContents) {
		this.goodContents = goodContents;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public Date getModDate() {
		return modDate;
	}

	public void setModDate(Date modDate) {
		this.modDate = modDate;
	}

	public List<AttachImageVO> getImageList() {
		return imageList;
	}

	public void setImageList(List<AttachImageVO> imageList) {
		this.imageList = imageList;
	}

	

}




